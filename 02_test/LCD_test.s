addi x20, x0,  -1888   #LCD 

lui  x3,        524288  #Turn on the LCD 
addi x3,  x3,   1080    #8-bit, 2-line mode, E = 1 
sw   x3,        0(x20)  #Send to LCD (io_lcd = 0x80000438)
jal  x1,        delay   #Delay a few miliseconds 

addi x3,  x0,   56      #8-bit, 2-line mode, E = 0 
sh   x3,        0(x20)  #io_lcd = 0x80000038  
jal  x1,        delay

addi x3,  x0,   1036    #Cursor off, E = 1 
sh   x3,        0(x20)  #io_lcd = 0x8000040C  
jal  x1,        delay

addi x3,  x0,   12      #Cursor off, E = 0 
sh   x3,        0(x20)  #io_lcd = 0x8000000C  
jal  x1,        delay

main:

addi x3,  x0,   1025    #Clear display, E = 1 
sh   x3,        0(x20)  #io_lcd = 0x80000401  
jal  x1,        delay

addi x3,  x0,   1       #Clear display, E = 0 
sh   x3,        0(x20)  #io_lcd = 0x80000001  
jal  x1,        delay

addi x5,  x0,   1584
addi x6,  x0,   560

addi x4,  x0,   16
firstrow:

add  x3,  x0,   x5      #Print ASCII, E = 1 
sh   x3,        0(x20)
jal  x1,        delay

add  x3,  x0,   x6      #Print ASCII, E = 0 
sh   x3,        0(x20)
jal  x1,        delay

addi x5,  x5,   1
addi x6,  x6,   1
addi x4,  x4,  -1
bne  x4,  x0,   firstrow

addi x3,  x0,   1216    #Set cursor, E = 1 
sh   x3,        0(x20)  #io_lcd = 0x800004C0  
jal  x1,        delay

addi x3,  x0,   192     #Set cursor, E = 0 
sh   x3,        0(x20)  #io_lcd = 0x800000C0  
jal  x1,        delay

addi x4,  x0,   16
secondrow:

add  x3,  x0,   x5      #Print ASCII, E = 1 
sh   x3,        0(x20)
jal  x1,        delay

add  x3,  x0,   x6      #Print ASCII, E = 0 
sh   x3,        0(x20)
jal  x1,        delay

addi x5,  x5,   1
addi x6,  x6,   1
addi x4,  x4,  -1
bne  x4,  x0,   secondrow

jal  x1,        delay1
jal  x0,        main  #infinite Loop 

delay:
lui  x31,       9
addi x31, x31, -1865  #x31 = 34999 
d:
addi x31, x31, -1
lh   x30,       0(x21)
sw   x30,       0(x18)
bne  x31, x0,   d
jalr x0,        0(x1)

delay1:
lui  x31,       610
addi x31, x31,  1439  #x31 = 2499999 
d1s:
addi x31, x31, -1
lh   x30,       0(x21)
sw   x30,       0(x18)
bne  x31, x0,   d1s
jalr x0,        0(x1)