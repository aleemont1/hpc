/*mpi-hello.c*/

/**
 * Compile with:
 * mpicc -Wall -Wpedantic --std=c99 mpi-hello.c -o mpi-hello
 * Exec with:
 * mpirun --oversubscribe -n NUMBER_OF_PROCESSORS ./mpi-hello
*/

#include <stdio.h>
#include <mpi.h>

int main(int argc, char *argv[])
{
    int rank, size, len;
    char hostname[MPI_MAX_PROCESSOR_NAME];
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Get_processor_name(hostname, &len);
    printf("Greetings from process %d of %d running on %s\n",
           rank, size, hostname);
    MPI_Finalize();
    return 0;
}
