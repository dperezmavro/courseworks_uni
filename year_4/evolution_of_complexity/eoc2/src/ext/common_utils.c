#include "common_utils.h"

double translate(unsigned short member, double max){
    double fragment = (2 * max ) / number_of_fragments ;    
    return member*fragment - max ;
}

void mutate(int dimensions, unsigned short (*pop)[POPSIZE][dimensions]){
    for(int z = 0 ; z < POPSIZE ; z++){
        for (int i = 0 ; i < dimensions; i++){
            for(int j = 0 ; j < chromlength ; j++){
                if((double)rand()/(double)RAND_MAX < 1.0/((double)chromlength*dimensions)){
                    (*pop)[z][i] ^= 1 << j ;
                }
            }
        }
    }
}

void crossover(unsigned short parent1, unsigned short parent2, unsigned short *child){
    unsigned short point1 = rand()%chromlength ;
    unsigned short point2 = rand()%chromlength ;
    unsigned short temp = 0 ;
    unsigned short mask2 = 0 ;
    
    if(point1 > point2){
        temp = point1 ;
        point1 = point2 ;
        point2 = temp ;
    }
    
    for(int i = point1 ; i <= point2 ; i++){
        mask2 ^= 1 << i;
    }
    *child = (parent1 & (mask1 ^ mask2) ) | (parent2 & mask2);
}

void initialize_pop(int dimensions, unsigned short (*pop)[POPSIZE][dimensions]){
    for(int i = 0 ; i < POPSIZE ; i++){
        for(int j =  0 ; j < dimensions ; j++){
            (*pop)[i][j] = rand()%(int)pow(2,16);
        }
    }
}

void evaluate_fitnesses(int dimensions, double(*eval_function)(unsigned short (*pop)[dimensions]), double (*fitnesses)[POPSIZE], unsigned short (*pop)[POPSIZE][dimensions], int *max, int *min){
    *max = 0 ;
    *min = 0 ;
    for(int i = 0 ; i < POPSIZE ; i ++){
        (*fitnesses)[i] = eval_function((*pop)[i]);
        if((*fitnesses)[i] < (*fitnesses)[*min]){
            *min = i;
        }else if((*fitnesses)[i] > (*fitnesses)[*max]){
            *max = i ;
        }
    }
}

void roulette_selection(double (*fitnesses)[POPSIZE], unsigned int (*new_member)[POPSIZE],double (*fitness_window)[window_size]){
    double temp_fitnesses[POPSIZE];
    double total_fitness = 0.0 ;
    double total ;
    int chance ;
    int j = 0 ;
    double least ;
    int worst_index = 0 ;

    for(int i = 0 ; i < window_size ;i++){
        least = (*fitness_window)[i] > least ? (*fitness_window)[i] : least ;
    }

    for(int i = 0 ; i < POPSIZE ; i++){
        total_fitness += (*fitnesses)[i];
    }

    for(int i = 0 ; i < POPSIZE ; i++){
        temp_fitnesses[i] = least - (*fitnesses)[i] ; //will remove less fit individual
    }

    for(int i = 0 ; i < POPSIZE ; i++){
        total = 0.0 ;
        j = i ;
        chance = rand()%(int)round(total_fitness);
        do{
            total += temp_fitnesses[j];
            j = (j+1)%(POPSIZE-1) ;
        }while( total <= chance );
        (*new_member)[i] = j ;
    }
}

void initialize_ccga(int dimensions, unsigned short (*pop)[dimensions][POPSIZE]){
    for(int i = 0 ; i < dimensions ; i++){
        for(int j = 0 ; j < POPSIZE ; j++){
            (*pop)[i][j] = rand()%(int)pow(2,16);
        }
    }
}

void mutate_ccga(unsigned int dimensions, unsigned short (*pop)[dimensions][POPSIZE]){
    for(int i = 0 ; i < dimensions; i++){
        for(int j = 0 ; j < POPSIZE ; j++){
            for(int l = 0 ; l < chromlength; l++){
                if((double)rand()/(double)RAND_MAX < 1.0/((double)chromlength*dimensions )){
                    (*pop)[i][j] ^= 1<<l ;
                }
            }
        }
    }
}

void find_fitnesses_ccga(int dimensions, double (*fitnesses)[dimensions][POPSIZE], int (*fitnesses_min)[dimensions], int (*fitnesses_max)[dimensions], double *highest_store, double *total_fitness){
    int max = 0 ;
    int min = 0 ;
    *highest_store = 0 ;
    *total_fitness = 0 ;
    for(int i = 0 ; i < dimensions ; i++){
        for(int j = 0 ; j < POPSIZE ; j++){
            min = (*fitnesses)[i][j] < (*fitnesses)[i][min] ? j : min ;
            max = (*fitnesses)[i][j] > (*fitnesses)[i][max] ? j : max ;
            *total_fitness += (*fitnesses)[i][j];

        }
        *highest_store = *highest_store > (*fitnesses)[i][max] ? *highest_store : (*fitnesses)[i][max] ;
        (*fitnesses_min)[i] = min ;
        (*fitnesses_max)[i] = max ;
        min = 0 ;
        max = 0 ;
    }
}

void eval_ccga(int dimensions,unsigned short (*pop)[dimensions][POPSIZE], int (*curr_best)[dimensions], double (*func_ptr)(unsigned short (*pop)[dimensions]), double (*fitnesses)[dimensions][POPSIZE]){
    unsigned short best[dimensions];
    unsigned short eval_vector[dimensions];

    for(int i = 0 ; i < dimensions;i++){
        best[i] = (*pop)[i][(*curr_best)[i]]; //backup the best
    } 
    
    for(int i = 0 ; i < dimensions ; i++){
        memcpy(&eval_vector, &best, sizeof(unsigned short)*dimensions);
        for(int j = 0 ; j < POPSIZE ; j++){
            eval_vector[i] = (*pop)[i][j];
            (*fitnesses)[i][j] = func_ptr(&eval_vector);
        }
    }
}

void crossover_ccga(unsigned int dimensions, unsigned short (*pop)[dimensions][POPSIZE]){
    if((double)rand()/(double)RAND_MAX < 0.6){
        return 0; 
    }
    for(int i = 0 ; i < dimensions;i++){
        for(int j = 0 ; j < POPSIZE ; j++){
            unsigned short child = 0 ;
            crossover((*pop)[i][j], (*pop)[(i+1)%dimensions][rand()%POPSIZE],&child);
            (*pop)[(i+2)%dimensions][j] = child ;
        }
    }
}

void roulette_wheel_select_ccga(int dimensions, unsigned short (*pop)[dimensions][POPSIZE], double (*fitnesses)[dimensions][POPSIZE], double (*scalling_window)[window_size], double total_fitnesses ){
    double worst = (*scalling_window)[0] ;
    double inverted_fitnesses[dimensions][POPSIZE];
    double total = 0 ;
    int j = 0 ;
    unsigned short temp_pop[dimensions][POPSIZE];
    memcpy(&temp_pop, pop, sizeof(unsigned short)*dimensions*POPSIZE);

    for(int i = 1 ; i < window_size; i++){
        worst = worst > (*scalling_window)[i] ? worst : (*scalling_window)[i];
    }

    for(int i = 0 ; i < dimensions; i++){
        for(int j = 0 ; j < POPSIZE ; j++){
            inverted_fitnesses[i][j] = worst - (*fitnesses)[i][j];
        }
    }

    for(int i = 0 ; i < dimensions ; i++){
        for(int z = 0 ; z < POPSIZE; z++){
            j = z ;
            total = inverted_fitnesses[i][j] ;
            while(total < total_fitnesses ){
                j = (j+1)%POPSIZE ;
                total += inverted_fitnesses[i][j];
            }
            (*pop)[i][z] = temp_pop[i][z] ; 
        }
    }
}
