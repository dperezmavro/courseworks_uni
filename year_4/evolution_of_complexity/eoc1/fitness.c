#include "main.h"

int fitness(char *str)
{
    int i = 0 ;
    int fitness = 0 ;
    for(; i < LEN ; i++){
        fitness += (str[i] == weasel[i]);
    }
    return fitness ;
}

unsigned int get_fittest(){
    unsigned int fittest = 0 ;    
    int i ;
    for (i = 0 ; i < POP ; i++){
        fittest = (fitnesses[i] > fitnesses [fittest]) ? i : fittest ;
    }
    return fittest ;
}
