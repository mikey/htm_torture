LDFLAGS = -lpthread
CC = gcc -Wno-pointer-to-int-cast
DEBUG = -O0 -g
SRC = src
DEPS = $(SRC)/torture.h

%.o: $(SRC)/%.c $(DEPS)
	$(CC) $(DEBUG) -c -o $@ $< $(CFLAGS)

torture: worker.o torture.o workload.o threads.o
	$(CC) $(DEBUG) -o torture worker.o torture.o workload.o threads.o $(LDFLAGS)

asm:
	gcc -S -fverbose-asm worker.c torture.c workload.c threads.c

z: z.c
	$(CC) $(DEBUG) z.c -o z

all: torture

clean:
	rm -f *.o
	rm -f a.out
	rm -f z
	rm -fr torture
