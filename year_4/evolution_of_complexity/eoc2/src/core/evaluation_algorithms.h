#include "common_utils.h"

#define NRASTR 20
#define NGRIEW 10
#define NACKLEY 30
#define NSCHWE 10
#define PI 3.141593

double rastrigin(unsigned short (*pop)[NRASTR]);
double griewangk(unsigned short (*pop)[NGRIEW]);
double ackley(unsigned short (*pop)[NACKLEY]);
double schwefel(unsigned short (*pop)[NSCHWE]);
