# General Info
E lang is a compiled systems language designed to replace c++.
It's basically just c++ but with less cancer.
Meaning it's designed to offer the same low level preformance and control of c++ but without the chaos of a language updated hundreds of times over the course of decades.
It features a simple no bells or whistles translation between e code and x86-64 machine code.
Similar to c users should be able to look at disassembled e code and generally understand how the conversion took place and why.
ALL FEATURES IN E are required to be you pay for what you use. Sunk costs for features are unacceptable and will result in that feature being removed.
A simple int main() { return 0; } program should compile into a single RET 0 assembly instruction with no extra BS.

# Types
Integer Types:
sbyte - 1 byte signed integer
byte - 1 byte unsigned integer
short - 2 byte signed integer
ushort - 2 byte unsigned integer
int - 4 byte signed integer
uint - 4 byte unsigned integer
long - 8 byte signed integer
ulong - 8 byte unsigned integer
intn - ? byte signed integer (? is the size of a hardware register)
uintn - ? byte unsigned integer (? is the size of a hardware register)

Floating Point Types:
float - 4 byte IEEE 754 signed floating point number
double - 8 byte IEEE 754 signed floating point number
real - ? byte IEEE 754 signed floating point number (? is the native size of a value on the FPU stack)

Fixed Point Types:
fixed - 8 byte signed fixed point number
decimal - 16 byte signed fixed point number

Character Types:
char - 1 byte utf8 character
wchar - 2 byte utf16 character
uchar - 4 byte utf32 character

Pointer Value Types:
void* - A pointer to an unknown chunk of memory or null. Guaranteed to be the same size as an address
something* - A pointer to a something or null. Guaranteed to be the same size as an address

Struct Types:
Structs are user defined types which varry in size
They are defined as a consecutive lists of fixed size fields

Unions:
Unions are user defined types which varry in size
They are defined as overlapping collections of 1 or more fixed size types
The overall size of the union is the max size of any union field

Typedefs:
A typedef can be used to create a new type based upon an existing one
For example typedef void* as HANDLE;
This creates a brand new type called HANDLE which is the same size as a void*
Note that typeof(HANDLE) != typeof(void*)
They are two separate types which can NOT be implicitly cast to each other or used interchangably

# Const
In c++ const is way way to complicated and it almost never helps you do what you want to do
In epsilon const is simple
Const may only be applied to pointer types as an extra type qualifier not to value types
A non-const pointer can be implicitly cast to a const pointer however the opposite is not possible
It is 100% impossible to create a mutable pointer from a const pointer (There will NEVER be a const cast)
A const pointer cannot be used for write operations in any situation
The only exception to this rule is that when calling a method on a class through a const pointer this is still mutable
For example the following code will still work even though it mutates Foo

class Foo {
    private int age = 0;
    public void SetAge(int newAge) {
        age = newAge;
    }
}
void Bar(const Foo* input) {
    input.SetAge(10);
}

# Literals
Literal Integer Values:
Literal sbyte - 1sb
Literal byte - 1b
Literal short - 1s
Literal ushort - 1us
Literal int - 1
Literal uint - 1u
Literal long - 1l
Literal ulong - 1ul
Literal intn - 1n
Literal uintn - 1un

Literal Floating Point Values:
Literal float - 0.1f
Literal double - 0.1d
Literal real - 0.1r

Literal Fixed Point Values:
Literal fixed - 0.1F
Literal decimal - 0.1D

Literal Character Values:
Literal char - 'c'
Literal wchar - W'c'
Literal uchar - U'c'

Literal String Values:
NOTE: Literal strings are null terminated if they are in "" and not if they are in ''
Literal char string - "Hello World"
Literal wchar string - W"Hello World"
Literal uchar string - U"Hello World"

Literal Pointers:
The only literal avalible for pointer types is null
null is always defined as a literal for any pointer type
Users don't need to specify the type of null as null is always valid for all pointer types 
typeof(null) is always void*

# Functions
Functions are declared with a return type or void and a name
Functions can also have out parameters using the out keyword
Out parameters are a syntax sugar that generally translates to the following
void Foo(out int bar) {
    bar = 0;
}
void Foo(int* bar) {
    int __local_bar;
    __local_bar = 0;
    if (bar != null){
        *bar = __local_bar;
    }
}

# Exceptions
E uses an exception system where clients can register an exception handle on the exception stack
Then when an exception is throw it will be caught by the exception handler at the top of the exception stack
So each try/catch block is really doing the following
try { // Places an exception handler on the exception stack saying if theres an exception jump to the code in the catch block
} // Closing curly brace at the end of a try block removes the top exception handler on the stack
catch { // Marks the starting address of the code block to be excuted by this exception handler
} // Closing curly brace at the end of a catch block is a return statement to jump back into normal execution
When an exception is throw it sets Environment.ExceptionPtr to a pointer to the thrown exception and jumps to the address at the top of the exception handler stack

# Multithreading
All variables are thread scoped by default
That means that if we declare an integer i in the global scope, set i to 7 and then in another thread print i the value of 0 will be printed.
This is because each thread gets a copy of all the global variables.
So when we create a new thread a new stack is created with new places to store each global variable.
Setting a global variable only set's it for the current thread.
If we want a variable to be shared across threads we can mark it with crossthread.
Variables defined with crossthread only have a single copy shared across all threads.
There is no built in syncronization mechinism to crossthread variables however defining a lock is highly suggested.
For example a good programmer might write:

crossthread int bankBalance;
crossthread lock l_bankBalance;

This allows them to safely change bank balance like so:
lock (l_bankBalance) {
    if (bankBalance > 100){
        bankBalance -= 100;
        print("You spent 100 dollars and bought 1 sword.");
    } else {
        print("You could not afford 1 sword. They cost 100 dollars.");
    }
}

# Heap Allocation





# Example Codes
int main()