#include <stdio.h>

extern unsigned int nsum(unsigned int n);

int main(void) {
    unsigned int n, res;
    if (scanf("%u", &n) < 0) {
        fprintf(stderr, "error.\n");
        return 1;
    }
    res = nsum(n);
    printf("sum of 1..%u is: %u\n", n, res);
    return 0;
}
