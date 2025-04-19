#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <stdio.h>

int main(int argc, char **argv, char **envp)
{
  char *buffer;
  gid_t gid;
  uid_t uid;
  char *username; 

	username=getlogin();
  
  gid = getegid();
  uid = geteuid();
  setresgid(gid, gid, gid);
  setresuid(uid, uid, uid);
  
  buffer = NULL
  asprintf(&buffer, "/bin/echo %s is cool", username);
  printf("about to call system(\"%s\")\n", buffer);
  
  system(buffer);
}
