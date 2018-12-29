#include "stm8s.h"
#include "src\lcd\lcd.h"
#include <stdio.h>
#include "main.h"	

/*
	LAB5 -> UART -> Recieve data from PC, Send it back
	and print it on the lcd
*/

void main(void)
{
	setup();
	
	USART_send("Welcome");
	
	while(1)
	{	
		lcd_gotoxy(0, 1);
    lcd_puts(data);
    delay_ms(100);
	}
}

void setup(void)
{
  clock_setup();
	lcd_init();
	lcd_clear();
	lcd_gotoxy(4,0); 
	lcd_puts("Welcome");
	delay_ms(2000);
	lcd_clear();
	lcd_gotoxy(3,0); 
	lcd_puts("running...");
	USART_setup();
}
 
void USART_setup(void)
{
	UART2_DeInit();
  UART2_Init((uint32_t)115200,UART2_WORDLENGTH_8D,UART2_STOPBITS_1,
  UART2_PARITY_NO,UART2_SYNCMODE_CLOCK_DISABLE,
	UART2_MODE_TXRX_ENABLE);
	
	UART2_SetPrescaler(8);
	UART2_Cmd(ENABLE);
	
	/* Part 2 */
  UART2_ITConfig(UART2_IT_RXNE_OR, ENABLE);
	enableInterrupts();
}

void USART_send(char *USART_string)
{
	while(*USART_string != 0)
  {
		UART2_SendData8(*USART_string);
		while(!UART2_GetFlagStatus(UART2_FLAG_TC));
		UART2_ClearFlag(UART2_FLAG_TXE);
		USART_string++;
  }
}
 
void clock_setup(void)
{
  CLK_DeInit();

  CLK_HSECmd(DISABLE); //8Mgh
  CLK_LSICmd(DISABLE);
  CLK_HSICmd(ENABLE);
  while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
	
	/* Configure the Fcpu to DIV1*/
	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
	
	/* Configure the HSI prescaler to the optimal value */
	CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);
 
  /* Set peripherals clock */
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART2, ENABLE); //Enable
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
}