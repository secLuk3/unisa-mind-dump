#include <assert.h>
#include <stdio.h>
#include <cuda.h>
#include <time.h>

void sommaMatriciCPU(float *a, float *b, float *c, int m, int n);

__global__ void sommaMatriciGPU(float *a, float *b, float *c, int m, int n);

void stampaMatrice(float *a, int M);

int main(void)
{
	float *w_h, *w_h2, *u_h, *v_h; // host data
	float *w_d, *u_d, *v_d;		   // device data
	int M, nBytes, i, j,  dimMatrix;
	dim3 gridDim, blockDim;

	printf("***\t SOMMA DI DUE MATRICI QUADRATE \t***\n");

	printf("Inserisci le dimensioni delle matrici M x M\n");
	scanf("%d", &M);

	dimMatrix = M * M;

	//Configurazione Kernel

	//Dimensione del singolo blocco (1D, 2D o 3D)
	blockDim.x = 32; 
	blockDim.y = 32;

	// determinazione esatta del numero di blocchi
	gridDim.x = M / blockDim.x +
			  ((M % blockDim.x) == 0 ? 0 : 1);
	gridDim.y = M / blockDim.y +
			  ((M % blockDim.y) == 0 ? 0 : 1);

	// izializzazione variabili
	nBytes = dimMatrix * sizeof(float);
	u_h = (float *)malloc(nBytes);
	v_h = (float *)malloc(nBytes);
	w_h = (float *)malloc(nBytes);
	w_h2 = (float *)malloc(nBytes);

	cudaMalloc((void **)&w_d, nBytes);
	cudaMalloc((void **)&u_d, nBytes);
	cudaMalloc((void **)&v_d, nBytes);

	// inizializzo i dati
	/*Inizializza la generazione random dei vettori utilizzando l'ora attuale del sistema*/
	srand((unsigned int)time(0));

	for (i = 0; i < M; i++)
	{
		for(j=0; j< M; j++){
			u_h[i*M+j] = rand() % 5 - 2;
			v_h[i*M+j] = rand() % 5 - 2;
		}
		
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
	sommaMatriciGPU<<<gridDim, blockDim>>>(u_d, v_d, w_d, M, M);

	cudaEventRecord(stop);
	cudaEventSynchronize(stop); // assicura che tutti siano arrivati all'evento stop prima di registrare il tempo

	float elapsed;
	// tempo tra i due eventi in millisecondi
	cudaEventElapsedTime(&elapsed, start, stop);
	cudaEventDestroy(start);
	cudaEventDestroy(stop);

	printf("tempo GPU = %f\n\n", elapsed);

	cudaMemcpy(w_h, w_d, nBytes, cudaMemcpyDeviceToHost);

	cudaEventCreate(&start);
	cudaEventCreate(&stop);
	cudaEventRecord(start);
	// calcolo prodotto scalare seriale su CPU
	sommaMatriciCPU(u_h, v_h, w_h2, M, M);

	cudaEventRecord(stop);
	cudaEventSynchronize(stop);
	cudaEventElapsedTime(&elapsed, start, stop);
	cudaEventDestroy(start);
	cudaEventDestroy(stop);

	printf("tempo CPU = %f\n", elapsed);

	// verifica che i risultati di CPU e GPU siano uguali
	// se non stampa nulla, i due vettori sono uguali
	for (i = 0; i < M; i++)
	{
		for(j= 0; j < M; j++){
			assert(w_h[i*M+j] == w_h2[i*M+j]);
		}
	}
		

	if (M < 20)
	{
		printf("Matrice U\n");
		stampaMatrice(u_h, M);

		printf("Matrice V\n");
		stampaMatrice(v_h, M);

		printf("Matrice somma risultante\n");
		stampaMatrice(w_h, M);
	}

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
void sommaMatriciCPU(float *a, float *b, float *c, int m, int n)
{
	int i, j;
	for (i = 0; i < m; i++){
		for(j = 0; j < n; j++){
			c[i*n+j] = a[i*n+j] + b[i*n+j];
		}
	}
		
}

// Parallelo
__global__ void sommaMatriciGPU(float *a, float *b, float *c, int m, int n)
{
	int i = blockIdx.x * blockDim.x + threadIdx.x;
	int j = blockIdx.y * blockDim.y + threadIdx.y;
	
	int index = j * gridDim.x  *  blockDim.x + i;
	
	if (index < n*m)
		c[index] = a[index] + b[index];
}

//stampa matrice
void stampaMatrice(float *a, int M)
{
	int i, j;

	for (i = 0; i < M; i++)
	{
		for(j = 0; j < M; j++){
			printf("%.2f\t", a[i*M+j]);
		}
		printf("\n");
	}
}
