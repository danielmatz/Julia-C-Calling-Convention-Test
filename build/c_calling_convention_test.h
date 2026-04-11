#ifndef C_CALLING_CONVENTION_TEST_H
#define C_CALLING_CONVENTION_TEST_H

#include "stdint.h"

typedef struct {
    uint8_t data[4];
} SmallStruct;

typedef struct {
    uint8_t data[168];
} LargeStruct;

void test_small_struct(SmallStruct, SmallStruct);
void test_large_struct(SmallStruct, LargeStruct);

#endif
