   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  49                     ; 13 main()
  49                     ; 14 {
  51                     	switch	.text
  52  0000               _main:
  56                     ; 15 	setup();
  58  0000 ad3c          	call	_setup
  60                     ; 17 	lcd_init();
  62  0002 cd0000        	call	_lcd_init
  64                     ; 18 	lcd_clear();
  66  0005 cd0000        	call	_lcd_clear
  68                     ; 19 	lcd_gotoxy(4,0);
  70  0008 ae0400        	ldw	x,#1024
  71  000b cd0000        	call	_lcd_gotoxy
  73                     ; 20 	lcd_puts("Welcome");
  75  000e ae0016        	ldw	x,#L12
  76  0011 cd0000        	call	_lcd_puts
  78                     ; 21 	delay_ms(2000);
  80  0014 ae07d0        	ldw	x,#2000
  81  0017 89            	pushw	x
  82  0018 ae0000        	ldw	x,#0
  83  001b 89            	pushw	x
  84  001c cd0000        	call	_delay_ms
  86  001f 5b04          	addw	sp,#4
  87                     ; 22 	lcd_clear();
  89  0021 cd0000        	call	_lcd_clear
  91  0024               L32:
  92                     ; 26 		lcd_gotoxy(3,0);
  94  0024 ae0300        	ldw	x,#768
  95  0027 cd0000        	call	_lcd_gotoxy
  97                     ; 27     lcd_puts("First Name");
  99  002a ae000b        	ldw	x,#L72
 100  002d cd0000        	call	_lcd_puts
 102                     ; 28     lcd_gotoxy(3,1);
 104  0030 ae0301        	ldw	x,#769
 105  0033 cd0000        	call	_lcd_gotoxy
 107                     ; 29     lcd_puts("Last  Name");
 109  0036 ae0000        	ldw	x,#L13
 110  0039 cd0000        	call	_lcd_puts
 113  003c 20e6          	jra	L32
 138                     ; 33 void setup(void)
 138                     ; 34 {
 139                     	switch	.text
 140  003e               _setup:
 144                     ; 35   clock_setup();
 146  003e ad03          	call	_clock_setup
 148                     ; 36   GPIO_setup();
 150  0040 ad67          	call	_GPIO_setup
 152                     ; 37 }
 155  0042 81            	ret
 188                     ; 40 void clock_setup(void)
 188                     ; 41 {
 189                     	switch	.text
 190  0043               _clock_setup:
 194                     ; 42   CLK_DeInit();
 196  0043 cd0000        	call	_CLK_DeInit
 198                     ; 44   CLK_HSECmd(ENABLE);
 200  0046 a601          	ld	a,#1
 201  0048 cd0000        	call	_CLK_HSECmd
 203                     ; 45   CLK_LSICmd(DISABLE);
 205  004b 4f            	clr	a
 206  004c cd0000        	call	_CLK_LSICmd
 208                     ; 46   CLK_HSICmd(DISABLE);
 210  004f 4f            	clr	a
 211  0050 cd0000        	call	_CLK_HSICmd
 214  0053               L55:
 215                     ; 47   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 217  0053 ae0102        	ldw	x,#258
 218  0056 cd0000        	call	_CLK_GetFlagStatus
 220  0059 4d            	tnz	a
 221  005a 27f7          	jreq	L55
 222                     ; 50 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 224  005c a680          	ld	a,#128
 225  005e cd0000        	call	_CLK_SYSCLKConfig
 227                     ; 53 	CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);
 229  0061 4f            	clr	a
 230  0062 cd0000        	call	_CLK_SYSCLKConfig
 232                     ; 56 	CLK_CCOConfig(CLK_OUTPUT_CPU);
 234  0065 a608          	ld	a,#8
 235  0067 cd0000        	call	_CLK_CCOConfig
 237                     ; 59 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSE, DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE);
 239  006a 4b00          	push	#0
 240  006c 4b00          	push	#0
 241  006e ae01b4        	ldw	x,#436
 242  0071 cd0000        	call	_CLK_ClockSwitchConfig
 244  0074 85            	popw	x
 245                     ; 61   CLK_ClockSwitchCmd(ENABLE);
 247  0075 a601          	ld	a,#1
 248  0077 cd0000        	call	_CLK_ClockSwitchCmd
 250                     ; 68   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 252  007a 5f            	clrw	x
 253  007b cd0000        	call	_CLK_PeripheralClockConfig
 255                     ; 69   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 257  007e ae0100        	ldw	x,#256
 258  0081 cd0000        	call	_CLK_PeripheralClockConfig
 260                     ; 70   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 262  0084 ae0300        	ldw	x,#768
 263  0087 cd0000        	call	_CLK_PeripheralClockConfig
 265                     ; 71   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 267  008a ae1200        	ldw	x,#4608
 268  008d cd0000        	call	_CLK_PeripheralClockConfig
 270                     ; 72   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 272  0090 ae1300        	ldw	x,#4864
 273  0093 cd0000        	call	_CLK_PeripheralClockConfig
 275                     ; 73   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 277  0096 ae0700        	ldw	x,#1792
 278  0099 cd0000        	call	_CLK_PeripheralClockConfig
 280                     ; 74   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 282  009c ae0500        	ldw	x,#1280
 283  009f cd0000        	call	_CLK_PeripheralClockConfig
 285                     ; 75   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 287  00a2 ae0400        	ldw	x,#1024
 288  00a5 cd0000        	call	_CLK_PeripheralClockConfig
 290                     ; 80 }
 293  00a8 81            	ret
 316                     ; 81 void GPIO_setup(void)
 316                     ; 82 {                    
 317                     	switch	.text
 318  00a9               _GPIO_setup:
 322                     ; 84 }
 325  00a9 81            	ret
 338                     	xdef	_main
 339                     	xdef	_GPIO_setup
 340                     	xdef	_clock_setup
 341                     	xdef	_setup
 342                     	xref	_lcd_gotoxy
 343                     	xref	_lcd_clear
 344                     	xref	_lcd_puts
 345                     	xref	_lcd_init
 346                     	xref	_delay_ms
 347                     	xref	_CLK_GetFlagStatus
 348                     	xref	_CLK_SYSCLKConfig
 349                     	xref	_CLK_CCOConfig
 350                     	xref	_CLK_ClockSwitchConfig
 351                     	xref	_CLK_PeripheralClockConfig
 352                     	xref	_CLK_ClockSwitchCmd
 353                     	xref	_CLK_LSICmd
 354                     	xref	_CLK_HSICmd
 355                     	xref	_CLK_HSECmd
 356                     	xref	_CLK_DeInit
 357                     .const:	section	.text
 358  0000               L13:
 359  0000 4c6173742020  	dc.b	"Last  Name",0
 360  000b               L72:
 361  000b 466972737420  	dc.b	"First Name",0
 362  0016               L12:
 363  0016 57656c636f6d  	dc.b	"Welcome",0
 383                     	end
