CC = gcc
CFLAGS = -Wall -O3
DEBUG = -g -D DEBUG
TARGET = ./build/main
SRCS = main3.c lwt.c lwt_chl.c
TSTSRC = test.c lwt.c lwt_chl.c
MAIN = lwt

all: $(MAIN)
$(MAIN): $(SRCS)
	if [ ! -f ./build/main ]; then mkdir build;fi 
	$(CC) $(CFLAGS) $(SRCS) -o $(TARGET)
debug: $(SRCS)
	$(CC) $(DEBUG) $(SRCS) -o $(TARGET)
test: $(TSTSRC)
	$(CC) $(DEBUG) $(TSTSRC) -o $(TARGET)

clean:
	$(RM) *.o $(TARGET)
