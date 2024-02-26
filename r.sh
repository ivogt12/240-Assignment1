#!/bin/bash

#Program name "Average Driving Speed"
#Author: Isaiah Vogt
#This file is the script file that accompanies the "Average Driving Speed" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble the source file average.asm"
nasm -f elf64 -l avg.lis -o avg.o average.asm

echo "Compile the source file driver.c"
gcc -m64 -no-pie -std=c2x -o driver.o -c driver.c

echo "Link the object modules to create an executable file"
gcc -m64 -no-pie -std=c2x -o go.out driver.o avg.o

echo "This is the program that outputs a driver's miles driven, duration of drive, and average mph."
chmod +x go.out
./go.out

echo "This bash script will now terminate."
