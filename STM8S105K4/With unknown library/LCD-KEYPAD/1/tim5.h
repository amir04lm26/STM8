#ifndef __tim5_h
#define __tim5_h

#include "stm8s.h"

//����жϱ�־
#define TIM5_UIF_CLR()  TIM5->SR1 &= ~TIM5_SR1_UIF
#define TIM5_IntEnable()    TIM5->IER |= TIM5_IER_UIE    //Interrupt Enable
#define TIM5_IntDisable()   TIM5->IER &= ~TIM5_IER_UIE   //�ض�ʱ���ж�
#define TIM5_IntStatus()    (TIM5->IER & TIM5_IER_UIE)    //��ʱ���ж�״̬�������ж�һ����ʾˢ���Ƿ����

void TIM5_Init(void);


#endif /* __tim5_h */