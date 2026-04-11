#include "julia_init.h"
#include "c_calling_convention_test.h"
#include "stdio.h"
#include "stdlib.h"
#include "stdint.h"

void assign_bytes(uint8_t *data, size_t n) {
    for (size_t i = 0; i < n; i++) {
        data[i] = (uint8_t)i;
    }
}

void print_bytes(uint8_t *data, size_t n) {
    for (size_t i = 0; i < n; i++) {
        fprintf(stderr, "%hhu ", data[i]);
    }
    fputs("\n", stderr);
}

int run_example() {
    int ret = EXIT_SUCCESS;

    SmallStruct small;
    assign_bytes(small.data, 4);
    LargeStruct large;
    assign_bytes(large.data, 168);

    fputs("Testing small struct...\n", stderr);
    fputs("C bytes:\n", stderr);
    print_bytes(small.data, 4);
    test_small_struct(small, small);

    fputs("Testing large struct...\n", stderr);
    fputs("C bytes:\n", stderr);
    print_bytes(large.data, 16);
    test_large_struct(small, large);

    return ret;
}

int main(int argc, char *argv[])
{
    int ret = EXIT_SUCCESS;

    init_julia(argc, argv);

    ret = run_example();

    shutdown_julia(ret);

    return ret;
}
