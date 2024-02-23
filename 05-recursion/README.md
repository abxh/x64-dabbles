# recursion in assembly

This is the equivalent C code, I have implemented.

```c
uint64_t npow(uint64_t base, uint64_t exponent) {
    if (exponent == 0)
        return 1;
    else if ((exponent & 1) == 1) {
        return base * npow(base, exponent - 1);
    }
    else {
        uint64_t res = npow(base, exponent >> 1);
        return res * res;
    }
}
```

Seeing the dissassembly by the compiler is interesting. Try
copy pasting the code in [godbolt.org](https://godbolt.org/)
and looking at it.
