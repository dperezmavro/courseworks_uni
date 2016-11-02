#include "evaluation_algorithms.h"

double rastrigin(unsigned short (*pop)[NRASTR]){
    double res = 3.0*NRASTR;
    double val;
    for(int i = 0 ; i < NRASTR ; i++){
        val = translate((*pop)[i] , 5.12);
       res += (val*val) - (3.0*cos(2.0*PI*val));
    }
    return res ;
}

double griewangk(unsigned short (*pop)[NGRIEW]){
    double res = 1 ;
    double sum = 0 ;
    double mul = 1 ;
    double member = 0 ;

    for(int i = 0 ; i < NGRIEW ; i++){
       member = translate((*pop)[i], 600.0);
       sum += (member*member) ;
       mul *= cos(member/sqrt(i+1));
    }

    return res + (sum/4000.0) - mul ;
}

double ackley(unsigned short (*pop)[NACKLEY]){
    double res = 20.0 + exp(1.0);
    double e1 = 0 ;
    double e2 = 0 ;
    double member = 0 ;

    for(int i = 0 ; i < NACKLEY ; i++){
        member = translate((*pop)[i], 30);
        e1 += member*member ;
        e2 += cos(2.0*PI*member);
    }

    e2 = exp(e2*1.0/(double)NACKLEY);
    e1 = exp(-0.2*sqrt(e1*1.0/(double)NACKLEY));
    return res - (20.0*e1) - e2 ;
}

double schwefel(unsigned short (*pop)[NSCHWE]){
    double res = 418.9829*NSCHWE ;
    double loop = 0 ;
    double member = 0 ;
    
    for(int i = 0 ; i < NSCHWE ; i++){
        member = translate((*pop)[i], 500);
        loop -= member*sin(sqrt(fabs(member)));
    }

    return res + loop;
}
