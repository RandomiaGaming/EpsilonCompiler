#include system.e

void Main() {
    printLn("Hello World!");
}

/*
#include system.e
This line tells the compiler to look for a file called system.e.
When searching for system.e the compiler will first check the current directory recursively.
Next the compiler will check the standard lib folder recursively.
Finally the compiler will check the standard packages folder recursively.
Note if you don't want the compiler to check in the lib or standard packages folders you can specify my code only with the following.
#include("system.e", IncludeFlags.NoSubDirs | IncludeFlags.MyCodeOnly);
This will tell the compiler to look for system.e only in the current directory and nowhere else.

void Main() { }
This defines a function called Main which returns nothing and is public.
Note that the program selects Main as its entry point because there is no entry directive to specify otherwise.
To specify a custom entry function you could use the following.
#entry OtherMain
If no custom entry is defined the compiler searches for a function named "Main" and then "main" before giving up.

Note that there is no such thing as a call stack in e because recursion is strictly prohibited.

*/