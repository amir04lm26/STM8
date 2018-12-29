	/**
  ******************************************************************************
  * @file     stm8s_it.c
  * @author   MCD Application Team
  * @version  V2.0.4
  * @date     26-April-2018
  * @brief    Main Interrupt Service Routines.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */ 

/* Includes ------------------------------------------------------------------*/
#include "stm8s_it.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/* Public functions ----------------------------------------------------------*/

/* @addtogroup EXTI_InterruptPriority*/

extern unsigned char pos;
extern unsigned char data[16];
/*int temp;
char tmp;*/
void UART_RX_IRQHandler(void)
{
	/*temp = UART2_ReceiveData8();
	tmp= (char)UART2_ReceiveData8();*/
	data[pos] = UART2_ReceiveData8();
	UART2_ClearITPendingBit(UART2_IT_RXNE);
  UART2_ClearFlag(UART2_FLAG_RXNE);
	UART2_SendData8(data[pos]);
	UART2_ClearFlag(UART2_FLAG_TXE);
	pos++;
  if(pos > 15)
  {
    pos = 0;
  }
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
