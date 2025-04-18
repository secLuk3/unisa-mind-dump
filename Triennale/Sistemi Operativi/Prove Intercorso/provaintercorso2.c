#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <ctype.h>   // aggiunta libreria

#define MAX_SIZE 8192

int main(){

int pid1,status,n,fd1,fd2 , consonanti = 0; //aggiunnta la variabile consonanti
char buf[MAX_SIZE] , buf2[MAX_SIZE]; //aggiunto secondo buffer usato per selezionare le consonanti lette la primo buf

signal(SIGINT, SIG_IGN);

pid1 = fork();

if(pid1 < 0 )
	{
	fprintf(stderr , " Errore nella fork");
	exit(1);
	}
else if (pid1 == 0)
	{
		fd1 = open( "provaintercorso2.c" , O_RDONLY); //nella prova ho scritto O_RONLY
		fd2 = open( "TOPOLINO.txt" , O_WRONLY | O_CREAT , S_IRWXU ); //nella prova ho scritto S_IRWX

		if ( fd1  < 0 || fd2 < 0)    //aggiunto controllo su apertura dei file
		{
		fprintf(stderr, "Errore apertura file\n");
		exit(1);
		}

		while( ( n = read(fd1 , buf , MAX_SIZE)) > 0) // parentesi tonda mancata
		{
			for (int i= 0 ; i < n ; i++)
			{
				if( buf[i]!= 'a' && buf[i]!= 'e' && buf[i]!= 'i' && buf[i]!= 'o' && buf[i]!='u' &&                    // if ottimizzato controllanado se buf[i] e un carattere
				 		buf[i]!= 'A' && buf[i]!= 'E' && buf[i]!= 'I' && buf[i]!= 'O' && buf[i]!='U' && isalpha(buf[i]))
				{
					buf2[consonanti] = buf[i]; //usato secondo buffer su cui memorizzare solo le consonanti
					consonanti++; //incremento la variabile consonanti
				}
			}
	       if( consonanti != write(fd2 , buf2 , consonanti))  // aggiunto controllo sulla write
				 {
					fprintf(stderr , " Errore nella write\n");
					exit(1);
				 }
	               	printf("numero di consonanti copiate : %d\n" , consonanti ); //mancate virgolette
     }
		 		close(fd1); //aggiunto close
				close(fd2); //aggiunto close
		 		exit(1);
		}
	else

	printf("Terminato figlio con pid : %d\n " , wait(&status)); // mancate virgolette

	return 0;
}
