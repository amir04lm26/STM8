#include "beep.h"

//ֱ����LSI 128KHz��Ϊʱ��Դ��δУ׼��
void BEEP_Init(void)
{
	CLK->PCKENR2 |= CLK_PCKENR2_AWU;	//����ʱ��Դ(�Ƚ��ر�)
	BEEP->CSR = BEEP_CSR_RESET_VALUE;
	BEEP->CSR = 0x0f;								//BeepDiv=16
	BEEP->CSR |= BEEP_CSR_BEEPSEL;	//0xC0ѡ��4kHz
	//BEEP->CSR |= 0x40;							//0x40ѡ��2kHz
	//BEEP->CSR |= 0x00;							//0x00ѡ��1kHz
	//BEEP-> CSR = 0x98;//DIV  f=2.6KHz
}

/*
void BEEP_On(void)
{
	BEEP->CSR |= BEEP_CSR_BEEPEN;		//ʹ�ܷ���������
}

void BEEP_Off(void)
{
	BEEP->CSR &= ~BEEP_CSR_BEEPEN;	//��ֹ����������	
}
*/