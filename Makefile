all: lwt
lwt: lwt.c main.c lwt_dispatch.o
	gcc -g -o main.o lwt.c main.c lwt_dispatch.o
