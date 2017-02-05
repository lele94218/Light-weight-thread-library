all: lwt
lwt: lwt.c main.c
	gcc -g -O3 lwt.c main.c -o main.o
