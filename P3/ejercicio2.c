#include <stdio.h>
#include <stdlib.h> //exit, rand, srand
#include <unistd.h> //pipe, close, fork, usleep, read, write, getpid, getppid
#include <sys/wait.h> //wait
#include <errno.h> //Control de errores
int main(){
   pid_t flag;
   int status;
   int fildes1[2], fildes2[2];
   const int BSIZE = 100;
   char buf[BSIZE];
   ssize_t nbytes;

   status = pipe(fildes1);
   if(status==-1){
      perror("Error al crear la tuberia");
      exit(EXIT_FAILURE);
   }

   status = pipe(fildes2);
   if(status==-1){
      perror("Error al crear la tuberia");
   }

   switch (fork()) {
      case -1:
         perror("No se ha podido crear el proceso hijo...");
         exit(EXIT_FAILURE);

      case 0:
         if(close(fildes1[1])==-1){
            perror("Error en close");
            exit(EXIT_FAILURE);
         }
         int entero=0;
         nbytes=read(fildes1[0], &entero, sizeof(int));
         if (nbytes == -1){
   			perror("Error en read");
   			exit(EXIT_FAILURE);
		   }
		   else{
            if (nbytes == 0){
               printf("[HIJO]: Detecto que mi padre ha cerrado la tuberia 1...\n");
            }
		      else{
			      printf("[HIJO]: Leido %i de la tuberia 1.\n", entero);
            }
         }
         if(close(fildes1[0])==-1){
               perror("Error en close");
               exit(EXIT_FAILURE);
         }

         //escribir en la segunda tuberia
         if (close(fildes2[0]) == -1){
   			perror("Error en close");
   			exit(EXIT_FAILURE);
   		}

         if(entero%2==0){
            if(write(fildes2[1], "PAR", 3) == -1){
               perror("Error en write");
               exit(EXIT_FAILURE);
      		}
         }
         else{
            if(write(fildes2[1], "IMPAR", 5) == -1){
               perror("Error en write");
               exit(EXIT_FAILURE);
            }
         }
         if (close(fildes2[1]) == -1){
   			perror("Error en close");
   			exit(EXIT_FAILURE);
   		}
   		else{
            printf("[HIJO]: Tuberia 1 cerrada.\n");
            exit(EXIT_SUCCESS);
         }

      default:
         if(close(fildes1[0]) == -1){
            perror("Error en close");
            exit(EXIT_FAILURE);
         }

         int numero=0;
         printf("Introduce un numero por pantalla\n");
         scanf("%i", &numero);

         if(write(fildes1[1], &numero, sizeof(int)) == -1){
            perror("Error en write");
            exit(EXIT_FAILURE);
         }

         if(close(fildes1[1]) == -1){
            perror("Error en close");
            exit(EXIT_FAILURE);
         }

         wait(&status);

         if(close(fildes2[1])==-1){
            perror("Error en close");
            exit(EXIT_FAILURE);
         }

         nbytes=read(fildes2[0], buf, BSIZE);
         if (nbytes == -1){
            printf ("hola\n");
   			perror("Error en read");
   			exit(EXIT_FAILURE);
		   }
		   else{
            if(nbytes == 0){
               printf("[HIJO]: Detecto que mi padre ha cerrado la tuberia...\n");
            }
		      else{
			      printf("EL numero es %s.\n", buf);
            }
         }
         if(close(fildes2[0])==-1){
               perror("Error en close");
               exit(EXIT_FAILURE);
         }
   }
}
