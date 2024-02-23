
#include <stdint.h>
#include <stdio.h>

extern uint64_t npow(uint64_t base, uint64_t exponent);

int main(void) {
    uint64_t base, exponent;

    printf("base: ");
    scanf("%lu", &base);
    printf("exponent: ");
    scanf("%lu", &exponent);

    uint64_t res = npow(base, exponent);
    printf("%lu\n", res);

    return 0;
}
