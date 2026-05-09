#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

typedef struct {
    unsigned int a;
} Small;

typedef struct {
    double a;
    double b;
    double c;
    double d;
    double e;
    double f;
    double g;
    double h;
    double i;
    double j;
    double k;
    double l;
    double m[3][3];
} Large;

void print_bytes(uint8_t *ptr, size_t n) {
    fputs("C bytes:\n", stderr);
    for (size_t i = 0; i < n; ++i) {
        fprintf(stderr, "%hhu", ptr[i]);
        if (i < (n - 1)) {
            fprintf(stderr, " ");
        }
    }
    fprintf(stderr, "\n");
}

void test_small_struct(Small a, Small b, double *c) {
    print_bytes((uint8_t *)&b, 4);
    fprintf(stderr, "C pointer: %p\n", c);
}

void test_large_struct(Small a, Large b, double *c) {
    print_bytes((uint8_t *)&b, 16);
    fprintf(stderr, "C pointer: %p\n", c);
}
