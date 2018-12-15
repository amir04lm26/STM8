#include "lcd.h"
 
void LCD_GPIO_init(void)
{
	GPIO_Init(LCD_CTRL_PORT, LCD_RS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
	//GPIO_Init(LCD_CTRL_PORT, LCD_RW_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_Init(LCD_CTRL_PORT, LCD_EN_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_Init(LCD_DATA_PORT, LCD_D4_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_Init(LCD_DATA_PORT, LCD_D5_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_Init(LCD_DATA_PORT, LCD_D6_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_Init(LCD_DATA_PORT, LCD_D7_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
	delay_ms(start_dly);   
}
 
void lcd_init(void) //LCD
{                                     
	LCD_GPIO_init(); //Intialize LCD pins   
	toggle_EN_pin();
  
	GPIO_WriteLow(LCD_CTRL_PORT, LCD_RS_pin);            
	GPIO_WriteLow(LCD_DATA_PORT, LCD_D7_pin);   
	GPIO_WriteLow(LCD_DATA_PORT, LCD_D6_pin);   
	GPIO_WriteHigh(LCD_DATA_PORT, LCD_D5_pin);   
	GPIO_WriteHigh(LCD_DATA_PORT, LCD_D4_pin);                      
	toggle_EN_pin();
  
	GPIO_WriteLow(LCD_DATA_PORT, LCD_D7_pin);   
	GPIO_WriteLow(LCD_DATA_PORT, LCD_D6_pin);   
	GPIO_WriteHigh(LCD_DATA_PORT, LCD_D5_pin);   
	GPIO_WriteHigh(LCD_DATA_PORT, LCD_D4_pin);  
	toggle_EN_pin();
 
	GPIO_WriteLow(LCD_DATA_PORT, LCD_D7_pin);   
	GPIO_WriteLow(LCD_DATA_PORT, LCD_D6_pin);   
	GPIO_WriteHigh(LCD_DATA_PORT, LCD_D5_pin);   
	GPIO_WriteHigh(LCD_DATA_PORT, LCD_D4_pin);  
	toggle_EN_pin();                  
 
	GPIO_WriteLow(LCD_DATA_PORT, LCD_D7_pin);   
	GPIO_WriteLow(LCD_DATA_PORT, LCD_D6_pin);   
	GPIO_WriteHigh(LCD_DATA_PORT, LCD_D5_pin);        
	GPIO_WriteLow(LCD_DATA_PORT, LCD_D4_pin);  
	toggle_EN_pin();
 
	LCD_send((_4_pin_interface | _2_row_display | _5x7_dots), CMD);
	LCD_send((display_on | cursor_off | blink_off), CMD); 
	LCD_send(clear_display, CMD);         
	LCD_send((cursor_direction_inc | display_no_shift), CMD);
}   
 
void LCD_send(unsigned char value, unsigned char mode)
{                               
    switch(mode)
    {
        case DAT:
        {
            GPIO_WriteHigh(LCD_CTRL_PORT, LCD_RS_pin);   
            break;
        }
        case CMD:
        {
            GPIO_WriteLow(LCD_CTRL_PORT, LCD_RS_pin);   
            break;
        }
    }

    LCD_4bit_send(value);
}  

void LCD_4bit_send(unsigned char lcd_data)       
{
    toggle_io(lcd_data, 7, LCD_D7_pin);
    toggle_io(lcd_data, 6, LCD_D6_pin);
    toggle_io(lcd_data, 5, LCD_D5_pin);
    toggle_io(lcd_data, 4, LCD_D4_pin);
    toggle_EN_pin();
    toggle_io(lcd_data, 3, LCD_D7_pin);
    toggle_io(lcd_data, 2, LCD_D6_pin);
    toggle_io(lcd_data, 1, LCD_D5_pin);
    toggle_io(lcd_data, 0, LCD_D4_pin);
    toggle_EN_pin();
}  

void lcd_puts(char *lcd_string) //LCD_putstr
{
    do
    {
        LCD_send(*lcd_string++, DAT);
    }while(*lcd_string != '\0');
}

void lcd_putchar(char char_data) //LCD_putchar
{
    LCD_send(char_data, DAT);
}

//Clear LCD & go home(0,0)
void lcd_clear(void) //LCD_clear_home
{
    LCD_send(clear_display, CMD);
    LCD_send(goto_home, CMD);
}

//LCD position
void lcd_gotoxy(unsigned char  x_pos, unsigned char  y_pos)
{                                                   
    if(y_pos == 0)    
    {                              
        LCD_send((0x80 | x_pos), CMD);
    }
    else 
    {                                              
        LCD_send((0x80 | 0x40 | x_pos), CMD); 
    }
}
 
//LCD_PORT -> Manual handle
void toggle_EN_pin(void)
{
    GPIO_WriteHigh(LCD_CTRL_PORT, LCD_EN_pin);    
    delay_ms(dly);
    GPIO_WriteLow(LCD_CTRL_PORT,LCD_EN_pin);   
}

//Sepperate & send data
void toggle_io(unsigned char lcd_data, unsigned char bit_pos, unsigned char pin_num)
{
    int temp = 0;
    
    temp = (0x01 & (lcd_data >> bit_pos)); //Select data 

    switch(temp)
    {
        case 1:
        {
            GPIO_WriteHigh(LCD_DATA_PORT, pin_num);   
            break;
        }
 
        default:
        {
            GPIO_WriteLow(LCD_DATA_PORT, pin_num);   
            break;
         }
      }
}