#include <stdint.h>

/* We'll be using the serial interface to print on the console (qemu)
 * For this, we write to the UART. 
 * Refer: http://www.ti.com/lit/ds/symlink/lm3s6965.pdf Table 2-8
 * for the mapping of UART devices (including UART0)
 */

// #define LM3S6965_UART0 (*(volatile uint8_t *)0x4000C000)
volatile unsigned int * lm3s6965_uart0 = (unsigned int*)0x4000C000;

// Some Variable of different data types :
const char *start_msg3 = "Hi This is Demo For Map File\r\n";
const int DataInt = 10;
const char DataChar = 'C';
char DataArry[12];
static int DataStaticInt = 100;

void uart0_print(const char* msg);

void main(void)
{
    const char *start_msg = "Hello, World!\r\n";
    const char *start_msg2 = "First Bare-Metal Program ARM :)\r\n";

    uart0_print(start_msg);
    uart0_print(start_msg2);
    
    while(1);
}

void uart0_print(const char* msg)
{
    while(*msg)
    {
        *lm3s6965_uart0 = *msg;
        msg++;
    }
}
