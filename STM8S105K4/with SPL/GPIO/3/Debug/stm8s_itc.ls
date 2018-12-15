   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  43                     ; 50 uint8_t ITC_GetCPUCC(void)
  43                     ; 51 {
  45                     	switch	.text
  46  0000               _ITC_GetCPUCC:
  50                     ; 53   _asm("push cc");
  53  0000 8a            push cc
  55                     ; 54   _asm("pop a");
  58  0001 84            pop a
  60                     ; 55   return; /* Ignore compiler warning, the returned value is in A register */
  63  0002 81            	ret
  86                     ; 80 void ITC_DeInit(void)
  86                     ; 81 {
  87                     	switch	.text
  88  0003               _ITC_DeInit:
  92                     ; 82   ITC->ISPR1 = ITC_SPRX_RESET_VALUE;
  94  0003 35ff7f70      	mov	32624,#255
  95                     ; 83   ITC->ISPR2 = ITC_SPRX_RESET_VALUE;
  97  0007 35ff7f71      	mov	32625,#255
  98                     ; 84   ITC->ISPR3 = ITC_SPRX_RESET_VALUE;
 100  000b 35ff7f72      	mov	32626,#255
 101                     ; 85   ITC->ISPR4 = ITC_SPRX_RESET_VALUE;
 103  000f 35ff7f73      	mov	32627,#255
 104                     ; 86   ITC->ISPR5 = ITC_SPRX_RESET_VALUE;
 106  0013 35ff7f74      	mov	32628,#255
 107                     ; 87   ITC->ISPR6 = ITC_SPRX_RESET_VALUE;
 109  0017 35ff7f75      	mov	32629,#255
 110                     ; 88   ITC->ISPR7 = ITC_SPRX_RESET_VALUE;
 112  001b 35ff7f76      	mov	32630,#255
 113                     ; 89   ITC->ISPR8 = ITC_SPRX_RESET_VALUE;
 115  001f 35ff7f77      	mov	32631,#255
 116                     ; 90 }
 119  0023 81            	ret
 144                     ; 97 uint8_t ITC_GetSoftIntStatus(void)
 144                     ; 98 {
 145                     	switch	.text
 146  0024               _ITC_GetSoftIntStatus:
 150                     ; 99   return (uint8_t)(ITC_GetCPUCC() & CPU_CC_I1I0);
 152  0024 adda          	call	_ITC_GetCPUCC
 154  0026 a428          	and	a,#40
 157  0028 81            	ret
 406                     .const:	section	.text
 407  0000               L22:
 408  0000 004c          	dc.w	L14
 409  0002 004c          	dc.w	L14
 410  0004 004c          	dc.w	L14
 411  0006 004c          	dc.w	L14
 412  0008 0055          	dc.w	L34
 413  000a 0055          	dc.w	L34
 414  000c 0055          	dc.w	L34
 415  000e 0055          	dc.w	L34
 416  0010 0089          	dc.w	L302
 417  0012 0089          	dc.w	L302
 418  0014 005e          	dc.w	L54
 419  0016 005e          	dc.w	L54
 420  0018 0067          	dc.w	L74
 421  001a 0067          	dc.w	L74
 422  001c 0067          	dc.w	L74
 423  001e 0067          	dc.w	L74
 424  0020 0070          	dc.w	L15
 425  0022 0089          	dc.w	L302
 426  0024 0089          	dc.w	L302
 427  0026 0070          	dc.w	L15
 428  0028 0079          	dc.w	L35
 429  002a 0079          	dc.w	L35
 430  002c 0079          	dc.w	L35
 431  002e 0079          	dc.w	L35
 432  0030 0082          	dc.w	L55
 433                     ; 107 ITC_PriorityLevel_TypeDef ITC_GetSoftwarePriority(ITC_Irq_TypeDef IrqNum)
 433                     ; 108 {
 434                     	switch	.text
 435  0029               _ITC_GetSoftwarePriority:
 437  0029 88            	push	a
 438  002a 89            	pushw	x
 439       00000002      OFST:	set	2
 442                     ; 109   uint8_t Value = 0;
 444  002b 0f02          	clr	(OFST+0,sp)
 445                     ; 110   uint8_t Mask = 0;
 447                     ; 113   assert_param(IS_ITC_IRQ_OK((uint8_t)IrqNum));
 449                     ; 116   Mask = (uint8_t)(0x03U << (((uint8_t)IrqNum % 4U) * 2U));
 451  002d a403          	and	a,#3
 452  002f 48            	sll	a
 453  0030 5f            	clrw	x
 454  0031 97            	ld	xl,a
 455  0032 a603          	ld	a,#3
 456  0034 5d            	tnzw	x
 457  0035 2704          	jreq	L41
 458  0037               L61:
 459  0037 48            	sll	a
 460  0038 5a            	decw	x
 461  0039 26fc          	jrne	L61
 462  003b               L41:
 463  003b 6b01          	ld	(OFST-1,sp),a
 464                     ; 118   switch (IrqNum)
 466  003d 7b03          	ld	a,(OFST+1,sp)
 468                     ; 198   default:
 468                     ; 199     break;
 469  003f a119          	cp	a,#25
 470  0041 2407          	jruge	L02
 471  0043 5f            	clrw	x
 472  0044 97            	ld	xl,a
 473  0045 58            	sllw	x
 474  0046 de0000        	ldw	x,(L22,x)
 475  0049 fc            	jp	(x)
 476  004a               L02:
 477  004a 203d          	jra	L302
 478  004c               L14:
 479                     ; 120   case ITC_IRQ_TLI: /* TLI software priority can be read but has no meaning */
 479                     ; 121   case ITC_IRQ_AWU:
 479                     ; 122   case ITC_IRQ_CLK:
 479                     ; 123   case ITC_IRQ_PORTA:
 479                     ; 124     Value = (uint8_t)(ITC->ISPR1 & Mask); /* Read software priority */
 481  004c c67f70        	ld	a,32624
 482  004f 1401          	and	a,(OFST-1,sp)
 483  0051 6b02          	ld	(OFST+0,sp),a
 484                     ; 125     break;
 486  0053 2034          	jra	L302
 487  0055               L34:
 488                     ; 127   case ITC_IRQ_PORTB:
 488                     ; 128   case ITC_IRQ_PORTC:
 488                     ; 129   case ITC_IRQ_PORTD:
 488                     ; 130   case ITC_IRQ_PORTE:
 488                     ; 131     Value = (uint8_t)(ITC->ISPR2 & Mask); /* Read software priority */
 490  0055 c67f71        	ld	a,32625
 491  0058 1401          	and	a,(OFST-1,sp)
 492  005a 6b02          	ld	(OFST+0,sp),a
 493                     ; 132     break;
 495  005c 202b          	jra	L302
 496  005e               L54:
 497                     ; 141   case ITC_IRQ_SPI:
 497                     ; 142   case ITC_IRQ_TIM1_OVF:
 497                     ; 143     Value = (uint8_t)(ITC->ISPR3 & Mask); /* Read software priority */
 499  005e c67f72        	ld	a,32626
 500  0061 1401          	and	a,(OFST-1,sp)
 501  0063 6b02          	ld	(OFST+0,sp),a
 502                     ; 144     break;
 504  0065 2022          	jra	L302
 505  0067               L74:
 506                     ; 146   case ITC_IRQ_TIM1_CAPCOM:
 506                     ; 147 #if defined (STM8S903) || defined (STM8AF622x)
 506                     ; 148   case ITC_IRQ_TIM5_OVFTRI:
 506                     ; 149   case ITC_IRQ_TIM5_CAPCOM:
 506                     ; 150 #else
 506                     ; 151   case ITC_IRQ_TIM2_OVF:
 506                     ; 152   case ITC_IRQ_TIM2_CAPCOM:
 506                     ; 153 #endif /* STM8S903 or STM8AF622x*/
 506                     ; 154   case ITC_IRQ_TIM3_OVF:
 506                     ; 155     Value = (uint8_t)(ITC->ISPR4 & Mask); /* Read software priority */
 508  0067 c67f73        	ld	a,32627
 509  006a 1401          	and	a,(OFST-1,sp)
 510  006c 6b02          	ld	(OFST+0,sp),a
 511                     ; 156     break;
 513  006e 2019          	jra	L302
 514  0070               L15:
 515                     ; 158   case ITC_IRQ_TIM3_CAPCOM:
 515                     ; 159 #if defined(STM8S208) ||defined(STM8S207) || defined (STM8S007) || defined(STM8S103) || \
 515                     ; 160     defined(STM8S003) ||defined(STM8S001) || defined (STM8S903) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
 515                     ; 161   case ITC_IRQ_UART1_TX:
 515                     ; 162   case ITC_IRQ_UART1_RX:
 515                     ; 163 #endif /*STM8S208 or STM8S207 or STM8S007 or STM8S103 or STM8S003 or STM8S001 or STM8S903 or STM8AF52Ax or STM8AF62Ax */ 
 515                     ; 164 #if defined(STM8AF622x)
 515                     ; 165   case ITC_IRQ_UART4_TX:
 515                     ; 166   case ITC_IRQ_UART4_RX:
 515                     ; 167 #endif /*STM8AF622x */
 515                     ; 168   case ITC_IRQ_I2C:
 515                     ; 169     Value = (uint8_t)(ITC->ISPR5 & Mask); /* Read software priority */
 517  0070 c67f74        	ld	a,32628
 518  0073 1401          	and	a,(OFST-1,sp)
 519  0075 6b02          	ld	(OFST+0,sp),a
 520                     ; 170     break;
 522  0077 2010          	jra	L302
 523  0079               L35:
 524                     ; 173   case ITC_IRQ_UART2_TX:
 524                     ; 174   case ITC_IRQ_UART2_RX:
 524                     ; 175 #endif /*STM8S105 or STM8AF626x*/
 524                     ; 176 #if defined(STM8S208) || defined(STM8S207) || defined(STM8S007) || defined(STM8AF52Ax) || \
 524                     ; 177     defined(STM8AF62Ax)
 524                     ; 178   case ITC_IRQ_UART3_TX:
 524                     ; 179   case ITC_IRQ_UART3_RX:
 524                     ; 180   case ITC_IRQ_ADC2:
 524                     ; 181 #endif /*STM8S208 or STM8S207 or STM8AF52Ax or STM8AF62Ax */
 524                     ; 182 #if defined(STM8S105) || defined(STM8S005) || defined(STM8S103) || defined(STM8S003) || \
 524                     ; 183     defined(STM8S001) || defined(STM8S903) || defined(STM8AF626x) || defined(STM8AF622x)
 524                     ; 184   case ITC_IRQ_ADC1:
 524                     ; 185 #endif /*STM8S105, STM8S005, STM8S103 or STM8S003 or STM8S001 or STM8S903 or STM8AF626x or STM8AF622x */
 524                     ; 186 #if defined (STM8S903) || defined (STM8AF622x)
 524                     ; 187   case ITC_IRQ_TIM6_OVFTRI:
 524                     ; 188 #else
 524                     ; 189   case ITC_IRQ_TIM4_OVF:
 524                     ; 190 #endif /*STM8S903 or STM8AF622x */
 524                     ; 191     Value = (uint8_t)(ITC->ISPR6 & Mask); /* Read software priority */
 526  0079 c67f75        	ld	a,32629
 527  007c 1401          	and	a,(OFST-1,sp)
 528  007e 6b02          	ld	(OFST+0,sp),a
 529                     ; 192     break;
 531  0080 2007          	jra	L302
 532  0082               L55:
 533                     ; 194   case ITC_IRQ_EEPROM_EEC:
 533                     ; 195     Value = (uint8_t)(ITC->ISPR7 & Mask); /* Read software priority */
 535  0082 c67f76        	ld	a,32630
 536  0085 1401          	and	a,(OFST-1,sp)
 537  0087 6b02          	ld	(OFST+0,sp),a
 538                     ; 196     break;
 540  0089               L75:
 541                     ; 198   default:
 541                     ; 199     break;
 543  0089               L302:
 544                     ; 202   Value >>= (uint8_t)(((uint8_t)IrqNum % 4u) * 2u);
 546  0089 7b03          	ld	a,(OFST+1,sp)
 547  008b a403          	and	a,#3
 548  008d 48            	sll	a
 549  008e 5f            	clrw	x
 550  008f 97            	ld	xl,a
 551  0090 7b02          	ld	a,(OFST+0,sp)
 552  0092 5d            	tnzw	x
 553  0093 2704          	jreq	L42
 554  0095               L62:
 555  0095 44            	srl	a
 556  0096 5a            	decw	x
 557  0097 26fc          	jrne	L62
 558  0099               L42:
 559  0099 6b02          	ld	(OFST+0,sp),a
 560                     ; 204   return((ITC_PriorityLevel_TypeDef)Value);
 562  009b 7b02          	ld	a,(OFST+0,sp)
 565  009d 5b03          	addw	sp,#3
 566  009f 81            	ret
 630                     	switch	.const
 631  0032               L44:
 632  0032 00d5          	dc.w	L502
 633  0034 00d5          	dc.w	L502
 634  0036 00d5          	dc.w	L502
 635  0038 00d5          	dc.w	L502
 636  003a 00e7          	dc.w	L702
 637  003c 00e7          	dc.w	L702
 638  003e 00e7          	dc.w	L702
 639  0040 00e7          	dc.w	L702
 640  0042 0151          	dc.w	L162
 641  0044 0151          	dc.w	L162
 642  0046 00f9          	dc.w	L112
 643  0048 00f9          	dc.w	L112
 644  004a 010b          	dc.w	L312
 645  004c 010b          	dc.w	L312
 646  004e 010b          	dc.w	L312
 647  0050 010b          	dc.w	L312
 648  0052 011d          	dc.w	L512
 649  0054 0151          	dc.w	L162
 650  0056 0151          	dc.w	L162
 651  0058 011d          	dc.w	L512
 652  005a 012f          	dc.w	L712
 653  005c 012f          	dc.w	L712
 654  005e 012f          	dc.w	L712
 655  0060 012f          	dc.w	L712
 656  0062 0141          	dc.w	L122
 657                     ; 220 void ITC_SetSoftwarePriority(ITC_Irq_TypeDef IrqNum, ITC_PriorityLevel_TypeDef PriorityValue)
 657                     ; 221 {
 658                     	switch	.text
 659  00a0               _ITC_SetSoftwarePriority:
 661  00a0 89            	pushw	x
 662  00a1 89            	pushw	x
 663       00000002      OFST:	set	2
 666                     ; 222   uint8_t Mask = 0;
 668                     ; 223   uint8_t NewPriority = 0;
 670                     ; 226   assert_param(IS_ITC_IRQ_OK((uint8_t)IrqNum));
 672                     ; 227   assert_param(IS_ITC_PRIORITY_OK(PriorityValue));
 674                     ; 230   assert_param(IS_ITC_INTERRUPTS_DISABLED);
 676                     ; 234   Mask = (uint8_t)(~(uint8_t)(0x03U << (((uint8_t)IrqNum % 4U) * 2U)));
 678  00a2 9e            	ld	a,xh
 679  00a3 a403          	and	a,#3
 680  00a5 48            	sll	a
 681  00a6 5f            	clrw	x
 682  00a7 97            	ld	xl,a
 683  00a8 a603          	ld	a,#3
 684  00aa 5d            	tnzw	x
 685  00ab 2704          	jreq	L23
 686  00ad               L43:
 687  00ad 48            	sll	a
 688  00ae 5a            	decw	x
 689  00af 26fc          	jrne	L43
 690  00b1               L23:
 691  00b1 43            	cpl	a
 692  00b2 6b01          	ld	(OFST-1,sp),a
 693                     ; 237   NewPriority = (uint8_t)((uint8_t)(PriorityValue) << (((uint8_t)IrqNum % 4U) * 2U));
 695  00b4 7b03          	ld	a,(OFST+1,sp)
 696  00b6 a403          	and	a,#3
 697  00b8 48            	sll	a
 698  00b9 5f            	clrw	x
 699  00ba 97            	ld	xl,a
 700  00bb 7b04          	ld	a,(OFST+2,sp)
 701  00bd 5d            	tnzw	x
 702  00be 2704          	jreq	L63
 703  00c0               L04:
 704  00c0 48            	sll	a
 705  00c1 5a            	decw	x
 706  00c2 26fc          	jrne	L04
 707  00c4               L63:
 708  00c4 6b02          	ld	(OFST+0,sp),a
 709                     ; 239   switch (IrqNum)
 711  00c6 7b03          	ld	a,(OFST+1,sp)
 713                     ; 329   default:
 713                     ; 330     break;
 714  00c8 a119          	cp	a,#25
 715  00ca 2407          	jruge	L24
 716  00cc 5f            	clrw	x
 717  00cd 97            	ld	xl,a
 718  00ce 58            	sllw	x
 719  00cf de0032        	ldw	x,(L44,x)
 720  00d2 fc            	jp	(x)
 721  00d3               L24:
 722  00d3 207c          	jra	L162
 723  00d5               L502:
 724                     ; 241   case ITC_IRQ_TLI: /* TLI software priority can be written but has no meaning */
 724                     ; 242   case ITC_IRQ_AWU:
 724                     ; 243   case ITC_IRQ_CLK:
 724                     ; 244   case ITC_IRQ_PORTA:
 724                     ; 245     ITC->ISPR1 &= Mask;
 726  00d5 c67f70        	ld	a,32624
 727  00d8 1401          	and	a,(OFST-1,sp)
 728  00da c77f70        	ld	32624,a
 729                     ; 246     ITC->ISPR1 |= NewPriority;
 731  00dd c67f70        	ld	a,32624
 732  00e0 1a02          	or	a,(OFST+0,sp)
 733  00e2 c77f70        	ld	32624,a
 734                     ; 247     break;
 736  00e5 206a          	jra	L162
 737  00e7               L702:
 738                     ; 249   case ITC_IRQ_PORTB:
 738                     ; 250   case ITC_IRQ_PORTC:
 738                     ; 251   case ITC_IRQ_PORTD:
 738                     ; 252   case ITC_IRQ_PORTE:
 738                     ; 253     ITC->ISPR2 &= Mask;
 740  00e7 c67f71        	ld	a,32625
 741  00ea 1401          	and	a,(OFST-1,sp)
 742  00ec c77f71        	ld	32625,a
 743                     ; 254     ITC->ISPR2 |= NewPriority;
 745  00ef c67f71        	ld	a,32625
 746  00f2 1a02          	or	a,(OFST+0,sp)
 747  00f4 c77f71        	ld	32625,a
 748                     ; 255     break;
 750  00f7 2058          	jra	L162
 751  00f9               L112:
 752                     ; 264   case ITC_IRQ_SPI:
 752                     ; 265   case ITC_IRQ_TIM1_OVF:
 752                     ; 266     ITC->ISPR3 &= Mask;
 754  00f9 c67f72        	ld	a,32626
 755  00fc 1401          	and	a,(OFST-1,sp)
 756  00fe c77f72        	ld	32626,a
 757                     ; 267     ITC->ISPR3 |= NewPriority;
 759  0101 c67f72        	ld	a,32626
 760  0104 1a02          	or	a,(OFST+0,sp)
 761  0106 c77f72        	ld	32626,a
 762                     ; 268     break;
 764  0109 2046          	jra	L162
 765  010b               L312:
 766                     ; 270   case ITC_IRQ_TIM1_CAPCOM:
 766                     ; 271 #if defined(STM8S903) || defined(STM8AF622x) 
 766                     ; 272   case ITC_IRQ_TIM5_OVFTRI:
 766                     ; 273   case ITC_IRQ_TIM5_CAPCOM:
 766                     ; 274 #else
 766                     ; 275   case ITC_IRQ_TIM2_OVF:
 766                     ; 276   case ITC_IRQ_TIM2_CAPCOM:
 766                     ; 277 #endif /*STM8S903 or STM8AF622x */
 766                     ; 278   case ITC_IRQ_TIM3_OVF:
 766                     ; 279     ITC->ISPR4 &= Mask;
 768  010b c67f73        	ld	a,32627
 769  010e 1401          	and	a,(OFST-1,sp)
 770  0110 c77f73        	ld	32627,a
 771                     ; 280     ITC->ISPR4 |= NewPriority;
 773  0113 c67f73        	ld	a,32627
 774  0116 1a02          	or	a,(OFST+0,sp)
 775  0118 c77f73        	ld	32627,a
 776                     ; 281     break;
 778  011b 2034          	jra	L162
 779  011d               L512:
 780                     ; 283   case ITC_IRQ_TIM3_CAPCOM:
 780                     ; 284 #if defined(STM8S208) ||defined(STM8S207) || defined (STM8S007) || defined(STM8S103) || \
 780                     ; 285     defined(STM8S001) ||defined(STM8S003) ||defined(STM8S903) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
 780                     ; 286   case ITC_IRQ_UART1_TX:
 780                     ; 287   case ITC_IRQ_UART1_RX:
 780                     ; 288 #endif /*STM8S208 or STM8S207 or STM8S007 or STM8S103 or STM8S003 or STM8S001 or STM8S903 or STM8AF52Ax or STM8AF62Ax */ 
 780                     ; 289 #if defined(STM8AF622x)
 780                     ; 290   case ITC_IRQ_UART4_TX:
 780                     ; 291   case ITC_IRQ_UART4_RX:
 780                     ; 292 #endif /*STM8AF622x */
 780                     ; 293   case ITC_IRQ_I2C:
 780                     ; 294     ITC->ISPR5 &= Mask;
 782  011d c67f74        	ld	a,32628
 783  0120 1401          	and	a,(OFST-1,sp)
 784  0122 c77f74        	ld	32628,a
 785                     ; 295     ITC->ISPR5 |= NewPriority;
 787  0125 c67f74        	ld	a,32628
 788  0128 1a02          	or	a,(OFST+0,sp)
 789  012a c77f74        	ld	32628,a
 790                     ; 296     break;
 792  012d 2022          	jra	L162
 793  012f               L712:
 794                     ; 299   case ITC_IRQ_UART2_TX:
 794                     ; 300   case ITC_IRQ_UART2_RX:
 794                     ; 301 #endif /*STM8S105 or STM8AF626x */
 794                     ; 302     
 794                     ; 303 #if defined(STM8S208) || defined(STM8S207) || defined(STM8S007) || defined(STM8AF52Ax) || \
 794                     ; 304     defined(STM8AF62Ax)
 794                     ; 305   case ITC_IRQ_UART3_TX:
 794                     ; 306   case ITC_IRQ_UART3_RX:
 794                     ; 307   case ITC_IRQ_ADC2:
 794                     ; 308 #endif /*STM8S208 or STM8S207 or STM8AF52Ax or STM8AF62Ax */
 794                     ; 309     
 794                     ; 310 #if defined(STM8S105) || defined(STM8S005) || defined(STM8S103) || defined(STM8S003) || \
 794                     ; 311     defined(STM8S001) || defined(STM8S903) || defined(STM8AF626x) || defined (STM8AF622x)
 794                     ; 312   case ITC_IRQ_ADC1:
 794                     ; 313 #endif /*STM8S105, STM8S005, STM8S103 or STM8S003 or STM8S001 or STM8S903 or STM8AF626x or STM8AF622x */
 794                     ; 314     
 794                     ; 315 #if defined (STM8S903) || defined (STM8AF622x)
 794                     ; 316   case ITC_IRQ_TIM6_OVFTRI:
 794                     ; 317 #else
 794                     ; 318   case ITC_IRQ_TIM4_OVF:
 794                     ; 319 #endif /* STM8S903 or STM8AF622x */
 794                     ; 320     ITC->ISPR6 &= Mask;
 796  012f c67f75        	ld	a,32629
 797  0132 1401          	and	a,(OFST-1,sp)
 798  0134 c77f75        	ld	32629,a
 799                     ; 321     ITC->ISPR6 |= NewPriority;
 801  0137 c67f75        	ld	a,32629
 802  013a 1a02          	or	a,(OFST+0,sp)
 803  013c c77f75        	ld	32629,a
 804                     ; 322     break;
 806  013f 2010          	jra	L162
 807  0141               L122:
 808                     ; 324   case ITC_IRQ_EEPROM_EEC:
 808                     ; 325     ITC->ISPR7 &= Mask;
 810  0141 c67f76        	ld	a,32630
 811  0144 1401          	and	a,(OFST-1,sp)
 812  0146 c77f76        	ld	32630,a
 813                     ; 326     ITC->ISPR7 |= NewPriority;
 815  0149 c67f76        	ld	a,32630
 816  014c 1a02          	or	a,(OFST+0,sp)
 817  014e c77f76        	ld	32630,a
 818                     ; 327     break;
 820  0151               L322:
 821                     ; 329   default:
 821                     ; 330     break;
 823  0151               L162:
 824                     ; 332 }
 827  0151 5b04          	addw	sp,#4
 828  0153 81            	ret
 841                     	xdef	_ITC_GetSoftwarePriority
 842                     	xdef	_ITC_SetSoftwarePriority
 843                     	xdef	_ITC_GetSoftIntStatus
 844                     	xdef	_ITC_DeInit
 845                     	xdef	_ITC_GetCPUCC
 864                     	end
