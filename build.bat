@echo off

if "%CC%"=="" set "CC=i686-elf-gcc"
if "%LD%"=="" set "LD=i686-elf-ld"

set CFLAGS=-m32 -fno-exceptions -fno-rtti -fno-pie -ffreestanding -nostdlib

mkdir build 2>nul
mkdir build\iso\boot\grub 2>nul
mkdir build\Graphics 2>nul

echo kernel entry
nasm -f elf32 src\Kernel\kernel_entry.asm -o build\kernel_entry.o || exit /b 1

echo kernel main
%CC% %CFLAGS% -c src\Kernel\KernelMain.cpp -o build\kernel.o || exit /b 1

echo kernel services
%CC% %CFLAGS% -c src\Kernel\Kernel_Services.cpp -o build\Kernel_Services.o || exit /b 1

echo serial driver
%CC% %CFLAGS% -c src\Kernel\Driver\Serial\serial_driver.cpp -o build\serial_driver.o || exit /b 1

echo PS2 keyboard driver
%CC% %CFLAGS% -c src\Kernel\Driver\PS2Keyboard\Ps2KeyboardDriver.cpp -o build\ps2_driver.o || exit /b 1

echo PS2 mouse driver
%CC% %CFLAGS% -c src\Kernel\Driver\PS2Mouse\Ps2MouseMain.cpp -o build\ps2_mouse.o || exit /b 1

echo driver manager
%CC% %CFLAGS% -c src\Kernel\Driver\DriverManager.cpp -o build\DriverManager.o || exit /b 1

echo PIT timer driver
%CC% %CFLAGS% -c src\Kernel\Driver\Time\Pit\PitMain.cpp -o build\PitMain.o || exit /b 1

echo interrupt stubs
nasm -f elf32 src\Kernel\interrupts\interrupt_stubs.asm -o build\interrupt_stubs.o || exit /b 1

echo interrupt system
%CC% %CFLAGS% -c src\Kernel\interrupts\interruptsMain.cpp -o build\interrupts.o || exit /b 1

echo cmd line
%CC% %CFLAGS% -c src\Os\cmdLine\main.cpp -o build\cmdline_main.o || exit /b 1

echo graphics service
%CC% %CFLAGS% -c src\Os\Services\Graphics\main.cpp -o build\Graphics\main.o || exit /b 1

echo graphics API
%CC% %CFLAGS% -c src\Os\Services\Graphics\Api\GraphicsApiMain.cpp -o build\Graphics\GraphicsApi.o || exit /b 1

echo port I/O
%CC% %CFLAGS% -c src\Kernel\IO\PortIO.cpp -o build\PortIO.o || exit /b 1

echo input handler
%CC% %CFLAGS% -c src\Kernel\Input\KernelInputHandler.cpp -o build\KernelInputHandler.o || exit /b 1

echo linking kernel
%LD% -m elf_i386 -T src\Kernel\linker_grub.ld -nostdlib build\kernel_entry.o build\kernel.o build\Kernel_Services.o build\PortIO.o build\serial_driver.o build\ps2_driver.o build\ps2_mouse.o build\DriverManager.o build\PitMain.o build\interrupt_stubs.o build\interrupts.o build\Graphics\main.o build\Graphics\GraphicsApi.o build\cmdline_main.o build\KernelInputHandler.o -o build\kernel.elf || exit /b 1

copy /Y build\kernel.elf build\iso\boot\kernel.bin >nul
copy /Y grub\grub.cfg build\iso\boot\grub\grub.cfg >nul

if exist make_iso.bat call make_iso.bat

echo building PIT Timer Driver
%CC% %CCOMPILE_FLAGS% -c src\Kernel\Driver\Time\Pit\PitMain.cpp -o build\PitMain.o || (
    echo [ERROR] PIT Timer Driver compilation failed!
    exit /b 1
)

echo building interrupt stubs
nasm -f elf32 src\Kernel\interrupts\interrupt_stubs.asm -o build\interrupt_stubs.o || (
    echo [ERROR] Interrupt stubs assembly failed!
    exit /b 1
)

echo building interrupt system
%CC% %CCOMPILE_FLAGS% -c src\Kernel\interrupts\interruptsMain.cpp -o build\interrupts.o || (
    echo [ERROR] Interrupt system compilation failed!
    exit /b 1
)



echo building cmd line
%CC% %CCOMPILE_FLAGS% -c src\Os\cmdLine\main.cpp -o build\cmdline_main.o || (
    echo [ERROR] cmdLine compilation failed!
    exit /b 1
)

echo building graphic service
mkdir build\Graphics 2>nul
%CC% %CCOMPILE_FLAGS% -c src\Os\Services\Graphics\main.cpp -o build\Graphics\main.o || (
    echo [ERROR] Graphics service compilation failed!
    exit /b 1
)

echo building graphics API
%CC% %CCOMPILE_FLAGS% -c src\Os\Services\Graphics\Api\GraphicsApiMain.cpp -o build\Graphics\GraphicsApi.o || (
    echo [ERROR] Graphics API compilation failed!
    exit /b 1
)


echo building Port I/O module
%CC% %CCOMPILE_FLAGS% -c src\Kernel\IO\PortIO.cpp -o build\PortIO.o || (
    echo [ERROR] Port I/O module compilation failed!
    exit /b 1
)

echo building kernel input handler
%CC% %CCOMPILE_FLAGS% -c src\Kernel\Input\KernelInputHandler.cpp -o build\KernelInputHandler.o || (
    echo [ERROR] Kernel input handler compilation failed!
    exit /b 1
)

echo Linking kernel
%LD% -m elf_i386 -T src\Kernel\linker_grub.ld -nostdlib build\kernel_entry.o build\kernel.o build\Kernel_Services.o build\PortIO.o build\serial_driver.o build\ps2_driver.o build\ps2_mouse.o build\DriverManager.o build\PitMain.o build\interrupt_stubs.o build\interrupts.o build\Graphics\main.o build\Graphics\GraphicsApi.o build\cmdline_main.o build\KernelInputHandler.o -o build\kernel.elf || (
    echo [ERROR] Kernel linking failed!
    exit /b 1
)


copy /Y build\kernel.elf build\iso\boot\kernel.bin >nul
copy /Y grub\grub.cfg build\iso\boot\grub\grub.cfg >nul



if exist make_iso.bat (
    call make_iso.bat
)

endlocal
exit /b 0
