;****************************************************************************************************************************
;Program name: "Average Driving Time ". This program provides user inputs for miles driven and miles per hour(mph).        *
;Then the program calculates values for the total distance traveled, duration of the trip, and the average speed.           *
;The average speed is then sent to the driver.c file as a means of demonstrating successful completion.                     *
;Copyright (C) 2024 Isaiah Vogt.                                                                                            *
;                                                                                                                           *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
;<https://www.gnu.org/licenses/>.                                                                                           *
;****************************************************************************************************************************


;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Isaiah Vogt
;  Author email: ivogt@csu.fullerton.edu
;
;Program information
;  Program name: Average Driving Time
;  Programming languages: One module in C, one in X86, and one in bash.
;  Date program began: 2024-Jan-22
;  Date of last update: 2024-Feb-1
;  Files in this program: driver.c, average.asm, r.sh.  At a future date rg.sh may be added.
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Finished. The program was tested extensively with no errors in 11.1.0ubuntu4.
;
;Purpose
;  This program provides statistical driving information, including total miles driven, average mph, and duration of the
;  trip for drivers in the Orange County Area. 
;
;This file:
;  File name: average.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l avg.lis -o avg.o average.asm
;  Assemble (debug): nasm -g dwarf -l avg.lis -o avg.o average.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double average();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Declaration section.

extern printf ; output library

extern scanf ; C library for user float input

extern fgets  ; C library for reading from string input

extern stdin ; C library for collecting user input

extern strlen ; C library for getting string length

global average ; function used in this file and called in driver.c to receive the average speed

name_string_size equ 48 ; user name max length

title_string_size equ 48 ; user title max length

segment .data 

; dialogue for collecting user information input
prompt_for_name db "Please enter your first and last names: ", 0
prompt_for_title db "Please enter your title such as Lieutenant, Chief, Mr, Ms, Influencer, Chairman, Freshman, Foreman, Project Leader, etc: ", 0

; friendly message
friendly_message db "Thank you %s %s.", 10, 0

; user input prompts
prompt_for_Full_to_SA db 10, "Enter the number of miles traveled from Fullerton to Santa Ana: ", 0
prompt_for_SA_to_LB db 10, "Enter the number of miles traveled from Santa Ana to Long Beach: ", 0
prompt_for_LB_to_Full db 10, "Enter the number of miles traveled from Long Beach to Fullerton: ", 0
prompt_for_mph db "Enter your average speed during that leg of the trip: ", 0

; format
mile_data_format db "%lf", 0

; result prompts
prompt_processing db 10, "The inputted data are being processed.", 10, 0
total_distance_traveled db 10, "The total distance traveled is %1.8lf miles.", 10, 0
time_of_trip db "The time of the trip is %1.8lf hours.", 10, 0
average_speed db "The average speed during this trip is %1.8lf mph.", 10, 0

; Constant declarations
pi dq 3.141592

segment .bss

align 64

backup_storage_area resb 832;

user_name resb name_string_size
user_title resb title_string_size

segment .text

average:

;Back up the GPRs
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

;Backup the registers other than the GPRs
mov rax,7
mov rdx,0
xsave [backup_storage_area]

;Output instruction for user
mov rax, 0
mov rdi, prompt_for_name
call printf

;Collect user name
mov rax, 0
mov rdi, user_name ; destination for input
mov rsi, name_string_size ; source for input
mov rdx, [stdin] ; store input in register
call fgets ; user input that accounts for white space

;Remove newline
mov rax, 0
mov rdi, user_name
call strlen
mov [user_name+rax-1], byte 0

;Output instruction for user
mov rax, 0
mov rdi, prompt_for_title
call printf

;Collect user title
mov rax, 0
mov rdi, user_title ; destination for input
mov rsi, title_string_size ; source for input
mov rdx, [stdin] ; store input in register
call fgets ; carry out input

;Remove newline
mov rax, 0
mov rdi, user_title
call strlen
mov [user_title+rax-1], byte 0

;Something nice
mov rax, 0
mov rdi, friendly_message
mov rsi, user_title
mov rdx, user_name
call printf

;Full to SA*********************************************************************************

;prompt for miles traveled from Fullerton to Santa Ana
mov rax, 0
mov rdi, prompt_for_Full_to_SA
call printf

;Collect miles traveled Full to SA
mov rax, 0
mov rdi, mile_data_format ; destination for input
push qword 0
push qword 0
mov rsi, rsp ; points to top of the stack
call scanf ; collects user input
movsd xmm7, [rsp] ; move input into float register
pop rax
pop rax


;prompt for mph from Full to SA
mov rax, 0
mov rdi, prompt_for_mph
call printf

;Collect mph Full to SA
mov rax, 0
mov rdi, mile_data_format
push qword 0
push qword 0
mov rsi, rsp
call scanf
movsd xmm8, [rsp]
pop rax
pop rax

;Compute duration(in hours) of trip from Full to SA
movsd xmm0, xmm7
divsd xmm0, xmm8
addsd xmm11, xmm0

;Add to net miles traveled variable
addsd xmm10, xmm7

;SA to LB*********************************************************************************

;Prompt for miles traveled from SA to LB
mov rax, 0
mov rdi, prompt_for_SA_to_LB
call printf

;Collect miles traveled from SA to LB
mov rax, 0
mov rdi, mile_data_format
push qword 0
push qword 0
mov rsi, rsp
call scanf
movsd xmm7, [rsp]
pop rax
pop rax

;prompt for mph from SA to LB
mov rax, 0
mov rdi, prompt_for_mph
call printf

;Collect mph SA to LB
mov rax, 0
mov rdi, mile_data_format
push qword 0
push qword 0
mov rsi, rsp
call scanf
movsd xmm8, [rsp]
pop rax
pop rax

;Compute duration of trip(in hours) from SA to LB
movsd xmm0, xmm7
divsd xmm0, xmm8
addsd xmm11, xmm0

;Add to total distance
addsd xmm10, xmm7

;LB to Full*********************************************************************************

;prompt for miles traveled from LB to Full
mov rax, 0
mov rdi, prompt_for_LB_to_Full
call printf

;Collect miles traveled from LB to Full
mov rax, 0
mov rdi, mile_data_format
push qword 0
push qword 0
mov rsi, rsp
call scanf
movsd xmm7, [rsp]
pop rax
pop rax

;prompt for mph from LB to Full
mov rax, 0
mov rdi, prompt_for_mph
call printf

;Collect mph LB to Full
mov rax, 0
mov rdi, mile_data_format
push qword 0
push qword 0
mov rsi, rsp
call scanf
movsd xmm8, [rsp]
pop rax
pop rax

;Compute duration of trip(in hours) from LB to Full
movsd xmm0, xmm7
divsd xmm0, xmm8
addsd xmm11, xmm0

;Add to total distance
addsd xmm10, xmm7

;Processed Data*********************************************************************************

;prompt to notify the user that the info is data is processing
mov rax, 0
mov rdi, prompt_processing
call printf

;Total distance traveled
mov rax, 1
mov rdi, total_distance_traveled
movsd xmm0, xmm10
call printf

;Time of trip
mov rax, 1
mov rdi, time_of_trip
movsd xmm0, xmm11
call printf

;Average Speed of trip
mov rax, 1
mov rdi, average_speed
divsd xmm10, xmm11
movsd xmm0, xmm10
call printf

;Store avg speed in rsp before SSE registers get wiped
push qword 0
movsd [rsp], xmm10

;Restore the values to non-GPRs
mov rax,7
mov rdx,0
xrstor [backup_storage_area]

;Send avg speed to driver.c
movsd xmm0, [rsp]
pop rax

;Restore the GPRs
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp   ;Restore rbp to the base of the activation record of the caller program
ret
;End of the function average ====================================================================
