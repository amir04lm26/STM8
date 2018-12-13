#include "tim6.h"

//2ms��ʱ�����ж�ģʽ
void TIM6_Init(void)
{
	CLK->PCKENR1 |= CLK_PCKENR1_TIM6;		//Timer5 clock enable
	TIM6->PSCR |= 0x07;									//128��Ƶ��125KHZ = 8us
	TIM6->CR1 |= TIM6_CR1_ARPE;					//Auto-Reload Preload Enable
	TIM6->ARR = 250;										//2ms=250*8us
	TIM6->IER |= TIM6_IER_UIE;					//Update Interrupt Enable
	TIM6->CR1 |= TIM6_CR1_CEN;					//Counter Enable
}