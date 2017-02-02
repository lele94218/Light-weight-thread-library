all: lwt		
lwt: lwt.c main.c	
	gcc -g -o main.o lwt.c main.c
