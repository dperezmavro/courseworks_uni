#include <stdlib.h>

#define POPSIZE 100

static unsigned short mask1 = -1  ;
static const unsigned int chromlength = 16;
static const unsigned int average = 50 ;
static const unsigned int iterations = 1000 ;
static const unsigned int window_size = 5 ;
static const double number_of_fragments = pow(2,16);

double translate(unsigned short member, double max);
void mutate(int dimensions, unsigned short (*pop)[POPSIZE][dimensions]);
void crossover(unsigned short parent1, unsigned short parent2, unsigned short *child);
void initialize_pop(int dimensions, unsigned short (*pop)[POPSIZE][dimensions]);
void evaluate_fitnesses(int dimensions, double(*eval_function)(unsigned short (*pop)[dimensions]), double (*fitnesses)[POPSIZE], unsigned short (*pop)[POPSIZE][dimensions], int *max, int *min);
void roulette_selection(double (*fitnesses)[POPSIZE], unsigned int (*new_member)[POPSIZE],double (*fitness_window)[window_size]);

//CCGA things
void initialize_ccga(int dimensions, unsigned short (*pop)[dimensions][POPSIZE]);
void mutate_ccga(unsigned int dimensions, unsigned short (*pop)[dimensions][POPSIZE]);
void find_fitnesses_ccga(int dimensions, double (*fitnesses)[dimensions][POPSIZE], int (*fitnesses_min)[dimensions], int (*fitnesses_max)[dimensions], double *store, double *tot);
void eval_ccga(int dimensions,unsigned short (*pop)[dimensions][POPSIZE], int (*curr_best)[dimensions], double (*func_ptr)(unsigned short (*pop)[dimensions]), double (*fitnesses)[dimensions][POPSIZE]);
void crossover_ccga(unsigned int d, unsigned short(*pop)[d][POPSIZE]);
void roulette_wheel_select_ccga(int dimensions, unsigned short (*pop)[dimensions][POPSIZE], double (*fitnesses)[dimensions][POPSIZE], double (*scalling_window)[window_size], double total_fitnesses );
