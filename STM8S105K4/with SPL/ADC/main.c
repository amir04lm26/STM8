#include "stm8s.h"
#include "src\lcd\lcd.h"
#include <stdio.h>
#include "main.h"	

/*
	LAB6 -> ADC -> Volt Meter
*/

void main(void)
{
	unsigned char lcd[16];
	unsigned int _Time = 0;
	float ADC_val;
	float temp;
	int real = 0;
	int point = 0;
	
	setup();
	
	while(1)
	{	
		while(_Time < 11)
		{
			_Time++;
			ADC1_StartConversion();
			while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);

			ADC_val = ADC1_GetConversionValue();
			ADC1_ClearFlag(ADC1_FLAG_EOC);
		
			if(ADC_val != 0)
				ADC_val=(ADC_val/1023.0)*5;//5.1
				
			temp += ADC_val;
		}
		temp = temp/10.0;
		
		/* Sprintf for float dows not work */
		real = (int)ADC_val;
		point = (int)((ADC_val-real)*100);
		
		//lcd_clear();
		sprintf(lcd, "VAL=%d.%d", real, point);
		lcd_gotoxy(3,0); 
		lcd_puts("LAB6->ADC");
		lcd_gotoxy(3,1); 
		lcd_puts(lcd);
		delay_ms(500);
	}
}

void setup(void)
{
  clock_setup();
  GPIO_setup();
	ADC1_setup();
	lcd_init();
	lcd_clear();
	lcd_gotoxy(4,0); 
	lcd_puts("Welcome");
	delay_ms(2000);
	lcd_clear();
}
 
void ADC1_setup(void)
{
	ADC1_DeInit();         
	ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, 
             ADC1_CHANNEL_4,
             ADC1_PRESSEL_FCPU_D8, 
             ADC1_EXTTRIG_GPIO, 
             DISABLE, 
             ADC1_ALIGN_RIGHT, 
             ADC1_SCHMITTTRIG_CHANNEL4, 
             DISABLE);
	ADC1_Cmd(ENABLE);
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
	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSE,
	DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE);
	
	/* Switch mode -> Enable */
  CLK_ClockSwitchCmd(ENABLE);
	
	/* CSS -> Enable */
	CLK_ClockSecuritySystemEnable();
 
  /* Set peripherals clock */
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART2, DISABLE); 
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE); //Enable
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
}

void GPIO_setup(void)
{                    
	GPIO_DeInit(GPIOD);
	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);
}