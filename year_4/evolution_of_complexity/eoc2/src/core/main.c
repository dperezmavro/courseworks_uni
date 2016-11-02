#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include "evaluation_algorithms.h"

void run_algorithm(double (*results)[iterations], unsigned int dimensions,double (*func_ptr)(unsigned short (*pop)[dimensions])){
    unsigned short pop[POPSIZE][dimensions] ;
    double fitnesses[POPSIZE];
    unsigned short temp_pop[POPSIZE][dimensions];
    double fitness_window[5];
    unsigned short best_individual[dimensions];
    unsigned int next_gen_indexes[POPSIZE];
    unsigned int max_index = 0 ;
    unsigned int min_index = 0 ;
    unsigned int age = 0 ;
    unsigned short child1=0;
    unsigned short child2=0;
    
    //initialize arrays
    memset(&pop,0,sizeof(unsigned short)*POPSIZE*dimensions);
    memset(&fitnesses,0,sizeof(double)*POPSIZE);
    memset(&temp_pop,0,sizeof(unsigned short)*POPSIZE*dimensions);
    memset(&best_individual,0,sizeof(unsigned short)*dimensions);
    memset(&next_gen_indexes,0,sizeof(unsigned int)*POPSIZE);

    initialize_pop(dimensions, &pop);
    evaluate_fitnesses(dimensions, func_ptr,&fitnesses, &pop, &max_index, &min_index);
    memcpy(&best_individual, &pop[min_index], sizeof(unsigned short)*dimensions);

    while(age < iterations ){
        for(int i = 0 ; i < POPSIZE/2 ; i+=2){
            for(int j = 0 ; j < dimensions;j++){
                crossover(pop[i][j], pop[i+1][j], &child1);
                crossover(pop[i+1][j], pop[i][j], &child2);
                pop[i][j] = child1 ;
                pop[i+1][j] = child2 ;
            }
        }
        mutate(dimensions, &pop);
        memcpy(&pop[min_index], &best_individual, sizeof(unsigned short)*dimensions); //restore best individual ;
        (*results)[age] += fitnesses[min_index] ;//update with best score for this age       
        evaluate_fitnesses(dimensions, func_ptr, &fitnesses, &pop, &max_index, &min_index);
        fitness_window[age%5] = fitnesses[max_index];

        //scale fitnesses
        roulette_selection(&fitnesses, &next_gen_indexes,&fitness_window);
        memcpy(&temp_pop, &pop, sizeof(unsigned short)*dimensions*POPSIZE); //create population copy
        for(int i = 0 ; i < POPSIZE; i++){
            memcpy(&pop[i], &temp_pop[next_gen_indexes[i]], sizeof(unsigned short)*dimensions);//copy the appropriate population members
        }

        memcpy(&best_individual, &temp_pop[min_index], sizeof(unsigned short)*dimensions); //save new best
        age++;
    }
}

void run_algorithm_ccga(double (*results)[iterations], unsigned int dimensions,double (*func_ptr)(unsigned short (*pop)[dimensions])){
    int age = 0 ;
    unsigned int min_fitness_indexes[dimensions];
    unsigned int max_fitness_indexes[dimensions];
    unsigned int fitest_positions_backup[dimensions];
    unsigned short population[dimensions][POPSIZE];
    unsigned short fitest_backup[dimensions];
    unsigned short eval_vector[dimensions];
    double fitnesses[dimensions][POPSIZE];
    double min_fitness_values[dimensions];
    double max_fitness_values[dimensions];
    double fitness_backup[dimensions];
    double fitness_window[window_size];
    double highest_function_value = 0 ;
    double total_fitnesses = 0 ;
    memset(&min_fitness_values, 0 , sizeof(double)*dimensions);
    memset(&max_fitness_values, 0 , sizeof(double)*dimensions);
    memset(&population, 0,sizeof(unsigned short)*dimensions*POPSIZE);
    memset(&fitest_backup, 0,sizeof(unsigned short)*dimensions);
    memset(&fitness_backup, 0,sizeof(unsigned short)*dimensions);
    memset(&max_fitness_indexes, 0,sizeof(unsigned int)*dimensions);
    memset(&min_fitness_indexes, 0,sizeof(unsigned int)*dimensions);
    memset(&fitest_positions_backup, 0 , sizeof(unsigned int)*dimensions);
    memset(&eval_vector, 0,sizeof(unsigned short)*dimensions);
    memset(&fitnesses, 0,sizeof(double)*POPSIZE*dimensions);
    memset(&fitnesses, 0, sizeof(double)*window_size);
   
    //initialization
    initialize_ccga(dimensions, &population);
    for(int i = 0 ; i < dimensions;i++){
        for(int j = 0 ; j < POPSIZE ; j++){
            eval_vector[i] = population[i][j];
            for(int z = 0 ; z < dimensions; z++){
                if( z != i ){
                    eval_vector[z] = population[z][rand()%POPSIZE];    
                }
            }
            fitnesses[i][j] = func_ptr(&eval_vector);
        }
    }

    find_fitnesses_ccga(dimensions, &fitnesses, &min_fitness_indexes, &max_fitness_indexes, &highest_function_value, &total_fitnesses);

    while(age < iterations){
        for(int i = 0 ; i < dimensions ; i++){ //backup the best
            fitest_backup[i] = population[i][min_fitness_indexes[i]];
            fitness_backup[i] = fitnesses[i][min_fitness_indexes[i]];
        }
        memcpy(&fitest_positions_backup, &min_fitness_indexes, sizeof(unsigned int)*dimensions);
        age++;

        mutate_ccga(dimensions, &population);
        crossover_ccga(dimensions, &population);
        eval_ccga(dimensions, &population, &min_fitness_indexes, func_ptr, &fitnesses);
        find_fitnesses_ccga(dimensions, &fitnesses, &min_fitness_indexes, &max_fitness_indexes,&highest_function_value, &total_fitnesses);
        fitness_window[age%window_size] = highest_function_value ;
        
        roulette_wheel_select_ccga(dimensions, &population, &fitnesses, &fitness_window, total_fitnesses);

        for(int i = 0 ; i < dimensions ; i++){//restore
            population[i][fitest_positions_backup[i]] = fitest_backup[i];
            fitnesses[i][fitest_positions_backup[i]] = fitness_backup[i];
            if(fitnesses[fitest_positions_backup[i]] < fitnesses[min_fitness_indexes[i]]){
                min_fitness_indexes[i] = fitest_positions_backup[i];
            }
        }

        for(int i = 0 ; i < dimensions ; i++){
            eval_vector[i] = population[i][min_fitness_indexes[i]];
        }

        (*results)[age] += func_ptr(&eval_vector);
    }
}

int main(void){
    srand(time(NULL));
    
    double fitnesses[iterations] ;
    double fitnesses_ccga[iterations];
    memset(&fitnesses, 0 , sizeof(double)*iterations);
    memset(&fitnesses_ccga, 0 , sizeof(double)*iterations);

    double (*rastrigin_ptr)(unsigned short (*pop)[NRASTR]) = &rastrigin ; //function pointer for rastrigin function
    for (int i = 0 ; i < average ; i++){ // revert that when done
        printf("Doing iteration %d\n",i);
        run_algorithm(&fitnesses, NRASTR,rastrigin_ptr);
        run_algorithm_ccga(&fitnesses_ccga, NRASTR, rastrigin_ptr);
    }

    FILE *outfile = fopen("data/ra.data","w");
    for (int i = 1 ; i < iterations ; i++){
        fprintf(outfile,"%d    %lf    %lf\n", (i+1)*100, fitnesses[i]/average, fitnesses_ccga[i]/average);
    }
    fclose(outfile);
        
    memset(&fitnesses, 0 , sizeof(double)*iterations);//clear results after each iteration
    memset(&fitnesses_ccga, 0 , sizeof(double)*iterations);//clear results after each iteration
    
    double (*griewangk_ptr)(unsigned short (*pop)[NGRIEW]) = &griewangk ; //function pointer for rastrigin function
    for (int i = 0 ; i < average ; i++){ // revert that when done
        printf("Doing iteration %d\n",i);
        run_algorithm(&fitnesses, NGRIEW, griewangk_ptr);
        run_algorithm_ccga(&fitnesses_ccga, NGRIEW, griewangk_ptr);
    }

    FILE *outfile_gr = fopen("data/gr.data","w");
    for (int i = 1 ; i < iterations ; i++){
        fprintf(outfile_gr,"%d    %lf    %lf\n", (i+1)*100, fitnesses[i]/average, fitnesses_ccga[i]/average);
    }
    fclose(outfile_gr);

    memset(&fitnesses, 0 , sizeof(double)*iterations);//clear results after each iteration
    memset(&fitnesses_ccga, 0 , sizeof(double)*iterations);//clear results after each iteration

    double (*ackley_ptr)(unsigned short (*pop)[NACKLEY]) = &ackley ; //function pointer for rastrigin function
    for (int i = 0 ; i < average ; i++){ 
        printf("Doing iteration %d\n",i);
        run_algorithm(&fitnesses, NACKLEY, ackley_ptr);
        run_algorithm_ccga(&fitnesses_ccga, NACKLEY, ackley_ptr);
    }

    FILE *outfile_ac = fopen("data/ac.data","w");
    for (int i = 1 ; i < iterations ; i++){
        fprintf(outfile_ac,"%d    %lf    %lf\n", (i+1)*100, fitnesses[i]/average, fitnesses_ccga[i]/average);
    }
    fclose(outfile_ac);

    memset(&fitnesses, 0 , sizeof(double)*iterations);//clear results after each iteration
    memset(&fitnesses_ccga, 0 , sizeof(double)*iterations);//clear results after each iteration    
    
    double (*schwefel_ptr)(unsigned short (*pop)[NSCHWE]) = &schwefel ; //function pointer for rastrigin function
    for (int i = 0 ; i < average ; i++){ // revert that when done
        printf("Doing iteration %d\n",i);
        run_algorithm(&fitnesses, NSCHWE, schwefel_ptr);
        run_algorithm_ccga(&fitnesses_ccga, NSCHWE, schwefel_ptr);
    }

    FILE *outfile_scw = fopen("data/scw.data","w");
    for (int i = 1 ; i < iterations ; i++){
        fprintf(outfile_scw,"%d    %lf    %lf\n", (i+1)*100, fitnesses[i]/average, fitnesses_ccga[i]/average);
    }
    fclose(outfile_scw);

    return 0;
}
