   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  15                     	bsct
  16  0000               L3__time:
  17  0000 0005          	dc.w	5
  70                     ; 11 main()
  70                     ; 12 {
  72                     	switch	.text
  73  0000               _main:
  75  0000 89            	pushw	x
  76       00000002      OFST:	set	2
  79                     ; 14 	setup();
  81  0001 ad7e          	call	_setup
  83  0003               L53:
  84                     ; 18 		unsigned int __time = _time; //Repaet blink times
  86  0003 be00          	ldw	x,L3__time
  87  0005 1f01          	ldw	(OFST-1,sp),x
  88                     ; 19 		if(!(GPIO_ReadInputPin(KEY_port, GPIO_PIN_0)))
  90  0007 4b01          	push	#1
  91  0009 ae5005        	ldw	x,#20485
  92  000c cd0000        	call	_GPIO_ReadInputPin
  94  000f 5b01          	addw	sp,#1
  95  0011 4d            	tnz	a
  96  0012 26ef          	jrne	L53
  98  0014               L54:
  99                     ; 21 			while(!(GPIO_ReadInputPin(KEY_port, GPIO_PIN_0))); //Wait for debounce
 101  0014 4b01          	push	#1
 102  0016 ae5005        	ldw	x,#20485
 103  0019 cd0000        	call	_GPIO_ReadInputPin
 105  001c 5b01          	addw	sp,#1
 106  001e 4d            	tnz	a
 107  001f 27f3          	jreq	L54
 109  0021 202a          	jra	L35
 110  0023               L15:
 111                     ; 24 				GPIO_Write(LED_port, 0xff); //All LED on  
 113  0023 4bff          	push	#255
 114  0025 ae500f        	ldw	x,#20495
 115  0028 cd0000        	call	_GPIO_Write
 117  002b 84            	pop	a
 118                     ; 25 				delay_ms(500); //wait 500ms						           
 120  002c ae01f4        	ldw	x,#500
 121  002f 89            	pushw	x
 122  0030 ae0000        	ldw	x,#0
 123  0033 89            	pushw	x
 124  0034 ad28          	call	_delay_ms
 126  0036 5b04          	addw	sp,#4
 127                     ; 26 				GPIO_Write(LED_port, 0x00); //All LED off
 129  0038 4b00          	push	#0
 130  003a ae500f        	ldw	x,#20495
 131  003d cd0000        	call	_GPIO_Write
 133  0040 84            	pop	a
 134                     ; 27 				delay_ms(500); // wait 500ms
 136  0041 ae01f4        	ldw	x,#500
 137  0044 89            	pushw	x
 138  0045 ae0000        	ldw	x,#0
 139  0048 89            	pushw	x
 140  0049 ad13          	call	_delay_ms
 142  004b 5b04          	addw	sp,#4
 143  004d               L35:
 144                     ; 22 			while(__time-->0)
 146  004d 1e01          	ldw	x,(OFST-1,sp)
 147  004f 1d0001        	subw	x,#1
 148  0052 1f01          	ldw	(OFST-1,sp),x
 149  0054 1c0001        	addw	x,#1
 150  0057 a30000        	cpw	x,#0
 151  005a 26c7          	jrne	L15
 152  005c 20a5          	jra	L53
 204                     ; 33 void delay_ms(unsigned long int n)
 204                     ; 34 {
 205                     	switch	.text
 206  005e               _delay_ms:
 208  005e 5208          	subw	sp,#8
 209       00000008      OFST:	set	8
 212                     ; 35 unsigned long int x=0;
 214                     ; 36 unsigned long fCPU=16000000; // HSI RC =16 MHz ----- HSIDIV=8 ------CPUDIV=1 fCPU=16 / 8 / 1 Mhz
 216                     ; 37 x=fCPU/5000;
 218                     ; 38 x=x/50; 
 220                     ; 39 n=n*x;
 222  0060 96            	ldw	x,sp
 223  0061 1c000b        	addw	x,#OFST+3
 224  0064 a606          	ld	a,#6
 225  0066 cd0000        	call	c_lglsh
 228  0069               L701:
 229                     ; 40 while (n-- > 0);
 231  0069 96            	ldw	x,sp
 232  006a 1c000b        	addw	x,#OFST+3
 233  006d cd0000        	call	c_ltor
 235  0070 96            	ldw	x,sp
 236  0071 1c000b        	addw	x,#OFST+3
 237  0074 a601          	ld	a,#1
 238  0076 cd0000        	call	c_lgsbc
 240  0079 cd0000        	call	c_lrzmp
 242  007c 26eb          	jrne	L701
 243                     ; 41 }
 246  007e 5b08          	addw	sp,#8
 247  0080 81            	ret
 272                     ; 43 void setup(void)
 272                     ; 44 {
 273                     	switch	.text
 274  0081               _setup:
 278                     ; 45   clock_setup();
 280  0081 ad03          	call	_clock_setup
 282                     ; 46   GPIO_setup();
 284  0083 ad67          	call	_GPIO_setup
 286                     ; 47 }
 289  0085 81            	ret
 322                     ; 50 void clock_setup(void)
 322                     ; 51 {
 323                     	switch	.text
 324  0086               _clock_setup:
 328                     ; 52   CLK_DeInit();
 330  0086 cd0000        	call	_CLK_DeInit
 332                     ; 54   CLK_HSECmd(ENABLE);
 334  0089 a601          	ld	a,#1
 335  008b cd0000        	call	_CLK_HSECmd
 337                     ; 55   CLK_LSICmd(DISABLE);
 339  008e 4f            	clr	a
 340  008f cd0000        	call	_CLK_LSICmd
 342                     ; 56   CLK_HSICmd(DISABLE);
 344  0092 4f            	clr	a
 345  0093 cd0000        	call	_CLK_HSICmd
 348  0096               L531:
 349                     ; 57   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 351  0096 ae0102        	ldw	x,#258
 352  0099 cd0000        	call	_CLK_GetFlagStatus
 354  009c 4d            	tnz	a
 355  009d 27f7          	jreq	L531
 356                     ; 60 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 358  009f a680          	ld	a,#128
 359  00a1 cd0000        	call	_CLK_SYSCLKConfig
 361                     ; 63 	CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);
 363  00a4 4f            	clr	a
 364  00a5 cd0000        	call	_CLK_SYSCLKConfig
 366                     ; 66 	CLK_CCOConfig(CLK_OUTPUT_CPU);
 368  00a8 a608          	ld	a,#8
 369  00aa cd0000        	call	_CLK_CCOConfig
 371                     ; 69 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSE, DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE);
 373  00ad 4b00          	push	#0
 374  00af 4b00          	push	#0
 375  00b1 ae01b4        	ldw	x,#436
 376  00b4 cd0000        	call	_CLK_ClockSwitchConfig
 378  00b7 85            	popw	x
 379                     ; 71   CLK_ClockSwitchCmd(ENABLE);
 381  00b8 a601          	ld	a,#1
 382  00ba cd0000        	call	_CLK_ClockSwitchCmd
 384                     ; 78   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 386  00bd 5f            	clrw	x
 387  00be cd0000        	call	_CLK_PeripheralClockConfig
 389                     ; 79   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 391  00c1 ae0100        	ldw	x,#256
 392  00c4 cd0000        	call	_CLK_PeripheralClockConfig
 394                     ; 80   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 396  00c7 ae0300        	ldw	x,#768
 397  00ca cd0000        	call	_CLK_PeripheralClockConfig
 399                     ; 81   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 401  00cd ae1200        	ldw	x,#4608
 402  00d0 cd0000        	call	_CLK_PeripheralClockConfig
 404                     ; 82   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 406  00d3 ae1300        	ldw	x,#4864
 407  00d6 cd0000        	call	_CLK_PeripheralClockConfig
 409                     ; 83   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 411  00d9 ae0700        	ldw	x,#1792
 412  00dc cd0000        	call	_CLK_PeripheralClockConfig
 414                     ; 84   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 416  00df ae0500        	ldw	x,#1280
 417  00e2 cd0000        	call	_CLK_PeripheralClockConfig
 419                     ; 85   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 421  00e5 ae0400        	ldw	x,#1024
 422  00e8 cd0000        	call	_CLK_PeripheralClockConfig
 424                     ; 90 }
 427  00eb 81            	ret
 452                     ; 91 void GPIO_setup(void)
 452                     ; 92 {                               
 453                     	switch	.text
 454  00ec               _GPIO_setup:
 458                     ; 93   GPIO_DeInit(LED_port);
 460  00ec ae500f        	ldw	x,#20495
 461  00ef cd0000        	call	_GPIO_DeInit
 463                     ; 94 	GPIO_Init(LED_port, GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7, 	GPIO_MODE_OUT_PP_LOW_FAST);
 465  00f2 4be0          	push	#224
 466  00f4 4bff          	push	#255
 467  00f6 ae500f        	ldw	x,#20495
 468  00f9 cd0000        	call	_GPIO_Init
 470  00fc 85            	popw	x
 471                     ; 95 	GPIO_Init(KEY_port, GPIO_PIN_0, GPIO_MODE_IN_PU_NO_IT);
 473  00fd 4b40          	push	#64
 474  00ff 4b01          	push	#1
 475  0101 ae5005        	ldw	x,#20485
 476  0104 cd0000        	call	_GPIO_Init
 478  0107 85            	popw	x
 479                     ; 96 }
 482  0108 81            	ret
 495                     	xdef	_main
 496                     	xdef	_delay_ms
 497                     	xdef	_GPIO_setup
 498                     	xdef	_clock_setup
 499                     	xdef	_setup
 500                     	xref	_GPIO_ReadInputPin
 501                     	xref	_GPIO_Write
 502                     	xref	_GPIO_Init
 503                     	xref	_GPIO_DeInit
 504                     	xref	_CLK_GetFlagStatus
 505                     	xref	_CLK_SYSCLKConfig
 506                     	xref	_CLK_CCOConfig
 507                     	xref	_CLK_ClockSwitchConfig
 508                     	xref	_CLK_PeripheralClockConfig
 509                     	xref	_CLK_ClockSwitchCmd
 510                     	xref	_CLK_LSICmd
 511                     	xref	_CLK_HSICmd
 512                     	xref	_CLK_HSECmd
 513                     	xref	_CLK_DeInit
 532                     	xref	c_lrzmp
 533                     	xref	c_lgsbc
 534                     	xref	c_ltor
 535                     	xref	c_lglsh
 536                     	end
