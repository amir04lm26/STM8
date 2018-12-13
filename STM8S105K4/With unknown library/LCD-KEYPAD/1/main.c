#include "stm8s.h"
#include "lcd\lcd.h"
#include "keypad\keypad.h"
#include "delay.h"
#include <stdio.h>

main()   
{            
	unsigned int key_pad;
	char str[17];
	lcd_init();
	lcd_clear();
	lcd_gotoxy(4,0);
	lcd_puts("Welcome");
	delay_ms(2000);
	lcd_clear();
	
	while(1)
	{
		key_pad=keypad_press();
    sprintf(str,"Number is %d",key_pad);
    lcd_puts(str);
    delay_ms(200);
    lcd_clear();
	}
}