#!/usr/bin/env bash
echo "🏗️  Building MySDOS v.0.0.0.6 [STABLE BUILD]..."

# 1. Assembling semua komponen (Driver & Program)
as -o boot.o boot/boot.s
as -o init.o init/init.s
as -o screen.o drivers/screen.s
as -o keyboard.o drivers/keyboard.s
as -o panic.o drivers/panic.s
as -o gpu.o drivers/gpu.s
as -o ver.o program/ver.s
as -o snake.o program/snake.s
as -o info.o program/sysinfo.s
as -o gpu_test.o program/gpu_test.s
as -o kernel.o kernel/kernel.s

# 2. Linker (Gabungkan SEMUA tanpa terkecuali!)
ld -T linker/linker.ld -o kernel.elf \
    boot.o init.o screen.o keyboard.o panic.o \
    gpu.o ver.o snake.o info.o gpu_test.o kernel.o

if [ -f kernel.elf ]; then
    objcopy -O binary kernel.elf mysdos.bin
    echo "✅ MySDOS v.0.0.0.6 [HW-MON] Ready!"
    echo "🚀 Booting Terminal (No VNC)..."
    
    # Jalankan QEMU Mode Serial (Symmetrical & Clean)
    qemu-system-aarch64 -M virt -cpu cortex-a53 -m 128M \
        -display none -serial stdio \
        -device loader,file=mysdos.bin,addr=0x40100000,cpu-num=0
else
    echo "❌ Build Gagal! Cek lagi file .s kamu, Louis."
fi
