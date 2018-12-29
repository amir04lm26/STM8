void setup(void);
void clock_setup(void);
void USART_setup(void);
void USART_send(char *USART_string);

unsigned char pos;
unsigned char data[16] = {0};