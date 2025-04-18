#include <assert.h>
#include <stdio.h>
#include <cuda.h>
#include <time.h>

void prodottoScalareCPU(float *a, float *b, float *c, int n);
float sommaCPU(float *a, int n);
__global__ void prodottoScalareGPU(float *a, float *b, float *c, int n);

int main(void)
{
	float *w_h, *w_h2, s_h, *u_h, *v_h;  // host data -> CPU
	float *w_d, *u_d, *v_d, s_d; // device data -> GPU
	int N, nBytes, i, sharedDim;
	float tempoGPU, tempoCPU;
	dim3 gridDim, blockDim;

	printf("***\t Prodotto scalare vettori - 3 strategia \t***\n");

	printf("Inserisci il numero degli elementi dei vettori\n");
	scanf("%d", &N);

	blockDim.x = 64; //Configurazione ottimale
	
	// Determinazione esatta del numero di blocchi
	gridDim.x = N/blockDim.x+((N%blockDim.x)==0?0:1);

    // Dimensione dell' array condiviso fra i thread allocato dinamicamente
    sharedDim = blockDim.x * sizeof(float);

	// Inzializzazione variabili
	nBytes = N * sizeof(float);
	u_h = (float *)malloc(nBytes);
	v_h = (float *)malloc(nBytes);
	w_h = (float *)malloc(nBytes);
	w_h2 = (float *)malloc(nBytes);
	s_h = 0;
	s_d = 0;

	cudaMalloc((void **)&w_d, nBytes);
	cudaMalloc((void **)&u_d, nBytes);
	cudaMalloc((void **)&v_d, nBytes);

	//Inizializzazione dati in modo randomico
	srand((unsigned int)time(0));

	for (i = 0; i < N; i++)
	{
		u_h[i] = rand() % 5 - 2;
		v_h[i] = rand() % 5 - 2;
		
	}

	// Ricorda cudamemcpy( vettore destinazione, vettore da copiare, byte da copiare, verso di copia)
	cudaMemcpy(u_d, u_h, nBytes, cudaMemcpyHostToDevice);
	cudaMemcpy(v_d, v_h, nBytes, cudaMemcpyHostToDevice);

	// Azzero il contenuto del vettore w e gli riservo lo spazio indicato
	memset(w_h, 0, gridDim.x * sizeof(float));
	cudaMemset(w_d, 0, nBytes);

	// Calcolo del tempo di eseciuzione su GPU
	cudaEvent_t start, stop;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);
	
	cudaEventRecord(start); //Start timer

	//Invocazione del kernel
	prodottoScalareGPU<<<gridDim, blockDim, sharedDim>>>(u_d, v_d, w_d, N); //Con allocazione sharedMemory dinamica
	cudaMemcpy(w_h, w_d, gridDim.x * sizeof(float), cudaMemcpyDeviceToHost); //Passaggio dei dati ottenuti all'host

  	//Unione dei sottorisultati ottenuti del vettore ottenuto 
	//L'array avrà nella posizione iniziale di ogni blocco la somma parziale dei vari blocchi
  	for(i=0; i< gridDim.x; i++)
  	{
    	s_d += w_h[i];
  	}

	cudaEventRecord(stop); //Stop timer
	cudaEventSynchronize(stop); //Sincornizzazione del timer -> Assicura che tutti siano arrivati all'evento stop prima di registrare il tempo finale

	
	//Calcolo del tempo tra i due eventi -> in millisecondi
	cudaEventElapsedTime(&tempoGPU, start, stop);
	cudaEventDestroy(start); 
	cudaEventDestroy(stop); 
	
	printf("tempo GPU = %f\n", tempoGPU);

	cudaEventCreate(&start);
	cudaEventCreate(&stop);
	cudaEventRecord(start);

	// Calcolo prodotto scalare seriale su CPU
	prodottoScalareCPU(u_h, v_h, w_h2, N);
	s_h = sommaCPU(w_h2, N);

	cudaEventRecord(stop);
	cudaEventSynchronize(stop);
	cudaEventElapsedTime(&tempoCPU, start, stop);
	cudaEventDestroy(start);
	cudaEventDestroy(stop);

	printf("tempo CPU = %f\n", tempoCPU);

	//Controllo se il risultato corrisponde
	assert(s_h == s_d);

	if (N < 20)
	{
		for (i = 0; i < N; i++)
			printf("u_h[%d]=%.2f ", i, u_h[i]);
		printf("\n");
		for (i = 0; i < N; i++)
			printf("v_h[%d]=%.2f ", i, v_h[i]);
		printf("\n");
		for (i = 0; i < N; i++)
			printf("w_h2[%d]=%.2f ", i, w_h2[i]);
		printf("\n");

		for (i = 0; i < gridDim.x; i++)
			printf("w_h[%d]=%.2f ", i, w_h[i]);
		printf("\n");
	}

	printf("\n---> Il prodotto scalare calcolato dalla CPU è: %.2f\n", s_h);
  	printf("\n---> Il prodotto scalare calcolato dalla GPU è: %.2f", s_d);

	//Rilascio memoria utilzzata
	free(u_h);
	free(v_h);
	free(w_h);
	free(w_h2);

	cudaFree(u_d);
	cudaFree(v_d);
	cudaFree(w_d);

	return 0;
}

// Seriale
void prodottoScalareCPU(float *a, float *b, float *c, int n)
{
	int i;
	for (i = 0; i < n; i++)
		c[i] = a[i] * b[i];
}

// Seriale
float sommaCPU(float *a, int n)
{
	int i;
	float s;

	for (i = 0; i < n; i++)
	{
		s += a[i];
	}

	return s;
}

//Prodotto scalare parallelo
// -> Senza bank conflict poichè thread diversi accedono a elementi diversi di banchi diversi
// Con limitazione:
// - blockDim deve essere potenza di 2
__global__ void prodottoScalareGPU(float* a, float * b, float* c, int n){

	int distanza = blockDim.x / 2;
    extern __shared__ float s[];
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    int id = threadIdx.x;

    if(index < n)
        s[id] = a[index] * b[index];
    __syncthreads();

    // Somma in parallelo  
  	while(distanza > 0 ){
		
	    if(id < distanza){ //Lavorano thread con lo stesso id ma di warp diversi
	        s[id] = s[id] + s[id + distanza];
	    }
	    __syncthreads();

		distanza /= 2; //Divido ogni volta la distanza per 2
	}

	if(id == 0) c[blockIdx.x] = s[0];
}
