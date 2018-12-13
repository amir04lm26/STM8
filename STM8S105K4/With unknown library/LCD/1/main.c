#include "stm8s.h"
#include "lcd\lcd.h"
//#include "delay.h"

main()   
{            
	lcd_init();
	lcd_clear();
	lcd_gotoxy(4,0);
	lcd_puts("Welcome");
	delay_ms(2000);
	lcd_clear();
	
	while(1)
	{
		lcd_gotoxy(3,0);
    lcd_puts("First Name");
    lcd_gotoxy(3,1);
    lcd_puts("Last  Name");
	}
}