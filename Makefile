CC = gcc
CFLAGS = -Wall -O3 -D SAFE_MODE
DEBUG = -g -D DEBUG
UNSAFE = -Wall -O3 
TARGET = main.o
SRCS = main.c lwt.c
MAIN = lwt

all: $(MAIN)
$(MAIN): $(SRCS)
	$(CC) $(CFLAGS) $(SRCS) -o $(TARGET)
debug: $(SRCS)
	$(CC) $(DEBUG) $(SRCS) -o $(TARGET)
unsafe: $(SRCS)
	$(CC) $(UNSAFE) $(SRCS) -o $(TARGET)
clean:
	$(RM) *.o $(TARGET)
