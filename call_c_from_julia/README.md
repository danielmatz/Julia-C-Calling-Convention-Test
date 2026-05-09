# Call C from Julia

We build a small C shared library and call it from Julia, passing small and large-ish structs by value.

## Results

So far, this method does not seem to exhibit the issue I was seeing when calling Julia from C.

The following platforms work as expected:
- x86_64-linux-gnu, sapphirerapids, Julia 1.12.6, GCC 8.5.0
