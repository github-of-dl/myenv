all:
	mkdir -p bin
	g++ -Wall -g -o bin/perrno perrno.c
	g++ -Wall -g -o bin/psysconf psysconf.c
	g++ -Wall -g -o bin/mysqlwrapper mysqlwrapper.c -I/usr/local/mysql/include -L/usr/local/mysql/lib -l:libmysqlclient.a -lpthread -ldl -lrt -lz

clean:
	-rm bin/*
