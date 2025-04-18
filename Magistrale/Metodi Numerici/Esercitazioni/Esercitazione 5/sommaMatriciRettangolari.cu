#include <assert.h>
#include <stdio.h>
#include <cuda.h>
#include <time.h>

void sommaMatriciCPU(float *a, float *b, float *c, int n);

__global__ void sommaMatriciGPU(float *a, float *b, float *c, int n);

void stampaMatrice(float *a, int M, int N);

int main(void)
{
	float *w_h, *w_h2, *u_h, *v_h; // host data
	float *w_d, *u_d, *v_d;		   // device data
	int N, M, nBytes, i, dimMatrix;
	dim3 gridDim, blockDim;

	printf("***\t SOMMA DI DUE MATRICI RETTANGOLARI \t***\n");

	printf("Inserisci il numero delle righe matrice M x N\n");
	scanf("%d", &M);

	printf("Inserisci il numero delle colonne della matrice M x N\n");
	scanf("%d", &N);

	dimMatrix = M * N;

	// configurazione kernel
	blockDim.x = 16;
	blockDim.y = 4;
	gridDim.x = M / blockDim.x + ((M % blockDim.x) == 0 ? 0 : 1);
	gridDim.y = N / blockDim.y + ((N % blockDim.y) == 0 ? 0 : 1);


	// izializzazione variabili
	nBytes = dimMatrix * sizeof(float);
	u_h = (float *)malloc(nBytes);
	v_h = (float *)malloc(nBytes);
	w_h = (float *)malloc(nBytes);
	w_h2 = (float *)malloc(nBytes);

	cudaMalloc((void **)&u_d, nBytes);
	cudaMalloc((void **)&v_d, nBytes);
	cudaMalloc((void **)&w_d, nBytes);

	// inizializzo i dati
	/*Inizializza la generazione random dei vettori utilizzando l'ora attuale del sistema*/
	srand((unsigned int)time(0));

	for (i = 0; i < dimMatrix; i++)
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
	sommaMatriciGPU<<<gridDim, blockDim>>>(u_d, v_d, w_d, dimMatrix);

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

	// calcolo somma matrice seriale su CPU
	sommaMatriciCPU(u_h, v_h, w_h2, dimMatrix);

	cudaEventRecord(stop);
	cudaEventSynchronize(stop);
	cudaEventElapsedTime(&elapsed, start, stop);
	cudaEventDestroy(start);
	cudaEventDestroy(stop);

	printf("tempo CPU = %f\n\n", elapsed);


	// verifica che i risultati di CPU e GPU siano uguali
	// se non stampa nulla, i due vettori sono uguali
	for (i = 0; i < dimMatrix; i++)
	{
		assert(w_h[i] == w_h2[i]);
	}

	if (N < 20)
	{
		printf("Matrice U da host\n");
		stampaMatrice(u_h, M, N);

		printf("Matrice V da host\n");
		stampaMatrice(v_h, M, N);

		printf("Matrice somma risultante da device\n");
		stampaMatrice(w_h, M, N);
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
void sommaMatriciCPU(float *a, float *b, float *c, int n)
{
	int i;
	for (i = 0; i < n; i++)
		c[i] = a[i] + b[i];
}

// Parallelo
__global__ void sommaMatriciGPU(float *a, float *b, float *c, int n)
{
	int i = threadIdx.x + blockIdx.x * blockDim.x;
	int j = blockIdx.y * blockDim.y + threadIdx.y;
	int index = j * gridDim.x * blockDim.x + i;

	if (index < n)
		c[index] = a[index] + b[index];
}

// stampa matrice
void stampaMatrice(float *a, int M, int N)
{
	int i, j;

	for (i = 0; i < M; i++)
	{
		for (j = 0; j < N; j++)
		{
			printf("%.2f\t", a[i*N+j]);
		}
		printf("\n");
	}
}
