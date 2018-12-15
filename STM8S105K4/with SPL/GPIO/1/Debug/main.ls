   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  57                     ; 10 main()
  57                     ; 11 {
  59                     	switch	.text
  60  0000               _main:
  62  0000 89            	pushw	x
  63       00000002      OFST:	set	2
  66                     ; 12 	unsigned int _time = 14;
  68                     ; 13 	_time = (_time*2);
  70  0001 ae001c        	ldw	x,#28
  71  0004 1f01          	ldw	(OFST-1,sp),x
  72                     ; 14 	setup();
  74  0006 cd008a        	call	_setup
  77  0009 204b          	jra	L13
  78  000b               L72:
  79                     ; 18 		GPIO_WriteReverse(LED_port,GPIO_PIN_1);
  81  000b 4b02          	push	#2
  82  000d ae500f        	ldw	x,#20495
  83  0010 cd0000        	call	_GPIO_WriteReverse
  85  0013 84            	pop	a
  86                     ; 19 		GPIO_WriteReverse(LED_port,GPIO_PIN_2);
  88  0014 4b04          	push	#4
  89  0016 ae500f        	ldw	x,#20495
  90  0019 cd0000        	call	_GPIO_WriteReverse
  92  001c 84            	pop	a
  93                     ; 20 		GPIO_WriteReverse(LED_port,GPIO_PIN_3);
  95  001d 4b08          	push	#8
  96  001f ae500f        	ldw	x,#20495
  97  0022 cd0000        	call	_GPIO_WriteReverse
  99  0025 84            	pop	a
 100                     ; 21 		GPIO_WriteReverse(LED_port,GPIO_PIN_4);
 102  0026 4b10          	push	#16
 103  0028 ae500f        	ldw	x,#20495
 104  002b cd0000        	call	_GPIO_WriteReverse
 106  002e 84            	pop	a
 107                     ; 22 		GPIO_WriteReverse(LED_port,GPIO_PIN_5);
 109  002f 4b20          	push	#32
 110  0031 ae500f        	ldw	x,#20495
 111  0034 cd0000        	call	_GPIO_WriteReverse
 113  0037 84            	pop	a
 114                     ; 23 		GPIO_WriteReverse(LED_port,GPIO_PIN_6);
 116  0038 4b40          	push	#64
 117  003a ae500f        	ldw	x,#20495
 118  003d cd0000        	call	_GPIO_WriteReverse
 120  0040 84            	pop	a
 121                     ; 24 		GPIO_WriteReverse(LED_port,GPIO_PIN_7);
 123  0041 4b80          	push	#128
 124  0043 ae500f        	ldw	x,#20495
 125  0046 cd0000        	call	_GPIO_WriteReverse
 127  0049 84            	pop	a
 128                     ; 25 		delay_ms(500); // wait 500 ms
 130  004a ae01f4        	ldw	x,#500
 131  004d 89            	pushw	x
 132  004e ae0000        	ldw	x,#0
 133  0051 89            	pushw	x
 134  0052 ad13          	call	_delay_ms
 136  0054 5b04          	addw	sp,#4
 137  0056               L13:
 138                     ; 16 	while(_time-->0)
 140  0056 1e01          	ldw	x,(OFST-1,sp)
 141  0058 1d0001        	subw	x,#1
 142  005b 1f01          	ldw	(OFST-1,sp),x
 143  005d 1c0001        	addw	x,#1
 144  0060 a30000        	cpw	x,#0
 145  0063 26a6          	jrne	L72
 146  0065               L53:
 147                     ; 27 	while(1);
 149  0065 20fe          	jra	L53
 201                     ; 30 void delay_ms(unsigned long int n)
 201                     ; 31 {
 202                     	switch	.text
 203  0067               _delay_ms:
 205  0067 5208          	subw	sp,#8
 206       00000008      OFST:	set	8
 209                     ; 32 unsigned long int x=0;
 211                     ; 33 unsigned long fCPU=16000000; // HSI RC =16 MHz ----- HSIDIV=8 ------CPUDIV=1 fCPU=16 / 8 / 1 Mhz
 213                     ; 34 x=fCPU/5000;
 215                     ; 35 x=x/50; 
 217                     ; 36 n=n*x;
 219  0069 96            	ldw	x,sp
 220  006a 1c000b        	addw	x,#OFST+3
 221  006d a606          	ld	a,#6
 222  006f cd0000        	call	c_lglsh
 225  0072               L17:
 226                     ; 37 while (n-- > 0);
 228  0072 96            	ldw	x,sp
 229  0073 1c000b        	addw	x,#OFST+3
 230  0076 cd0000        	call	c_ltor
 232  0079 96            	ldw	x,sp
 233  007a 1c000b        	addw	x,#OFST+3
 234  007d a601          	ld	a,#1
 235  007f cd0000        	call	c_lgsbc
 237  0082 cd0000        	call	c_lrzmp
 239  0085 26eb          	jrne	L17
 240                     ; 38 }
 243  0087 5b08          	addw	sp,#8
 244  0089 81            	ret
 269                     ; 40 void setup(void)
 269                     ; 41 {
 270                     	switch	.text
 271  008a               _setup:
 275                     ; 42   clock_setup();
 277  008a ad03          	call	_clock_setup
 279                     ; 43   GPIO_setup();
 281  008c ad67          	call	_GPIO_setup
 283                     ; 44 }
 286  008e 81            	ret
 319                     ; 47 void clock_setup(void)
 319                     ; 48 {
 320                     	switch	.text
 321  008f               _clock_setup:
 325                     ; 49   CLK_DeInit();
 327  008f cd0000        	call	_CLK_DeInit
 329                     ; 51   CLK_HSECmd(ENABLE);
 331  0092 a601          	ld	a,#1
 332  0094 cd0000        	call	_CLK_HSECmd
 334                     ; 52   CLK_LSICmd(DISABLE);
 336  0097 4f            	clr	a
 337  0098 cd0000        	call	_CLK_LSICmd
 339                     ; 53   CLK_HSICmd(DISABLE);
 341  009b 4f            	clr	a
 342  009c cd0000        	call	_CLK_HSICmd
 345  009f               L711:
 346                     ; 54   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 348  009f ae0102        	ldw	x,#258
 349  00a2 cd0000        	call	_CLK_GetFlagStatus
 351  00a5 4d            	tnz	a
 352  00a6 27f7          	jreq	L711
 353                     ; 57 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 355  00a8 a680          	ld	a,#128
 356  00aa cd0000        	call	_CLK_SYSCLKConfig
 358                     ; 60 	CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);
 360  00ad 4f            	clr	a
 361  00ae cd0000        	call	_CLK_SYSCLKConfig
 363                     ; 63 	CLK_CCOConfig(CLK_OUTPUT_CPU);
 365  00b1 a608          	ld	a,#8
 366  00b3 cd0000        	call	_CLK_CCOConfig
 368                     ; 66 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSE, DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE);
 370  00b6 4b00          	push	#0
 371  00b8 4b00          	push	#0
 372  00ba ae01b4        	ldw	x,#436
 373  00bd cd0000        	call	_CLK_ClockSwitchConfig
 375  00c0 85            	popw	x
 376                     ; 68   CLK_ClockSwitchCmd(ENABLE);
 378  00c1 a601          	ld	a,#1
 379  00c3 cd0000        	call	_CLK_ClockSwitchCmd
 381                     ; 75   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 383  00c6 5f            	clrw	x
 384  00c7 cd0000        	call	_CLK_PeripheralClockConfig
 386                     ; 76   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 388  00ca ae0100        	ldw	x,#256
 389  00cd cd0000        	call	_CLK_PeripheralClockConfig
 391                     ; 77   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 393  00d0 ae0300        	ldw	x,#768
 394  00d3 cd0000        	call	_CLK_PeripheralClockConfig
 396                     ; 78   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 398  00d6 ae1200        	ldw	x,#4608
 399  00d9 cd0000        	call	_CLK_PeripheralClockConfig
 401                     ; 79   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 403  00dc ae1300        	ldw	x,#4864
 404  00df cd0000        	call	_CLK_PeripheralClockConfig
 406                     ; 80   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 408  00e2 ae0700        	ldw	x,#1792
 409  00e5 cd0000        	call	_CLK_PeripheralClockConfig
 411                     ; 81   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 413  00e8 ae0500        	ldw	x,#1280
 414  00eb cd0000        	call	_CLK_PeripheralClockConfig
 416                     ; 82   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 418  00ee ae0400        	ldw	x,#1024
 419  00f1 cd0000        	call	_CLK_PeripheralClockConfig
 421                     ; 87 }
 424  00f4 81            	ret
 449                     ; 88 void GPIO_setup(void)
 449                     ; 89 {                               
 450                     	switch	.text
 451  00f5               _GPIO_setup:
 455                     ; 90   GPIO_DeInit(LED_port);
 457  00f5 ae500f        	ldw	x,#20495
 458  00f8 cd0000        	call	_GPIO_DeInit
 460                     ; 91 	GPIO_Init(LED_port, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);
 462  00fb 4be0          	push	#224
 463  00fd 4b02          	push	#2
 464  00ff ae500f        	ldw	x,#20495
 465  0102 cd0000        	call	_GPIO_Init
 467  0105 85            	popw	x
 468                     ; 92 	GPIO_Init(LED_port, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST);
 470  0106 4be0          	push	#224
 471  0108 4b04          	push	#4
 472  010a ae500f        	ldw	x,#20495
 473  010d cd0000        	call	_GPIO_Init
 475  0110 85            	popw	x
 476                     ; 93 	GPIO_Init(LED_port, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 478  0111 4be0          	push	#224
 479  0113 4b08          	push	#8
 480  0115 ae500f        	ldw	x,#20495
 481  0118 cd0000        	call	_GPIO_Init
 483  011b 85            	popw	x
 484                     ; 94 	GPIO_Init(LED_port, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
 486  011c 4be0          	push	#224
 487  011e 4b10          	push	#16
 488  0120 ae500f        	ldw	x,#20495
 489  0123 cd0000        	call	_GPIO_Init
 491  0126 85            	popw	x
 492                     ; 95 	GPIO_Init(LED_port, GPIO_PIN_5, GPIO_MODE_OUT_PP_LOW_FAST);
 494  0127 4be0          	push	#224
 495  0129 4b20          	push	#32
 496  012b ae500f        	ldw	x,#20495
 497  012e cd0000        	call	_GPIO_Init
 499  0131 85            	popw	x
 500                     ; 96 	GPIO_Init(LED_port, GPIO_PIN_6, GPIO_MODE_OUT_PP_LOW_FAST);
 502  0132 4be0          	push	#224
 503  0134 4b40          	push	#64
 504  0136 ae500f        	ldw	x,#20495
 505  0139 cd0000        	call	_GPIO_Init
 507  013c 85            	popw	x
 508                     ; 97 	GPIO_Init(LED_port, GPIO_PIN_7, GPIO_MODE_OUT_PP_LOW_FAST);
 510  013d 4be0          	push	#224
 511  013f 4b80          	push	#128
 512  0141 ae500f        	ldw	x,#20495
 513  0144 cd0000        	call	_GPIO_Init
 515  0147 85            	popw	x
 516                     ; 98 }
 519  0148 81            	ret
 532                     	xdef	_main
 533                     	xdef	_delay_ms
 534                     	xdef	_GPIO_setup
 535                     	xdef	_clock_setup
 536                     	xdef	_setup
 537                     	xref	_GPIO_WriteReverse
 538                     	xref	_GPIO_Init
 539                     	xref	_GPIO_DeInit
 540                     	xref	_CLK_GetFlagStatus
 541                     	xref	_CLK_SYSCLKConfig
 542                     	xref	_CLK_CCOConfig
 543                     	xref	_CLK_ClockSwitchConfig
 544                     	xref	_CLK_PeripheralClockConfig
 545                     	xref	_CLK_ClockSwitchCmd
 546                     	xref	_CLK_LSICmd
 547                     	xref	_CLK_HSICmd
 548                     	xref	_CLK_HSECmd
 549                     	xref	_CLK_DeInit
 568                     	xref	c_lrzmp
 569                     	xref	c_lgsbc
 570                     	xref	c_ltor
 571                     	xref	c_lglsh
 572                     	end
