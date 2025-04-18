//CIAO
#include <assert.h>
#include <stdio.h>
#include <cuda.h>
#include <time.h>

void prodottoScalareCPU(float *a, float *b, float *c, int n);
float sommaCPU(float *a, int n);

__global__ void prodottoScalareGPU(float *a, float *b, float *c, int n);

int main(void)
{
	float *w_h, *w_h2, s_h, *u_h, *v_h; // host data
	float *w_d, *u_d, *v_d;				// device data
	int N, nBytes, i;
	dim3 gridDim, blockDim;

	printf("***\t PRODOTTO DI DUE VETTORI \t***\n");

	printf("Inserisci il numero degli elementi dei vettori\n");
	scanf("%d", &N);

	printf("Inserisci il numero di thread per blocco\n");
	scanf("%d", &blockDim.x);

	// determinazione esatta del numero di blocchi
	gridDim = N / blockDim.x +
			  ((N % blockDim.x) == 0 ? 0 : 1);

	// izializzazione variabili
	nBytes = N * sizeof(float);
	u_h = (float *)malloc(nBytes);
	v_h = (float *)malloc(nBytes);
	w_h = (float *)malloc(nBytes);
	w_h2 = (float *)malloc(nBytes);
	s_h = 0;

	cudaMalloc((void **)&w_d, nBytes);
	cudaMalloc((void **)&u_d, nBytes);
	cudaMalloc((void **)&v_d, nBytes);

	// inizializzo i dati
	/*Inizializza la generazione random dei vettori utilizzando l'ora attuale del sistema*/
	srand((unsigned int)time(0));

	for (i = 0; i < N; i++)
	{
		u_h[i] = rand() % 5 - 2;
		v_h[i] = rand() % 5 - 2;
		
	}

	// cudamemcpy( vettore destinazione, vettore da copiare, n byte da copiare, tipo di copia)
	cudaMemcpy(u_d, u_h, nBytes, cudaMemcpyHostToDevice);
	cudaMemcpy(v_d, v_h, nBytes, cudaMemcpyHostToDevice);

	// azzeriamo il contenuto del vettore w
	memset(w_h, 0, nBytes);
	cudaMemset(w_d, 0, nBytes);

	// inizializzo i contatori per il tempo di eseciuzione su GPU
	cudaEvent_t start, stop;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);

	cudaEventRecord(start);
	// invocazione del kernel
	prodottoScalareGPU<<<gridDim, blockDim>>>(u_d, v_d, w_d, N);

	cudaEventRecord(stop);
	cudaEventSynchronize(stop); // assicura che tutti siano arrivati all'evento stop prima di registrare il tempo

	float elapsed;
	// tempo tra i due eventi in millisecondi
	cudaEventElapsedTime(&elapsed, start, stop);
	cudaEventDestroy(start);
	cudaEventDestroy(stop);

	printf("tempo GPU = %f\n", elapsed);

	cudaMemcpy(w_h, w_d, nBytes, cudaMemcpyDeviceToHost);

	cudaEventCreate(&start);
	cudaEventCreate(&stop);
	cudaEventRecord(start);
	// calcolo prodotto scalare seriale su CPU
	prodottoScalareCPU(u_h, v_h, w_h2, N);

	cudaEventRecord(stop);
	cudaEventSynchronize(stop);
	cudaEventElapsedTime(&elapsed, start, stop);
	cudaEventDestroy(start);
	cudaEventDestroy(stop);

	printf("tempo CPU = %f\n", elapsed);

	// verifica che i risultati di CPU e GPU siano uguali
	// se non stampa nulla, i due vettori sono uguali
	for (i = 0; i < N; i++)
		assert(w_h[i] == w_h2[i]);

	if (N < 20)
	{
		for (i = 0; i < N; i++)
			printf("u_h[%d]=%6.2f ", i, u_h[i]);
		printf("\n");
		for (i = 0; i < N; i++)
			printf("v_h[%d]=%6.2f ", i, v_h[i]);
		printf("\n");
		for (i = 0; i < N; i++)
			printf("w_h[%d]=%6.2f ", i, w_h[i]);
		printf("\n");
	}

	s_h = sommaCPU(w_h, N);
	printf("Il prodotto è: %6.2f", s_h);

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

// Parallelo
__global__ void prodottoScalareGPU(float *a, float *b, float *c, int n)
{
	int index = threadIdx.x + blockIdx.x * blockDim.x;
	if (index < n)
		c[index] = a[index] * b[index];
}
