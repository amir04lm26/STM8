#include "adc1.h"

//ͨ��4,5��4MHz��ʱ��Դ��һ��ת��14��ʱ�����ڣ�3.5us
void ADC1_Init(void)
{
	CLK->PCKENR2 |= CLK_PCKENR2_ADC;	//ADC Clock Enable
	ADC1->TDRL |= ADC1_TDRL_DEF;	//���ö�ӦADͨ����ʩ���ش�����
	ADC1->CR2 &= ~ADC1_CR2_ALIGN;				//�������룬��ֻ��ȡ�߰�λ
	ADC1->CR1 |= (0x20 | ADC1_CR1_ADON);	//ʱ��4��Ƶ������ADC1��Դ
  //��ʱĬ�ϻῪ��ͨ��0(PB0)����PB0����Ϊ���������������Ч��ֱ���л�ͨ��
	ADC1->CSR = CH_TEMP;								//ѡ����һͨ������ֹPB0�����ʱ������
}

void ADC1_Start(u8 channel)
{
	ADC1->CSR = channel;								//ѡ��ͨ��
	ADC1->CR1 |= ADC1_CR1_ADON;				//����ADC1��ʼת��
}

u8 ADC1_GetValue(void)
{
	u8 data;
	while(!(ADC1->CSR & ADC1_CSR_EOC));//�ȴ�ת������   14��ʱ������
	ADC1->CSR &= ~ADC1_CSR_EOC;				//������־λ����
	data = ADC1->DRH;
	return data;
}
