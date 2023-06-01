# Single-Cycle-RISC-V
This is a basic single cycle risc-v RV32I implementation meant for learning purposes. Programmed in verilog and simulated in modelsim.

## Architecture
![arch](https://github.com/Jormit/Single-Cycle-RISC-V/assets/15094591/f25136ab-de42-4824-9117-105689823e91)

## Demo
### Assembly code
```asm
addi x1, x0, 1
addi x2, x0, 2
add x3, x1, x2
sw x3, 0(x0)
addi x3, x3, -1
bne x3, x0, -4
xor x3, x2, x0
jal x1, -28
```

### Waveform output
![image](https://github.com/Jormit/Single-Cycle-RISC-V/assets/15094591/254976c8-7d44-4939-ac4d-44d267b8491f)
