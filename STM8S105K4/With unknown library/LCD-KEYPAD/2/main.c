#include "stm8s.h"
#include "lcd\lcd.h"
#include "keypad\keypad.h"
#include "delay.h"
#include <stdio.h>

main()   
{            
	unsigned int _pw = 2468;
	unsigned int _key_pad_data;
	unsigned int _lenght = 4;
	unsigned int _loop = 0;
	unsigned int _data = 0;
	unsigned int _result;
	char _str[17];
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