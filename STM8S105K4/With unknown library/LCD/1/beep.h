#ifndef __beep_h
#define __beep_h

#include "stm8s.h"

//ʹ�ܷ���������
#define BEEP_On()		BEEP->CSR |= BEEP_CSR_BEEPEN
//��ֹ����������
#define BEEP_Off()	BEEP->CSR &= ~BEEP_CSR_BEEPEN


/**************************************
CSR[7:6] :����Ƶ��ѡ�� 
00: ���fLS/(8 x BEEPDIV) kHz  
01: ���fLS/(4 x BEEPDIV) kHz  
1x: ���fLS/(2 x BEEPDIV) kHz 
***************************************/
//������Ƶ��ѡ��
#define BEEP_4KHz()	BEEP->CSR |= Bit7
#define BEEP_2KHz()	BEEP->CSR |= Bit6;BEEP->CSR &= ~Bit7
#define BEEP_1KHz()	BEEP->CSR &= ~(Bit7|Bit6)

void BEEP_Init(void);
/*
void BEEP_On(void);
void BEEP_Off(void);
*/

#endif /* __beep_h */