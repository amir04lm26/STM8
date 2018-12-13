/**
 * @file:   common.h
 * @brief:  SENHE Plant Wall Project Hardware definition
 * @author: Eric Yu
 * @date:   2012-11-26
 */
/*
2012-11-26 Eric Yu
  ����Ӳ�����Ŷ������Դ����
*/

#ifndef __common_h
#define __common_h

#define HW_V1 0
#define HW_V2 1
#define HW_Ver  HW_V2 // Ӳ���汾

#define WATER_LOW_RESTORE   1   // ˮλ���͹��Ϻ�ָ�ԭ������״̬������ʱ��

#include "stm8s.h"
#include "iwdg.h"
//#include "spi.h"
#include "beep.h"
#include "tim6.h"
#include "tim5.h"
#include "eeprom.h"
//#include "i2c.h"

//�õ����ж��ڴ˶�������
extern @far @interrupt void TIME_BASE_IRQ(void);
extern @far @interrupt void TIM5_UPD_IRQ(void);
//extern @far @interrupt void I2C_Slave_IRQ(void);
//extern @far @interrupt void UART1_TX_IRQ(void);

#define TIM6_UPD_OVF_TRG_IRQHandler     TIME_BASE_IRQ
#define TIM5_UPD_OVF_BRK_TRG_IRQHandler     TIM5_UPD_IRQ
//#define I2C_IRQHandler    I2C_Slave_IRQ
//#define UART1_TX_IRQHandler    UART1_TX_IRQ

#define Bit0      ((u8)0x01)
#define Bit1      ((u8)0x02)
#define Bit2      ((u8)0x04)
#define Bit3      ((u8)0x08)
#define Bit4      ((u8)0x10)
#define Bit5      ((u8)0x20)
#define Bit6      ((u8)0x40)
#define Bit7      ((u8)0x80)

//�˿ں궨��
//GPIOA
#define WATER_FULL  Bit1      // ��ˮλ����
#define WATER_LOW   Bit2      // ��ˮλ����
#define PA3       Bit3        // ��������
#define WaterLow_In()      (GPIOA->IDR & WATER_LOW)          //��ˮλ����״̬����
#define WaterFull_In()  (GPIOA->IDR & WATER_FULL)          //ˮ������״̬����

//GPIOB
#define LIGHT     Bit7        // �����
#define FAN       Bit6        // ����
#define PB5       Bit5        //��������
#define PB4       Bit4        //��������
#define FAN_Enable()  GPIOB->ODR |= FAN
#define FAN_Disable()  GPIOB->ODR &= ~FAN
#define LIGHT_Enable()  GPIOB->ODR |= LIGHT
#define LIGHT_Disable()  GPIOB->ODR &= ~LIGHT

// ʪ�ȴ������������
#define TEMPADIn  Bit3				//�¶�AD�˿�PB3(AIN3)
#define HUMIADIn  Bit2				//ʪ��AD�˿�PB2(AIN2)
#define A1En      Bit0				//A1ʹ�� �Ӵ�������
#define A2En      Bit1				//A2ʹ�� �ӹ̶������
#define MASK      (A1En|A2En)
#define HUMI_PORT   GPIOB->ODR
#define A1_High()   HUMI_PORT |= A1En						//A1�ø�
#define A1_Low()    HUMI_PORT &= ~A1En						//A1�õ�
#define A2_High()   HUMI_PORT |= A2En						//A2�ø�
#define A2_Low()    HUMI_PORT &= ~A2En						//A2�õ�
#define SE_Disable()  HUMI_PORT &= ~MASK					//Sensor Excitation Disable

#define CH_TEMP  3    //�¶Ȳ���ͨ��
#define CH_HUMI  2    //ʪ�Ȳ���ͨ��
#define ADC1_TDRL_DEF ((1<<CH_TEMP)|(1<<CH_HUMI))

//GPIOC
#define SEG_PORT  GPIOC->ODR  // PC��

#define SEG_MASK    0xfe  // P7~P1
#define SEG_AllDirIn()   GPIOC->DDR &= ~SEG_MASK  // ��ѡ�˿�ȫ����Ϊ����
#define SEG_AllDirOut()   GPIOC->DDR |= SEG_MASK  // ��ѡ�˿�ȫ����Ϊ���
#define SEG_DirOut(i)     GPIOC->DDR |= i        // ĳһ��ѡ�˿���Ϊ���
#define SEG_AllRuEn()     GPIOC->CR1 |= SEG_MASK    // ������������ʹ��
#define SEG_In()        (GPIOC->IDR & SEG_MASK)     // ��ȡ����ֵ
//GPIOE
#define PE5         Bit5        //��������


//GPIOD
#define KEY_IN      Bit7				// ��������
#define COM5        Bit0        // ��ʾ������ ָʾ��
#define COM4        Bit3        // ��ʾ������ �����2��λ
#define COM3        Bit5        // ��ʾ������ �����2ʮλ
#define COM2        Bit2				// ��ʾ������ �����1��λ
#define COM1        Bit6				// ��ʾ������ �����1ʮλ

#define COM_MASK    (COM1 | COM2 | COM3 | COM4 | COM5)
#define COM_PORT    GPIOD->ODR  // PD��
//#define LED_Enable()  COM_PORT &= ~COM_MASK  //��ʾʹ��
#define LED_Disable()  COM_PORT |= COM_MASK  //��ʾ�رգ��ߵ�ƽ�ر�

#define KEY_In()      (GPIOD->IDR & KEY_IN)          // ����״̬����
#define KEY_DirIn()   GPIOD->DDR &= ~KEY_IN   // ����Ϊ����
#define KEY_DirOut()   GPIOD->DDR |= KEY_IN   // ����Ϊ���
#define KEY_High()    GPIOD->ODR |= KEY_IN    // ����ߵ�ƽ
#define KEY_Low()    GPIOD->ODR &= ~KEY_IN    // ����͵�ƽ

//GPIOF
#define PUMP      Bit4        // ˮ��
#define PUMP_Enable()  GPIOF->ODR |= PUMP
#define PUMP_Disable()  GPIOF->ODR &= ~PUMP


#define FsysMHz      16        //ϵͳʱ��MHz

//�ڲ�EEPROM����洢�����׵�ַ
#define  DATA_SAVE_ADD    0x4000      

// ������ʪ�ȴ�������ַ
#define RHI_ADDR    0xA6        //������������ַ
#define HumiAddr    0x18        //ʪ�����ݵ�Ԫ��ַ
#define TempAddr    0x0a        //�¶����ݵ�Ԫ��ַ

// ����ʪ�ȴ�����ֵ�߽綨��
#define HUMI_MIN  10    //10%
#define HUMI_MAX  99    //99%

// �¶ȴ�����ADֵ�߽綨��
#define TEMP_AD_MIN	(u8)9	 	//-40��
#define TEMP_AD_MAX	(u8)220	 	//80��

// ʪ�ȴ�����ADֵ�߽綨��
#define HUMI_AD_MIN (u8)6  // ��·
#define HUMI_AD_MAX (u8)254 // ��·

void Delay_1us(void);
void Delay_Nus(u16 Cnt);
void Delay_1ms(void);
void Delay_Nms(u16 Cnt);
s8 GetCoilValue(u8 AdValue);//����ADֵ��ȡ�̹��¶�ֵ
s8 GetExhaValue(u8 AdValue);//����ADֵ��ȡ�����¶�ֵ
u8 GetAverage(u8 *p);//��ȡ������6������ƽ��ֵ(ȥ����ֵ��4ƽ��)
u8 CheckSum(u8 * pBuf, u8 n);
s8 GetTempValue(u8 I2cData);
u8 GetHumiValue(u8 I2cData);
void CLK_Config(void);
void IO_Init(void);

#endif /* __common_h */
