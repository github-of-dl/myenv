#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
	int error_number = 0;
	if(argc>1)
	{
		error_number = atoi(argv[1]);
	}
	printf("[%d] -> [%s]\n", error_number, strerror(error_number));
	return 0;
}
