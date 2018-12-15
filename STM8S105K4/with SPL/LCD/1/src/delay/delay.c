#include "delay.h"
void delay_ms(unsigned long int n)
{
unsigned long int x=0;
unsigned long fCPU=16000000; // HSI RC =16 MHz ----- HSIDIV=8 ------CPUDIV=1 fCPU=16 / 8 / 1 Mhz
x=fCPU/5000;
x=x/50; 
n=n*x;
while (n-- > 0);
}