#include "iwdg.h"

//���ó�20ms��ʱ��λ����LSI/2��64��Ƶ��������RL[7:0]=20
void IWDG_Init(void)
{
	IWDG->KR = KEY_ACCESS;		//���д����
	//IWDG->PR = 4;							//64��Ƶ��ÿ��1ms
	IWDG->PR = 6;							//256��Ƶ��ÿ��4ms
	//IWDG->RLR = 20;						//��װ�ؼĴ�����20ms
	IWDG->RLR = 255;						//��װ�ؼĴ�����1.02s
	IWDG->KR = KEY_REFRESH;		//�ָ�д����
	IWDG->KR = KEY_ENABLE;		//�������Ź�
}

/*
void IWDG_Refresh(void)
{
	IWDG->KR = KEY_REFRESH;		//ˢ�¼���ֵ
}
*/