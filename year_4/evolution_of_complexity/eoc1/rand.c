#include "main.h"

unsigned char get_random_char()
{
    unsigned char base = ' ' ;
    unsigned int res = rand()%27 ;

    if(res){
        return 96+res ;
    }
    return base ;
}

int random_fit_parent()
{
    return roulette[rand()%population_fitness] ;
}

int random_parent()
{
    return random()%POP ;
}


