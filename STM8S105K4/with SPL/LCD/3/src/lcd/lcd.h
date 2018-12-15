#ifndef _LCD_H
#define _LCD_H

#include "stm8s.h"
#include "delay.h"

#define LCD_DATA_PORT     	GPIOC
#define LCD_CTRL_PORT     	GPIOC
#define LCD_RS_pin        	GPIO_PIN_1
//#define LCD_RW_pin      	  GPIO_PIN_2
#define LCD_EN_pin        	GPIO_PIN_3
#define LCD_D4_pin        	GPIO_PIN_4
#define LCD_D5_pin        	GPIO_PIN_5
#define LCD_D6_pin        	GPIO_PIN_6
#define LCD_D7_pin        	GPIO_PIN_7

#define clear_display             0x01          
#define goto_home                 0x02
#define cursor_direction_inc      (0x04 | 0x02)
#define cursor_direction_dec      (0x04 | 0x00)
#define display_shift             (0x04 | 0x01) 
#define display_no_shift          (0x04 | 0x00)
 
#define display_on                (0x08 | 0x04)
#define display_off               (0x08 | 0x02) 
#define cursor_on                 (0x08 | 0x02)       
#define cursor_off                (0x08 | 0x00)   
#define blink_on                  (0x08 | 0x01)   
#define blink_off                 (0x08 | 0x00)   

#define _8_pin_interface          (0x20 | 0x10)   
#define _4_pin_interface          (0x20 | 0x00)      
#define _2_row_display            (0x20 | 0x08) 
#define _1_row_display            (0x20 | 0x00)
#define _5x10_dots                (0x20 | 0x40)      
#define _5x7_dots                 (0x20 | 0x00)
 
#define start_dly									10 
#define dly                       2
#define DAT                       1
#define CMD                       0
 
void LCD_GPIO_init(void);
void lcd_init(void);
void LCD_send(unsigned char value, unsigned char mode);
void LCD_4bit_send(unsigned char lcd_data);          
void lcd_puts(char *lcd_string);               
void lcd_putchar(char char_data);             
void lcd_clear(void);
void lcd_gotoxy(unsigned char  x_pos, unsigned char  y_pos);
void toggle_EN_pin(void);
void toggle_io(unsigned char lcd_data, unsigned char bit_pos, unsigned char pin_num);
#endif