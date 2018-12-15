   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  72                     ; 2 void delay_ms(unsigned long int n)
  72                     ; 3 {
  74                     	switch	.text
  75  0000               _delay_ms:
  77  0000 5208          	subw	sp,#8
  78       00000008      OFST:	set	8
  81                     ; 4 unsigned long int x=0;
  83                     ; 5 unsigned long fCPU=16000000; // HSI RC =16 MHz ----- HSIDIV=8 ------CPUDIV=1 fCPU=16 / 8 / 1 Mhz
  85                     ; 6 x=fCPU/5000;
  87                     ; 7 x=x/50; 
  89                     ; 8 n=n*x;
  91  0002 96            	ldw	x,sp
  92  0003 1c000b        	addw	x,#OFST+3
  93  0006 a606          	ld	a,#6
  94  0008 cd0000        	call	c_lglsh
  97  000b               L14:
  98                     ; 9 while (n-- > 0);
 100  000b 96            	ldw	x,sp
 101  000c 1c000b        	addw	x,#OFST+3
 102  000f cd0000        	call	c_ltor
 104  0012 96            	ldw	x,sp
 105  0013 1c000b        	addw	x,#OFST+3
 106  0016 a601          	ld	a,#1
 107  0018 cd0000        	call	c_lgsbc
 109  001b cd0000        	call	c_lrzmp
 111  001e 26eb          	jrne	L14
 112                     ; 10 }
 115  0020 5b08          	addw	sp,#8
 116  0022 81            	ret
 129                     	xdef	_delay_ms
 148                     	xref	c_lrzmp
 149                     	xref	c_lgsbc
 150                     	xref	c_ltor
 151                     	xref	c_lglsh
 152                     	end
