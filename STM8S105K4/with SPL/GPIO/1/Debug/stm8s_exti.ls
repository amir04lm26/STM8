   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  43                     ; 53 void EXTI_DeInit(void)
  43                     ; 54 {
  45                     	switch	.text
  46  0000               _EXTI_DeInit:
  50                     ; 55   EXTI->CR1 = EXTI_CR1_RESET_VALUE;
  52  0000 725f50a0      	clr	20640
  53                     ; 56   EXTI->CR2 = EXTI_CR2_RESET_VALUE;
  55  0004 725f50a1      	clr	20641
  56                     ; 57 }
  59  0008 81            	ret
 184                     ; 70 void EXTI_SetExtIntSensitivity(EXTI_Port_TypeDef Port, EXTI_Sensitivity_TypeDef SensitivityValue)
 184                     ; 71 {
 185                     	switch	.text
 186  0009               _EXTI_SetExtIntSensitivity:
 188  0009 89            	pushw	x
 189       00000000      OFST:	set	0
 192                     ; 73   assert_param(IS_EXTI_PORT_OK(Port));
 194                     ; 74   assert_param(IS_EXTI_SENSITIVITY_OK(SensitivityValue));
 196                     ; 77   switch (Port)
 198  000a 9e            	ld	a,xh
 200                     ; 99   default:
 200                     ; 100     break;
 201  000b 4d            	tnz	a
 202  000c 270e          	jreq	L12
 203  000e 4a            	dec	a
 204  000f 271d          	jreq	L32
 205  0011 4a            	dec	a
 206  0012 272e          	jreq	L52
 207  0014 4a            	dec	a
 208  0015 2742          	jreq	L72
 209  0017 4a            	dec	a
 210  0018 2756          	jreq	L13
 211  001a 2064          	jra	L311
 212  001c               L12:
 213                     ; 79   case EXTI_PORT_GPIOA:
 213                     ; 80     EXTI->CR1 &= (uint8_t)(~EXTI_CR1_PAIS);
 215  001c c650a0        	ld	a,20640
 216  001f a4fc          	and	a,#252
 217  0021 c750a0        	ld	20640,a
 218                     ; 81     EXTI->CR1 |= (uint8_t)(SensitivityValue);
 220  0024 c650a0        	ld	a,20640
 221  0027 1a02          	or	a,(OFST+2,sp)
 222  0029 c750a0        	ld	20640,a
 223                     ; 82     break;
 225  002c 2052          	jra	L311
 226  002e               L32:
 227                     ; 83   case EXTI_PORT_GPIOB:
 227                     ; 84     EXTI->CR1 &= (uint8_t)(~EXTI_CR1_PBIS);
 229  002e c650a0        	ld	a,20640
 230  0031 a4f3          	and	a,#243
 231  0033 c750a0        	ld	20640,a
 232                     ; 85     EXTI->CR1 |= (uint8_t)((uint8_t)(SensitivityValue) << 2);
 234  0036 7b02          	ld	a,(OFST+2,sp)
 235  0038 48            	sll	a
 236  0039 48            	sll	a
 237  003a ca50a0        	or	a,20640
 238  003d c750a0        	ld	20640,a
 239                     ; 86     break;
 241  0040 203e          	jra	L311
 242  0042               L52:
 243                     ; 87   case EXTI_PORT_GPIOC:
 243                     ; 88     EXTI->CR1 &= (uint8_t)(~EXTI_CR1_PCIS);
 245  0042 c650a0        	ld	a,20640
 246  0045 a4cf          	and	a,#207
 247  0047 c750a0        	ld	20640,a
 248                     ; 89     EXTI->CR1 |= (uint8_t)((uint8_t)(SensitivityValue) << 4);
 250  004a 7b02          	ld	a,(OFST+2,sp)
 251  004c 97            	ld	xl,a
 252  004d a610          	ld	a,#16
 253  004f 42            	mul	x,a
 254  0050 9f            	ld	a,xl
 255  0051 ca50a0        	or	a,20640
 256  0054 c750a0        	ld	20640,a
 257                     ; 90     break;
 259  0057 2027          	jra	L311
 260  0059               L72:
 261                     ; 91   case EXTI_PORT_GPIOD:
 261                     ; 92     EXTI->CR1 &= (uint8_t)(~EXTI_CR1_PDIS);
 263  0059 c650a0        	ld	a,20640
 264  005c a43f          	and	a,#63
 265  005e c750a0        	ld	20640,a
 266                     ; 93     EXTI->CR1 |= (uint8_t)((uint8_t)(SensitivityValue) << 6);
 268  0061 7b02          	ld	a,(OFST+2,sp)
 269  0063 97            	ld	xl,a
 270  0064 a640          	ld	a,#64
 271  0066 42            	mul	x,a
 272  0067 9f            	ld	a,xl
 273  0068 ca50a0        	or	a,20640
 274  006b c750a0        	ld	20640,a
 275                     ; 94     break;
 277  006e 2010          	jra	L311
 278  0070               L13:
 279                     ; 95   case EXTI_PORT_GPIOE:
 279                     ; 96     EXTI->CR2 &= (uint8_t)(~EXTI_CR2_PEIS);
 281  0070 c650a1        	ld	a,20641
 282  0073 a4fc          	and	a,#252
 283  0075 c750a1        	ld	20641,a
 284                     ; 97     EXTI->CR2 |= (uint8_t)(SensitivityValue);
 286  0078 c650a1        	ld	a,20641
 287  007b 1a02          	or	a,(OFST+2,sp)
 288  007d c750a1        	ld	20641,a
 289                     ; 98     break;
 291  0080               L33:
 292                     ; 99   default:
 292                     ; 100     break;
 294  0080               L311:
 295                     ; 102 }
 298  0080 85            	popw	x
 299  0081 81            	ret
 357                     ; 111 void EXTI_SetTLISensitivity(EXTI_TLISensitivity_TypeDef SensitivityValue)
 357                     ; 112 {
 358                     	switch	.text
 359  0082               _EXTI_SetTLISensitivity:
 363                     ; 114   assert_param(IS_EXTI_TLISENSITIVITY_OK(SensitivityValue));
 365                     ; 117   EXTI->CR2 &= (uint8_t)(~EXTI_CR2_TLIS);
 367  0082 721550a1      	bres	20641,#2
 368                     ; 118   EXTI->CR2 |= (uint8_t)(SensitivityValue);
 370  0086 ca50a1        	or	a,20641
 371  0089 c750a1        	ld	20641,a
 372                     ; 119 }
 375  008c 81            	ret
 421                     ; 126 EXTI_Sensitivity_TypeDef EXTI_GetExtIntSensitivity(EXTI_Port_TypeDef Port)
 421                     ; 127 {
 422                     	switch	.text
 423  008d               _EXTI_GetExtIntSensitivity:
 425  008d 88            	push	a
 426       00000001      OFST:	set	1
 429                     ; 128   uint8_t value = 0;
 431  008e 0f01          	clr	(OFST+0,sp)
 432                     ; 131   assert_param(IS_EXTI_PORT_OK(Port));
 434                     ; 133   switch (Port)
 437                     ; 150   default:
 437                     ; 151     break;
 438  0090 4d            	tnz	a
 439  0091 270e          	jreq	L341
 440  0093 4a            	dec	a
 441  0094 2714          	jreq	L541
 442  0096 4a            	dec	a
 443  0097 271c          	jreq	L741
 444  0099 4a            	dec	a
 445  009a 2725          	jreq	L151
 446  009c 4a            	dec	a
 447  009d 2730          	jreq	L351
 448  009f 2035          	jra	L302
 449  00a1               L341:
 450                     ; 135   case EXTI_PORT_GPIOA:
 450                     ; 136     value = (uint8_t)(EXTI->CR1 & EXTI_CR1_PAIS);
 452  00a1 c650a0        	ld	a,20640
 453  00a4 a403          	and	a,#3
 454  00a6 6b01          	ld	(OFST+0,sp),a
 455                     ; 137     break;
 457  00a8 202c          	jra	L302
 458  00aa               L541:
 459                     ; 138   case EXTI_PORT_GPIOB:
 459                     ; 139     value = (uint8_t)((uint8_t)(EXTI->CR1 & EXTI_CR1_PBIS) >> 2);
 461  00aa c650a0        	ld	a,20640
 462  00ad a40c          	and	a,#12
 463  00af 44            	srl	a
 464  00b0 44            	srl	a
 465  00b1 6b01          	ld	(OFST+0,sp),a
 466                     ; 140     break;
 468  00b3 2021          	jra	L302
 469  00b5               L741:
 470                     ; 141   case EXTI_PORT_GPIOC:
 470                     ; 142     value = (uint8_t)((uint8_t)(EXTI->CR1 & EXTI_CR1_PCIS) >> 4);
 472  00b5 c650a0        	ld	a,20640
 473  00b8 a430          	and	a,#48
 474  00ba 4e            	swap	a
 475  00bb a40f          	and	a,#15
 476  00bd 6b01          	ld	(OFST+0,sp),a
 477                     ; 143     break;
 479  00bf 2015          	jra	L302
 480  00c1               L151:
 481                     ; 144   case EXTI_PORT_GPIOD:
 481                     ; 145     value = (uint8_t)((uint8_t)(EXTI->CR1 & EXTI_CR1_PDIS) >> 6);
 483  00c1 c650a0        	ld	a,20640
 484  00c4 a4c0          	and	a,#192
 485  00c6 4e            	swap	a
 486  00c7 44            	srl	a
 487  00c8 44            	srl	a
 488  00c9 a403          	and	a,#3
 489  00cb 6b01          	ld	(OFST+0,sp),a
 490                     ; 146     break;
 492  00cd 2007          	jra	L302
 493  00cf               L351:
 494                     ; 147   case EXTI_PORT_GPIOE:
 494                     ; 148     value = (uint8_t)(EXTI->CR2 & EXTI_CR2_PEIS);
 496  00cf c650a1        	ld	a,20641
 497  00d2 a403          	and	a,#3
 498  00d4 6b01          	ld	(OFST+0,sp),a
 499                     ; 149     break;
 501  00d6               L551:
 502                     ; 150   default:
 502                     ; 151     break;
 504  00d6               L302:
 505                     ; 154   return((EXTI_Sensitivity_TypeDef)value);
 507  00d6 7b01          	ld	a,(OFST+0,sp)
 510  00d8 5b01          	addw	sp,#1
 511  00da 81            	ret
 547                     ; 162 EXTI_TLISensitivity_TypeDef EXTI_GetTLISensitivity(void)
 547                     ; 163 {
 548                     	switch	.text
 549  00db               _EXTI_GetTLISensitivity:
 551  00db 88            	push	a
 552       00000001      OFST:	set	1
 555                     ; 164   uint8_t value = 0;
 557                     ; 167   value = (uint8_t)(EXTI->CR2 & EXTI_CR2_TLIS);
 559  00dc c650a1        	ld	a,20641
 560  00df a404          	and	a,#4
 561  00e1 6b01          	ld	(OFST+0,sp),a
 562                     ; 169   return((EXTI_TLISensitivity_TypeDef)value);
 564  00e3 7b01          	ld	a,(OFST+0,sp)
 567  00e5 5b01          	addw	sp,#1
 568  00e7 81            	ret
 581                     	xdef	_EXTI_GetTLISensitivity
 582                     	xdef	_EXTI_GetExtIntSensitivity
 583                     	xdef	_EXTI_SetTLISensitivity
 584                     	xdef	_EXTI_SetExtIntSensitivity
 585                     	xdef	_EXTI_DeInit
 604                     	end
