# C Calling Convention Test

This is a minimum working example of an issue I was having passing large-ish structs by value from C to Julia.

To build and run the example, simply run `make` in the root of the repository.

## Results

When a large struct is passed by value as the second argument, the bytes of the second argument match, but the pointer in the third argument does not match. When a small struct is passed as the second argument, the pointer in the third argument does match.

The following platforms exhibit the issue:
- x86_86-linux-gnu, broadwell, Julia 1.10.11, GCC 12.4.0
- x86_86-linux-gnu, sapphirerapids, Julia 1.10.11, GCC 12.4.0
- x86_86-linux-gnu, broadwell, Julia 1.12.6, GCC 12.4.0
- x86_86-linux-gnu, sapphirerapids, Julia 1.12.6, GCC 8.5.0

The following platforms work as expected:

## Example output showing issue

Note the last "C pointer" and "Julia pointer" in the output below.

```
Metadata...
C sizeof(Small): 4
C alignof(Small): 4
C sizeof(Large): 168
C alignof(Large): 8
Julia Sys.MACHINE: x86_64-linux-gnu
Julia Sys.CPU_NAME: sapphirerapids
Julia sizeof(Small): 4
Julia alignof(Small): 4
Julia sizeof(Large): 168
Julia alignof(Large): 8
Testing small struct...
C bytes:
1 0 0 0 
C pointer: 0x7ffd56f29588
Julia bytes:
1 0 0 0
Julia pointer: Ptr{Float64} @0x00007ffd56f29588
Testing large struct...
C bytes:
0 0 0 0 0 0 240 63 0 0 0 0 0 0 0 64 
C pointer: 0x7ffd56f29588 <------ HERE
Julia bytes:
0 0 0 0 0 0 240 63 0 0 0 0 0 0 0 64
Julia pointer: Ptr{Float64} @0x00007ffd56f294d0 <------ AND HERE
```
