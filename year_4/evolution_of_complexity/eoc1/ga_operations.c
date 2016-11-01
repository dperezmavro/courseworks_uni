#include <stdlib.h>
#include "main.h"

void mutate(char *str)
{
    int i = 0 ;
    for (; i < LEN ; i++){
        if(random()/(double) RAND_MAX <= 1.0/28.0){
            str[i] = get_random_char() ;
        }
    }
}

void perform_crossover(unsigned char *par1, unsigned char *par2, unsigned char *res){
    int i = 0 ;
    for( ; i < LEN+1 ; i++){ //len+1 will copy \0
        res[i] = ( rand()%10 < 5 ) ? par1[i] : par2[i] ;
    }
}
