#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	printf("page=%ld\n", sysconf(_SC_PAGE_SIZE));
	return 0;
}
