all: lwt
dispatch: lwt_dispatch.c
	gcc -o lwt_dipatch.o lwt_dispatch.c
lwt: lwt.c main.c lwt_dispatch.o
	gcc -g -O3 lwt.c main.c lwt_dispatch.o -o main.o
