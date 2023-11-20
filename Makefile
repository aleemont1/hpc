SHELL=/bin/bash

CPUCOUNT := $(shell grep -c "^processor" /proc/cpuinfo)

CC ?= gcc
MPICC ?= mpicc
CFLAGS = --std=c99 -Wall -Wpedantic

OMP_SRC := $(wildcard omp/*/*.c)
MPI_SRC := $(wildcard mpi/*/*.c)

# Generate names for the compiled files
OMP_BIN := $(patsubst %.c,%,$(OMP_SRC))
MPI_BIN := $(patsubst %.c,%,$(MPI_SRC))

.PHONY: all multi clean

#default: single job run
all: omp mpi

#multi-job run
multi: omp_ mpi_

#omp compilation (multiple jobs)
%_:
	@echo "Running: $(CPUCOUNT) jobs for $*"
	$(MAKE) -j$(CPUCOUNT) $*

#omp compilation (single job)
omp: $(OMP_BIN)

#mpi compilation (single job)
mpi: $(MPI_BIN)

#compile omp files
omp/%: omp/%.c
	$(CC) $(CFLAGS) -fopenmp $< -o $@ -lm

#compile mpi files
mpi/%: mpi/%.c
	$(MPICC) $(CFLAGS) $< -o $@

clean:
	rm -f $(OMP_BIN) $(MPI_BIN) */**/*{ppm,xmp,png}