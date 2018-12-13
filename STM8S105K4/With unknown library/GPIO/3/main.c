#include "stm8s.h"

void delay_ms(unsigned long int n); // Customized delay

main()   
{            
	unsigned int _time = 5; // Static repaet blink

	GPIOD->DDR |= 0xff; // PD as Output
	GPIOD->CR1 |= 0xff; // PD as Push Pull Type Output
	GPIOC->DDR &= ~(1<<6); // PC.6 as input
	GPIOC->CR1 |= (1<<6);	// Pull up without interrupts
	
	while(1)
	{
		GPIOD->ODR &= ~(0xff<<0); // All LED off
		if(!((GPIOC->IDR)&(1<<6))) // if PC.6 == 0
		{
			unsigned int __time = _time; // Repaet blink
			while(!((GPIOC->IDR)&(1<<6))); // wait for debounce
			while(__time-- > 0)
			{
				GPIOD->ODR |= (0xff<<0);  // All LED on  
				delay_ms(500); // wait 500ms						           
				GPIOD->ODR &= ~(0xff<<0); // All LED off
				delay_ms(500); // wait 500ms
			}
		}
	}
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