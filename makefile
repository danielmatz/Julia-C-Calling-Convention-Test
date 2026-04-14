JULIA ?= julia
DLEXT := $(shell $(JULIA) --startup-file=no -e 'using Libdl; print(Libdl.dlext)')

TARGET := $(abspath build/output)

MYLIB_INCLUDES := $(TARGET)/include/julia_init.h $(TARGET)/include/c_calling_convention_test.h
MYLIB_PATH := $(TARGET)/lib/libc_calling_convention_test.$(DLEXT)

.PHONY: all
all: example/main
	example/main

$(MYLIB_PATH) $(MYLIB_INCLUDES): build/build.jl src/c_calling_convention_test.jl
	$(JULIA) --startup-file=no --project=. -e 'using Pkg; Pkg.update()'
	$(JULIA) --startup-file=no --project=build -e 'using Pkg; Pkg.update(); include("build/build.jl")'

example/main: example/main.c $(MYLIB_PATH) $(MYLIB_INCLUDES)
	$(CC) -o $@ -std=gnu99 -I$(TARGET)/include $< -Wl,-rpath,$(TARGET)/lib -Wl,-rpath,$(TARGET)/lib/julia -L$(TARGET)/lib -lc_calling_convention_test

example/main.ll: example/main.c $(MYLIB_INCLUDES)
	clang -o $@ -std=gnu99 -I$(TARGET)/include $< -S -emit-llvm -O0

.PHONY: clean
clean:
	$(RM) -rf $(TARGET)
	$(RM) example/main
