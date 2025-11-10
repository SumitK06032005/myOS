# 🧩 StringOS Bootloader

**StringOS** is a simple bootloader written in x86 Assembly that runs in 16-bit real mode, prints text to the screen, then switches to 32-bit protected mode and prints again — forming the foundation of a tiny hobby operating system.

This project is my first step into OS development (OSDev) and low-level programming.  
It focuses on understanding how the CPU boots, how to print characters without BIOS interrupts, and how to transition safely to protected mode.

---

## ⚙️ Features

- Boots in **16-bit Real Mode**
- Prints a message using BIOS interrupts
- Sets up **GDT (Global Descriptor Table)**
- Enters **32-bit Protected Mode**
- Prints another message in 32-bit mode
- Fully written in **x86 Assembly (NASM)**

---

## 🧱 Project Structure
-StringOS/\n
-├── src/\n
-│ ├── bootloader.asm # Main bootloader entry (16-bit)\n
-│ ├── gdt.asm # GDT setup for Protected Mode\n
-│ ├── pm_entry.asm # 32-bit entry point\n
-│ └── print.asm # Text printing routines\n
-├── build/\n
-│ ├── bootloader.bin # Compiled binary\n
-├── docs/\n
-│ └── Architecture.md\n
-├── LICENSE\n
-└── README.md\n

---

## 🧰 Requirements

To build and run StringOS, you’ll need:

- [NASM](https://www.nasm.us/) — assembler\n    
- [QEMU](https://www.qemu.org/) — emulator for testing  \n

---

## 🚀 Build & Run

### Option 1: Manual build
-nasm -f bin src/32-bitPM.asm -o bootloader.bin\n
-qemu-system-x86_64 -drive format=raw,file=bootloader.bin
