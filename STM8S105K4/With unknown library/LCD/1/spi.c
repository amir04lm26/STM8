#include "spi.h"

//���ó�ֻ������ģʽ���������ſ�����Ϊ��ͨIO��ʹ��
void SPI_Init(void)
{
	CLK->PCKENR1 |= CLK_PCKENR1_SPI;	//SPI Clock Enable
	SPI->CR1 = SPI_CR1_RESET_VALUE;
	SPI->CR2 = SPI_CR2_RESET_VALUE;
	//SPI->CR1 |= SPI_CR1_BR & 0x00;		//������ΪFmaster��2��Ƶ
	//SPI->CR1 |= (SPI_CR1_BR & 0x08);		//������ΪFmaster��4��Ƶ
	SPI->CR1 |= (SPI_CR1_BR & 0x20);		//������ΪFmaster��32��Ƶ 500K
	//SPI->CR1 |= (SPI_CR1_BR & 0x30);		//������ΪFmaster��128��Ƶ 125K
	//SPI->CR1 |= (SPI_CR1_BR & 0x38);		//������ΪFmaster��256��Ƶ 62.5K
	SPI->CR1 |= SPI_CR1_MSTR;					//����Ϊ���豸
	//SPI->CR1 |= SPI_CR1_CPOL;					//Clock Polarity
	//SPI->CR1 |= SPI_CR1_CPHA;					//Clock Phase
  //SPI->CR1 |= SPI_CR1_LSBFIRST;     //�ȷ��͵�λ
  SPI->CR2 |= SPI_CR2_SSM;					//������豸��������NSS�ܽ��������
	SPI->CR2 |= SPI_CR2_SSI;					//�ڲ�ѡ��Ϊ��ģʽ
	
	SPI->CR1 |= SPI_CR1_SPE;					//SPI Enable 
}

u8 SPI_SendByte(u8 Data)
{
	/* Write in the DR register the data to be sent*/
  SPI->DR = Data; 
  /* �ȴ����ݴ������ */
  while(!(SPI->SR & SPI_SR_RXNE));
  /* ��DR�Ĵ��������RXNE��־ */
  return (SPI->DR); 
}