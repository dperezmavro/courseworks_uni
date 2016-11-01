#include "main.h"

void build_wheel()
{
    roulette = malloc(sizeof(int) * population_fitness);
    int *ptr = roulette ;
    int i = 0 ;
    int j = 0 ;
    for(; i < POP ; i++){
        for(j = 0 ; j < fitnesses[i] ; j++){
            *(ptr++) = i ;
        }
    }
}

void initialize_population()
{
    int i = 0 ;
    int j ;
    for(; i < POP ; i++){ 
        for(j = 0 ; j < LEN ; j++){
            population[i][j] = get_random_char(); 
        }
        fitnesses[i] = fitness(population[i]);
        population_fitness += fitnesses[i] ;
    }
}
