   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  57                     ; 11 main()
  57                     ; 12 {
  59                     	switch	.text
  60  0000               _main:
  62  0000 89            	pushw	x
  63       00000002      OFST:	set	2
  66                     ; 13 	unsigned int _time = 0;
  68  0001 5f            	clrw	x
  69  0002 1f01          	ldw	(OFST-1,sp),x
  70                     ; 14 	setup();
  72  0004 ad50          	call	_setup
  74  0006               L72:
  75                     ; 18 		if(!(GPIO_ReadInputPin(KEY_port, GPIO_PIN_0)))
  77  0006 4b01          	push	#1
  78  0008 ae5005        	ldw	x,#20485
  79  000b cd0000        	call	_GPIO_ReadInputPin
  81  000e 5b01          	addw	sp,#1
  82  0010 4d            	tnz	a
  83  0011 2614          	jrne	L33
  85  0013               L73:
  86                     ; 20 			while(!(GPIO_ReadInputPin(KEY_port, GPIO_PIN_0))); //Wait for debounce
  88  0013 4b01          	push	#1
  89  0015 ae5005        	ldw	x,#20485
  90  0018 cd0000        	call	_GPIO_ReadInputPin
  92  001b 5b01          	addw	sp,#1
  93  001d 4d            	tnz	a
  94  001e 27f3          	jreq	L73
  95                     ; 21 			_time++;
  97  0020 1e01          	ldw	x,(OFST-1,sp)
  98  0022 1c0001        	addw	x,#1
  99  0025 1f01          	ldw	(OFST-1,sp),x
 100  0027               L33:
 101                     ; 23 		GPIO_Write(LED_port, _time); //Key press num  
 103  0027 7b02          	ld	a,(OFST+0,sp)
 104  0029 88            	push	a
 105  002a ae500f        	ldw	x,#20495
 106  002d cd0000        	call	_GPIO_Write
 108  0030 84            	pop	a
 110  0031 20d3          	jra	L72
 162                     ; 27 void delay_ms(unsigned long int n)
 162                     ; 28 {
 163                     	switch	.text
 164  0033               _delay_ms:
 166  0033 5208          	subw	sp,#8
 167       00000008      OFST:	set	8
 170                     ; 29 unsigned long int x=0;
 172                     ; 30 unsigned long fCPU=16000000; // HSI RC =16 MHz ----- HSIDIV=8 ------CPUDIV=1 fCPU=16 / 8 / 1 Mhz
 174                     ; 31 x=fCPU/5000;
 176                     ; 32 x=x/50; 
 178                     ; 33 n=n*x;
 180  0035 96            	ldw	x,sp
 181  0036 1c000b        	addw	x,#OFST+3
 182  0039 a606          	ld	a,#6
 183  003b cd0000        	call	c_lglsh
 186  003e               L37:
 187                     ; 34 while (n-- > 0);
 189  003e 96            	ldw	x,sp
 190  003f 1c000b        	addw	x,#OFST+3
 191  0042 cd0000        	call	c_ltor
 193  0045 96            	ldw	x,sp
 194  0046 1c000b        	addw	x,#OFST+3
 195  0049 a601          	ld	a,#1
 196  004b cd0000        	call	c_lgsbc
 198  004e cd0000        	call	c_lrzmp
 200  0051 26eb          	jrne	L37
 201                     ; 35 }
 204  0053 5b08          	addw	sp,#8
 205  0055 81            	ret
 230                     ; 37 void setup(void)
 230                     ; 38 {
 231                     	switch	.text
 232  0056               _setup:
 236                     ; 39   clock_setup();
 238  0056 ad03          	call	_clock_setup
 240                     ; 40   GPIO_setup();
 242  0058 ad67          	call	_GPIO_setup
 244                     ; 41 }
 247  005a 81            	ret
 280                     ; 44 void clock_setup(void)
 280                     ; 45 {
 281                     	switch	.text
 282  005b               _clock_setup:
 286                     ; 46   CLK_DeInit();
 288  005b cd0000        	call	_CLK_DeInit
 290                     ; 48   CLK_HSECmd(ENABLE);
 292  005e a601          	ld	a,#1
 293  0060 cd0000        	call	_CLK_HSECmd
 295                     ; 49   CLK_LSICmd(DISABLE);
 297  0063 4f            	clr	a
 298  0064 cd0000        	call	_CLK_LSICmd
 300                     ; 50   CLK_HSICmd(DISABLE);
 302  0067 4f            	clr	a
 303  0068 cd0000        	call	_CLK_HSICmd
 306  006b               L121:
 307                     ; 51   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 309  006b ae0102        	ldw	x,#258
 310  006e cd0000        	call	_CLK_GetFlagStatus
 312  0071 4d            	tnz	a
 313  0072 27f7          	jreq	L121
 314                     ; 54 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 316  0074 a680          	ld	a,#128
 317  0076 cd0000        	call	_CLK_SYSCLKConfig
 319                     ; 57 	CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);
 321  0079 4f            	clr	a
 322  007a cd0000        	call	_CLK_SYSCLKConfig
 324                     ; 60 	CLK_CCOConfig(CLK_OUTPUT_CPU);
 326  007d a608          	ld	a,#8
 327  007f cd0000        	call	_CLK_CCOConfig
 329                     ; 63 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSE, DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE);
 331  0082 4b00          	push	#0
 332  0084 4b00          	push	#0
 333  0086 ae01b4        	ldw	x,#436
 334  0089 cd0000        	call	_CLK_ClockSwitchConfig
 336  008c 85            	popw	x
 337                     ; 65   CLK_ClockSwitchCmd(ENABLE);
 339  008d a601          	ld	a,#1
 340  008f cd0000        	call	_CLK_ClockSwitchCmd
 342                     ; 72   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 344  0092 5f            	clrw	x
 345  0093 cd0000        	call	_CLK_PeripheralClockConfig
 347                     ; 73   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 349  0096 ae0100        	ldw	x,#256
 350  0099 cd0000        	call	_CLK_PeripheralClockConfig
 352                     ; 74   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 354  009c ae0300        	ldw	x,#768
 355  009f cd0000        	call	_CLK_PeripheralClockConfig
 357                     ; 75   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 359  00a2 ae1200        	ldw	x,#4608
 360  00a5 cd0000        	call	_CLK_PeripheralClockConfig
 362                     ; 76   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 364  00a8 ae1300        	ldw	x,#4864
 365  00ab cd0000        	call	_CLK_PeripheralClockConfig
 367                     ; 77   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 369  00ae ae0700        	ldw	x,#1792
 370  00b1 cd0000        	call	_CLK_PeripheralClockConfig
 372                     ; 78   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 374  00b4 ae0500        	ldw	x,#1280
 375  00b7 cd0000        	call	_CLK_PeripheralClockConfig
 377                     ; 79   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 379  00ba ae0400        	ldw	x,#1024
 380  00bd cd0000        	call	_CLK_PeripheralClockConfig
 382                     ; 84 }
 385  00c0 81            	ret
 410                     ; 85 void GPIO_setup(void)
 410                     ; 86 {                               
 411                     	switch	.text
 412  00c1               _GPIO_setup:
 416                     ; 87   GPIO_DeInit(LED_port);
 418  00c1 ae500f        	ldw	x,#20495
 419  00c4 cd0000        	call	_GPIO_DeInit
 421                     ; 88 	GPIO_Init(LED_port, GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7, 	GPIO_MODE_OUT_PP_LOW_FAST);
 423  00c7 4be0          	push	#224
 424  00c9 4bff          	push	#255
 425  00cb ae500f        	ldw	x,#20495
 426  00ce cd0000        	call	_GPIO_Init
 428  00d1 85            	popw	x
 429                     ; 89 	GPIO_Init(KEY_port, GPIO_PIN_0, GPIO_MODE_IN_PU_NO_IT);
 431  00d2 4b40          	push	#64
 432  00d4 4b01          	push	#1
 433  00d6 ae5005        	ldw	x,#20485
 434  00d9 cd0000        	call	_GPIO_Init
 436  00dc 85            	popw	x
 437                     ; 90 }
 440  00dd 81            	ret
 453                     	xdef	_main
 454                     	xdef	_delay_ms
 455                     	xdef	_GPIO_setup
 456                     	xdef	_clock_setup
 457                     	xdef	_setup
 458                     	xref	_GPIO_ReadInputPin
 459                     	xref	_GPIO_Write
 460                     	xref	_GPIO_Init
 461                     	xref	_GPIO_DeInit
 462                     	xref	_CLK_GetFlagStatus
 463                     	xref	_CLK_SYSCLKConfig
 464                     	xref	_CLK_CCOConfig
 465                     	xref	_CLK_ClockSwitchConfig
 466                     	xref	_CLK_PeripheralClockConfig
 467                     	xref	_CLK_ClockSwitchCmd
 468                     	xref	_CLK_LSICmd
 469                     	xref	_CLK_HSICmd
 470                     	xref	_CLK_HSECmd
 471                     	xref	_CLK_DeInit
 490                     	xref	c_lrzmp
 491                     	xref	c_lgsbc
 492                     	xref	c_ltor
 493                     	xref	c_lglsh
 494                     	end
