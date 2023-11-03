CC=       	gcc
CFLAGS= 	-g -gdwarf-2 -std=gnu99 -Wall -lmemalloc -pedantic -ansi --std=c99
CLFLAGS= 	-g -gdwarf-2 -std=gnu99 -Wall -pedantic -ansi
LDFLAGS=
LIBRARIES=      lib/libmemalloc.a

all:   unit_test benchmark1 benchmark2 benchmark3 benchmark4 benchmark5 benchmark1_tracy benchmark2_tracy benchmark3_tracy benchmark4_tracy benchmark5_tracy

benchmark1: benchmark1.o libmemalloc.a
	gcc -o benchmark1 benchmark1.o -L. -lmemalloc -g

benchmark2: benchmark2.o libmemalloc.a
	gcc -o benchmark2 benchmark2.o -L. -lmemalloc -g

benchmark3: benchmark3.o libmemalloc.a
	gcc -o benchmark3 benchmark3.o -L. -lmemalloc -g

benchmark4: benchmark4.o libmemalloc.a
	gcc -o benchmark4 benchmark4.o -L. -lmemalloc -g

benchmark5: benchmark5.o libmemalloc.a
	gcc -o benchmark5 benchmark5.o -L. -lmemalloc -g

benchmark1_tracy: benchmark1.o libmemalloc_tracy.a
	gcc -o benchmark1_tracy benchmark1.o -L. -lmemalloc_tracy -lTracyClient -g -v

benchmark2_tracy: benchmark2.o libmemalloc_tracy.a
	gcc -o benchmark2_tracy benchmark2.o -L. -lmemalloc_tracy -lTracyClient -g -v

benchmark3_tracy: benchmark3.o libmemalloc_tracy.a
	gcc -o benchmark3_tracy benchmark3.o -L. -lmemalloc_tracy -lTracyClient -g -v

benchmark4_tracy: benchmark4.o libmemalloc_tracy.a
	gcc -o benchmark4_tracy benchmark4.o -L. -lmemalloc_tracy -lTracyClient -g -v

benchmark5_tracy: benchmark5.o libmemalloc_tracy.a
	gcc -o benchmark5_tracy benchmark5.o -L. -lmemalloc_tracy -lTracyClient -g -v

unit_test: main.o libmemalloc.a
	gcc -o unit_test main.o -L. -lmemalloc -g -v

main.o: src/main.c
	gcc  -c  -Wall -Wno-self-assign -Wno-nonnull src/main.c -g -Isrc/memalloc -Iext/tinytest

benchmark1.o: benchmarks/benchmark1.c
	gcc  -c -Wall benchmarks/benchmark1.c -g -Isrc/memalloc

benchmark2.o: benchmarks/benchmark2.c
	gcc  -c -Wall benchmarks/benchmark2.c -g -Isrc/memalloc

benchmark3.o: benchmarks/benchmark3.c
	gcc  -c -Wall benchmarks/benchmark3.c -g -Isrc/memalloc

benchmark4.o: benchmarks/benchmark4.c
	gcc  -c -Wall benchmarks/benchmark4.c -g -Isrc/memalloc

benchmark5.o: benchmarks/benchmark5.c
	gcc  -c -Wall benchmarks/benchmark5.c -g -Isrc/memalloc

memalloc.o: src/memalloc/memalloc.c
	gcc  -c  -Wall src/memalloc/memalloc.c -g -Isrc/memalloc

memalloc_tracy.o: src/memalloc/memalloc.c
	gcc  -c  -Wall src/memalloc/memalloc.c -g -o memalloc_tracy.o -Isrc/memalloc -Iext/tracy-0.10 -D_TRACY_C -v

libmemalloc.a: memalloc.o
	ar rcs libmemalloc.a memalloc.o

libmemalloc_tracy.a: memalloc_tracy.o
	ar rcs libmemalloc_tracy.a memalloc_tracy.o

clean:
	rm -f *.o *.a unit_test main benchmark1 benchmark2 benchmark3 benchmark4 benchmark5 benchmark1_tracy benchmark2_tracy benchmark3_tracy benchmark4_tracy benchmark5_tracy

.PHONY: all clean
