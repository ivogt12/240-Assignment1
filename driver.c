//****************************************************************************************************************************
//Program name: "Average Driving Time".  This program provides user inputs for miles driven and miles per hour(mph). Then    *
//the program calculates values for the total distance traveled, duration of the trip, and the average speed. The average    *
//speed is then sent to the driver.c file as a means of demonstrating successful completion. Copyright (C) 2024 Isaiah Vogt. *                                                                                            *
//                                                                                                                           *
//Average Driving Time is free software: you can redistribute it and/or modify it under the terms of the GNU General Public  *
//License version 3 as published by the Free Software Foundation. Average Driving Time is distributed in the hope that it    *
//will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR *
//PURPOSE.  See the GNU General Public License for more details. A copy of the GNU General Public License v3 is available    *
//here:  <https:;www.gnu.org/licenses/>.                                                                                     *
//****************************************************************************************************************************


//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Isaiah Vogt
//  Author email: ivogt@csu.fullerton.edu
//
//Program information
//  Program name: Average Driving Time
//  Programming languages: One modules in C, one module in X86, and one in bash
//  Date program began: 2024-Jan-23
//  Date of last update: 2024-Feb-1
//  Date of reorganization of comments: 2024-Feb-1
//  Files in this program: driver.c, manage-floats.c, r.sh
//  Status: Finished.  The program was tested extensively with no errors in 11.1.0ubuntu4.
//
//Purpose
// This program provides statistical driving information, including total miles driven, average mph, and duration of the
// trip for drivers in the Orange County Area.
//
//This file
//   File name: driver.c
//   Language: C
//   Max page width: 132 columns
//   Compile: gcc -m64 -no-pie -std=c2x -o driver.o -c driver.c
//   Link: gcc -m64 -no-pie -std=c2x -o go.out driver.o avg.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================

#include <stdio.h>

extern double average();

int main( int argc, const char * argv[] )
{
    printf( "\nWelcome to Average Driving Time maintained by Isaiah Vogt.\n" );
    //variable that stores value from average.asm
    double count = 0.0;
    //calls average.asm
    count = average();
    printf( "\nThe driver has received this number %1.8lf and will keep it for future use.\nHave a great day.\n", count );
    printf( "\nA zero will be sent to the operating system as a signal of a successful execution.\n" );
    return 0;
}