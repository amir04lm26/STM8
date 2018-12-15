   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  43                     ; 54 void BEEP_DeInit(void)
  43                     ; 55 {
  45                     	switch	.text
  46  0000               _BEEP_DeInit:
  50                     ; 56   BEEP->CSR = BEEP_CSR_RESET_VALUE;
  52  0000 351f50f3      	mov	20723,#31
  53                     ; 57 }
  56  0004 81            	ret
 121                     ; 67 void BEEP_Init(BEEP_Frequency_TypeDef BEEP_Frequency)
 121                     ; 68 {
 122                     	switch	.text
 123  0005               _BEEP_Init:
 125  0005 88            	push	a
 126       00000000      OFST:	set	0
 129                     ; 70   assert_param(IS_BEEP_FREQUENCY_OK(BEEP_Frequency));
 131                     ; 73   if ((BEEP->CSR & BEEP_CSR_BEEPDIV) == BEEP_CSR_BEEPDIV)
 133  0006 c650f3        	ld	a,20723
 134  0009 a41f          	and	a,#31
 135  000b a11f          	cp	a,#31
 136  000d 2610          	jrne	L15
 137                     ; 75     BEEP->CSR &= (uint8_t)(~BEEP_CSR_BEEPDIV); /* Clear bits */
 139  000f c650f3        	ld	a,20723
 140  0012 a4e0          	and	a,#224
 141  0014 c750f3        	ld	20723,a
 142                     ; 76     BEEP->CSR |= BEEP_CALIBRATION_DEFAULT;
 144  0017 c650f3        	ld	a,20723
 145  001a aa0b          	or	a,#11
 146  001c c750f3        	ld	20723,a
 147  001f               L15:
 148                     ; 80   BEEP->CSR &= (uint8_t)(~BEEP_CSR_BEEPSEL);
 150  001f c650f3        	ld	a,20723
 151  0022 a43f          	and	a,#63
 152  0024 c750f3        	ld	20723,a
 153                     ; 81   BEEP->CSR |= (uint8_t)(BEEP_Frequency);
 155  0027 c650f3        	ld	a,20723
 156  002a 1a01          	or	a,(OFST+1,sp)
 157  002c c750f3        	ld	20723,a
 158                     ; 82 }
 161  002f 84            	pop	a
 162  0030 81            	ret
 217                     ; 91 void BEEP_Cmd(FunctionalState NewState)
 217                     ; 92 {
 218                     	switch	.text
 219  0031               _BEEP_Cmd:
 223                     ; 93   if (NewState != DISABLE)
 225  0031 4d            	tnz	a
 226  0032 2706          	jreq	L101
 227                     ; 96     BEEP->CSR |= BEEP_CSR_BEEPEN;
 229  0034 721a50f3      	bset	20723,#5
 231  0038 2004          	jra	L301
 232  003a               L101:
 233                     ; 101     BEEP->CSR &= (uint8_t)(~BEEP_CSR_BEEPEN);
 235  003a 721b50f3      	bres	20723,#5
 236  003e               L301:
 237                     ; 103 }
 240  003e 81            	ret
 293                     .const:	section	.text
 294  0000               L41:
 295  0000 000003e8      	dc.l	1000
 296                     ; 118 void BEEP_LSICalibrationConfig(uint32_t LSIFreqHz)
 296                     ; 119 {
 297                     	switch	.text
 298  003f               _BEEP_LSICalibrationConfig:
 300  003f 5206          	subw	sp,#6
 301       00000006      OFST:	set	6
 304                     ; 124   assert_param(IS_LSI_FREQUENCY_OK(LSIFreqHz));
 306                     ; 126   lsifreqkhz = (uint16_t)(LSIFreqHz / 1000); /* Converts value in kHz */
 308  0041 96            	ldw	x,sp
 309  0042 1c0009        	addw	x,#OFST+3
 310  0045 cd0000        	call	c_ltor
 312  0048 ae0000        	ldw	x,#L41
 313  004b cd0000        	call	c_ludv
 315  004e be02          	ldw	x,c_lreg+2
 316  0050 1f03          	ldw	(OFST-3,sp),x
 317                     ; 130   BEEP->CSR &= (uint8_t)(~BEEP_CSR_BEEPDIV); /* Clear bits */
 319  0052 c650f3        	ld	a,20723
 320  0055 a4e0          	and	a,#224
 321  0057 c750f3        	ld	20723,a
 322                     ; 132   A = (uint16_t)(lsifreqkhz >> 3U); /* Division by 8, keep integer part only */
 324  005a 1e03          	ldw	x,(OFST-3,sp)
 325  005c 54            	srlw	x
 326  005d 54            	srlw	x
 327  005e 54            	srlw	x
 328  005f 1f05          	ldw	(OFST-1,sp),x
 329                     ; 134   if ((8U * A) >= ((lsifreqkhz - (8U * A)) * (1U + (2U * A))))
 331  0061 1e05          	ldw	x,(OFST-1,sp)
 332  0063 58            	sllw	x
 333  0064 58            	sllw	x
 334  0065 58            	sllw	x
 335  0066 1f01          	ldw	(OFST-5,sp),x
 336  0068 1e03          	ldw	x,(OFST-3,sp)
 337  006a 72f001        	subw	x,(OFST-5,sp)
 338  006d 1605          	ldw	y,(OFST-1,sp)
 339  006f 9058          	sllw	y
 340  0071 905c          	incw	y
 341  0073 cd0000        	call	c_imul
 343  0076 1605          	ldw	y,(OFST-1,sp)
 344  0078 9058          	sllw	y
 345  007a 9058          	sllw	y
 346  007c 9058          	sllw	y
 347  007e bf00          	ldw	c_x,x
 348  0080 90b300        	cpw	y,c_x
 349  0083 250c          	jrult	L331
 350                     ; 136     BEEP->CSR |= (uint8_t)(A - 2U);
 352  0085 7b06          	ld	a,(OFST+0,sp)
 353  0087 a002          	sub	a,#2
 354  0089 ca50f3        	or	a,20723
 355  008c c750f3        	ld	20723,a
 357  008f 2009          	jra	L531
 358  0091               L331:
 359                     ; 140     BEEP->CSR |= (uint8_t)(A - 1U);
 361  0091 7b06          	ld	a,(OFST+0,sp)
 362  0093 4a            	dec	a
 363  0094 ca50f3        	or	a,20723
 364  0097 c750f3        	ld	20723,a
 365  009a               L531:
 366                     ; 142 }
 369  009a 5b06          	addw	sp,#6
 370  009c 81            	ret
 383                     	xdef	_BEEP_LSICalibrationConfig
 384                     	xdef	_BEEP_Cmd
 385                     	xdef	_BEEP_Init
 386                     	xdef	_BEEP_DeInit
 387                     	xref.b	c_lreg
 388                     	xref.b	c_x
 407                     	xref	c_imul
 408                     	xref	c_ludv
 409                     	xref	c_ltor
 410                     	end
