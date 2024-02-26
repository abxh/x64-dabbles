#include <stdio.h>
#include "circle_area.h"

int main(void) {
    double radius;
    scanf("%lf", &radius);
    double res = circle_area(radius);
    printf("Circle area: %g\n", res);
    return 0;
}
