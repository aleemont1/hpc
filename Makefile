SHELL=/bin/bash
CC = gcc
MPICC = mpicc
CFLAGS = --std=c99 -Wall -Wpedantic

OMP_SRC := $(wildcard omp/*/*.c)
MPI_SRC := $(wildcard mpi/*/*.c)

# Generate names for the compiled files
OMP_BIN := $(patsubst %.c,%,$(OMP_SRC))
MPI_BIN := $(patsubst %.c,%,$(MPI_SRC))

all: omp mpi

omp: $(OMP_BIN)

mpi: $(MPI_BIN)

omp/%: omp/%.c
	$(CC) $(CFLAGS) -fopenmp $< -o $@ -lm

mpi/%: mpi/%.c
	$(MPICC) $(CFLAGS) $< -o $@

clean:
	rm -f $(OMP_BIN) $(MPI_BIN) omp/raytracer/*{ppm,xmp}