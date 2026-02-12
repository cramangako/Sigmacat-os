@echo off

echo [ISO-BUILD] Creating bootable ISO...

if not exist "build\iso\boot\kernel.bin" (
    echo [ERROR] Kernel not found
    exit /b 1
)

if not exist "build\iso\boot\grub\grub.cfg" (
    echo [ERROR] GRUB config not found
    exit /b 1
)

wsl bash -c "cd /mnt/c/projects/code/Sigmacat-os && grub-mkrescue -o build/os.iso build/iso 2>&1"

if %errorlevel% equ 0 (
    echo [ISO-BUILD] Success! ISO created at build\os.iso
    exit /b 0
) else (
    echo [ERROR] ISO creation failed
    exit /b 1
)
