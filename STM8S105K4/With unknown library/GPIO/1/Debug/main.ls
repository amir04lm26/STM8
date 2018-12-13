   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  55                     ; 5 main()   
  55                     ; 6 {            
  57                     	switch	.text
  58  0000               _main:
  60  0000 89            	pushw	x
  61       00000002      OFST:	set	2
  64                     ; 7 	unsigned int _time = 14;
  66  0001 ae000e        	ldw	x,#14
  67  0004 1f01          	ldw	(OFST-1,sp),x
  68                     ; 9 	GPIOD->DDR |= 0xff; // PD as Output
  70  0006 c65011        	ld	a,20497
  71  0009 aaff          	or	a,#255
  72  000b c75011        	ld	20497,a
  73                     ; 10 	GPIOD->CR1 |= 0xff; // PD as Push Pull Type Output
  75  000e c65012        	ld	a,20498
  76  0011 aaff          	or	a,#255
  77  0013 c75012        	ld	20498,a
  79  0016 2024          	jra	L13
  80  0018               L72:
  81                     ; 14 		GPIOD->ODR |= (0xff<<0);  // Key press num  
  83  0018 c6500f        	ld	a,20495
  84  001b aaff          	or	a,#255
  85  001d c7500f        	ld	20495,a
  86                     ; 15 		delay_ms(500); // wait 500 ms
  88  0020 ae01f4        	ldw	x,#500
  89  0023 89            	pushw	x
  90  0024 ae0000        	ldw	x,#0
  91  0027 89            	pushw	x
  92  0028 ad23          	call	_delay_ms
  94  002a 5b04          	addw	sp,#4
  95                     ; 16 		GPIOD->ODR &= !(0xff<<0);  // Key press num  
  97  002c 725f500f      	clr	20495
  98                     ; 17 		delay_ms(500); // wait 500 ms
 100  0030 ae01f4        	ldw	x,#500
 101  0033 89            	pushw	x
 102  0034 ae0000        	ldw	x,#0
 103  0037 89            	pushw	x
 104  0038 ad13          	call	_delay_ms
 106  003a 5b04          	addw	sp,#4
 107  003c               L13:
 108                     ; 12 	while(_time-- >0)
 110  003c 1e01          	ldw	x,(OFST-1,sp)
 111  003e 1d0001        	subw	x,#1
 112  0041 1f01          	ldw	(OFST-1,sp),x
 113  0043 1c0001        	addw	x,#1
 114  0046 a30000        	cpw	x,#0
 115  0049 26cd          	jrne	L72
 116  004b               L53:
 117                     ; 20 	while(1);
 119  004b 20fe          	jra	L53
 171                     ; 23 void delay_ms(unsigned long int n)
 171                     ; 24 {
 172                     	switch	.text
 173  004d               _delay_ms:
 175  004d 5208          	subw	sp,#8
 176       00000008      OFST:	set	8
 179                     ; 25 unsigned long int x=0;
 181                     ; 26 unsigned long fCPU=800000; // HSI RC =16 MHz ----- HSIDIV=8 ------CPUDIV=1 fCPU=16 / 8 / 1 Mhz
 183                     ; 27 x=fCPU/1000;
 185                     ; 28 x=x/50; 
 187                     ; 29 n=n*x;
 189  004f 96            	ldw	x,sp
 190  0050 1c000b        	addw	x,#OFST+3
 191  0053 a604          	ld	a,#4
 192  0055 cd0000        	call	c_lglsh
 195  0058               L17:
 196                     ; 30 while (n-- > 0);
 198  0058 96            	ldw	x,sp
 199  0059 1c000b        	addw	x,#OFST+3
 200  005c cd0000        	call	c_ltor
 202  005f 96            	ldw	x,sp
 203  0060 1c000b        	addw	x,#OFST+3
 204  0063 a601          	ld	a,#1
 205  0065 cd0000        	call	c_lgsbc
 207  0068 cd0000        	call	c_lrzmp
 209  006b 26eb          	jrne	L17
 210                     ; 31 }
 213  006d 5b08          	addw	sp,#8
 214  006f 81            	ret
 227                     	xdef	_main
 228                     	xdef	_delay_ms
 247                     	xref	c_lrzmp
 248                     	xref	c_lgsbc
 249                     	xref	c_ltor
 250                     	xref	c_lglsh
 251                     	end
