#include<stdio.h>

void fibo(int num);

int main(){
    int n;

    printf("Fibonacci Series:");
    printf("Enter the number of terms: ");
    scanf("%d", n);

    if(n >0 && n < 18){
        fibo(n);
        }
    else
    {
       printf(" Wrong entry !  Try Again !! ");
        return 0;
    }    

    printf("\nBye Bye...");


    
}




