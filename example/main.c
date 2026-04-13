#include "julia_init.h"
#include "c_calling_convention_test.h"
#include "stdio.h"
#include "stdlib.h"
#include "stdint.h"

void print_bytes(void *x, size_t n) {
    uint8_t *bytes = (uint8_t *)x;
    for (size_t i = 0; i < n; i++) {
        fprintf(stderr, "%hhu ", bytes[i]);
    }
    fputs("\n", stderr);
}

int run_example() {
    int ret = EXIT_SUCCESS;

    Small small = {
        .a = 1
    };
    Large large = {
        .a = 1,
        .b = 2,
        .c = 3,
        .d = 4,
        .e = 5,
        .f = 6,
        .g = 7,
        .h = 8,
        .i = 9,
        .j = 10,
        .k = 11,
        .l = 12,
        .m = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}}
    };

    double x;

    fputs("Metadata...\n", stderr);
    fprintf(stderr, "C sizeof(Small): %zu\n", sizeof(Small));
    fprintf(stderr, "C alignof(Small): %zu\n", _Alignof(Small));
    fprintf(stderr, "C sizeof(Large): %zu\n", sizeof(Large));
    fprintf(stderr, "C alignof(Large): %zu\n", _Alignof(Large));
    print_metadata();

    fputs("Testing small struct...\n", stderr);
    fputs("C bytes:\n", stderr);
    print_bytes(&small, 4);
    fprintf(stderr, "C pointer: %p\n", &x);
    test_small_struct(small, small, &x);

    fputs("Testing large struct...\n", stderr);
    fputs("C bytes:\n", stderr);
    print_bytes(&large, 16);
    fprintf(stderr, "C pointer: %p\n", &x);
    test_large_struct(small, large, &x);

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
