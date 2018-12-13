#include "stm8s.h"

void delay_ms(unsigned long int n); // Customized delay

main()   
{            
	unsigned int _time = 14;
	
	GPIOD->DDR |= 0xff; // PD as Output
	GPIOD->CR1 |= 0xff; // PD as Push Pull Type Output

	while(_time-- >0)
	{
		GPIOD->ODR |= (0xff<<0);  // Key press num  
		delay_ms(500); // wait 500 ms
		GPIOD->ODR &= !(0xff<<0);  // Key press num  
		delay_ms(500); // wait 500 ms
	}
	
	while(1);
}

void delay_ms(unsigned long int n)
{
unsigned long int x=0;
unsigned long fCPU=800000; // HSI RC =16 MHz ----- HSIDIV=8 ------CPUDIV=1 fCPU=16 / 8 / 1 Mhz
x=fCPU/1000;
x=x/50; 
n=n*x;
while (n-- > 0);
}