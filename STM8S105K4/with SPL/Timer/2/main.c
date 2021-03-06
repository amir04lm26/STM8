#include "stm8s.h"
#include "src\lcd\lcd.h"
#include <stdio.h>
#include "main.h"	

void main(void)
{
	setup();

	while(1)
	{
		//RED
		while (sec<RED_Time)
		{         
			GPIO_WriteHigh(GPIOD, GPIO_PIN_2);
		}    
		GPIO_WriteLow(GPIOD, GPIO_PIN_2);
		sec = 0;
		
		//GREEN
		while (sec<GREEN_Time)
		{         
			GPIO_WriteHigh(GPIOD, GPIO_PIN_4);
		}    
		GPIO_WriteLow(GPIOD, GPIO_PIN_4);
		sec = 0;
		
		//YELLOW
		while (sec<YELLOW_Time)
		{         
			GPIO_WriteHigh(GPIOD, GPIO_PIN_3);
		}    
		GPIO_WriteLow(GPIOD, GPIO_PIN_3);
		sec = 0;
	}
}

void setup(void)
{
  clock_setup();
  GPIO_setup();
	GPIO_WriteLow(GPIOD, GPIO_PIN_2);
	GPIO_WriteLow(GPIOD, GPIO_PIN_3);
	GPIO_WriteLow(GPIOD, GPIO_PIN_4);	
	lcd_init();
	lcd_clear();
	lcd_gotoxy(4,0); 
	lcd_puts("Welcome");
	delay_ms(2000);
	lcd_clear();
	lcd_gotoxy(2,0); 
	lcd_puts("_running..._");
	TIM2_setup();
}
 
void TIM2_setup(void)
{
    TIM2_DeInit();
    TIM2_TimeBaseInit(TIM2_PRESCALER_8, 1000);
		TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
    TIM2_Cmd(ENABLE);
		
		enableInterrupts();
}
 
void clock_setup(void)
{
  CLK_DeInit();

  CLK_HSECmd(ENABLE); //8Mgh
  CLK_LSICmd(DISABLE);
  CLK_HSICmd(DISABLE);
  while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
	
	/* Configure the Fcpu to DIV1*/
	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
	
	/* Configure the HSI prescaler to the optimal value */
	CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);

	/* Output Fcpu on CLK_CCO pin */
	CLK_CCOConfig(CLK_OUTPUT_CPU);

	/* Configure the system clock to use HSE clock source and to run at 24Mhz */
	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSE, DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE);

  CLK_ClockSwitchCmd(ENABLE);
  /*CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);
  CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV4);
 
  CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSE,
  DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);*/
 
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE); //Enable
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);

  /*CLK_CCOConfig(CLK_OUTPUT_CPU);
  CLK_CCOCmd(ENABLE);
  while(CLK_GetFlagStatus(CLK_FLAG_CCORDY) == FALSE);*/
}

void GPIO_setup(void)
{                    
	GPIO_DeInit(GPIOD); 
	GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST);
}