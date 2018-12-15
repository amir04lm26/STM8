#include "stm8s.h"

#define LED_port    GPIOD

void setup(void);
void clock_setup(void);
void GPIO_setup(void);
void delay_ms(unsigned long int n); // Customized delay

main()
{
	unsigned int _time = 14;
	_time = (_time*2);
	setup();
 
	while(_time-->0)
	{
		GPIO_WriteReverse(LED_port,GPIO_PIN_0);
		GPIO_WriteReverse(LED_port,GPIO_PIN_1);
		GPIO_WriteReverse(LED_port,GPIO_PIN_2);
		GPIO_WriteReverse(LED_port,GPIO_PIN_3);
		GPIO_WriteReverse(LED_port,GPIO_PIN_4);
		GPIO_WriteReverse(LED_port,GPIO_PIN_5);
		GPIO_WriteReverse(LED_port,GPIO_PIN_6);
		GPIO_WriteReverse(LED_port,GPIO_PIN_7);
		delay_ms(500); // wait 500 ms
	}
	while(1);
}

void delay_ms(unsigned long int n)
{
unsigned long int x=0;
unsigned long fCPU=16000000; // HSI RC =16 MHz ----- HSIDIV=8 ------CPUDIV=1 fCPU=16 / 8 / 1 Mhz
x=fCPU/5000;
x=x/50; 
n=n*x;
while (n-- > 0);
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
    GPIO_DeInit(LED_port);
    GPIO_Init(LED_port, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(LED_port, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(LED_port, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(LED_port, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(LED_port, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(LED_port, GPIO_PIN_5, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(LED_port, GPIO_PIN_6, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(LED_port, GPIO_PIN_7, GPIO_MODE_OUT_PP_LOW_FAST);
}