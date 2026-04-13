#ifndef C_CALLING_CONVENTION_TEST_H
#define C_CALLING_CONVENTION_TEST_H

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

void print_metadata();
void test_small_struct(Small, Small, double *);
void test_large_struct(Small, Large, double *);

#endif
