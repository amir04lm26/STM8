#include "stm8s.h"
#include "src\lcd\lcd.h"
#include "src\keypad\keypad.h"
#include "src\delay\delay.h"
#include <stdio.h>
#include "main.h"	

void main(void)
{
	char _str[17];
	
	setup();
	
	while(1)
	{
		lcd_gotoxy(0,0);
		lcd_puts("pressed time is:");
		lcd_gotoxy(0,1);
		sprintf(_str, "%d", counter);
		lcd_puts(_str);
	}
}

void EXTI_setup(void)
{
	ITC_DeInit();
	ITC_SetSoftwarePriority(ITC_IRQ_PORTB, ITC_PRIORITYLEVEL_0);
 
	EXTI_DeInit();
	/*EXTI_SENSITIVITY_FALL_LOW
		EXTI_SENSITIVITY_RISE_ONLY
		EXTI_SENSITIVITY_FALL_ONLY
		EXTI_SENSITIVITY_RISE_FALL*/
	EXTI_SetExtIntSensitivity(ITC_IRQ_PORTB, EXTI_SENSITIVITY_FALL_ONLY);
	/*EXTI_TLISENSITIVITY_FALL_ONLY
		EXTI_TLISENSITIVITY_RISE_ONLY*/
	EXTI_SetTLISensitivity(EXTI_SENSITIVITY_RISE_ONLY);
 
	enableInterrupts();
}

void setup(void)
{
  clock_setup();
  GPIO_setup();
	EXTI_setup();
	lcd_init();
	lcd_clear();
	lcd_gotoxy(4,0); 
	lcd_puts("Welcome");
	delay_ms(2000);
	lcd_clear();
	//GPIO_WriteLow(GPIOD, GPIO_PIN_3);
}
 
void clock_setup(void)
{
  CLK_DeInit();

  CLK_HSECmd(ENABLE);
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
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);

  /*CLK_CCOConfig(CLK_OUTPUT_CPU);
  CLK_CCOCmd(ENABLE);
  while(CLK_GetFlagStatus(CLK_FLAG_CCORDY) == FALSE);*/
}

void GPIO_setup(void)
{                    
	GPIO_DeInit(GPIOB);    
	GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_IN_PU_IT);
	/*GPIO_DeInit(GPIOD); 
	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_FAST);*/
}