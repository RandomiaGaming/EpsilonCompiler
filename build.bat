@echo off
del Program.o
del Program.exe
gcc.exe -o "Program.o" "Program.c"
gcc.exe -o "Program.exe" "Program.o"