#include <stdio.h>
#include <unistd.h>

void main() {
/*  pid_t pid = fork();

   if (pid == -1) {
      perror("fork failed");
   }
   else if (pid == 0) {
	execl("/bin/sh", "/bin/sh", "linuxrc", NULL);
   }
   else {
	   while(1) sleep(10);
   }
   */
  execl("/bin/sh", "/bin/sh", "linuxrc", NULL);
}

