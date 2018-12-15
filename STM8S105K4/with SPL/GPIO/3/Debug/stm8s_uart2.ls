   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  43                     ; 53 void UART2_DeInit(void)
  43                     ; 54 {
  45                     	switch	.text
  46  0000               _UART2_DeInit:
  50                     ; 57   (void) UART2->SR;
  52  0000 c65240        	ld	a,21056
  53                     ; 58   (void)UART2->DR;
  55  0003 c65241        	ld	a,21057
  56                     ; 60   UART2->BRR2 = UART2_BRR2_RESET_VALUE;  /*  Set UART2_BRR2 to reset value 0x00 */
  58  0006 725f5243      	clr	21059
  59                     ; 61   UART2->BRR1 = UART2_BRR1_RESET_VALUE;  /*  Set UART2_BRR1 to reset value 0x00 */
  61  000a 725f5242      	clr	21058
  62                     ; 63   UART2->CR1 = UART2_CR1_RESET_VALUE; /*  Set UART2_CR1 to reset value 0x00  */
  64  000e 725f5244      	clr	21060
  65                     ; 64   UART2->CR2 = UART2_CR2_RESET_VALUE; /*  Set UART2_CR2 to reset value 0x00  */
  67  0012 725f5245      	clr	21061
  68                     ; 65   UART2->CR3 = UART2_CR3_RESET_VALUE; /*  Set UART2_CR3 to reset value 0x00  */
  70  0016 725f5246      	clr	21062
  71                     ; 66   UART2->CR4 = UART2_CR4_RESET_VALUE; /*  Set UART2_CR4 to reset value 0x00  */
  73  001a 725f5247      	clr	21063
  74                     ; 67   UART2->CR5 = UART2_CR5_RESET_VALUE; /*  Set UART2_CR5 to reset value 0x00  */
  76  001e 725f5248      	clr	21064
  77                     ; 68   UART2->CR6 = UART2_CR6_RESET_VALUE; /*  Set UART2_CR6 to reset value 0x00  */
  79  0022 725f5249      	clr	21065
  80                     ; 69 }
  83  0026 81            	ret
 404                     .const:	section	.text
 405  0000               L01:
 406  0000 00000064      	dc.l	100
 407                     ; 85 void UART2_Init(uint32_t BaudRate, UART2_WordLength_TypeDef WordLength, UART2_StopBits_TypeDef StopBits, UART2_Parity_TypeDef Parity, UART2_SyncMode_TypeDef SyncMode, UART2_Mode_TypeDef Mode)
 407                     ; 86 {
 408                     	switch	.text
 409  0027               _UART2_Init:
 411  0027 520e          	subw	sp,#14
 412       0000000e      OFST:	set	14
 415                     ; 87   uint8_t BRR2_1 = 0, BRR2_2 = 0;
 419                     ; 88   uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 423                     ; 91   assert_param(IS_UART2_BAUDRATE_OK(BaudRate));
 425                     ; 92   assert_param(IS_UART2_WORDLENGTH_OK(WordLength));
 427                     ; 93   assert_param(IS_UART2_STOPBITS_OK(StopBits));
 429                     ; 94   assert_param(IS_UART2_PARITY_OK(Parity));
 431                     ; 95   assert_param(IS_UART2_MODE_OK((uint8_t)Mode));
 433                     ; 96   assert_param(IS_UART2_SYNCMODE_OK((uint8_t)SyncMode));
 435                     ; 99   UART2->CR1 &= (uint8_t)(~UART2_CR1_M);
 437  0029 72195244      	bres	21060,#4
 438                     ; 101   UART2->CR1 |= (uint8_t)WordLength; 
 440  002d c65244        	ld	a,21060
 441  0030 1a15          	or	a,(OFST+7,sp)
 442  0032 c75244        	ld	21060,a
 443                     ; 104   UART2->CR3 &= (uint8_t)(~UART2_CR3_STOP);
 445  0035 c65246        	ld	a,21062
 446  0038 a4cf          	and	a,#207
 447  003a c75246        	ld	21062,a
 448                     ; 106   UART2->CR3 |= (uint8_t)StopBits; 
 450  003d c65246        	ld	a,21062
 451  0040 1a16          	or	a,(OFST+8,sp)
 452  0042 c75246        	ld	21062,a
 453                     ; 109   UART2->CR1 &= (uint8_t)(~(UART2_CR1_PCEN | UART2_CR1_PS  ));
 455  0045 c65244        	ld	a,21060
 456  0048 a4f9          	and	a,#249
 457  004a c75244        	ld	21060,a
 458                     ; 111   UART2->CR1 |= (uint8_t)Parity;
 460  004d c65244        	ld	a,21060
 461  0050 1a17          	or	a,(OFST+9,sp)
 462  0052 c75244        	ld	21060,a
 463                     ; 114   UART2->BRR1 &= (uint8_t)(~UART2_BRR1_DIVM);
 465  0055 725f5242      	clr	21058
 466                     ; 116   UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVM);
 468  0059 c65243        	ld	a,21059
 469  005c a40f          	and	a,#15
 470  005e c75243        	ld	21059,a
 471                     ; 118   UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVF);
 473  0061 c65243        	ld	a,21059
 474  0064 a4f0          	and	a,#240
 475  0066 c75243        	ld	21059,a
 476                     ; 121   BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 478  0069 96            	ldw	x,sp
 479  006a 1c0011        	addw	x,#OFST+3
 480  006d cd0000        	call	c_ltor
 482  0070 a604          	ld	a,#4
 483  0072 cd0000        	call	c_llsh
 485  0075 96            	ldw	x,sp
 486  0076 1c0001        	addw	x,#OFST-13
 487  0079 cd0000        	call	c_rtol
 489  007c cd0000        	call	_CLK_GetClockFreq
 491  007f 96            	ldw	x,sp
 492  0080 1c0001        	addw	x,#OFST-13
 493  0083 cd0000        	call	c_ludv
 495  0086 96            	ldw	x,sp
 496  0087 1c000b        	addw	x,#OFST-3
 497  008a cd0000        	call	c_rtol
 499                     ; 122   BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 501  008d 96            	ldw	x,sp
 502  008e 1c0011        	addw	x,#OFST+3
 503  0091 cd0000        	call	c_ltor
 505  0094 a604          	ld	a,#4
 506  0096 cd0000        	call	c_llsh
 508  0099 96            	ldw	x,sp
 509  009a 1c0001        	addw	x,#OFST-13
 510  009d cd0000        	call	c_rtol
 512  00a0 cd0000        	call	_CLK_GetClockFreq
 514  00a3 a664          	ld	a,#100
 515  00a5 cd0000        	call	c_smul
 517  00a8 96            	ldw	x,sp
 518  00a9 1c0001        	addw	x,#OFST-13
 519  00ac cd0000        	call	c_ludv
 521  00af 96            	ldw	x,sp
 522  00b0 1c0007        	addw	x,#OFST-7
 523  00b3 cd0000        	call	c_rtol
 525                     ; 126   BRR2_1 = (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 525                     ; 127                                 << 4) / 100) & (uint8_t)0x0F); 
 527  00b6 96            	ldw	x,sp
 528  00b7 1c000b        	addw	x,#OFST-3
 529  00ba cd0000        	call	c_ltor
 531  00bd a664          	ld	a,#100
 532  00bf cd0000        	call	c_smul
 534  00c2 96            	ldw	x,sp
 535  00c3 1c0001        	addw	x,#OFST-13
 536  00c6 cd0000        	call	c_rtol
 538  00c9 96            	ldw	x,sp
 539  00ca 1c0007        	addw	x,#OFST-7
 540  00cd cd0000        	call	c_ltor
 542  00d0 96            	ldw	x,sp
 543  00d1 1c0001        	addw	x,#OFST-13
 544  00d4 cd0000        	call	c_lsub
 546  00d7 a604          	ld	a,#4
 547  00d9 cd0000        	call	c_llsh
 549  00dc ae0000        	ldw	x,#L01
 550  00df cd0000        	call	c_ludv
 552  00e2 b603          	ld	a,c_lreg+3
 553  00e4 a40f          	and	a,#15
 554  00e6 6b05          	ld	(OFST-9,sp),a
 555                     ; 128   BRR2_2 = (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0);
 557  00e8 96            	ldw	x,sp
 558  00e9 1c000b        	addw	x,#OFST-3
 559  00ec cd0000        	call	c_ltor
 561  00ef a604          	ld	a,#4
 562  00f1 cd0000        	call	c_lursh
 564  00f4 b603          	ld	a,c_lreg+3
 565  00f6 a4f0          	and	a,#240
 566  00f8 b703          	ld	c_lreg+3,a
 567  00fa 3f02          	clr	c_lreg+2
 568  00fc 3f01          	clr	c_lreg+1
 569  00fe 3f00          	clr	c_lreg
 570  0100 b603          	ld	a,c_lreg+3
 571  0102 6b06          	ld	(OFST-8,sp),a
 572                     ; 130   UART2->BRR2 = (uint8_t)(BRR2_1 | BRR2_2);
 574  0104 7b05          	ld	a,(OFST-9,sp)
 575  0106 1a06          	or	a,(OFST-8,sp)
 576  0108 c75243        	ld	21059,a
 577                     ; 132   UART2->BRR1 = (uint8_t)BaudRate_Mantissa;           
 579  010b 7b0e          	ld	a,(OFST+0,sp)
 580  010d c75242        	ld	21058,a
 581                     ; 135   UART2->CR2 &= (uint8_t)~(UART2_CR2_TEN | UART2_CR2_REN);
 583  0110 c65245        	ld	a,21061
 584  0113 a4f3          	and	a,#243
 585  0115 c75245        	ld	21061,a
 586                     ; 137   UART2->CR3 &= (uint8_t)~(UART2_CR3_CPOL | UART2_CR3_CPHA | UART2_CR3_LBCL);
 588  0118 c65246        	ld	a,21062
 589  011b a4f8          	and	a,#248
 590  011d c75246        	ld	21062,a
 591                     ; 139   UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART2_CR3_CPOL | \
 591                     ; 140     UART2_CR3_CPHA | UART2_CR3_LBCL));
 593  0120 7b18          	ld	a,(OFST+10,sp)
 594  0122 a407          	and	a,#7
 595  0124 ca5246        	or	a,21062
 596  0127 c75246        	ld	21062,a
 597                     ; 142   if ((uint8_t)(Mode & UART2_MODE_TX_ENABLE))
 599  012a 7b19          	ld	a,(OFST+11,sp)
 600  012c a504          	bcp	a,#4
 601  012e 2706          	jreq	L302
 602                     ; 145     UART2->CR2 |= (uint8_t)UART2_CR2_TEN;
 604  0130 72165245      	bset	21061,#3
 606  0134 2004          	jra	L502
 607  0136               L302:
 608                     ; 150     UART2->CR2 &= (uint8_t)(~UART2_CR2_TEN);
 610  0136 72175245      	bres	21061,#3
 611  013a               L502:
 612                     ; 152   if ((uint8_t)(Mode & UART2_MODE_RX_ENABLE))
 614  013a 7b19          	ld	a,(OFST+11,sp)
 615  013c a508          	bcp	a,#8
 616  013e 2706          	jreq	L702
 617                     ; 155     UART2->CR2 |= (uint8_t)UART2_CR2_REN;
 619  0140 72145245      	bset	21061,#2
 621  0144 2004          	jra	L112
 622  0146               L702:
 623                     ; 160     UART2->CR2 &= (uint8_t)(~UART2_CR2_REN);
 625  0146 72155245      	bres	21061,#2
 626  014a               L112:
 627                     ; 164   if ((uint8_t)(SyncMode & UART2_SYNCMODE_CLOCK_DISABLE))
 629  014a 7b18          	ld	a,(OFST+10,sp)
 630  014c a580          	bcp	a,#128
 631  014e 2706          	jreq	L312
 632                     ; 167     UART2->CR3 &= (uint8_t)(~UART2_CR3_CKEN); 
 634  0150 72175246      	bres	21062,#3
 636  0154 200a          	jra	L512
 637  0156               L312:
 638                     ; 171     UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & UART2_CR3_CKEN);
 640  0156 7b18          	ld	a,(OFST+10,sp)
 641  0158 a408          	and	a,#8
 642  015a ca5246        	or	a,21062
 643  015d c75246        	ld	21062,a
 644  0160               L512:
 645                     ; 173 }
 648  0160 5b0e          	addw	sp,#14
 649  0162 81            	ret
 704                     ; 181 void UART2_Cmd(FunctionalState NewState)
 704                     ; 182 {
 705                     	switch	.text
 706  0163               _UART2_Cmd:
 710                     ; 183   if (NewState != DISABLE)
 712  0163 4d            	tnz	a
 713  0164 2706          	jreq	L542
 714                     ; 186     UART2->CR1 &= (uint8_t)(~UART2_CR1_UARTD);
 716  0166 721b5244      	bres	21060,#5
 718  016a 2004          	jra	L742
 719  016c               L542:
 720                     ; 191     UART2->CR1 |= UART2_CR1_UARTD; 
 722  016c 721a5244      	bset	21060,#5
 723  0170               L742:
 724                     ; 193 }
 727  0170 81            	ret
 859                     ; 210 void UART2_ITConfig(UART2_IT_TypeDef UART2_IT, FunctionalState NewState)
 859                     ; 211 {
 860                     	switch	.text
 861  0171               _UART2_ITConfig:
 863  0171 89            	pushw	x
 864  0172 89            	pushw	x
 865       00000002      OFST:	set	2
 868                     ; 212   uint8_t uartreg = 0, itpos = 0x00;
 872                     ; 215   assert_param(IS_UART2_CONFIG_IT_OK(UART2_IT));
 874                     ; 216   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 876                     ; 219   uartreg = (uint8_t)((uint16_t)UART2_IT >> 0x08);
 878  0173 9e            	ld	a,xh
 879  0174 6b01          	ld	(OFST-1,sp),a
 880                     ; 222   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
 882  0176 9f            	ld	a,xl
 883  0177 a40f          	and	a,#15
 884  0179 5f            	clrw	x
 885  017a 97            	ld	xl,a
 886  017b a601          	ld	a,#1
 887  017d 5d            	tnzw	x
 888  017e 2704          	jreq	L61
 889  0180               L02:
 890  0180 48            	sll	a
 891  0181 5a            	decw	x
 892  0182 26fc          	jrne	L02
 893  0184               L61:
 894  0184 6b02          	ld	(OFST+0,sp),a
 895                     ; 224   if (NewState != DISABLE)
 897  0186 0d07          	tnz	(OFST+5,sp)
 898  0188 273a          	jreq	L133
 899                     ; 227     if (uartreg == 0x01)
 901  018a 7b01          	ld	a,(OFST-1,sp)
 902  018c a101          	cp	a,#1
 903  018e 260a          	jrne	L333
 904                     ; 229       UART2->CR1 |= itpos;
 906  0190 c65244        	ld	a,21060
 907  0193 1a02          	or	a,(OFST+0,sp)
 908  0195 c75244        	ld	21060,a
 910  0198 2066          	jra	L743
 911  019a               L333:
 912                     ; 231     else if (uartreg == 0x02)
 914  019a 7b01          	ld	a,(OFST-1,sp)
 915  019c a102          	cp	a,#2
 916  019e 260a          	jrne	L733
 917                     ; 233       UART2->CR2 |= itpos;
 919  01a0 c65245        	ld	a,21061
 920  01a3 1a02          	or	a,(OFST+0,sp)
 921  01a5 c75245        	ld	21061,a
 923  01a8 2056          	jra	L743
 924  01aa               L733:
 925                     ; 235     else if (uartreg == 0x03)
 927  01aa 7b01          	ld	a,(OFST-1,sp)
 928  01ac a103          	cp	a,#3
 929  01ae 260a          	jrne	L343
 930                     ; 237       UART2->CR4 |= itpos;
 932  01b0 c65247        	ld	a,21063
 933  01b3 1a02          	or	a,(OFST+0,sp)
 934  01b5 c75247        	ld	21063,a
 936  01b8 2046          	jra	L743
 937  01ba               L343:
 938                     ; 241       UART2->CR6 |= itpos;
 940  01ba c65249        	ld	a,21065
 941  01bd 1a02          	or	a,(OFST+0,sp)
 942  01bf c75249        	ld	21065,a
 943  01c2 203c          	jra	L743
 944  01c4               L133:
 945                     ; 247     if (uartreg == 0x01)
 947  01c4 7b01          	ld	a,(OFST-1,sp)
 948  01c6 a101          	cp	a,#1
 949  01c8 260b          	jrne	L153
 950                     ; 249       UART2->CR1 &= (uint8_t)(~itpos);
 952  01ca 7b02          	ld	a,(OFST+0,sp)
 953  01cc 43            	cpl	a
 954  01cd c45244        	and	a,21060
 955  01d0 c75244        	ld	21060,a
 957  01d3 202b          	jra	L743
 958  01d5               L153:
 959                     ; 251     else if (uartreg == 0x02)
 961  01d5 7b01          	ld	a,(OFST-1,sp)
 962  01d7 a102          	cp	a,#2
 963  01d9 260b          	jrne	L553
 964                     ; 253       UART2->CR2 &= (uint8_t)(~itpos);
 966  01db 7b02          	ld	a,(OFST+0,sp)
 967  01dd 43            	cpl	a
 968  01de c45245        	and	a,21061
 969  01e1 c75245        	ld	21061,a
 971  01e4 201a          	jra	L743
 972  01e6               L553:
 973                     ; 255     else if (uartreg == 0x03)
 975  01e6 7b01          	ld	a,(OFST-1,sp)
 976  01e8 a103          	cp	a,#3
 977  01ea 260b          	jrne	L163
 978                     ; 257       UART2->CR4 &= (uint8_t)(~itpos);
 980  01ec 7b02          	ld	a,(OFST+0,sp)
 981  01ee 43            	cpl	a
 982  01ef c45247        	and	a,21063
 983  01f2 c75247        	ld	21063,a
 985  01f5 2009          	jra	L743
 986  01f7               L163:
 987                     ; 261       UART2->CR6 &= (uint8_t)(~itpos);
 989  01f7 7b02          	ld	a,(OFST+0,sp)
 990  01f9 43            	cpl	a
 991  01fa c45249        	and	a,21065
 992  01fd c75249        	ld	21065,a
 993  0200               L743:
 994                     ; 264 }
 997  0200 5b04          	addw	sp,#4
 998  0202 81            	ret
1055                     ; 272 void UART2_IrDAConfig(UART2_IrDAMode_TypeDef UART2_IrDAMode)
1055                     ; 273 {
1056                     	switch	.text
1057  0203               _UART2_IrDAConfig:
1061                     ; 274   assert_param(IS_UART2_IRDAMODE_OK(UART2_IrDAMode));
1063                     ; 276   if (UART2_IrDAMode != UART2_IRDAMODE_NORMAL)
1065  0203 4d            	tnz	a
1066  0204 2706          	jreq	L314
1067                     ; 278     UART2->CR5 |= UART2_CR5_IRLP;
1069  0206 72145248      	bset	21064,#2
1071  020a 2004          	jra	L514
1072  020c               L314:
1073                     ; 282     UART2->CR5 &= ((uint8_t)~UART2_CR5_IRLP);
1075  020c 72155248      	bres	21064,#2
1076  0210               L514:
1077                     ; 284 }
1080  0210 81            	ret
1115                     ; 292 void UART2_IrDACmd(FunctionalState NewState)
1115                     ; 293 {
1116                     	switch	.text
1117  0211               _UART2_IrDACmd:
1121                     ; 295   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1123                     ; 297   if (NewState != DISABLE)
1125  0211 4d            	tnz	a
1126  0212 2706          	jreq	L534
1127                     ; 300     UART2->CR5 |= UART2_CR5_IREN;
1129  0214 72125248      	bset	21064,#1
1131  0218 2004          	jra	L734
1132  021a               L534:
1133                     ; 305     UART2->CR5 &= ((uint8_t)~UART2_CR5_IREN);
1135  021a 72135248      	bres	21064,#1
1136  021e               L734:
1137                     ; 307 }
1140  021e 81            	ret
1199                     ; 316 void UART2_LINBreakDetectionConfig(UART2_LINBreakDetectionLength_TypeDef UART2_LINBreakDetectionLength)
1199                     ; 317 {
1200                     	switch	.text
1201  021f               _UART2_LINBreakDetectionConfig:
1205                     ; 319   assert_param(IS_UART2_LINBREAKDETECTIONLENGTH_OK(UART2_LINBreakDetectionLength));
1207                     ; 321   if (UART2_LINBreakDetectionLength != UART2_LINBREAKDETECTIONLENGTH_10BITS)
1209  021f 4d            	tnz	a
1210  0220 2706          	jreq	L764
1211                     ; 323     UART2->CR4 |= UART2_CR4_LBDL;
1213  0222 721a5247      	bset	21063,#5
1215  0226 2004          	jra	L174
1216  0228               L764:
1217                     ; 327     UART2->CR4 &= ((uint8_t)~UART2_CR4_LBDL);
1219  0228 721b5247      	bres	21063,#5
1220  022c               L174:
1221                     ; 329 }
1224  022c 81            	ret
1345                     ; 341 void UART2_LINConfig(UART2_LinMode_TypeDef UART2_Mode, 
1345                     ; 342                      UART2_LinAutosync_TypeDef UART2_Autosync, 
1345                     ; 343                      UART2_LinDivUp_TypeDef UART2_DivUp)
1345                     ; 344 {
1346                     	switch	.text
1347  022d               _UART2_LINConfig:
1349  022d 89            	pushw	x
1350       00000000      OFST:	set	0
1353                     ; 346   assert_param(IS_UART2_SLAVE_OK(UART2_Mode));
1355                     ; 347   assert_param(IS_UART2_AUTOSYNC_OK(UART2_Autosync));
1357                     ; 348   assert_param(IS_UART2_DIVUP_OK(UART2_DivUp));
1359                     ; 350   if (UART2_Mode != UART2_LIN_MODE_MASTER)
1361  022e 9e            	ld	a,xh
1362  022f 4d            	tnz	a
1363  0230 2706          	jreq	L155
1364                     ; 352     UART2->CR6 |=  UART2_CR6_LSLV;
1366  0232 721a5249      	bset	21065,#5
1368  0236 2004          	jra	L355
1369  0238               L155:
1370                     ; 356     UART2->CR6 &= ((uint8_t)~UART2_CR6_LSLV);
1372  0238 721b5249      	bres	21065,#5
1373  023c               L355:
1374                     ; 359   if (UART2_Autosync != UART2_LIN_AUTOSYNC_DISABLE)
1376  023c 0d02          	tnz	(OFST+2,sp)
1377  023e 2706          	jreq	L555
1378                     ; 361     UART2->CR6 |=  UART2_CR6_LASE ;
1380  0240 72185249      	bset	21065,#4
1382  0244 2004          	jra	L755
1383  0246               L555:
1384                     ; 365     UART2->CR6 &= ((uint8_t)~ UART2_CR6_LASE );
1386  0246 72195249      	bres	21065,#4
1387  024a               L755:
1388                     ; 368   if (UART2_DivUp != UART2_LIN_DIVUP_LBRR1)
1390  024a 0d05          	tnz	(OFST+5,sp)
1391  024c 2706          	jreq	L165
1392                     ; 370     UART2->CR6 |=  UART2_CR6_LDUM;
1394  024e 721e5249      	bset	21065,#7
1396  0252 2004          	jra	L365
1397  0254               L165:
1398                     ; 374     UART2->CR6 &= ((uint8_t)~ UART2_CR6_LDUM);
1400  0254 721f5249      	bres	21065,#7
1401  0258               L365:
1402                     ; 376 }
1405  0258 85            	popw	x
1406  0259 81            	ret
1441                     ; 384 void UART2_LINCmd(FunctionalState NewState)
1441                     ; 385 {
1442                     	switch	.text
1443  025a               _UART2_LINCmd:
1447                     ; 386   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1449                     ; 388   if (NewState != DISABLE)
1451  025a 4d            	tnz	a
1452  025b 2706          	jreq	L306
1453                     ; 391     UART2->CR3 |= UART2_CR3_LINEN;
1455  025d 721c5246      	bset	21062,#6
1457  0261 2004          	jra	L506
1458  0263               L306:
1459                     ; 396     UART2->CR3 &= ((uint8_t)~UART2_CR3_LINEN);
1461  0263 721d5246      	bres	21062,#6
1462  0267               L506:
1463                     ; 398 }
1466  0267 81            	ret
1501                     ; 406 void UART2_SmartCardCmd(FunctionalState NewState)
1501                     ; 407 {
1502                     	switch	.text
1503  0268               _UART2_SmartCardCmd:
1507                     ; 409   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1509                     ; 411   if (NewState != DISABLE)
1511  0268 4d            	tnz	a
1512  0269 2706          	jreq	L526
1513                     ; 414     UART2->CR5 |= UART2_CR5_SCEN;
1515  026b 721a5248      	bset	21064,#5
1517  026f 2004          	jra	L726
1518  0271               L526:
1519                     ; 419     UART2->CR5 &= ((uint8_t)(~UART2_CR5_SCEN));
1521  0271 721b5248      	bres	21064,#5
1522  0275               L726:
1523                     ; 421 }
1526  0275 81            	ret
1562                     ; 429 void UART2_SmartCardNACKCmd(FunctionalState NewState)
1562                     ; 430 {
1563                     	switch	.text
1564  0276               _UART2_SmartCardNACKCmd:
1568                     ; 432   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1570                     ; 434   if (NewState != DISABLE)
1572  0276 4d            	tnz	a
1573  0277 2706          	jreq	L746
1574                     ; 437     UART2->CR5 |= UART2_CR5_NACK;
1576  0279 72185248      	bset	21064,#4
1578  027d 2004          	jra	L156
1579  027f               L746:
1580                     ; 442     UART2->CR5 &= ((uint8_t)~(UART2_CR5_NACK));
1582  027f 72195248      	bres	21064,#4
1583  0283               L156:
1584                     ; 444 }
1587  0283 81            	ret
1644                     ; 452 void UART2_WakeUpConfig(UART2_WakeUp_TypeDef UART2_WakeUp)
1644                     ; 453 {
1645                     	switch	.text
1646  0284               _UART2_WakeUpConfig:
1650                     ; 454   assert_param(IS_UART2_WAKEUP_OK(UART2_WakeUp));
1652                     ; 456   UART2->CR1 &= ((uint8_t)~UART2_CR1_WAKE);
1654  0284 72175244      	bres	21060,#3
1655                     ; 457   UART2->CR1 |= (uint8_t)UART2_WakeUp;
1657  0288 ca5244        	or	a,21060
1658  028b c75244        	ld	21060,a
1659                     ; 458 }
1662  028e 81            	ret
1698                     ; 466 void UART2_ReceiverWakeUpCmd(FunctionalState NewState)
1698                     ; 467 {
1699                     	switch	.text
1700  028f               _UART2_ReceiverWakeUpCmd:
1704                     ; 468   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1706                     ; 470   if (NewState != DISABLE)
1708  028f 4d            	tnz	a
1709  0290 2706          	jreq	L717
1710                     ; 473     UART2->CR2 |= UART2_CR2_RWU;
1712  0292 72125245      	bset	21061,#1
1714  0296 2004          	jra	L127
1715  0298               L717:
1716                     ; 478     UART2->CR2 &= ((uint8_t)~UART2_CR2_RWU);
1718  0298 72135245      	bres	21061,#1
1719  029c               L127:
1720                     ; 480 }
1723  029c 81            	ret
1746                     ; 487 uint8_t UART2_ReceiveData8(void)
1746                     ; 488 {
1747                     	switch	.text
1748  029d               _UART2_ReceiveData8:
1752                     ; 489   return ((uint8_t)UART2->DR);
1754  029d c65241        	ld	a,21057
1757  02a0 81            	ret
1791                     ; 497 uint16_t UART2_ReceiveData9(void)
1791                     ; 498 {
1792                     	switch	.text
1793  02a1               _UART2_ReceiveData9:
1795  02a1 89            	pushw	x
1796       00000002      OFST:	set	2
1799                     ; 499   uint16_t temp = 0;
1801                     ; 501   temp = ((uint16_t)(((uint16_t)((uint16_t)UART2->CR1 & (uint16_t)UART2_CR1_R8)) << 1));
1803  02a2 c65244        	ld	a,21060
1804  02a5 5f            	clrw	x
1805  02a6 a480          	and	a,#128
1806  02a8 5f            	clrw	x
1807  02a9 02            	rlwa	x,a
1808  02aa 58            	sllw	x
1809  02ab 1f01          	ldw	(OFST-1,sp),x
1810                     ; 503   return (uint16_t)((((uint16_t)UART2->DR) | temp) & ((uint16_t)0x01FF));
1812  02ad c65241        	ld	a,21057
1813  02b0 5f            	clrw	x
1814  02b1 97            	ld	xl,a
1815  02b2 01            	rrwa	x,a
1816  02b3 1a02          	or	a,(OFST+0,sp)
1817  02b5 01            	rrwa	x,a
1818  02b6 1a01          	or	a,(OFST-1,sp)
1819  02b8 01            	rrwa	x,a
1820  02b9 01            	rrwa	x,a
1821  02ba a4ff          	and	a,#255
1822  02bc 01            	rrwa	x,a
1823  02bd a401          	and	a,#1
1824  02bf 01            	rrwa	x,a
1827  02c0 5b02          	addw	sp,#2
1828  02c2 81            	ret
1862                     ; 511 void UART2_SendData8(uint8_t Data)
1862                     ; 512 {
1863                     	switch	.text
1864  02c3               _UART2_SendData8:
1868                     ; 514   UART2->DR = Data;
1870  02c3 c75241        	ld	21057,a
1871                     ; 515 }
1874  02c6 81            	ret
1908                     ; 522 void UART2_SendData9(uint16_t Data)
1908                     ; 523 {
1909                     	switch	.text
1910  02c7               _UART2_SendData9:
1912  02c7 89            	pushw	x
1913       00000000      OFST:	set	0
1916                     ; 525   UART2->CR1 &= ((uint8_t)~UART2_CR1_T8);                  
1918  02c8 721d5244      	bres	21060,#6
1919                     ; 528   UART2->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART2_CR1_T8); 
1921  02cc 54            	srlw	x
1922  02cd 54            	srlw	x
1923  02ce 9f            	ld	a,xl
1924  02cf a440          	and	a,#64
1925  02d1 ca5244        	or	a,21060
1926  02d4 c75244        	ld	21060,a
1927                     ; 531   UART2->DR   = (uint8_t)(Data);                    
1929  02d7 7b02          	ld	a,(OFST+2,sp)
1930  02d9 c75241        	ld	21057,a
1931                     ; 532 }
1934  02dc 85            	popw	x
1935  02dd 81            	ret
1958                     ; 539 void UART2_SendBreak(void)
1958                     ; 540 {
1959                     	switch	.text
1960  02de               _UART2_SendBreak:
1964                     ; 541   UART2->CR2 |= UART2_CR2_SBK;
1966  02de 72105245      	bset	21061,#0
1967                     ; 542 }
1970  02e2 81            	ret
2004                     ; 549 void UART2_SetAddress(uint8_t UART2_Address)
2004                     ; 550 {
2005                     	switch	.text
2006  02e3               _UART2_SetAddress:
2008  02e3 88            	push	a
2009       00000000      OFST:	set	0
2012                     ; 552   assert_param(IS_UART2_ADDRESS_OK(UART2_Address));
2014                     ; 555   UART2->CR4 &= ((uint8_t)~UART2_CR4_ADD);
2016  02e4 c65247        	ld	a,21063
2017  02e7 a4f0          	and	a,#240
2018  02e9 c75247        	ld	21063,a
2019                     ; 557   UART2->CR4 |= UART2_Address;
2021  02ec c65247        	ld	a,21063
2022  02ef 1a01          	or	a,(OFST+1,sp)
2023  02f1 c75247        	ld	21063,a
2024                     ; 558 }
2027  02f4 84            	pop	a
2028  02f5 81            	ret
2062                     ; 566 void UART2_SetGuardTime(uint8_t UART2_GuardTime)
2062                     ; 567 {
2063                     	switch	.text
2064  02f6               _UART2_SetGuardTime:
2068                     ; 569   UART2->GTR = UART2_GuardTime;
2070  02f6 c7524a        	ld	21066,a
2071                     ; 570 }
2074  02f9 81            	ret
2108                     ; 594 void UART2_SetPrescaler(uint8_t UART2_Prescaler)
2108                     ; 595 {
2109                     	switch	.text
2110  02fa               _UART2_SetPrescaler:
2114                     ; 597   UART2->PSCR = UART2_Prescaler;
2116  02fa c7524b        	ld	21067,a
2117                     ; 598 }
2120  02fd 81            	ret
2277                     ; 606 FlagStatus UART2_GetFlagStatus(UART2_Flag_TypeDef UART2_FLAG)
2277                     ; 607 {
2278                     	switch	.text
2279  02fe               _UART2_GetFlagStatus:
2281  02fe 89            	pushw	x
2282  02ff 88            	push	a
2283       00000001      OFST:	set	1
2286                     ; 608   FlagStatus status = RESET;
2288                     ; 611   assert_param(IS_UART2_FLAG_OK(UART2_FLAG));
2290                     ; 614   if (UART2_FLAG == UART2_FLAG_LBDF)
2292  0300 a30210        	cpw	x,#528
2293  0303 2610          	jrne	L5511
2294                     ; 616     if ((UART2->CR4 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2296  0305 9f            	ld	a,xl
2297  0306 c45247        	and	a,21063
2298  0309 2706          	jreq	L7511
2299                     ; 619       status = SET;
2301  030b a601          	ld	a,#1
2302  030d 6b01          	ld	(OFST+0,sp),a
2304  030f 2039          	jra	L3611
2305  0311               L7511:
2306                     ; 624       status = RESET;
2308  0311 0f01          	clr	(OFST+0,sp)
2309  0313 2035          	jra	L3611
2310  0315               L5511:
2311                     ; 627   else if (UART2_FLAG == UART2_FLAG_SBK)
2313  0315 1e02          	ldw	x,(OFST+1,sp)
2314  0317 a30101        	cpw	x,#257
2315  031a 2611          	jrne	L5611
2316                     ; 629     if ((UART2->CR2 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2318  031c c65245        	ld	a,21061
2319  031f 1503          	bcp	a,(OFST+2,sp)
2320  0321 2706          	jreq	L7611
2321                     ; 632       status = SET;
2323  0323 a601          	ld	a,#1
2324  0325 6b01          	ld	(OFST+0,sp),a
2326  0327 2021          	jra	L3611
2327  0329               L7611:
2328                     ; 637       status = RESET;
2330  0329 0f01          	clr	(OFST+0,sp)
2331  032b 201d          	jra	L3611
2332  032d               L5611:
2333                     ; 640   else if ((UART2_FLAG == UART2_FLAG_LHDF) || (UART2_FLAG == UART2_FLAG_LSF))
2335  032d 1e02          	ldw	x,(OFST+1,sp)
2336  032f a30302        	cpw	x,#770
2337  0332 2707          	jreq	L7711
2339  0334 1e02          	ldw	x,(OFST+1,sp)
2340  0336 a30301        	cpw	x,#769
2341  0339 2614          	jrne	L5711
2342  033b               L7711:
2343                     ; 642     if ((UART2->CR6 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2345  033b c65249        	ld	a,21065
2346  033e 1503          	bcp	a,(OFST+2,sp)
2347  0340 2706          	jreq	L1021
2348                     ; 645       status = SET;
2350  0342 a601          	ld	a,#1
2351  0344 6b01          	ld	(OFST+0,sp),a
2353  0346 2002          	jra	L3611
2354  0348               L1021:
2355                     ; 650       status = RESET;
2357  0348 0f01          	clr	(OFST+0,sp)
2358  034a               L3611:
2359                     ; 668   return  status;
2361  034a 7b01          	ld	a,(OFST+0,sp)
2364  034c 5b03          	addw	sp,#3
2365  034e 81            	ret
2366  034f               L5711:
2367                     ; 655     if ((UART2->SR & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2369  034f c65240        	ld	a,21056
2370  0352 1503          	bcp	a,(OFST+2,sp)
2371  0354 2706          	jreq	L7021
2372                     ; 658       status = SET;
2374  0356 a601          	ld	a,#1
2375  0358 6b01          	ld	(OFST+0,sp),a
2377  035a 20ee          	jra	L3611
2378  035c               L7021:
2379                     ; 663       status = RESET;
2381  035c 0f01          	clr	(OFST+0,sp)
2382  035e 20ea          	jra	L3611
2417                     ; 699 void UART2_ClearFlag(UART2_Flag_TypeDef UART2_FLAG)
2417                     ; 700 {
2418                     	switch	.text
2419  0360               _UART2_ClearFlag:
2421  0360 89            	pushw	x
2422       00000000      OFST:	set	0
2425                     ; 701   assert_param(IS_UART2_CLEAR_FLAG_OK(UART2_FLAG));
2427                     ; 704   if (UART2_FLAG == UART2_FLAG_RXNE)
2429  0361 a30020        	cpw	x,#32
2430  0364 2606          	jrne	L1321
2431                     ; 706     UART2->SR = (uint8_t)~(UART2_SR_RXNE);
2433  0366 35df5240      	mov	21056,#223
2435  036a 201e          	jra	L3321
2436  036c               L1321:
2437                     ; 709   else if (UART2_FLAG == UART2_FLAG_LBDF)
2439  036c 1e01          	ldw	x,(OFST+1,sp)
2440  036e a30210        	cpw	x,#528
2441  0371 2606          	jrne	L5321
2442                     ; 711     UART2->CR4 &= (uint8_t)(~UART2_CR4_LBDF);
2444  0373 72195247      	bres	21063,#4
2446  0377 2011          	jra	L3321
2447  0379               L5321:
2448                     ; 714   else if (UART2_FLAG == UART2_FLAG_LHDF)
2450  0379 1e01          	ldw	x,(OFST+1,sp)
2451  037b a30302        	cpw	x,#770
2452  037e 2606          	jrne	L1421
2453                     ; 716     UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
2455  0380 72135249      	bres	21065,#1
2457  0384 2004          	jra	L3321
2458  0386               L1421:
2459                     ; 721     UART2->CR6 &= (uint8_t)(~UART2_CR6_LSF);
2461  0386 72115249      	bres	21065,#0
2462  038a               L3321:
2463                     ; 723 }
2466  038a 85            	popw	x
2467  038b 81            	ret
2549                     ; 738 ITStatus UART2_GetITStatus(UART2_IT_TypeDef UART2_IT)
2549                     ; 739 {
2550                     	switch	.text
2551  038c               _UART2_GetITStatus:
2553  038c 89            	pushw	x
2554  038d 89            	pushw	x
2555       00000002      OFST:	set	2
2558                     ; 740   ITStatus pendingbitstatus = RESET;
2560                     ; 741   uint8_t itpos = 0;
2562                     ; 742   uint8_t itmask1 = 0;
2564                     ; 743   uint8_t itmask2 = 0;
2566                     ; 744   uint8_t enablestatus = 0;
2568                     ; 747   assert_param(IS_UART2_GET_IT_OK(UART2_IT));
2570                     ; 750   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
2572  038e 9f            	ld	a,xl
2573  038f a40f          	and	a,#15
2574  0391 5f            	clrw	x
2575  0392 97            	ld	xl,a
2576  0393 a601          	ld	a,#1
2577  0395 5d            	tnzw	x
2578  0396 2704          	jreq	L27
2579  0398               L47:
2580  0398 48            	sll	a
2581  0399 5a            	decw	x
2582  039a 26fc          	jrne	L47
2583  039c               L27:
2584  039c 6b01          	ld	(OFST-1,sp),a
2585                     ; 752   itmask1 = (uint8_t)((uint8_t)UART2_IT >> (uint8_t)4);
2587  039e 7b04          	ld	a,(OFST+2,sp)
2588  03a0 4e            	swap	a
2589  03a1 a40f          	and	a,#15
2590  03a3 6b02          	ld	(OFST+0,sp),a
2591                     ; 754   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2593  03a5 7b02          	ld	a,(OFST+0,sp)
2594  03a7 5f            	clrw	x
2595  03a8 97            	ld	xl,a
2596  03a9 a601          	ld	a,#1
2597  03ab 5d            	tnzw	x
2598  03ac 2704          	jreq	L67
2599  03ae               L001:
2600  03ae 48            	sll	a
2601  03af 5a            	decw	x
2602  03b0 26fc          	jrne	L001
2603  03b2               L67:
2604  03b2 6b02          	ld	(OFST+0,sp),a
2605                     ; 757   if (UART2_IT == UART2_IT_PE)
2607  03b4 1e03          	ldw	x,(OFST+1,sp)
2608  03b6 a30100        	cpw	x,#256
2609  03b9 261c          	jrne	L7031
2610                     ; 760     enablestatus = (uint8_t)((uint8_t)UART2->CR1 & itmask2);
2612  03bb c65244        	ld	a,21060
2613  03be 1402          	and	a,(OFST+0,sp)
2614  03c0 6b02          	ld	(OFST+0,sp),a
2615                     ; 763     if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
2617  03c2 c65240        	ld	a,21056
2618  03c5 1501          	bcp	a,(OFST-1,sp)
2619  03c7 270a          	jreq	L1131
2621  03c9 0d02          	tnz	(OFST+0,sp)
2622  03cb 2706          	jreq	L1131
2623                     ; 766       pendingbitstatus = SET;
2625  03cd a601          	ld	a,#1
2626  03cf 6b02          	ld	(OFST+0,sp),a
2628  03d1 2064          	jra	L5131
2629  03d3               L1131:
2630                     ; 771       pendingbitstatus = RESET;
2632  03d3 0f02          	clr	(OFST+0,sp)
2633  03d5 2060          	jra	L5131
2634  03d7               L7031:
2635                     ; 774   else if (UART2_IT == UART2_IT_LBDF)
2637  03d7 1e03          	ldw	x,(OFST+1,sp)
2638  03d9 a30346        	cpw	x,#838
2639  03dc 261c          	jrne	L7131
2640                     ; 777     enablestatus = (uint8_t)((uint8_t)UART2->CR4 & itmask2);
2642  03de c65247        	ld	a,21063
2643  03e1 1402          	and	a,(OFST+0,sp)
2644  03e3 6b02          	ld	(OFST+0,sp),a
2645                     ; 779     if (((UART2->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2647  03e5 c65247        	ld	a,21063
2648  03e8 1501          	bcp	a,(OFST-1,sp)
2649  03ea 270a          	jreq	L1231
2651  03ec 0d02          	tnz	(OFST+0,sp)
2652  03ee 2706          	jreq	L1231
2653                     ; 782       pendingbitstatus = SET;
2655  03f0 a601          	ld	a,#1
2656  03f2 6b02          	ld	(OFST+0,sp),a
2658  03f4 2041          	jra	L5131
2659  03f6               L1231:
2660                     ; 787       pendingbitstatus = RESET;
2662  03f6 0f02          	clr	(OFST+0,sp)
2663  03f8 203d          	jra	L5131
2664  03fa               L7131:
2665                     ; 790   else if (UART2_IT == UART2_IT_LHDF)
2667  03fa 1e03          	ldw	x,(OFST+1,sp)
2668  03fc a30412        	cpw	x,#1042
2669  03ff 261c          	jrne	L7231
2670                     ; 793     enablestatus = (uint8_t)((uint8_t)UART2->CR6 & itmask2);
2672  0401 c65249        	ld	a,21065
2673  0404 1402          	and	a,(OFST+0,sp)
2674  0406 6b02          	ld	(OFST+0,sp),a
2675                     ; 795     if (((UART2->CR6 & itpos) != (uint8_t)0x00) && enablestatus)
2677  0408 c65249        	ld	a,21065
2678  040b 1501          	bcp	a,(OFST-1,sp)
2679  040d 270a          	jreq	L1331
2681  040f 0d02          	tnz	(OFST+0,sp)
2682  0411 2706          	jreq	L1331
2683                     ; 798       pendingbitstatus = SET;
2685  0413 a601          	ld	a,#1
2686  0415 6b02          	ld	(OFST+0,sp),a
2688  0417 201e          	jra	L5131
2689  0419               L1331:
2690                     ; 803       pendingbitstatus = RESET;
2692  0419 0f02          	clr	(OFST+0,sp)
2693  041b 201a          	jra	L5131
2694  041d               L7231:
2695                     ; 809     enablestatus = (uint8_t)((uint8_t)UART2->CR2 & itmask2);
2697  041d c65245        	ld	a,21061
2698  0420 1402          	and	a,(OFST+0,sp)
2699  0422 6b02          	ld	(OFST+0,sp),a
2700                     ; 811     if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
2702  0424 c65240        	ld	a,21056
2703  0427 1501          	bcp	a,(OFST-1,sp)
2704  0429 270a          	jreq	L7331
2706  042b 0d02          	tnz	(OFST+0,sp)
2707  042d 2706          	jreq	L7331
2708                     ; 814       pendingbitstatus = SET;
2710  042f a601          	ld	a,#1
2711  0431 6b02          	ld	(OFST+0,sp),a
2713  0433 2002          	jra	L5131
2714  0435               L7331:
2715                     ; 819       pendingbitstatus = RESET;
2717  0435 0f02          	clr	(OFST+0,sp)
2718  0437               L5131:
2719                     ; 823   return  pendingbitstatus;
2721  0437 7b02          	ld	a,(OFST+0,sp)
2724  0439 5b04          	addw	sp,#4
2725  043b 81            	ret
2761                     ; 852 void UART2_ClearITPendingBit(UART2_IT_TypeDef UART2_IT)
2761                     ; 853 {
2762                     	switch	.text
2763  043c               _UART2_ClearITPendingBit:
2765  043c 89            	pushw	x
2766       00000000      OFST:	set	0
2769                     ; 854   assert_param(IS_UART2_CLEAR_IT_OK(UART2_IT));
2771                     ; 857   if (UART2_IT == UART2_IT_RXNE)
2773  043d a30255        	cpw	x,#597
2774  0440 2606          	jrne	L1631
2775                     ; 859     UART2->SR = (uint8_t)~(UART2_SR_RXNE);
2777  0442 35df5240      	mov	21056,#223
2779  0446 2011          	jra	L3631
2780  0448               L1631:
2781                     ; 862   else if (UART2_IT == UART2_IT_LBDF)
2783  0448 1e01          	ldw	x,(OFST+1,sp)
2784  044a a30346        	cpw	x,#838
2785  044d 2606          	jrne	L5631
2786                     ; 864     UART2->CR4 &= (uint8_t)~(UART2_CR4_LBDF);
2788  044f 72195247      	bres	21063,#4
2790  0453 2004          	jra	L3631
2791  0455               L5631:
2792                     ; 869     UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
2794  0455 72135249      	bres	21065,#1
2795  0459               L3631:
2796                     ; 871 }
2799  0459 85            	popw	x
2800  045a 81            	ret
2813                     	xdef	_UART2_ClearITPendingBit
2814                     	xdef	_UART2_GetITStatus
2815                     	xdef	_UART2_ClearFlag
2816                     	xdef	_UART2_GetFlagStatus
2817                     	xdef	_UART2_SetPrescaler
2818                     	xdef	_UART2_SetGuardTime
2819                     	xdef	_UART2_SetAddress
2820                     	xdef	_UART2_SendBreak
2821                     	xdef	_UART2_SendData9
2822                     	xdef	_UART2_SendData8
2823                     	xdef	_UART2_ReceiveData9
2824                     	xdef	_UART2_ReceiveData8
2825                     	xdef	_UART2_ReceiverWakeUpCmd
2826                     	xdef	_UART2_WakeUpConfig
2827                     	xdef	_UART2_SmartCardNACKCmd
2828                     	xdef	_UART2_SmartCardCmd
2829                     	xdef	_UART2_LINCmd
2830                     	xdef	_UART2_LINConfig
2831                     	xdef	_UART2_LINBreakDetectionConfig
2832                     	xdef	_UART2_IrDACmd
2833                     	xdef	_UART2_IrDAConfig
2834                     	xdef	_UART2_ITConfig
2835                     	xdef	_UART2_Cmd
2836                     	xdef	_UART2_Init
2837                     	xdef	_UART2_DeInit
2838                     	xref	_CLK_GetClockFreq
2839                     	xref.b	c_lreg
2840                     	xref.b	c_x
2859                     	xref	c_lursh
2860                     	xref	c_lsub
2861                     	xref	c_smul
2862                     	xref	c_ludv
2863                     	xref	c_rtol
2864                     	xref	c_llsh
2865                     	xref	c_ltor
2866                     	end
