#include <stdio.h>

#include "main.h"

void hill_climber()
{
    initialize_population();
    unsigned char *candidate = malloc(sizeof(unsigned char)*(LEN+1));
    int fittest = get_fittest() ;

    strncpy(candidate, population[fittest],LEN+1);
    
    int i = 0 ; 
    while( fitness(population[fittest]) < MAX_FITNESS ){
        i++ ; 
        mutate(candidate);
        if (fitness(candidate) > fitnesses[fittest]){
            strncpy(population[fittest], candidate ,LEN+1);
            fitnesses[fittest] = fitness(candidate);
        }else{
            strncpy(candidate, population[fittest],LEN+1);
        }
    }
    
    printf("HC : %d epochs passed\n",i);
}

void ga_no_crossover()
{
    initialize_population();
    build_wheel();
    
    int child_fitness = 0 ;
    unsigned char *child = malloc(sizeof(unsigned char)*(LEN+1));
    int rand1;
    int rand2 ;
    int epochs = 0 ;

    while( child_fitness < MAX_FITNESS ){
        epochs++ ;
        rand1 = random_parent();
        while((rand2 = random_parent()) == rand1 ); //make sure no two parents are the same one

        rand1 = (fitnesses[rand1] > fitnesses[rand2] ) ? rand1 : rand2 ; //select fittest parent
        strncpy(child, population[rand1], LEN+1);
        mutate(child);
        child_fitness = fitness(child);
        
        rand1 = random_parent();// just reuse these variables here
        while((rand2 = random_parent()) == rand1 ); 

        rand1 = (fitnesses[rand1] > fitnesses[rand2]) ? rand2 : rand1 ; //replace less fit with child
        strncpy(population[rand1], child, LEN+1);
        fitnesses[rand1] = child_fitness;
    }

    printf("GA : %d epochs passed \n", epochs);
}

void ga_crossover()
{
    initialize_population();
    unsigned int rand1 ; // this will be the parent variable
    unsigned int rand2 ;
    unsigned int rand3 ;
    unsigned char *child = malloc(sizeof(unsigned char) * (LEN+1) );
    unsigned int child_fitness = 0 ;
    unsigned int epochs ;
    while( child_fitness < MAX_FITNESS ){
        //select first set of parents
        rand1 = random_parent();
        while((rand2 = random_parent() ) == rand1 );
        rand1 = (fitnesses[rand1] > fitnesses[rand2] ) ? rand1 : rand2 ; 

        //select second set of parents
        rand2 = random_parent();
        while((rand3 = random_parent() ) == rand2 && rand3 == rand1 );
        rand2 = (fitnesses[rand2] > fitnesses[rand3] ) ? rand2 : rand3 ; 
        
        perform_crossover(population[rand1], population[rand2], child);
        mutate(child);
    
        //select random person to be substituted
        rand1 = random_parent();
        while((rand2 = random_parent() ) == rand1 );
        rand1 = (fitnesses[rand1] > fitnesses[rand2] ) ? rand2 : rand3 ; 
        strncpy(population[rand1], child, LEN+1);
        child_fitness = fitness(child);
        fitnesses[rand1] = child_fitness ;
        epochs++;
    }
    printf("GA-C : %d epochs passed for convergence \n", epochs);
}
