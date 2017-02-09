CC = gcc
CFLAGS = -Wall -O3
DEBUG = -g -D DEBUG
PROFILE = -Wall -pg -O3 
TARGET = main.o
SRCS = main.c lwt.c
MAIN = lwt

all: $(MAIN)
$(MAIN): $(SRCS)
	$(CC) $(CFLAGS) $(SRCS) -o $(TARGET)
debug: $(SRCS)
	$(CC) $(DEBUG) $(SRCS) -o $(TARGET)
profile: $(SRCS)
	$(CC) $(PROFILE) $(SRCS) -o $(TARGET)
	./$(TARGET)
	gprof $(TARGET) gmon.out | ./gprof2dot.py | dot -Tpng -o output.png
clean:
	$(RM) *.o $(TARGET)
