CC = gcc
CFLAGS = -Wall -O3
DEBUG = -g -D DEBUG
TARGET = ./build/main
SRCS = main2.c lwt.c
MAIN = lwt

all: $(MAIN)
$(MAIN): $(SRCS)
	$(CC) $(CFLAGS) $(SRCS) -o $(TARGET)
debug: $(SRCS)
	$(CC) $(DEBUG) $(SRCS) -o $(TARGET)
clean:
	$(RM) *.o $(TARGET)
