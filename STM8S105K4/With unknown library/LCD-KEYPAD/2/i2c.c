#include "i2c.h"
#include "sys_ctrl.h"

//I2C����MCUΪ��׼ģʽ����������100KHz��
void I2C_Init(void)
{
	CLK->PCKENR1 |= CLK_PCKENR1_I2C;	//I2C clock Enable
	I2C->FREQR = FsysMHz;							//����ʱ��Ƶ�� FsysMHz
	/* �ڲ�ʱ�ӷ�Ƶ���� */
	I2C->CR1 &= ~I2C_CR1_PE;					//disable I2C	to config TRISE
	I2C->TRISER = FsysMHz + 1;			//�������ʱ������1000ns
	I2C->CCRL = (u8)(FsysMHz*5);			//��FsysMHz*5���CCR
	I2C->CCRH = (u8)(FsysMHz>>8);
	I2C->CCRH &= ~I2C_CCRH_FS;				//ѡ��Ϊ��׼ģʽ100KHz
	I2C->CR1 |= I2C_CR1_PE;					//Enable I2C
	I2C->CR2 |= I2C_CR2_ACK;				//Ӧ��ʹ��
	I2C->CR2 &= ~I2C_CR2_POS;				//Ӧ��ǰ�ֽ�
	I2C->OARL =	WSD_ADD;								//�ӵ�ַ���ã�7λ�ӵ�ַ
	I2C->OARH |= I2C_OARH_ADDCONF;	//��ַģʽ���ã��������ó�1 
  I2C->ITR |= (I2C_ITR_ITEVTEN | I2C_ITR_ITBUFEN);//�����¼��жϺͻ����ж�
}

//I2C�ӻ��ж�
@far @interrupt void I2C_Slave_IRQ(void)
{
  static u8 DataReceived;
  u8 Event = I2C->SR1;
  
  if (Event & I2C_SR1_ADDR)//EV1�ӵ�ַƥ��ɹ�
  {
    if (I2C->SR3 & I2C_SR3_TRA)    //��SR3���EV1,�������ӷ���ģʽ
    {
      switch (DataReceived)
      {
        case HumiAddr:
          I2C->DR = I2CHumiValue;
          break;
        case TempAddr:
          I2C->DR = I2CTempValue;
          break;
        default:
          I2C->DR = 0;
          break;
      }
    }
  }
  else if (Event & I2C_SR1_RXNE)//EV2���յ�����
  {
    DataReceived = I2C->DR; //��ȡ���ݣ�ͬʱ���EV2
  }
  else if (Event & I2C_SR1_STOPF)//EV4���յ�ֹͣλ
  {
    I2C->CR2 = I2C->CR2;    //дCR2�Ĵ��������EV4
  }
  else if (Event & I2C_SR1_TXE)//EV3���ݷ�����ɲ����յ�Ӧ��
  {
    I2C->DR = 0; //�����������ݣ�ͬʱ���EV3������Ϊ0
  }
}

/* end of file */
