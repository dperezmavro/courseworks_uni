#ifndef MAIN_H_EOC1
#define MAIN_H_EOC1

#define POP 500 //varying this (500 to 100) doesn't really afect GA-C, but really affects GA. increasing it to 1000 had a noticeable effect
#define MAX_FITNESS 28
#define LEN 28


extern unsigned char population[POP][LEN+1];
extern unsigned int fitnesses[POP] ;
extern const char *weasel;
extern unsigned int population_fitness;
extern unsigned int *roulette ;

int fitness(char *str);
unsigned char get_random_char();
void mutate(char *str);
void build_wheel();
int random_fit_parent();
int random_parent();
unsigned int get_fittest();
void initialize_population();
void hill_climber();
void print_fitnesses();
void ga_no_crossover();
void perform_crossover(unsigned char *par1, unsigned char *par2, unsigned char *res);
void ga_crossover();

#endif
