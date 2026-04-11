# C Calling Convention Test

This is a minimum working example of an issue I was having passing large-ish structs by value from C to Julia.

To build and run the example, simply run `make` in the root of the repository.

## Results

We expect the bytes seen by C and Julia to match. When the issue occurs, the bytes will not match.

The following platforms exhibit the issue:
- 

The following platforms work as expected:
- Apple M1, Julia 1.12.6, Clang 17.0.0

