#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include <time.h>
#include <cuda_runtime.h>
#include <cublas_v2.h>

void prod_mat_v(float w[], float *a, int ROWS, int COLS, float v[]);
void generaMatrice(float *A, int M, int N);
void stampa_matrice(float *A, int M, int N);
void generaVettore(float *v, int N);
void stampaVettore(float *v, int N);

int main (void){
    cudaError_t cudaStat;
    cublasStatus_t stat;
    cublasHandle_t handle;
    float* h_A = 0;     // Host matrice A
    float* d_A;         // Device array A
    float* h_b = 0;     // Host array b
    float *d_b;         // Device array b
    float *h_r = 0;     // Host risultato
    float *d_r;         // Device risultato

	int M; //Numero righe
    int N; //Numero colonne
    float *h_v;  //Risultato seriale

    printf("Inserisci numero di righe M della matrice: ");
    scanf("%d", &M);

    printf("Inserisci numero di colonne N della matrice: ");
    scanf("%d", &N);

    h_A = (float *)malloc (M * N * sizeof (*h_A));      // Alloco h_A e lo inizializzo
    if (!h_A) {
        printf ("host memory allocation failed");
        return EXIT_FAILURE;
    }
    
    generaMatrice(h_A, M, N);

    h_b = (float *)malloc (N * sizeof (*h_b));  // Alloco h_b e lo inizializzo
    if (!h_b) {
        printf ("host memory allocation failed");
        return EXIT_FAILURE;
    }

    generaVettore(h_b, N);

    if(M < 10 && N < 10){
        stampa_matrice(h_A, M, N);
        stampaVettore(h_b, N);
    }


    cudaStat = cudaMalloc ((void**)&d_A, M * N * sizeof(*h_A));       // Alloco d_a
    if (cudaStat != cudaSuccess) {
        printf ("device memory allocation failed");
        return EXIT_FAILURE;
    }
    
    cudaStat = cudaMalloc ((void**)&d_b, N*sizeof(*h_b));       // Alloco d_b
    if (cudaStat != cudaSuccess) {
        printf ("device memory allocation failed");
        return EXIT_FAILURE;
    }
    
    stat = cublasCreate(&handle);               // Creo l'handle per cublas
    if (stat != CUBLAS_STATUS_SUCCESS) {
        printf ("CUBLAS initialization failed\n");
        return EXIT_FAILURE;
    }
    
    stat = cublasSetMatrix(M, N, sizeof(float), h_A, M, d_A, M);    // Setto h_A su d_A
    if (stat != CUBLAS_STATUS_SUCCESS) {
        printf ("Matrice non impostata");
        cudaFree (d_A);
        cublasDestroy(handle);
        return EXIT_FAILURE;
    }
    
    stat = cublasSetVector(N, sizeof(float), h_b, 1, d_b, 1);    // Setto h_b su d_b
    if (stat != CUBLAS_STATUS_SUCCESS) {
        printf ("Vettore molitplicatore non impostato! ");
        cudaFree (d_b);
        cublasDestroy(handle);
        return EXIT_FAILURE;
    }

    h_r = (float *)malloc(M * sizeof(float));
    if (!h_r) {
        printf ("host memory allocation failed");
        return EXIT_FAILURE;
    }


    cudaStat = cudaMalloc ((void**)&d_r, M*sizeof(*h_r));       // Alloco d_r
    if (cudaStat != cudaSuccess) {
        printf ("device memory allocation failed");
        return EXIT_FAILURE;
    }
    
    stat = cublasSetVector(M, sizeof(float), h_r, 1, d_r, 1);    // Setto h_r su d_r
    if (stat != CUBLAS_STATUS_SUCCESS) {
        printf ("Vettore risultato non scaricato!");
        cudaFree (d_r);
        cublasDestroy(handle);
        return EXIT_FAILURE;
    }

    
    
     // parte calcolo GPU
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);

    float alfa = 1, beta = 0;
    stat = cublasSgemv(handle, CUBLAS_OP_T, M, N, &alfa, d_A, M, d_b, 1, &beta, d_r, 1);
    cudaMemcpy(h_r, d_r, M * sizeof(float), cudaMemcpyDeviceToHost); //Passo i dati all'host

    cudaEventRecord(stop);
    cudaEventSynchronize(stop); // assicura che tutti siano arrivati all'evento stop prima di registrare il tempo

    
    float tempoGPU;
    // tempo tra i due eventi in millisecondi
    cudaEventElapsedTime(&tempoGPU, start, stop);
    cudaEventDestroy(start);
    cudaEventDestroy(stop);
    printf("\ntempo GPU=%f\n", tempoGPU);

    if (stat != CUBLAS_STATUS_SUCCESS) {
        printf ("data download failed cublasSdot");
        cudaFree (d_A);
        cudaFree (d_b);
        cublasDestroy(handle);
        return EXIT_FAILURE;
    }

     // calcolo su CPU
    h_v = (float *)malloc(N*sizeof(float));
    if(!h_v){
         printf ("Allocazione memoria fallita!!");
        return EXIT_FAILURE;
    }

    float tempoCPU;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start);

     // calcolo somma seriale
    prod_mat_v(h_v, h_A, M, N, h_b);

    cudaEventRecord(stop);
    cudaEventSynchronize(stop); // assicura che tutti siano arrivati all'evento stop prima di registrare il tempo
    cudaEventElapsedTime(&tempoCPU, start, stop);
    cudaEventDestroy(start);
    cudaEventDestroy(stop);
    
    printf("\ntempo CPU=%f\n", tempoCPU);


    //Controllo se i risultati sono uguali
    for (int i = 0; i < M ; i++)
	{
       assert(h_v[i] == h_r[i]);	
	}

    
    if(M < 10){
        printf("Risultato del prodotto mat-vet su GPU = \n");
        stampaVettore(h_r, M);

        printf("Risultato del prodotto mat-vet su CPU = \n");
        stampaVettore(h_v, M);
    }


    cudaFree (d_A);     // Dealloco d_a
    cudaFree (d_b);     // Dealloco d_b
    cudaFree (d_r);     // Dealloco d_b
    
    cublasDestroy(handle);  // Distruggo l'handle
    
    free(h_A);      // Dealloco h_a
    free(h_b);      // Dealloco h_b    
    free(h_r);
    free(h_v);

    return EXIT_SUCCESS;
}


/**
 * Funzione che esegue il prodotto matrice vettore
*/
void prod_mat_v(float w[], float *a, int ROWS, int COLS, float v[])
{
    int i, j;

    for (i = 0; i < ROWS; i++)
    {
        w[i] = 0;
        for (j = 0; j < COLS; j++)
        {
            w[i] += a[i * COLS + j] * v[j];
        }
    }
}

/**
* Funzione che esegue la stampa delle matrice 
* 
*/
void stampa_matrice(float *A, int M, int N)
{
    int i, j;
    printf("\nMatrice = \n");
    for (i = 0; i < M; i++)
    {
        for (j = 0; j < N; j++)
        {
            printf("\t%.2f", A[i * M + j]);
        }
        printf("\n");
    }
}

/**
* Funzione che genera un vettore di dimensione N 
* 
*/
void generaVettore(float *v, int N){
    int j;
    printf("\n...Genero vettore di dimensione %d...", N);
    for (j = 0; j < N; j++)
    {
        v[j] = j;
    }

}

/**
* Funzione che stampa un vettore di dimensione N 
* 
*/
void stampaVettore(float *v, int N){
    int j;
    printf("\nVettore = \n");
    for (j = 0; j < N; j++)
    {
          printf("\t%.2f\n", v[j]);
    }
    
}

/**
* Funzione che genera una matrice di dimensione M, N 
* 
*/
void generaMatrice(float *A, int M, int N){
    
    int i,j;

    printf("\n...Genero matrice di dimensione %dx%d...",M, N);
    for (i = 0; i < M; i++)
    {
        for (j = 0; j < N; j++)
        {
            if (j == 0)
                A[i * N + j] = (float) ( rand() % 2 ) - 2;
            else
                A[i * N + j] = (float) ( rand() % 5 ) - 2;
        }
    }

}

    