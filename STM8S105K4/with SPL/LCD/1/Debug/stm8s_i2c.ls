   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  43                     ; 67 void I2C_DeInit(void)
  43                     ; 68 {
  45                     	switch	.text
  46  0000               _I2C_DeInit:
  50                     ; 69   I2C->CR1 = I2C_CR1_RESET_VALUE;
  52  0000 725f5210      	clr	21008
  53                     ; 70   I2C->CR2 = I2C_CR2_RESET_VALUE;
  55  0004 725f5211      	clr	21009
  56                     ; 71   I2C->FREQR = I2C_FREQR_RESET_VALUE;
  58  0008 725f5212      	clr	21010
  59                     ; 72   I2C->OARL = I2C_OARL_RESET_VALUE;
  61  000c 725f5213      	clr	21011
  62                     ; 73   I2C->OARH = I2C_OARH_RESET_VALUE;
  64  0010 725f5214      	clr	21012
  65                     ; 74   I2C->ITR = I2C_ITR_RESET_VALUE;
  67  0014 725f521a      	clr	21018
  68                     ; 75   I2C->CCRL = I2C_CCRL_RESET_VALUE;
  70  0018 725f521b      	clr	21019
  71                     ; 76   I2C->CCRH = I2C_CCRH_RESET_VALUE;
  73  001c 725f521c      	clr	21020
  74                     ; 77   I2C->TRISER = I2C_TRISER_RESET_VALUE;
  76  0020 3502521d      	mov	21021,#2
  77                     ; 78 }
  80  0024 81            	ret
 259                     .const:	section	.text
 260  0000               L01:
 261  0000 000186a1      	dc.l	100001
 262  0004               L21:
 263  0004 000f4240      	dc.l	1000000
 264                     ; 96 void I2C_Init(uint32_t OutputClockFrequencyHz, uint16_t OwnAddress, 
 264                     ; 97               I2C_DutyCycle_TypeDef I2C_DutyCycle, I2C_Ack_TypeDef Ack, 
 264                     ; 98               I2C_AddMode_TypeDef AddMode, uint8_t InputClockFrequencyMHz )
 264                     ; 99 {
 265                     	switch	.text
 266  0025               _I2C_Init:
 268  0025 5209          	subw	sp,#9
 269       00000009      OFST:	set	9
 272                     ; 100   uint16_t result = 0x0004;
 274                     ; 101   uint16_t tmpval = 0;
 276                     ; 102   uint8_t tmpccrh = 0;
 278  0027 0f07          	clr	(OFST-2,sp)
 279                     ; 105   assert_param(IS_I2C_ACK_OK(Ack));
 281                     ; 106   assert_param(IS_I2C_ADDMODE_OK(AddMode));
 283                     ; 107   assert_param(IS_I2C_OWN_ADDRESS_OK(OwnAddress));
 285                     ; 108   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));  
 287                     ; 109   assert_param(IS_I2C_INPUT_CLOCK_FREQ_OK(InputClockFrequencyMHz));
 289                     ; 110   assert_param(IS_I2C_OUTPUT_CLOCK_FREQ_OK(OutputClockFrequencyHz));
 291                     ; 115   I2C->FREQR &= (uint8_t)(~I2C_FREQR_FREQ);
 293  0029 c65212        	ld	a,21010
 294  002c a4c0          	and	a,#192
 295  002e c75212        	ld	21010,a
 296                     ; 117   I2C->FREQR |= InputClockFrequencyMHz;
 298  0031 c65212        	ld	a,21010
 299  0034 1a15          	or	a,(OFST+12,sp)
 300  0036 c75212        	ld	21010,a
 301                     ; 121   I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 303  0039 72115210      	bres	21008,#0
 304                     ; 124   I2C->CCRH &= (uint8_t)(~(I2C_CCRH_FS | I2C_CCRH_DUTY | I2C_CCRH_CCR));
 306  003d c6521c        	ld	a,21020
 307  0040 a430          	and	a,#48
 308  0042 c7521c        	ld	21020,a
 309                     ; 125   I2C->CCRL &= (uint8_t)(~I2C_CCRL_CCR);
 311  0045 725f521b      	clr	21019
 312                     ; 128   if (OutputClockFrequencyHz > I2C_MAX_STANDARD_FREQ) /* FAST MODE */
 314  0049 96            	ldw	x,sp
 315  004a 1c000c        	addw	x,#OFST+3
 316  004d cd0000        	call	c_ltor
 318  0050 ae0000        	ldw	x,#L01
 319  0053 cd0000        	call	c_lcmp
 321  0056 2403          	jruge	L41
 322  0058 cc00e5        	jp	L131
 323  005b               L41:
 324                     ; 131     tmpccrh = I2C_CCRH_FS;
 326  005b a680          	ld	a,#128
 327  005d 6b07          	ld	(OFST-2,sp),a
 328                     ; 133     if (I2C_DutyCycle == I2C_DUTYCYCLE_2)
 330  005f 0d12          	tnz	(OFST+9,sp)
 331  0061 2630          	jrne	L331
 332                     ; 136       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 3));
 334  0063 96            	ldw	x,sp
 335  0064 1c000c        	addw	x,#OFST+3
 336  0067 cd0000        	call	c_ltor
 338  006a a603          	ld	a,#3
 339  006c cd0000        	call	c_smul
 341  006f 96            	ldw	x,sp
 342  0070 1c0001        	addw	x,#OFST-8
 343  0073 cd0000        	call	c_rtol
 345  0076 7b15          	ld	a,(OFST+12,sp)
 346  0078 b703          	ld	c_lreg+3,a
 347  007a 3f02          	clr	c_lreg+2
 348  007c 3f01          	clr	c_lreg+1
 349  007e 3f00          	clr	c_lreg
 350  0080 ae0004        	ldw	x,#L21
 351  0083 cd0000        	call	c_lmul
 353  0086 96            	ldw	x,sp
 354  0087 1c0001        	addw	x,#OFST-8
 355  008a cd0000        	call	c_ludv
 357  008d be02          	ldw	x,c_lreg+2
 358  008f 1f08          	ldw	(OFST-1,sp),x
 360  0091 2034          	jra	L531
 361  0093               L331:
 362                     ; 141       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 25));
 364  0093 96            	ldw	x,sp
 365  0094 1c000c        	addw	x,#OFST+3
 366  0097 cd0000        	call	c_ltor
 368  009a a619          	ld	a,#25
 369  009c cd0000        	call	c_smul
 371  009f 96            	ldw	x,sp
 372  00a0 1c0001        	addw	x,#OFST-8
 373  00a3 cd0000        	call	c_rtol
 375  00a6 7b15          	ld	a,(OFST+12,sp)
 376  00a8 b703          	ld	c_lreg+3,a
 377  00aa 3f02          	clr	c_lreg+2
 378  00ac 3f01          	clr	c_lreg+1
 379  00ae 3f00          	clr	c_lreg
 380  00b0 ae0004        	ldw	x,#L21
 381  00b3 cd0000        	call	c_lmul
 383  00b6 96            	ldw	x,sp
 384  00b7 1c0001        	addw	x,#OFST-8
 385  00ba cd0000        	call	c_ludv
 387  00bd be02          	ldw	x,c_lreg+2
 388  00bf 1f08          	ldw	(OFST-1,sp),x
 389                     ; 143       tmpccrh |= I2C_CCRH_DUTY;
 391  00c1 7b07          	ld	a,(OFST-2,sp)
 392  00c3 aa40          	or	a,#64
 393  00c5 6b07          	ld	(OFST-2,sp),a
 394  00c7               L531:
 395                     ; 147     if (result < (uint16_t)0x01)
 397  00c7 1e08          	ldw	x,(OFST-1,sp)
 398  00c9 2605          	jrne	L731
 399                     ; 150       result = (uint16_t)0x0001;
 401  00cb ae0001        	ldw	x,#1
 402  00ce 1f08          	ldw	(OFST-1,sp),x
 403  00d0               L731:
 404                     ; 156     tmpval = ((InputClockFrequencyMHz * 3) / 10) + 1;
 406  00d0 7b15          	ld	a,(OFST+12,sp)
 407  00d2 97            	ld	xl,a
 408  00d3 a603          	ld	a,#3
 409  00d5 42            	mul	x,a
 410  00d6 a60a          	ld	a,#10
 411  00d8 cd0000        	call	c_sdivx
 413  00db 5c            	incw	x
 414  00dc 1f05          	ldw	(OFST-4,sp),x
 415                     ; 157     I2C->TRISER = (uint8_t)tmpval;
 417  00de 7b06          	ld	a,(OFST-3,sp)
 418  00e0 c7521d        	ld	21021,a
 420  00e3 2043          	jra	L141
 421  00e5               L131:
 422                     ; 164     result = (uint16_t)((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz << (uint8_t)1));
 424  00e5 96            	ldw	x,sp
 425  00e6 1c000c        	addw	x,#OFST+3
 426  00e9 cd0000        	call	c_ltor
 428  00ec 3803          	sll	c_lreg+3
 429  00ee 3902          	rlc	c_lreg+2
 430  00f0 3901          	rlc	c_lreg+1
 431  00f2 3900          	rlc	c_lreg
 432  00f4 96            	ldw	x,sp
 433  00f5 1c0001        	addw	x,#OFST-8
 434  00f8 cd0000        	call	c_rtol
 436  00fb 7b15          	ld	a,(OFST+12,sp)
 437  00fd b703          	ld	c_lreg+3,a
 438  00ff 3f02          	clr	c_lreg+2
 439  0101 3f01          	clr	c_lreg+1
 440  0103 3f00          	clr	c_lreg
 441  0105 ae0004        	ldw	x,#L21
 442  0108 cd0000        	call	c_lmul
 444  010b 96            	ldw	x,sp
 445  010c 1c0001        	addw	x,#OFST-8
 446  010f cd0000        	call	c_ludv
 448  0112 be02          	ldw	x,c_lreg+2
 449  0114 1f08          	ldw	(OFST-1,sp),x
 450                     ; 167     if (result < (uint16_t)0x0004)
 452  0116 1e08          	ldw	x,(OFST-1,sp)
 453  0118 a30004        	cpw	x,#4
 454  011b 2405          	jruge	L341
 455                     ; 170       result = (uint16_t)0x0004;
 457  011d ae0004        	ldw	x,#4
 458  0120 1f08          	ldw	(OFST-1,sp),x
 459  0122               L341:
 460                     ; 176     I2C->TRISER = (uint8_t)(InputClockFrequencyMHz + (uint8_t)1);
 462  0122 7b15          	ld	a,(OFST+12,sp)
 463  0124 4c            	inc	a
 464  0125 c7521d        	ld	21021,a
 465  0128               L141:
 466                     ; 181   I2C->CCRL = (uint8_t)result;
 468  0128 7b09          	ld	a,(OFST+0,sp)
 469  012a c7521b        	ld	21019,a
 470                     ; 182   I2C->CCRH = (uint8_t)((uint8_t)((uint8_t)(result >> 8) & I2C_CCRH_CCR) | tmpccrh);
 472  012d 7b08          	ld	a,(OFST-1,sp)
 473  012f a40f          	and	a,#15
 474  0131 1a07          	or	a,(OFST-2,sp)
 475  0133 c7521c        	ld	21020,a
 476                     ; 185   I2C->CR1 |= I2C_CR1_PE;
 478  0136 72105210      	bset	21008,#0
 479                     ; 188   I2C_AcknowledgeConfig(Ack);
 481  013a 7b13          	ld	a,(OFST+10,sp)
 482  013c ad77          	call	_I2C_AcknowledgeConfig
 484                     ; 191   I2C->OARL = (uint8_t)(OwnAddress);
 486  013e 7b11          	ld	a,(OFST+8,sp)
 487  0140 c75213        	ld	21011,a
 488                     ; 192   I2C->OARH = (uint8_t)((uint8_t)(AddMode | I2C_OARH_ADDCONF) |
 488                     ; 193                    (uint8_t)((OwnAddress & (uint16_t)0x0300) >> (uint8_t)7));
 490  0143 7b10          	ld	a,(OFST+7,sp)
 491  0145 97            	ld	xl,a
 492  0146 7b11          	ld	a,(OFST+8,sp)
 493  0148 9f            	ld	a,xl
 494  0149 a403          	and	a,#3
 495  014b 97            	ld	xl,a
 496  014c 4f            	clr	a
 497  014d 02            	rlwa	x,a
 498  014e 4f            	clr	a
 499  014f 01            	rrwa	x,a
 500  0150 48            	sll	a
 501  0151 59            	rlcw	x
 502  0152 9f            	ld	a,xl
 503  0153 6b04          	ld	(OFST-5,sp),a
 504  0155 7b14          	ld	a,(OFST+11,sp)
 505  0157 aa40          	or	a,#64
 506  0159 1a04          	or	a,(OFST-5,sp)
 507  015b c75214        	ld	21012,a
 508                     ; 194 }
 511  015e 5b09          	addw	sp,#9
 512  0160 81            	ret
 567                     ; 202 void I2C_Cmd(FunctionalState NewState)
 567                     ; 203 {
 568                     	switch	.text
 569  0161               _I2C_Cmd:
 573                     ; 205   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 575                     ; 207   if (NewState != DISABLE)
 577  0161 4d            	tnz	a
 578  0162 2706          	jreq	L371
 579                     ; 210     I2C->CR1 |= I2C_CR1_PE;
 581  0164 72105210      	bset	21008,#0
 583  0168 2004          	jra	L571
 584  016a               L371:
 585                     ; 215     I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 587  016a 72115210      	bres	21008,#0
 588  016e               L571:
 589                     ; 217 }
 592  016e 81            	ret
 627                     ; 225 void I2C_GeneralCallCmd(FunctionalState NewState)
 627                     ; 226 {
 628                     	switch	.text
 629  016f               _I2C_GeneralCallCmd:
 633                     ; 228   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 635                     ; 230   if (NewState != DISABLE)
 637  016f 4d            	tnz	a
 638  0170 2706          	jreq	L512
 639                     ; 233     I2C->CR1 |= I2C_CR1_ENGC;
 641  0172 721c5210      	bset	21008,#6
 643  0176 2004          	jra	L712
 644  0178               L512:
 645                     ; 238     I2C->CR1 &= (uint8_t)(~I2C_CR1_ENGC);
 647  0178 721d5210      	bres	21008,#6
 648  017c               L712:
 649                     ; 240 }
 652  017c 81            	ret
 687                     ; 250 void I2C_GenerateSTART(FunctionalState NewState)
 687                     ; 251 {
 688                     	switch	.text
 689  017d               _I2C_GenerateSTART:
 693                     ; 253   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 695                     ; 255   if (NewState != DISABLE)
 697  017d 4d            	tnz	a
 698  017e 2706          	jreq	L732
 699                     ; 258     I2C->CR2 |= I2C_CR2_START;
 701  0180 72105211      	bset	21009,#0
 703  0184 2004          	jra	L142
 704  0186               L732:
 705                     ; 263     I2C->CR2 &= (uint8_t)(~I2C_CR2_START);
 707  0186 72115211      	bres	21009,#0
 708  018a               L142:
 709                     ; 265 }
 712  018a 81            	ret
 747                     ; 273 void I2C_GenerateSTOP(FunctionalState NewState)
 747                     ; 274 {
 748                     	switch	.text
 749  018b               _I2C_GenerateSTOP:
 753                     ; 276   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 755                     ; 278   if (NewState != DISABLE)
 757  018b 4d            	tnz	a
 758  018c 2706          	jreq	L162
 759                     ; 281     I2C->CR2 |= I2C_CR2_STOP;
 761  018e 72125211      	bset	21009,#1
 763  0192 2004          	jra	L362
 764  0194               L162:
 765                     ; 286     I2C->CR2 &= (uint8_t)(~I2C_CR2_STOP);
 767  0194 72135211      	bres	21009,#1
 768  0198               L362:
 769                     ; 288 }
 772  0198 81            	ret
 808                     ; 296 void I2C_SoftwareResetCmd(FunctionalState NewState)
 808                     ; 297 {
 809                     	switch	.text
 810  0199               _I2C_SoftwareResetCmd:
 814                     ; 299   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 816                     ; 301   if (NewState != DISABLE)
 818  0199 4d            	tnz	a
 819  019a 2706          	jreq	L303
 820                     ; 304     I2C->CR2 |= I2C_CR2_SWRST;
 822  019c 721e5211      	bset	21009,#7
 824  01a0 2004          	jra	L503
 825  01a2               L303:
 826                     ; 309     I2C->CR2 &= (uint8_t)(~I2C_CR2_SWRST);
 828  01a2 721f5211      	bres	21009,#7
 829  01a6               L503:
 830                     ; 311 }
 833  01a6 81            	ret
 869                     ; 320 void I2C_StretchClockCmd(FunctionalState NewState)
 869                     ; 321 {
 870                     	switch	.text
 871  01a7               _I2C_StretchClockCmd:
 875                     ; 323   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 877                     ; 325   if (NewState != DISABLE)
 879  01a7 4d            	tnz	a
 880  01a8 2706          	jreq	L523
 881                     ; 328     I2C->CR1 &= (uint8_t)(~I2C_CR1_NOSTRETCH);
 883  01aa 721f5210      	bres	21008,#7
 885  01ae 2004          	jra	L723
 886  01b0               L523:
 887                     ; 334     I2C->CR1 |= I2C_CR1_NOSTRETCH;
 889  01b0 721e5210      	bset	21008,#7
 890  01b4               L723:
 891                     ; 336 }
 894  01b4 81            	ret
 930                     ; 345 void I2C_AcknowledgeConfig(I2C_Ack_TypeDef Ack)
 930                     ; 346 {
 931                     	switch	.text
 932  01b5               _I2C_AcknowledgeConfig:
 934  01b5 88            	push	a
 935       00000000      OFST:	set	0
 938                     ; 348   assert_param(IS_I2C_ACK_OK(Ack));
 940                     ; 350   if (Ack == I2C_ACK_NONE)
 942  01b6 4d            	tnz	a
 943  01b7 2606          	jrne	L743
 944                     ; 353     I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);
 946  01b9 72155211      	bres	21009,#2
 948  01bd 2014          	jra	L153
 949  01bf               L743:
 950                     ; 358     I2C->CR2 |= I2C_CR2_ACK;
 952  01bf 72145211      	bset	21009,#2
 953                     ; 360     if (Ack == I2C_ACK_CURR)
 955  01c3 7b01          	ld	a,(OFST+1,sp)
 956  01c5 a101          	cp	a,#1
 957  01c7 2606          	jrne	L353
 958                     ; 363       I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);
 960  01c9 72175211      	bres	21009,#3
 962  01cd 2004          	jra	L153
 963  01cf               L353:
 964                     ; 368       I2C->CR2 |= I2C_CR2_POS;
 966  01cf 72165211      	bset	21009,#3
 967  01d3               L153:
 968                     ; 371 }
 971  01d3 84            	pop	a
 972  01d4 81            	ret
1044                     ; 381 void I2C_ITConfig(I2C_IT_TypeDef I2C_IT, FunctionalState NewState)
1044                     ; 382 {
1045                     	switch	.text
1046  01d5               _I2C_ITConfig:
1048  01d5 89            	pushw	x
1049       00000000      OFST:	set	0
1052                     ; 384   assert_param(IS_I2C_INTERRUPT_OK(I2C_IT));
1054                     ; 385   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1056                     ; 387   if (NewState != DISABLE)
1058  01d6 9f            	ld	a,xl
1059  01d7 4d            	tnz	a
1060  01d8 2709          	jreq	L314
1061                     ; 390     I2C->ITR |= (uint8_t)I2C_IT;
1063  01da 9e            	ld	a,xh
1064  01db ca521a        	or	a,21018
1065  01de c7521a        	ld	21018,a
1067  01e1 2009          	jra	L514
1068  01e3               L314:
1069                     ; 395     I2C->ITR &= (uint8_t)(~(uint8_t)I2C_IT);
1071  01e3 7b01          	ld	a,(OFST+1,sp)
1072  01e5 43            	cpl	a
1073  01e6 c4521a        	and	a,21018
1074  01e9 c7521a        	ld	21018,a
1075  01ec               L514:
1076                     ; 397 }
1079  01ec 85            	popw	x
1080  01ed 81            	ret
1116                     ; 405 void I2C_FastModeDutyCycleConfig(I2C_DutyCycle_TypeDef I2C_DutyCycle)
1116                     ; 406 {
1117                     	switch	.text
1118  01ee               _I2C_FastModeDutyCycleConfig:
1122                     ; 408   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));
1124                     ; 410   if (I2C_DutyCycle == I2C_DUTYCYCLE_16_9)
1126  01ee a140          	cp	a,#64
1127  01f0 2606          	jrne	L534
1128                     ; 413     I2C->CCRH |= I2C_CCRH_DUTY;
1130  01f2 721c521c      	bset	21020,#6
1132  01f6 2004          	jra	L734
1133  01f8               L534:
1134                     ; 418     I2C->CCRH &= (uint8_t)(~I2C_CCRH_DUTY);
1136  01f8 721d521c      	bres	21020,#6
1137  01fc               L734:
1138                     ; 420 }
1141  01fc 81            	ret
1164                     ; 427 uint8_t I2C_ReceiveData(void)
1164                     ; 428 {
1165                     	switch	.text
1166  01fd               _I2C_ReceiveData:
1170                     ; 430   return ((uint8_t)I2C->DR);
1172  01fd c65216        	ld	a,21014
1175  0200 81            	ret
1240                     ; 440 void I2C_Send7bitAddress(uint8_t Address, I2C_Direction_TypeDef Direction)
1240                     ; 441 {
1241                     	switch	.text
1242  0201               _I2C_Send7bitAddress:
1244  0201 89            	pushw	x
1245       00000000      OFST:	set	0
1248                     ; 443   assert_param(IS_I2C_ADDRESS_OK(Address));
1250                     ; 444   assert_param(IS_I2C_DIRECTION_OK(Direction));
1252                     ; 447   Address &= (uint8_t)0xFE;
1254  0202 7b01          	ld	a,(OFST+1,sp)
1255  0204 a4fe          	and	a,#254
1256  0206 6b01          	ld	(OFST+1,sp),a
1257                     ; 450   I2C->DR = (uint8_t)(Address | (uint8_t)Direction);
1259  0208 7b01          	ld	a,(OFST+1,sp)
1260  020a 1a02          	or	a,(OFST+2,sp)
1261  020c c75216        	ld	21014,a
1262                     ; 451 }
1265  020f 85            	popw	x
1266  0210 81            	ret
1300                     ; 458 void I2C_SendData(uint8_t Data)
1300                     ; 459 {
1301                     	switch	.text
1302  0211               _I2C_SendData:
1306                     ; 461   I2C->DR = Data;
1308  0211 c75216        	ld	21014,a
1309                     ; 462 }
1312  0214 81            	ret
1536                     ; 578 ErrorStatus I2C_CheckEvent(I2C_Event_TypeDef I2C_Event)
1536                     ; 579 {
1537                     	switch	.text
1538  0215               _I2C_CheckEvent:
1540  0215 89            	pushw	x
1541  0216 5206          	subw	sp,#6
1542       00000006      OFST:	set	6
1545                     ; 580   __IO uint16_t lastevent = 0x00;
1547  0218 5f            	clrw	x
1548  0219 1f04          	ldw	(OFST-2,sp),x
1549                     ; 581   uint8_t flag1 = 0x00 ;
1551                     ; 582   uint8_t flag2 = 0x00;
1553                     ; 583   ErrorStatus status = ERROR;
1555                     ; 586   assert_param(IS_I2C_EVENT_OK(I2C_Event));
1557                     ; 588   if (I2C_Event == I2C_EVENT_SLAVE_ACK_FAILURE)
1559  021b 1e07          	ldw	x,(OFST+1,sp)
1560  021d a30004        	cpw	x,#4
1561  0220 260b          	jrne	L136
1562                     ; 590     lastevent = I2C->SR2 & I2C_SR2_AF;
1564  0222 c65218        	ld	a,21016
1565  0225 a404          	and	a,#4
1566  0227 5f            	clrw	x
1567  0228 97            	ld	xl,a
1568  0229 1f04          	ldw	(OFST-2,sp),x
1570  022b 201f          	jra	L336
1571  022d               L136:
1572                     ; 594     flag1 = I2C->SR1;
1574  022d c65217        	ld	a,21015
1575  0230 6b03          	ld	(OFST-3,sp),a
1576                     ; 595     flag2 = I2C->SR3;
1578  0232 c65219        	ld	a,21017
1579  0235 6b06          	ld	(OFST+0,sp),a
1580                     ; 596     lastevent = ((uint16_t)((uint16_t)flag2 << (uint16_t)8) | (uint16_t)flag1);
1582  0237 7b03          	ld	a,(OFST-3,sp)
1583  0239 5f            	clrw	x
1584  023a 97            	ld	xl,a
1585  023b 1f01          	ldw	(OFST-5,sp),x
1586  023d 7b06          	ld	a,(OFST+0,sp)
1587  023f 5f            	clrw	x
1588  0240 97            	ld	xl,a
1589  0241 4f            	clr	a
1590  0242 02            	rlwa	x,a
1591  0243 01            	rrwa	x,a
1592  0244 1a02          	or	a,(OFST-4,sp)
1593  0246 01            	rrwa	x,a
1594  0247 1a01          	or	a,(OFST-5,sp)
1595  0249 01            	rrwa	x,a
1596  024a 1f04          	ldw	(OFST-2,sp),x
1597  024c               L336:
1598                     ; 599   if (((uint16_t)lastevent & (uint16_t)I2C_Event) == (uint16_t)I2C_Event)
1600  024c 1e04          	ldw	x,(OFST-2,sp)
1601  024e 01            	rrwa	x,a
1602  024f 1408          	and	a,(OFST+2,sp)
1603  0251 01            	rrwa	x,a
1604  0252 1407          	and	a,(OFST+1,sp)
1605  0254 01            	rrwa	x,a
1606  0255 1307          	cpw	x,(OFST+1,sp)
1607  0257 2606          	jrne	L536
1608                     ; 602     status = SUCCESS;
1610  0259 a601          	ld	a,#1
1611  025b 6b06          	ld	(OFST+0,sp),a
1613  025d 2002          	jra	L736
1614  025f               L536:
1615                     ; 607     status = ERROR;
1617  025f 0f06          	clr	(OFST+0,sp)
1618  0261               L736:
1619                     ; 611   return status;
1621  0261 7b06          	ld	a,(OFST+0,sp)
1624  0263 5b08          	addw	sp,#8
1625  0265 81            	ret
1678                     ; 628 I2C_Event_TypeDef I2C_GetLastEvent(void)
1678                     ; 629 {
1679                     	switch	.text
1680  0266               _I2C_GetLastEvent:
1682  0266 5206          	subw	sp,#6
1683       00000006      OFST:	set	6
1686                     ; 630   __IO uint16_t lastevent = 0;
1688  0268 5f            	clrw	x
1689  0269 1f05          	ldw	(OFST-1,sp),x
1690                     ; 631   uint16_t flag1 = 0;
1692                     ; 632   uint16_t flag2 = 0;
1694                     ; 634   if ((I2C->SR2 & I2C_SR2_AF) != 0x00)
1696  026b c65218        	ld	a,21016
1697  026e a504          	bcp	a,#4
1698  0270 2707          	jreq	L766
1699                     ; 636     lastevent = I2C_EVENT_SLAVE_ACK_FAILURE;
1701  0272 ae0004        	ldw	x,#4
1702  0275 1f05          	ldw	(OFST-1,sp),x
1704  0277 201b          	jra	L176
1705  0279               L766:
1706                     ; 641     flag1 = I2C->SR1;
1708  0279 c65217        	ld	a,21015
1709  027c 5f            	clrw	x
1710  027d 97            	ld	xl,a
1711  027e 1f01          	ldw	(OFST-5,sp),x
1712                     ; 642     flag2 = I2C->SR3;
1714  0280 c65219        	ld	a,21017
1715  0283 5f            	clrw	x
1716  0284 97            	ld	xl,a
1717  0285 1f03          	ldw	(OFST-3,sp),x
1718                     ; 645     lastevent = ((uint16_t)((uint16_t)flag2 << 8) | (uint16_t)flag1);
1720  0287 1e03          	ldw	x,(OFST-3,sp)
1721  0289 4f            	clr	a
1722  028a 02            	rlwa	x,a
1723  028b 01            	rrwa	x,a
1724  028c 1a02          	or	a,(OFST-4,sp)
1725  028e 01            	rrwa	x,a
1726  028f 1a01          	or	a,(OFST-5,sp)
1727  0291 01            	rrwa	x,a
1728  0292 1f05          	ldw	(OFST-1,sp),x
1729  0294               L176:
1730                     ; 648   return (I2C_Event_TypeDef)lastevent;
1732  0294 1e05          	ldw	x,(OFST-1,sp)
1735  0296 5b06          	addw	sp,#6
1736  0298 81            	ret
1951                     ; 679 FlagStatus I2C_GetFlagStatus(I2C_Flag_TypeDef I2C_Flag)
1951                     ; 680 {
1952                     	switch	.text
1953  0299               _I2C_GetFlagStatus:
1955  0299 89            	pushw	x
1956  029a 89            	pushw	x
1957       00000002      OFST:	set	2
1960                     ; 681   uint8_t tempreg = 0;
1962  029b 0f02          	clr	(OFST+0,sp)
1963                     ; 682   uint8_t regindex = 0;
1965                     ; 683   FlagStatus bitstatus = RESET;
1967                     ; 686   assert_param(IS_I2C_FLAG_OK(I2C_Flag));
1969                     ; 689   regindex = (uint8_t)((uint16_t)I2C_Flag >> 8);
1971  029d 9e            	ld	a,xh
1972  029e 6b01          	ld	(OFST-1,sp),a
1973                     ; 691   switch (regindex)
1975  02a0 7b01          	ld	a,(OFST-1,sp)
1977                     ; 708     default:
1977                     ; 709       break;
1978  02a2 4a            	dec	a
1979  02a3 2708          	jreq	L376
1980  02a5 4a            	dec	a
1981  02a6 270c          	jreq	L576
1982  02a8 4a            	dec	a
1983  02a9 2710          	jreq	L776
1984  02ab 2013          	jra	L3101
1985  02ad               L376:
1986                     ; 694     case 0x01:
1986                     ; 695       tempreg = (uint8_t)I2C->SR1;
1988  02ad c65217        	ld	a,21015
1989  02b0 6b02          	ld	(OFST+0,sp),a
1990                     ; 696       break;
1992  02b2 200c          	jra	L3101
1993  02b4               L576:
1994                     ; 699     case 0x02:
1994                     ; 700       tempreg = (uint8_t)I2C->SR2;
1996  02b4 c65218        	ld	a,21016
1997  02b7 6b02          	ld	(OFST+0,sp),a
1998                     ; 701       break;
2000  02b9 2005          	jra	L3101
2001  02bb               L776:
2002                     ; 704     case 0x03:
2002                     ; 705       tempreg = (uint8_t)I2C->SR3;
2004  02bb c65219        	ld	a,21017
2005  02be 6b02          	ld	(OFST+0,sp),a
2006                     ; 706       break;
2008  02c0               L107:
2009                     ; 708     default:
2009                     ; 709       break;
2011  02c0               L3101:
2012                     ; 713   if ((tempreg & (uint8_t)I2C_Flag ) != 0)
2014  02c0 7b04          	ld	a,(OFST+2,sp)
2015  02c2 1502          	bcp	a,(OFST+0,sp)
2016  02c4 2706          	jreq	L5101
2017                     ; 716     bitstatus = SET;
2019  02c6 a601          	ld	a,#1
2020  02c8 6b02          	ld	(OFST+0,sp),a
2022  02ca 2002          	jra	L7101
2023  02cc               L5101:
2024                     ; 721     bitstatus = RESET;
2026  02cc 0f02          	clr	(OFST+0,sp)
2027  02ce               L7101:
2028                     ; 724   return bitstatus;
2030  02ce 7b02          	ld	a,(OFST+0,sp)
2033  02d0 5b04          	addw	sp,#4
2034  02d2 81            	ret
2078                     ; 759 void I2C_ClearFlag(I2C_Flag_TypeDef I2C_FLAG)
2078                     ; 760 {
2079                     	switch	.text
2080  02d3               _I2C_ClearFlag:
2082  02d3 89            	pushw	x
2083       00000002      OFST:	set	2
2086                     ; 761   uint16_t flagpos = 0;
2088                     ; 763   assert_param(IS_I2C_CLEAR_FLAG_OK(I2C_FLAG));
2090                     ; 766   flagpos = (uint16_t)I2C_FLAG & FLAG_Mask;
2092  02d4 01            	rrwa	x,a
2093  02d5 a4ff          	and	a,#255
2094  02d7 5f            	clrw	x
2095  02d8 02            	rlwa	x,a
2096  02d9 1f01          	ldw	(OFST-1,sp),x
2097  02db 01            	rrwa	x,a
2098                     ; 768   I2C->SR2 = (uint8_t)((uint16_t)(~flagpos));
2100  02dc 7b02          	ld	a,(OFST+0,sp)
2101  02de 43            	cpl	a
2102  02df c75218        	ld	21016,a
2103                     ; 769 }
2106  02e2 85            	popw	x
2107  02e3 81            	ret
2273                     ; 791 ITStatus I2C_GetITStatus(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
2273                     ; 792 {
2274                     	switch	.text
2275  02e4               _I2C_GetITStatus:
2277  02e4 89            	pushw	x
2278  02e5 5204          	subw	sp,#4
2279       00000004      OFST:	set	4
2282                     ; 793   ITStatus bitstatus = RESET;
2284                     ; 794   __IO uint8_t enablestatus = 0;
2286  02e7 0f03          	clr	(OFST-1,sp)
2287                     ; 795   uint16_t tempregister = 0;
2289                     ; 798     assert_param(IS_I2C_ITPENDINGBIT_OK(I2C_ITPendingBit));
2291                     ; 800   tempregister = (uint8_t)( ((uint16_t)((uint16_t)I2C_ITPendingBit & ITEN_Mask)) >> 8);
2293  02e9 01            	rrwa	x,a
2294  02ea 9f            	ld	a,xl
2295  02eb a407          	and	a,#7
2296  02ed 97            	ld	xl,a
2297  02ee 4f            	clr	a
2298  02ef 02            	rlwa	x,a
2299  02f0 4f            	clr	a
2300  02f1 01            	rrwa	x,a
2301  02f2 9f            	ld	a,xl
2302  02f3 5f            	clrw	x
2303  02f4 97            	ld	xl,a
2304  02f5 1f01          	ldw	(OFST-3,sp),x
2305                     ; 803   enablestatus = (uint8_t)(I2C->ITR & ( uint8_t)tempregister);
2307  02f7 c6521a        	ld	a,21018
2308  02fa 1402          	and	a,(OFST-2,sp)
2309  02fc 6b03          	ld	(OFST-1,sp),a
2310                     ; 805   if ((uint16_t)((uint16_t)I2C_ITPendingBit & REGISTER_Mask) == REGISTER_SR1_Index)
2312  02fe 7b05          	ld	a,(OFST+1,sp)
2313  0300 97            	ld	xl,a
2314  0301 7b06          	ld	a,(OFST+2,sp)
2315  0303 9f            	ld	a,xl
2316  0304 a430          	and	a,#48
2317  0306 97            	ld	xl,a
2318  0307 4f            	clr	a
2319  0308 02            	rlwa	x,a
2320  0309 a30100        	cpw	x,#256
2321  030c 2615          	jrne	L1311
2322                     ; 808     if (((I2C->SR1 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
2324  030e c65217        	ld	a,21015
2325  0311 1506          	bcp	a,(OFST+2,sp)
2326  0313 270a          	jreq	L3311
2328  0315 0d03          	tnz	(OFST-1,sp)
2329  0317 2706          	jreq	L3311
2330                     ; 811       bitstatus = SET;
2332  0319 a601          	ld	a,#1
2333  031b 6b04          	ld	(OFST+0,sp),a
2335  031d 2017          	jra	L7311
2336  031f               L3311:
2337                     ; 816       bitstatus = RESET;
2339  031f 0f04          	clr	(OFST+0,sp)
2340  0321 2013          	jra	L7311
2341  0323               L1311:
2342                     ; 822     if (((I2C->SR2 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
2344  0323 c65218        	ld	a,21016
2345  0326 1506          	bcp	a,(OFST+2,sp)
2346  0328 270a          	jreq	L1411
2348  032a 0d03          	tnz	(OFST-1,sp)
2349  032c 2706          	jreq	L1411
2350                     ; 825       bitstatus = SET;
2352  032e a601          	ld	a,#1
2353  0330 6b04          	ld	(OFST+0,sp),a
2355  0332 2002          	jra	L7311
2356  0334               L1411:
2357                     ; 830       bitstatus = RESET;
2359  0334 0f04          	clr	(OFST+0,sp)
2360  0336               L7311:
2361                     ; 834   return  bitstatus;
2363  0336 7b04          	ld	a,(OFST+0,sp)
2366  0338 5b06          	addw	sp,#6
2367  033a 81            	ret
2412                     ; 871 void I2C_ClearITPendingBit(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
2412                     ; 872 {
2413                     	switch	.text
2414  033b               _I2C_ClearITPendingBit:
2416  033b 89            	pushw	x
2417       00000002      OFST:	set	2
2420                     ; 873   uint16_t flagpos = 0;
2422                     ; 876   assert_param(IS_I2C_CLEAR_ITPENDINGBIT_OK(I2C_ITPendingBit));
2424                     ; 879   flagpos = (uint16_t)I2C_ITPendingBit & FLAG_Mask;
2426  033c 01            	rrwa	x,a
2427  033d a4ff          	and	a,#255
2428  033f 5f            	clrw	x
2429  0340 02            	rlwa	x,a
2430  0341 1f01          	ldw	(OFST-1,sp),x
2431  0343 01            	rrwa	x,a
2432                     ; 882   I2C->SR2 = (uint8_t)((uint16_t)~flagpos);
2434  0344 7b02          	ld	a,(OFST+0,sp)
2435  0346 43            	cpl	a
2436  0347 c75218        	ld	21016,a
2437                     ; 883 }
2440  034a 85            	popw	x
2441  034b 81            	ret
2454                     	xdef	_I2C_ClearITPendingBit
2455                     	xdef	_I2C_GetITStatus
2456                     	xdef	_I2C_ClearFlag
2457                     	xdef	_I2C_GetFlagStatus
2458                     	xdef	_I2C_GetLastEvent
2459                     	xdef	_I2C_CheckEvent
2460                     	xdef	_I2C_SendData
2461                     	xdef	_I2C_Send7bitAddress
2462                     	xdef	_I2C_ReceiveData
2463                     	xdef	_I2C_ITConfig
2464                     	xdef	_I2C_FastModeDutyCycleConfig
2465                     	xdef	_I2C_AcknowledgeConfig
2466                     	xdef	_I2C_StretchClockCmd
2467                     	xdef	_I2C_SoftwareResetCmd
2468                     	xdef	_I2C_GenerateSTOP
2469                     	xdef	_I2C_GenerateSTART
2470                     	xdef	_I2C_GeneralCallCmd
2471                     	xdef	_I2C_Cmd
2472                     	xdef	_I2C_Init
2473                     	xdef	_I2C_DeInit
2474                     	xref.b	c_lreg
2475                     	xref.b	c_x
2494                     	xref	c_sdivx
2495                     	xref	c_ludv
2496                     	xref	c_rtol
2497                     	xref	c_smul
2498                     	xref	c_lmul
2499                     	xref	c_lcmp
2500                     	xref	c_ltor
2501                     	end
