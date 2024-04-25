Types of types:
Person is a type denoting an instance of the Person class in the default format specified by the Person class definition.
Person* is a type denoting an unmanaged pointer to either null or an instance of the Person class on the heap.
Person^ is a type denoting a managed pointer to either null or an instance of the Person class on the heap.
Person$ is a type denoting an instance of the Person class on the stack.

Class Type Of Type Hinting:
class Person { } is the same as pointalloc class Person { }
pointalloc class Person { } is a class definition for Person where person may only be a pointer never a stack instance.
stackalloc class Person { } is a class definition for Person where person may be allocated only two the stack never as a pointer.
dynamalloc class Person { } is a class definition for Person where person may be allocated anywhere stack or heap.

delete frees a block of memory including classes, value types, arrays of classes, and arrays of value types too. Because delete should just work on all unmanaged pointers.

