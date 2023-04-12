all: system.bin

startup.o: startup.c
	arm-none-eabi-gcc -c -g -mcpu=cortex-m3 -mthumb -o startup.o startup.c

main.o: main.c
	arm-none-eabi-gcc -c -g -mcpu=cortex-m3 -mthumb -o main.o main.c

startup.elf: startup.o main.o
	arm-none-eabi-ld -T linker.ld -o startup.elf startup.o main.o

system.bin: startup.elf
	arm-none-eabi-objcopy -O binary startup.elf system.bin

run: system.bin
	qemu-system-arm -M lm3s6965evb -kernel system.bin -nographic -monitor telnet:127.0.0.1:3456,server,nowait 

rundbg: system.bin
	qemu-system-arm -S -M lm3s6965evb -kernel system.bin -gdb tcp::5678 -nographic -monitor telnet:127.0.0.1:1234,server,nowait 

clean:
	rm -f *.o *.elf *.bin

map:
	arm-none-eabi-ld -Map output.map -T linker.ld  -o output.elf  startup.o main.o 

dump: 
	arm-none-eabi-nm -n startup.o
	arm-none-eabi-objdump -h startup.o
	arm-none-eabi-nm -n main.o
	arm-none-eabi-objdump -h main.o
	arm-none-eabi-nm -n startup.elf
	arm-none-eabi-objdump -h startup.elf
	arm-none-eabi-size startup.elf

