#include "keypad.h"
unsigned int keypad_press (void)
{
	GPIO_Init(Keypad_Port, (GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3), GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_Init(Keypad_Port, (GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7), GPIO_MODE_IN_PU_NO_IT);

	while (loop)
	{
		unsigned int key = 20;
		
		GPIO_WriteLow(Keypad_Port, R1);
		GPIO_WriteHigh(Keypad_Port, R2);
		GPIO_WriteHigh(Keypad_Port, R3);
		GPIO_WriteHigh(Keypad_Port, R4);
		delay_us(5);
		if(c1_ch){key=7;while(c1_ch);delay_ms(50);return key;}
		if(c2_ch){key=8;while(c2_ch);delay_ms(50);return key;}
		if(c3_ch){key=9;while(c3_ch);delay_ms(50);return key;}
		if(c4_ch){key=10;while(c4_ch);delay_ms(50);return key;}
		
		GPIO_WriteLow(Keypad_Port, R2);
		GPIO_WriteHigh(Keypad_Port, R1);
		GPIO_WriteHigh(Keypad_Port, R3);
		GPIO_WriteHigh(Keypad_Port, R4);
		delay_us(5);
		if(c1_ch){key=4;while(c1_ch);delay_ms(50);return key;}
		if(c2_ch){key=5;while(c2_ch);delay_ms(50);return key;}
		if(c3_ch){key=6;while(c3_ch);delay_ms(50);return key;}
		if(c4_ch){key=11;while(c4_ch);delay_ms(50);return key;}

		GPIO_WriteLow(Keypad_Port, R3);
		GPIO_WriteHigh(Keypad_Port, R1);
		GPIO_WriteHigh(Keypad_Port, R2);
		GPIO_WriteHigh(Keypad_Port, R4);
		delay_us(5);
		if(c1_ch){key=1;while(c1_ch);delay_ms(50);return key;}
		if(c2_ch){key=2;while(c2_ch);delay_ms(50);return key;}
		if(c3_ch){key=3;while(c3_ch);delay_ms(50);return key;}
		if(c4_ch){key=12;while(c4_ch);delay_ms(50);return key;}

		GPIO_WriteLow(Keypad_Port, R4);
		GPIO_WriteHigh(Keypad_Port, R1);
		GPIO_WriteHigh(Keypad_Port, R2);
		GPIO_WriteHigh(Keypad_Port, R3);
		delay_us(5);
		if(c1_ch){key=15;while(c1_ch);delay_ms(50);return key;}
		if(c2_ch){key=0;while(c2_ch);delay_ms(50);return key;}
		if(c3_ch){key=14;while(c3_ch);delay_ms(50);return key;}
		if(c4_ch){key=13;while(c4_ch);delay_ms(50);return key;}
	}
}