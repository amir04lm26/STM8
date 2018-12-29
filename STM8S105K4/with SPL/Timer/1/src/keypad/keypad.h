#ifndef _KEYPAD_H
#define _KEYPAD_H

#include "stm8s.h"
#include "delay.h"

#define Keypad_Port	GPIOC
#define loop 1
#define R1 GPIO_PIN_0
#define R2 GPIO_PIN_1
#define R3 GPIO_PIN_2
#define R4 GPIO_PIN_3
#define c1 GPIO_PIN_4
#define c2 GPIO_PIN_5
#define c3 GPIO_PIN_6
#define c4 GPIO_PIN_7
#define c1_ch !(GPIO_ReadInputPin(Keypad_Port, c1))
#define c2_ch !(GPIO_ReadInputPin(Keypad_Port, c2))
#define c3_ch !(GPIO_ReadInputPin(Keypad_Port, c3))
#define c4_ch !(GPIO_ReadInputPin(Keypad_Port, c4))

unsigned int keypad_press (void);

#endif