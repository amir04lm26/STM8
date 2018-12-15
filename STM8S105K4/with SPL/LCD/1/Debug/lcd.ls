   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  45                     ; 3 void LCD_GPIO_init(void)
  45                     ; 4 {
  47                     	switch	.text
  48  0000               _LCD_GPIO_init:
  52                     ; 5 	GPIO_Init(LCD_CTRL_PORT, LCD_RS_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
  54  0000 4bf0          	push	#240
  55  0002 4b02          	push	#2
  56  0004 ae500a        	ldw	x,#20490
  57  0007 cd0000        	call	_GPIO_Init
  59  000a 85            	popw	x
  60                     ; 7 	GPIO_Init(LCD_CTRL_PORT, LCD_EN_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
  62  000b 4bf0          	push	#240
  63  000d 4b08          	push	#8
  64  000f ae500a        	ldw	x,#20490
  65  0012 cd0000        	call	_GPIO_Init
  67  0015 85            	popw	x
  68                     ; 8 	GPIO_Init(LCD_DATA_PORT, LCD_D4_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
  70  0016 4bf0          	push	#240
  71  0018 4b10          	push	#16
  72  001a ae500a        	ldw	x,#20490
  73  001d cd0000        	call	_GPIO_Init
  75  0020 85            	popw	x
  76                     ; 9 	GPIO_Init(LCD_DATA_PORT, LCD_D5_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
  78  0021 4bf0          	push	#240
  79  0023 4b20          	push	#32
  80  0025 ae500a        	ldw	x,#20490
  81  0028 cd0000        	call	_GPIO_Init
  83  002b 85            	popw	x
  84                     ; 10 	GPIO_Init(LCD_DATA_PORT, LCD_D6_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
  86  002c 4bf0          	push	#240
  87  002e 4b40          	push	#64
  88  0030 ae500a        	ldw	x,#20490
  89  0033 cd0000        	call	_GPIO_Init
  91  0036 85            	popw	x
  92                     ; 11 	GPIO_Init(LCD_DATA_PORT, LCD_D7_pin, GPIO_MODE_OUT_PP_HIGH_FAST);
  94  0037 4bf0          	push	#240
  95  0039 4b80          	push	#128
  96  003b ae500a        	ldw	x,#20490
  97  003e cd0000        	call	_GPIO_Init
  99  0041 85            	popw	x
 100                     ; 12 	delay_ms(start_dly);   
 102  0042 ae000a        	ldw	x,#10
 103  0045 89            	pushw	x
 104  0046 ae0000        	ldw	x,#0
 105  0049 89            	pushw	x
 106  004a cd0000        	call	_delay_ms
 108  004d 5b04          	addw	sp,#4
 109                     ; 13 }
 112  004f 81            	ret
 140                     ; 15 void lcd_init(void) //LCD
 140                     ; 16 {                                     
 141                     	switch	.text
 142  0050               _lcd_init:
 146                     ; 17 	LCD_GPIO_init(); //Intialize LCD pins   
 148  0050 adae          	call	_LCD_GPIO_init
 150                     ; 18 	toggle_EN_pin();
 152  0052 cd01df        	call	_toggle_EN_pin
 154                     ; 20 	GPIO_WriteLow(LCD_CTRL_PORT, LCD_RS_pin);            
 156  0055 4b02          	push	#2
 157  0057 ae500a        	ldw	x,#20490
 158  005a cd0000        	call	_GPIO_WriteLow
 160  005d 84            	pop	a
 161                     ; 21 	GPIO_WriteLow(LCD_DATA_PORT, LCD_D7_pin);   
 163  005e 4b80          	push	#128
 164  0060 ae500a        	ldw	x,#20490
 165  0063 cd0000        	call	_GPIO_WriteLow
 167  0066 84            	pop	a
 168                     ; 22 	GPIO_WriteLow(LCD_DATA_PORT, LCD_D6_pin);   
 170  0067 4b40          	push	#64
 171  0069 ae500a        	ldw	x,#20490
 172  006c cd0000        	call	_GPIO_WriteLow
 174  006f 84            	pop	a
 175                     ; 23 	GPIO_WriteHigh(LCD_DATA_PORT, LCD_D5_pin);   
 177  0070 4b20          	push	#32
 178  0072 ae500a        	ldw	x,#20490
 179  0075 cd0000        	call	_GPIO_WriteHigh
 181  0078 84            	pop	a
 182                     ; 24 	GPIO_WriteHigh(LCD_DATA_PORT, LCD_D4_pin);                      
 184  0079 4b10          	push	#16
 185  007b ae500a        	ldw	x,#20490
 186  007e cd0000        	call	_GPIO_WriteHigh
 188  0081 84            	pop	a
 189                     ; 25 	toggle_EN_pin();
 191  0082 cd01df        	call	_toggle_EN_pin
 193                     ; 27 	GPIO_WriteLow(LCD_DATA_PORT, LCD_D7_pin);   
 195  0085 4b80          	push	#128
 196  0087 ae500a        	ldw	x,#20490
 197  008a cd0000        	call	_GPIO_WriteLow
 199  008d 84            	pop	a
 200                     ; 28 	GPIO_WriteLow(LCD_DATA_PORT, LCD_D6_pin);   
 202  008e 4b40          	push	#64
 203  0090 ae500a        	ldw	x,#20490
 204  0093 cd0000        	call	_GPIO_WriteLow
 206  0096 84            	pop	a
 207                     ; 29 	GPIO_WriteHigh(LCD_DATA_PORT, LCD_D5_pin);   
 209  0097 4b20          	push	#32
 210  0099 ae500a        	ldw	x,#20490
 211  009c cd0000        	call	_GPIO_WriteHigh
 213  009f 84            	pop	a
 214                     ; 30 	GPIO_WriteHigh(LCD_DATA_PORT, LCD_D4_pin);  
 216  00a0 4b10          	push	#16
 217  00a2 ae500a        	ldw	x,#20490
 218  00a5 cd0000        	call	_GPIO_WriteHigh
 220  00a8 84            	pop	a
 221                     ; 31 	toggle_EN_pin();
 223  00a9 cd01df        	call	_toggle_EN_pin
 225                     ; 33 	GPIO_WriteLow(LCD_DATA_PORT, LCD_D7_pin);   
 227  00ac 4b80          	push	#128
 228  00ae ae500a        	ldw	x,#20490
 229  00b1 cd0000        	call	_GPIO_WriteLow
 231  00b4 84            	pop	a
 232                     ; 34 	GPIO_WriteLow(LCD_DATA_PORT, LCD_D6_pin);   
 234  00b5 4b40          	push	#64
 235  00b7 ae500a        	ldw	x,#20490
 236  00ba cd0000        	call	_GPIO_WriteLow
 238  00bd 84            	pop	a
 239                     ; 35 	GPIO_WriteHigh(LCD_DATA_PORT, LCD_D5_pin);   
 241  00be 4b20          	push	#32
 242  00c0 ae500a        	ldw	x,#20490
 243  00c3 cd0000        	call	_GPIO_WriteHigh
 245  00c6 84            	pop	a
 246                     ; 36 	GPIO_WriteHigh(LCD_DATA_PORT, LCD_D4_pin);  
 248  00c7 4b10          	push	#16
 249  00c9 ae500a        	ldw	x,#20490
 250  00cc cd0000        	call	_GPIO_WriteHigh
 252  00cf 84            	pop	a
 253                     ; 37 	toggle_EN_pin();                  
 255  00d0 cd01df        	call	_toggle_EN_pin
 257                     ; 39 	GPIO_WriteLow(LCD_DATA_PORT, LCD_D7_pin);   
 259  00d3 4b80          	push	#128
 260  00d5 ae500a        	ldw	x,#20490
 261  00d8 cd0000        	call	_GPIO_WriteLow
 263  00db 84            	pop	a
 264                     ; 40 	GPIO_WriteLow(LCD_DATA_PORT, LCD_D6_pin);   
 266  00dc 4b40          	push	#64
 267  00de ae500a        	ldw	x,#20490
 268  00e1 cd0000        	call	_GPIO_WriteLow
 270  00e4 84            	pop	a
 271                     ; 41 	GPIO_WriteHigh(LCD_DATA_PORT, LCD_D5_pin);        
 273  00e5 4b20          	push	#32
 274  00e7 ae500a        	ldw	x,#20490
 275  00ea cd0000        	call	_GPIO_WriteHigh
 277  00ed 84            	pop	a
 278                     ; 42 	GPIO_WriteLow(LCD_DATA_PORT, LCD_D4_pin);  
 280  00ee 4b10          	push	#16
 281  00f0 ae500a        	ldw	x,#20490
 282  00f3 cd0000        	call	_GPIO_WriteLow
 284  00f6 84            	pop	a
 285                     ; 43 	toggle_EN_pin();
 287  00f7 cd01df        	call	_toggle_EN_pin
 289                     ; 45 	LCD_send((_4_pin_interface | _2_row_display | _5x7_dots), CMD);
 291  00fa ae2800        	ldw	x,#10240
 292  00fd ad10          	call	_LCD_send
 294                     ; 46 	LCD_send((display_on | cursor_off | blink_off), CMD); 
 296  00ff ae0c00        	ldw	x,#3072
 297  0102 ad0b          	call	_LCD_send
 299                     ; 47 	LCD_send(clear_display, CMD);         
 301  0104 ae0100        	ldw	x,#256
 302  0107 ad06          	call	_LCD_send
 304                     ; 48 	LCD_send((cursor_direction_inc | display_no_shift), CMD);
 306  0109 ae0600        	ldw	x,#1536
 307  010c ad01          	call	_LCD_send
 309                     ; 49 }   
 312  010e 81            	ret
 358                     ; 51 void LCD_send(unsigned char value, unsigned char mode)
 358                     ; 52 {                               
 359                     	switch	.text
 360  010f               _LCD_send:
 362  010f 89            	pushw	x
 363       00000000      OFST:	set	0
 366                     ; 53     switch(mode)
 368  0110 9f            	ld	a,xl
 370                     ; 63             break;
 371  0111 4d            	tnz	a
 372  0112 270e          	jreq	L33
 373  0114 4a            	dec	a
 374  0115 2614          	jrne	L16
 375                     ; 57             GPIO_WriteHigh(LCD_CTRL_PORT, LCD_RS_pin);   
 377  0117 4b02          	push	#2
 378  0119 ae500a        	ldw	x,#20490
 379  011c cd0000        	call	_GPIO_WriteHigh
 381  011f 84            	pop	a
 382                     ; 58             break;
 384  0120 2009          	jra	L16
 385  0122               L33:
 386                     ; 62             GPIO_WriteLow(LCD_CTRL_PORT, LCD_RS_pin);   
 388  0122 4b02          	push	#2
 389  0124 ae500a        	ldw	x,#20490
 390  0127 cd0000        	call	_GPIO_WriteLow
 392  012a 84            	pop	a
 393                     ; 63             break;
 395  012b               L16:
 396                     ; 67     LCD_4bit_send(value);
 398  012b 7b01          	ld	a,(OFST+1,sp)
 399  012d ad02          	call	_LCD_4bit_send
 401                     ; 68 }  
 404  012f 85            	popw	x
 405  0130 81            	ret
 441                     ; 70 void LCD_4bit_send(unsigned char lcd_data)       
 441                     ; 71 {
 442                     	switch	.text
 443  0131               _LCD_4bit_send:
 445  0131 88            	push	a
 446       00000000      OFST:	set	0
 449                     ; 72     toggle_io(lcd_data, 7, LCD_D7_pin);
 451  0132 4b80          	push	#128
 452  0134 ae0007        	ldw	x,#7
 453  0137 95            	ld	xh,a
 454  0138 cd01ff        	call	_toggle_io
 456  013b 84            	pop	a
 457                     ; 73     toggle_io(lcd_data, 6, LCD_D6_pin);
 459  013c 4b40          	push	#64
 460  013e ae0006        	ldw	x,#6
 461  0141 7b02          	ld	a,(OFST+2,sp)
 462  0143 95            	ld	xh,a
 463  0144 cd01ff        	call	_toggle_io
 465  0147 84            	pop	a
 466                     ; 74     toggle_io(lcd_data, 5, LCD_D5_pin);
 468  0148 4b20          	push	#32
 469  014a ae0005        	ldw	x,#5
 470  014d 7b02          	ld	a,(OFST+2,sp)
 471  014f 95            	ld	xh,a
 472  0150 cd01ff        	call	_toggle_io
 474  0153 84            	pop	a
 475                     ; 75     toggle_io(lcd_data, 4, LCD_D4_pin);
 477  0154 4b10          	push	#16
 478  0156 ae0004        	ldw	x,#4
 479  0159 7b02          	ld	a,(OFST+2,sp)
 480  015b 95            	ld	xh,a
 481  015c cd01ff        	call	_toggle_io
 483  015f 84            	pop	a
 484                     ; 76     toggle_EN_pin();
 486  0160 ad7d          	call	_toggle_EN_pin
 488                     ; 77     toggle_io(lcd_data, 3, LCD_D7_pin);
 490  0162 4b80          	push	#128
 491  0164 ae0003        	ldw	x,#3
 492  0167 7b02          	ld	a,(OFST+2,sp)
 493  0169 95            	ld	xh,a
 494  016a cd01ff        	call	_toggle_io
 496  016d 84            	pop	a
 497                     ; 78     toggle_io(lcd_data, 2, LCD_D6_pin);
 499  016e 4b40          	push	#64
 500  0170 ae0002        	ldw	x,#2
 501  0173 7b02          	ld	a,(OFST+2,sp)
 502  0175 95            	ld	xh,a
 503  0176 cd01ff        	call	_toggle_io
 505  0179 84            	pop	a
 506                     ; 79     toggle_io(lcd_data, 1, LCD_D5_pin);
 508  017a 4b20          	push	#32
 509  017c ae0001        	ldw	x,#1
 510  017f 7b02          	ld	a,(OFST+2,sp)
 511  0181 95            	ld	xh,a
 512  0182 ad7b          	call	_toggle_io
 514  0184 84            	pop	a
 515                     ; 80     toggle_io(lcd_data, 0, LCD_D4_pin);
 517  0185 4b10          	push	#16
 518  0187 5f            	clrw	x
 519  0188 7b02          	ld	a,(OFST+2,sp)
 520  018a 95            	ld	xh,a
 521  018b ad72          	call	_toggle_io
 523  018d 84            	pop	a
 524                     ; 81     toggle_EN_pin();
 526  018e ad4f          	call	_toggle_EN_pin
 528                     ; 82 }  
 531  0190 84            	pop	a
 532  0191 81            	ret
 568                     ; 84 void lcd_puts(char *lcd_string) //LCD_putstr
 568                     ; 85 {
 569                     	switch	.text
 570  0192               _lcd_puts:
 572  0192 89            	pushw	x
 573       00000000      OFST:	set	0
 576  0193               L711:
 577                     ; 88         LCD_send(*lcd_string++, DAT);
 579  0193 ae0001        	ldw	x,#1
 580  0196 1601          	ldw	y,(OFST+1,sp)
 581  0198 72a90001      	addw	y,#1
 582  019c 1701          	ldw	(OFST+1,sp),y
 583  019e 72a20001      	subw	y,#1
 584  01a2 90f6          	ld	a,(y)
 585  01a4 95            	ld	xh,a
 586  01a5 cd010f        	call	_LCD_send
 588                     ; 89     }while(*lcd_string != '\0');
 590  01a8 1e01          	ldw	x,(OFST+1,sp)
 591  01aa 7d            	tnz	(x)
 592  01ab 26e6          	jrne	L711
 593                     ; 90 }
 596  01ad 85            	popw	x
 597  01ae 81            	ret
 632                     ; 92 void lcd_putchar(char char_data) //LCD_putchar
 632                     ; 93 {
 633                     	switch	.text
 634  01af               _lcd_putchar:
 638                     ; 94     LCD_send(char_data, DAT);
 640  01af ae0001        	ldw	x,#1
 641  01b2 95            	ld	xh,a
 642  01b3 cd010f        	call	_LCD_send
 644                     ; 95 }
 647  01b6 81            	ret
 671                     ; 98 void lcd_clear(void) //LCD_clear_home
 671                     ; 99 {
 672                     	switch	.text
 673  01b7               _lcd_clear:
 677                     ; 100     LCD_send(clear_display, CMD);
 679  01b7 ae0100        	ldw	x,#256
 680  01ba cd010f        	call	_LCD_send
 682                     ; 101     LCD_send(goto_home, CMD);
 684  01bd ae0200        	ldw	x,#512
 685  01c0 cd010f        	call	_LCD_send
 687                     ; 102 }
 690  01c3 81            	ret
 734                     ; 105 void lcd_gotoxy(unsigned char  x_pos, unsigned char  y_pos)
 734                     ; 106 {                                                   
 735                     	switch	.text
 736  01c4               _lcd_gotoxy:
 738  01c4 89            	pushw	x
 739       00000000      OFST:	set	0
 742                     ; 107     if(y_pos == 0)    
 744  01c5 9f            	ld	a,xl
 745  01c6 4d            	tnz	a
 746  01c7 260b          	jrne	L571
 747                     ; 109         LCD_send((0x80 | x_pos), CMD);
 749  01c9 5f            	clrw	x
 750  01ca 7b01          	ld	a,(OFST+1,sp)
 751  01cc aa80          	or	a,#128
 752  01ce 95            	ld	xh,a
 753  01cf cd010f        	call	_LCD_send
 756  01d2 2009          	jra	L771
 757  01d4               L571:
 758                     ; 113         LCD_send((0x80 | 0x40 | x_pos), CMD); 
 760  01d4 5f            	clrw	x
 761  01d5 7b01          	ld	a,(OFST+1,sp)
 762  01d7 aac0          	or	a,#192
 763  01d9 95            	ld	xh,a
 764  01da cd010f        	call	_LCD_send
 766  01dd               L771:
 767                     ; 115 }
 770  01dd 85            	popw	x
 771  01de 81            	ret
 797                     ; 118 void toggle_EN_pin(void)
 797                     ; 119 {
 798                     	switch	.text
 799  01df               _toggle_EN_pin:
 803                     ; 120     GPIO_WriteHigh(LCD_CTRL_PORT, LCD_EN_pin);    
 805  01df 4b08          	push	#8
 806  01e1 ae500a        	ldw	x,#20490
 807  01e4 cd0000        	call	_GPIO_WriteHigh
 809  01e7 84            	pop	a
 810                     ; 121     delay_ms(dly);
 812  01e8 ae0002        	ldw	x,#2
 813  01eb 89            	pushw	x
 814  01ec ae0000        	ldw	x,#0
 815  01ef 89            	pushw	x
 816  01f0 cd0000        	call	_delay_ms
 818  01f3 5b04          	addw	sp,#4
 819                     ; 122     GPIO_WriteLow(LCD_CTRL_PORT,LCD_EN_pin);   
 821  01f5 4b08          	push	#8
 822  01f7 ae500a        	ldw	x,#20490
 823  01fa cd0000        	call	_GPIO_WriteLow
 825  01fd 84            	pop	a
 826                     ; 123 }
 829  01fe 81            	ret
 892                     ; 126 void toggle_io(unsigned char lcd_data, unsigned char bit_pos, unsigned char pin_num)
 892                     ; 127 {
 893                     	switch	.text
 894  01ff               _toggle_io:
 896  01ff 89            	pushw	x
 897  0200 89            	pushw	x
 898       00000002      OFST:	set	2
 901                     ; 128     int temp = 0;
 903                     ; 130     temp = (0x01 & (lcd_data >> bit_pos)); //Select data 
 905  0201 9f            	ld	a,xl
 906  0202 5f            	clrw	x
 907  0203 97            	ld	xl,a
 908  0204 7b03          	ld	a,(OFST+1,sp)
 909  0206 5d            	tnzw	x
 910  0207 2704          	jreq	L03
 911  0209               L23:
 912  0209 44            	srl	a
 913  020a 5a            	decw	x
 914  020b 26fc          	jrne	L23
 915  020d               L03:
 916  020d 5f            	clrw	x
 917  020e a401          	and	a,#1
 918  0210 5f            	clrw	x
 919  0211 02            	rlwa	x,a
 920  0212 1f01          	ldw	(OFST-1,sp),x
 921  0214 01            	rrwa	x,a
 922                     ; 132     switch(temp)
 924  0215 1e01          	ldw	x,(OFST-1,sp)
 925  0217 a30001        	cpw	x,#1
 926  021a 260c          	jrne	L312
 929  021c               L112:
 930                     ; 136             GPIO_WriteHigh(LCD_DATA_PORT, pin_num);   
 932  021c 7b07          	ld	a,(OFST+5,sp)
 933  021e 88            	push	a
 934  021f ae500a        	ldw	x,#20490
 935  0222 cd0000        	call	_GPIO_WriteHigh
 937  0225 84            	pop	a
 938                     ; 137             break;
 940  0226 200a          	jra	L152
 941  0228               L312:
 942                     ; 142             GPIO_WriteLow(LCD_DATA_PORT, pin_num);   
 944  0228 7b07          	ld	a,(OFST+5,sp)
 945  022a 88            	push	a
 946  022b ae500a        	ldw	x,#20490
 947  022e cd0000        	call	_GPIO_WriteLow
 949  0231 84            	pop	a
 950                     ; 143             break;
 951  0232               L152:
 952                     ; 146 }
 955  0232 5b04          	addw	sp,#4
 956  0234 81            	ret
 969                     	xdef	_toggle_io
 970                     	xdef	_toggle_EN_pin
 971                     	xdef	_lcd_gotoxy
 972                     	xdef	_lcd_clear
 973                     	xdef	_lcd_putchar
 974                     	xdef	_lcd_puts
 975                     	xdef	_LCD_4bit_send
 976                     	xdef	_LCD_send
 977                     	xdef	_lcd_init
 978                     	xdef	_LCD_GPIO_init
 979                     	xref	_delay_ms
 980                     	xref	_GPIO_WriteLow
 981                     	xref	_GPIO_WriteHigh
 982                     	xref	_GPIO_Init
1001                     	end
