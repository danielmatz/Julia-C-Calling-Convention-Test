CC ?= gcc

libexample.so: main.c
	$(CC) -shared -o $@ -fPIC $<

.PHONY: clean
clean:
	$(RM) libexample.so
