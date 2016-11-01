#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>

#include "main.h"

unsigned char population[POP][LEN+1]  = {{'\0'}};
unsigned int fitnesses[POP] ;
const char *weasel = "methinks it is like a weasel";
unsigned int population_fitness = 0 ;
unsigned int *roulette ;

void print_fitnesses(){
    int i = 0 ;
    for( ; i < POP ; i++){
        printf("pop[%d] : %d\n", i , fitnesses[i]);
    }
}

int main(void)
{
    srand(time(NULL));
    hill_climber();
    ga_no_crossover();
    ga_crossover();
    return 0 ;
}
