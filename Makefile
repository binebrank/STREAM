GEM5SRC = /home/jusers/brank1/juawei/gem5_armhost
CC = gcc
CFLAGS = -O3 -fopenmp -static

FC = gfortran
FFLAGS = -O3 -fopenmp -static

all: stream_f.exe stream_c.exe stream_c_gem5roi.exe

stream_f.exe: stream.f mysecond.o
	$(CC) $(CFLAGS) -c mysecond.c
	$(FC) $(FFLAGS) -c stream.f
	$(FC) $(FFLAGS) stream.o mysecond.o -o stream_f.exe

stream_c.exe: stream.c
	$(CC) $(CFLAGS) stream.c -o stream_c.exe

stream_c_gem5roi.exe: stream.c
	$(CC) $(CFLAGS) -DGEM5ROI -I$(GEM5SRC)/include stream.c -L$(GEM5SRC)/util/m5/build/arm64/out -lm5 -o stream_c_gem5roi.exe

clean:
	rm -f stream_f.exe stream_c.exe *.o

# an example of a more complex build line for the Intel icc compiler
stream.icc: stream.c
	icc -O3 -xCORE-AVX2 -ffreestanding -qopenmp -DSTREAM_ARRAY_SIZE=80000000 -DNTIMES=20 stream.c -o stream.omp.AVX2.80M.20x.icc
