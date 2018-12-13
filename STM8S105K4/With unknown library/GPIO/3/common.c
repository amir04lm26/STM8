#include "common.h"

//�����ʱ(16Mϵͳʱ��ǰ���£����Ϻ�������ʱ���Լ1us)
void Delay_1us(void)
{
	nop();
}

void Delay_Nus(u16 Cnt)
{
  while (Cnt--)
  {
    Delay_1us();
  }  
}

//�����ʱ(16Mϵͳʱ��ǰ���£���Լ1ms)
void Delay_1ms(void)
{
	u16 i = 1167;
	while (i--);
}

void Delay_Nms(u16 Cnt)
{
  while (Cnt--)
  {
    Delay_1ms();
  }  
}

//��������ָ��ǰn������У��� (n < 256)
u8 CheckSum(u8 * pBuf, u8 n)
{
  u8 Sum = 0;
  
  while(n--)
  {
    Sum += *(pBuf++);
  }
  return ((Sum ^ 0xff) + 1);
}

//��ȡ������6������ƽ��ֵ(ȥ����ֵ��4ƽ��)
u8 GetAverage(u8 *p)
{
  u8 i = 6;
  u8 dat;
  u8 Max = 0;
  u8 Min = 255;
  u16 Sum = 0;
  
  while (i--)
  {
    dat = *(p+i);
    if (dat > Max)
    {
      Max = dat;
    }
    if (dat < Min)
    {
      Min = dat;
    }
    Sum += dat;
  }
  Sum -= Min;   //ȥ����Сֵ
  Sum -= Max;   //ȥ�����ֵ
  Sum /= 4;     //ȡƽ��ֵ
  return (u8)Sum;
}

void CLK_Config(void)
{
  /* ʱ������ */
  CLK->ICKR = CLK_ICKR_HSIEN;  //�ڲ�����ʱ��ʹ��
  CLK->CKDIVR = 0;            //�ڲ�ʱ��16MHz��CPUʱ���޷�Ƶ
  //CLK->CKDIVR = 0x10;            //�ڲ�ʱ��4MHz��CPUʱ���޷�Ƶ
  CLK->PCKENR1 = 0;            //��ֹ����ʱ��
  CLK->PCKENR2 = 0;            //��ֹ����ʱ��
  
  //CLK->ICKR |= CLK_ICKR_LSIEN;  //LSIʹ��(����Ҫ����LSI��ָ��Ϊ��ʱ��Դ/CCOʱ��Դ/AWU/IWDG��ʱ��Դʱ����λ���ܱ����)
}

void IO_Init(void)
{
  /* ȫ�����üĴ��� */
  //CFG->GCR |= CFG_GCR_SWD;  //����SWIM����(PD1)
  
  /* �˿����ã��ս������©�͵�ƽ����ǿ���������� */
  GPIOA->ODR = 0;        // ����͵�ƽ
  GPIOA->DDR = PA3;        //�ս����
  GPIOA->CR1 = 0;                //�ս������©
  //GPIOA->CR2 = 0;
  
  GPIOB->ODR = 0;  // ����͵�ƽ
  GPIOB->DDR = FAN| LIGHT |A1En|A2En|PB5|PB4;  //I2C�����
  GPIOB->CR1 = FAN| LIGHT |A1En|A2En;          //�������
  //GPIOB->CR2 = 0;
  
  GPIOC->ODR = SEG_MASK;      //���Ϊ�ߵ�ƽ
  GPIOC->DDR = SEG_MASK;      //���
  GPIOC->CR1 = SEG_MASK;          //�������
  //GPIOC->CR2 = 0;
  //GPIOC->CR2 |= Bit6 | Bit5;  //SPI�ӿڿ��ٰ���
  
  GPIOD->ODR = COM_MASK;              //���Ϊ�ߵ�ƽ
  GPIOD->DDR = COM_MASK;              //��������������
  GPIOD->CR1 = COM_MASK;          //������죬�������������
  //GPIOD->CR2 = 0;
  
  GPIOE->ODR = 0;              //���Ϊ�͵�ƽ
  GPIOE->DDR = PE5;              //���
  GPIOE->CR1 = 0;                //�����©
  //GPIOE->CR2 = 0;
  
  GPIOF->ODR = 0;              //���Ϊ�͵�ƽ
  GPIOF->DDR = PUMP;              //���
  GPIOF->CR1 = PUMP;                //�������
  //GPIOF->CR2 = 0;
}

/* end of file */