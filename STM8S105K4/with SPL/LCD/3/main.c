#include "stm8s.h"
#include "src\lcd\lcd.h"
#include "src\keypad\keypad.h"
#include "src\delay\delay.h"
#include <stdio.h>

void setup(void);
void clock_setup(void);
void GPIO_setup(void);
void delay_ms(unsigned long int n); //Customized delay

main()
{
	unsigned int _pw = 2468;
	unsigned int _key_pad_data;
	unsigned int _lenght = 4;
	unsigned int _loop = 0;
	unsigned int _data = 0;
	unsigned int _result;
	char _str[17];
	
	setup();
	lcd_init();
	lcd_clear();
	lcd_gotoxy(4,0);
	lcd_puts("Welcome");
	delay_ms(2000);
	lcd_clear();
	
	while(1)
	{
		while(_loop < _lenght)
		{
			_key_pad_data = keypad_press();
			if(_key_pad_data >= 10)
				continue;
			_loop++;
			_data = (10*_data) + _key_pad_data;
			lcd_clear();
			sprintf(_str, "%d", _data);
			lcd_puts(_str);
			if(_loop == _lenght)
			{
				if(_data == _pw)
					_result = 1;
				else
					_result = 0;
			}
		}
		delay_ms(300);
		lcd_clear();
		if(_result == 0)
		{
			lcd_puts("Wrong");
			delay_ms(300);
			lcd_clear();
			delay_ms(300);
			lcd_puts("Wrong");
			delay_ms(300);
			lcd_clear();
			delay_ms(300);
			lcd_puts("Wrong");
			delay_ms(300);
			lcd_clear();
			delay_ms(300);
			lcd_puts("Wrong");
			delay_ms(300);
			lcd_clear();
		}
		else
			lcd_puts("Correct");
		
		_data = 0;
		_loop = 0;
	}
}

void setup(void)
{
  clock_setup();
  GPIO_setup();
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

}