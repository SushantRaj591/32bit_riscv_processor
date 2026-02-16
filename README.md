The following program was used to verify the processor functionality:

addi x1, x0, 16  
addi x2, x0, 8  
add  x3, x1, x2  
sub  x4, x3, x3  
sw   x3, 0(x0)  
lw   x5, 0(x0)  
beq  x0, x0, 0  

 Execution Result

1. addi x1, x0, 16
   x1 = 16

2. addi x2, x0, 8 
   x2 = 8

3. add x3, x1, x2  
   x3 = 24

4. sub x4, x3, x3  
   x4 = 0  
   Zero flag = 1

5. sw x3, 0(x0) 
   Memory[0] = 24

6. lw x5, 0(x0)  
   x5 = 24

7. beq x0, x0, 0* 
   Branch taken → PC loops at the same address (program halt)

This confirms correct operation of:
- ALU (R-type and I-type)
- Register write-back
- Data memory read/write
- Zero flag generation
- Branch and PC update logic

<img width="646" height="287" alt="image" src="https://github.com/user-attachments/assets/0af67b8d-950f-48b4-a2ce-93511346d26e" />

- <img width="920" height="467" alt="image" src="https://github.com/user-attachments/assets/a6ec5d88-f693-49e8-93d1-c29b9cc248bc" />
