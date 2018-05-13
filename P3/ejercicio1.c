#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <pwd.h>
#include <grp.h>
#include <sys/types.h>
#include <string.h>
#include <unistd.h>
#include <ctype.h>
int main(int argc, char **argv){
   static struct option long_options[]={
		{"username",required_argument,0,'u'},
		{"useruid",required_argument,0,'i'},
		{"groupname",required_argument,0,'g'},
		{"groupuid",required_argument,0,'d'},
		{"allgroups",no_argument,0,'s'},
      {"allinfo", required_argument, 0, 'a'},
      {"bactive", no_argument, 0, 'b'},
      {"help", no_argument, 0, 'h'},
		{0, 0, 0, 0}
	};

   int uflag=0, iflag=0, gflag=0, dflag=0, sflag=0, aflag=0, bflag=0, hflag=0;
   for(int i=1; i<argc; i++){
      if(strstr(argv[i], "-u") || strstr(argv[i], "--username")){uflag=1;}
      if(strstr(argv[i], "-i") || strstr(argv[i], "--useruid")){iflag=1;}
      if(strstr(argv[i], "-g") || strstr(argv[i], "--groupname")){gflag=1;}
      if(strstr(argv[i], "-d") || strstr(argv[i], "--groupuid")){dflag=1;}
      if(strstr(argv[i], "-s") || strstr(argv[i], "--allgroups")){sflag=1;}
      if(strstr(argv[i], "-a") || strstr(argv[i], "--allinfo")){aflag=1;}
      if(strstr(argv[i], "-b") || strstr(argv[i], "--bactive")){bflag=1;}
      if(strstr(argv[i], "-h") || strstr(argv[i], "--help")){hflag=1;}
   }

   if((uflag==1 && iflag==1) || (uflag==1 && aflag==1) || (iflag==1 && aflag==1) || (gflag==1 && dflag==1) || (gflag==1 && aflag==1) || (dflag==1 && aflag==1)){
      printf("Opciones utilizadas incompatibles\n\n");
      printf("Uso del programa: ejercicio1.exe [opciones]\n");
      printf("Opciones:\n");
      printf("-h, --help\t\tImprimir esta ayuda\n");
      printf("-u, --username\t\tNombre de usuario\n");
      printf("-i, --useruid\t\tIdentificador de Usuario\n");
      printf("-g, --groupname\t\tNombre del grupo\n");
      printf("-d, --groupuid\t\tIdentificador del grupo\n");
      printf("-s, --allgroups\t\tMuestra info de todos los grupos del sistema\n");
      printf("-a, --allinfo\t\tNombre de Usuario\n");
      printf("-b, --bactive\t\tMuestra info grupo usuario Actual\n");
      return -1;
   }

   int option_index = 0;
   opterr=0;
   int c, flag=0;
   struct passwd *pw;
   struct group *gr;
   FILE *f;
   char *a, *b, *gid, *d;


   while ((c = getopt_long (argc, argv, "u:i:g:d:sa:bh", long_options, &option_index))!=-1){
      flag=1;
      switch (c){
         case 'u':
            pw = getpwnam(optarg);
            printf("Nombre: %s\n", pw->pw_gecos);
            printf("Login: %s\n", pw->pw_name);
            printf("Password: %s\n", pw->pw_passwd);
            printf("UID: %d\n", pw->pw_uid);
            printf("Home: %s\n", pw->pw_dir);
            printf("Número de grupo principal: %d\n", pw->pw_gid);
            break;

         case 'i':
            pw = getpwuid(atoi(optarg));
            printf("Nombre: %s\n", pw->pw_gecos);
            printf("Login: %s\n", pw->pw_name);
            printf("Password: %s\n", pw->pw_passwd);
            printf("UID: %d\n", pw->pw_uid);
            printf("Home: %s\n", pw->pw_dir);
            printf("Número de grupo principal: %d\n", pw->pw_gid);
            break;

         case 'g':
            gr = getgrnam(optarg);
            printf("GID: %i\n", gr->gr_gid);
            break;

         case 'd':
            gr = getgrgid(atoi(optarg));
            printf("Name: %s\n", gr->gr_name);
            break;

         case 's':
            // f=fopen("/etc/group", "r");
            // fscanf(f, "%s", a);
            // printf("%s\n", a);
            // a=strtok(a,":");
            // printf("%s", a);
            // fclose(f);

            break;

         case 'a':
            pw = getpwnam(optarg);
            printf("Nombre: %s\n", pw->pw_gecos);
            printf("Login: %s\n", pw->pw_name);
            printf("Password: %s\n", pw->pw_passwd);
            printf("UID: %d\n", pw->pw_uid);
            printf("Home: %s\n", pw->pw_dir);
            printf("Número de grupo principal: %d\n", pw->pw_gid);

            gr = getgrgid(pw->pw_gid);
            printf("Nombre del grupo principal: %s\n", gr->gr_name);
            break;

         case 'b':
            pw = getpwnam(getenv("USER"));
            gr = getgrgid(pw->pw_gid);
            printf("Nombre del grupo principal: %s\n", gr->gr_name);
            printf("GID: %i\n", gr->gr_gid);
            break;

         case 'h':
            printf("Uso del programa: ejercicio1.exe [opciones]\n");
            printf("Opciones:\n");
            printf("-h, --help\t\tImprimir esta ayuda\n");
            printf("-u, --username\t\tNombre de usuario\n");
            printf("-i, --useruid\t\tIdentificador de Usuario\n");
            printf("-g, --groupname\t\tNombre del grupo\n");
            printf("-d, --groupuid\t\tIdentificador del grupo\n");
            printf("-s, --allgroups\t\tMuestra info de todos los grupos del sistema\n");
            printf("-a, --allinfo\t\tNombre de Usuario\n");
            printf("-b, --bactive\t\tMuestra info grupo usuario Actual\n");
            break;

         case '?':
            switch (optopt) {
               case 'u':
                  fprintf (stderr, "La opción %c requiere un argumento -> -u username\n", optopt);
                  break;
               case 'i':
                  fprintf(stderr, "La opcion %c requiere un argumento -> -i UID\n", optopt);
                  break;
               case 'g':
                  fprintf(stderr, "La opcion %c requiere un argumento -> -g groupname\n", optopt);
                  break;
               case 'd':
                  fprintf(stderr, "La opcion %c requiere un argumento -> -d GID\n", optopt);
                  break;
               case 's':
                  fprintf(stderr, "La opcion %c no requiere un argumento\n", optopt);
                  break;
               case 'a':
                  fprintf(stderr, "La opcion %c requiere un argumento -> -a username\n", optopt);
                  break;
               case 'b':
                  fprintf(stderr, "La opcion %c no requiere un argumento\n", optopt);
                  break;
               case 'h':
                  fprintf(stderr, "La opcion %c no requiere un argumento\n", optopt);
                  break;
               default:
                  if(isprint (optopt)){ //Se mira si el caracter es imprimible
                     fprintf (stderr, "Opción desconocida \"-%c\". Valor de opterr = %d\n", optopt, opterr);
                  }
                  else{ //Caracter no imprimible o especial
                     fprintf (stderr, "Caracter `\\x%x'. Valor de opterr = %d\n", optopt, opterr);
                  }
            }
            printf("Uso del programa: ejercicio1.exe [opciones]\n");
            printf("Opciones:\n");
            printf("-h, --help\t\tImprimir esta ayuda\n");
            printf("-u, --username\t\tNombre de usuario\n");
            printf("-i, --useruid\t\tIdentificador de Usuario\n");
            printf("-g, --groupname\t\tNombre del grupo\n");
            printf("-d, --groupuid\t\tIdentificador del grupo\n");
            printf("-s, --allgroups\t\tMuestra info de todos los grupos del sistema\n");
            printf("-a, --allinfo\t\tNombre de Usuario\n");
            printf("-b, --bactive\t\tMuestra info grupo usuario Actual\n");
            return -1;
      }
   }

   if(flag==0){
      pw = getpwnam(getenv("USER"));
      gr = getgrgid(pw->pw_gid);
      if(strstr(getenv("LANG"), "EN")){
         printf("Nombre: %s\n", pw->pw_gecos);
         printf("Login: %s\n", pw->pw_name);
         printf("Password: %s\n", pw->pw_passwd);
         printf("UID: %d\n", pw->pw_uid);
         printf("Home: %s\n", pw->pw_dir);
         printf("Nombre del grupo principal: %s\n", gr->gr_name);
         printf("GID: %i\n", gr->gr_gid);
      }
      else{
         printf("Name: %s\n", pw->pw_gecos);
         printf("Login: %s\n", pw->pw_name);
         printf("Password: %s\n", pw->pw_passwd);
         printf("UID: %d\n", pw->pw_uid);
         printf("Home: %s\n", pw->pw_dir);
         printf("Group name: %s\n", gr->gr_name);
         printf("GID: %i\n", gr->gr_gid);
      }
   }
}
