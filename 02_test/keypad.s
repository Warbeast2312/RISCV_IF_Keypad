#     Col0 Col1 Col2 Col3
#    -------------------
# R0 |  0 |  1 |  2 |  3
# R1 |  4 |  5 |  6 |  7
# R2 |  8 |  9 |  A |  B
# R3 |  C |  D |  E |  F




jal  x1, power_reset_lcd
jal  x1, init_lcd

start:
    addi x1, x0, 0                 # Column index (0-3)

scan_column:
    li x2, 0xF0              # All columns HIGH (GPIO[7:4] = 1111)
    li x3, 0x10              # Bit mask to set one column LOW

    sll x4, x3, x1           # x4 = 1 << (4 + col)
    not x4, x4               # Invert for masking
    and x5, x2, x4           # Clear one column bit (drive LOW)

    # Write to GPIO to drive current column LOW
    li x6, 0x7004
    sb x5, 0(x6)             # Store byte to GPIO

    # Small delay to let signal settle
    li t1, 1000
delay_signal:
    addi t1, t1, -1
    bnez t1, delay_loop

    # Read GPIO to get rows
    lb x7, 0(x6)             # Load GPIO state
    andi x7, x7, 0x0F        # Mask rows (GPIO[3:0])

    li x8, 1                 # Row mask
    li x10, 0                 # Row index

check_row:
    and x11, x7, x8
    beqz x11, key_found       # If row bit is LOW, key is pressed

    slli x8, x8, 1           # Next row
    addi x10, x10, 1
    li x12, 4
    blt x10, x12, check_row

    # No key found in this column, try next column
    addi x1, x1, 1
    li x13, 4
    blt x1, x13, scan_column

    j start                 # No key detected, loop back

key_found:
    # Compute key index = row * 4 + column
	add x14, x10, x10
	add x14, x14, x10
	add x14, x14, x10
    add x14, x14, x1           # x14 = key index (0-15)


    li x15, 0x2000
    add x16, x0, x0     # x16 = 0 (counter aka stack pointer)



	addi x14, x14, -1
	blt x14, x0 , KEY_INDEX0
	
	addi x14, x14, -1
	beq x14, x0 , KEY_INDEX1

	addi x14, x14, -1
	beq x14, x0 , KEY_INDEX2

	addi x14, x14, -1
	beq x14, x0 , KEY_INDEX3

	addi x14, x14, -1
	beq x14, x0 , KEY_INDEX4

	addi x14, x14, -1
	beq x14, x0 , KEY_INDEX5

	addi x14, x14, -1
	beq x14, x0 , KEY_INDEX6

	addi x14, x14, -1
	beq x14, x0 , KEY_INDEX7

	addi x14, x14, -1
	beq x14, x0 , KEY_INDEX8

	addi x14, x14, -1
	beq x14, x0 , KEY_INDEX9

	addi x14, x14, -1
	beq x14, x0 , KEY_INDEX10

	addi x14, x14, -1
	beq x14, x0 , KEY_INDEX11

	addi x14, x14, -1
	beq x14, x0 , KEY_INDEX12

	addi x14, x14, -1
	beq x14, x0 , KEY_INDEX13

	addi x14, x14, -1
	beq x14, x0 , KEY_INDEX14

	addi x14, x14, -1
	beq x14, x0 , KEY_INDEX15		

end_start: j end_start




calculate: 
    # Accumulate loop
    lw x14, 0(x15)          # Load key index from stack 
    addi x15, x15, -4       # Decrement stack pointer
    addi x19, x19, 1       # Increment counter 

end_calculate: j end_calculate


   
  
    






KEY_INDEX0:

    addi x31, x31, 1     # Value 1
    sw x31 , 0(x15)      # Store key index in stack
    addi x15, x15, 4     # Increment stack pointer


li   x21, 1 			# Write data RS = 1
li   x20, 49            # Data content: 1  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

wait_release_0:
    lb x15, 0(x6)           # Read GPIO
    andi x15, x15, 0x0F     # Mask rows
    bnez x15, wait_release_0  # Wait until all rows are HIGH

    j start                 # Then return to scan
#---------------------------------------------------------------------------
KEY_INDEX1:

    addi x31, x31, 2     # Value 2
    sw x31 , 0(x15)      # Store key index in stack
    addi x15, x15, 4     # Increment stack pointer

li   x21, 1 			# Write data RS = 1
li   x20, 50            # Data content: 2  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

wait_release_1:
    lb x15, 0(x6)           # Read GPIO
    andi x15, x15, 0x0F     # Mask rows
    bnez x15, wait_release_1  # Wait until all rows are HIGH

    j start                 # Then return to scan
#---------------------------------------------------------------------------
KEY_INDEX2:

    addi x31, x31, 3     # Value 3
    sw x31 , 0(x15)      # Store key index in stack
    addi x15, x15, 4     # Increment stack pointer

li   x21, 1 			# Write data RS = 1
li   x20, 51            # Data content: 3  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

wait_release_2:
    lb x15, 0(x6)           # Read GPIO
    andi x15, x15, 0x0F     # Mask rows
    bnez x15, wait_release_2  # Wait until all rows are HIGH

    j start                 # Then return to scan
#---------------------------------------------------------------------------
KEY_INDEX3:

    addi x31, x31, 10     # Value A (add)
    sw x31 , 0(x15)      # Store key index in stack
    addi x15, x15, 4     # Increment stack pointer

#A

wait_release_3:
    lb x15, 0(x6)           # Read GPIO
    andi x15, x15, 0x0F     # Mask rows
    bnez x15, wait_release_3  # Wait until all rows are HIGH

    j start                 # Then return to scan
#---------------------------------------------------------------------------
KEY_INDEX4:


    addi x31, x31, 4     # Value 4
    sw x31 , 0(x15)      # Store key index in stack
    addi x15, x15, 4     # Increment stack pointer

li   x21, 1 			# Write data RS = 1
li   x20, 52            # Data content: 4  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

wait_release_4:
    lb x15, 0(x6)           # Read GPIO
    andi x15, x15, 0x0F     # Mask rows
    bnez x15, wait_release_4  # Wait until all rows are HIGH

    j start                 # Then return to scan
#---------------------------------------------------------------------------
KEY_INDEX5:

    addi x31, x31, 5     # Value 5
    sw x31 , 0(x15)      # Store key index in stack
    addi x15, x15, 4     # Increment stack pointer

li   x21, 1 			# Write data RS = 1
li   x20, 53            # Data content: 5  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

wait_release_5:
    lb x15, 0(x6)           # Read GPIO
    andi x15, x15, 0x0F     # Mask rows
    bnez x15, wait_release_5  # Wait until all rows are HIGH

    j start                 # Then return to scan
#---------------------------------------------------------------------------
KEY_INDEX6:

    addi x31, x31, 6     # Value 
    sw x31 , 0(x15)      # Store key index in stack
    addi x15, x15, 4     # Increment stack pointer


li   x21, 1 			# Write data RS = 1
li   x20, 54            # Data content: 6  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

wait_release_6:
    lb x15, 0(x6)           # Read GPIO
    andi x15, x15, 0x0F     # Mask rows
    bnez x15, wait_release_6  # Wait until all rows are HIGH

    j start                 # Then return to scan
#---------------------------------------------------------------------------
KEY_INDEX7:

#B
    addi x31, x31, 11     # Value B (sub)
    sw x31 , 0(x15)      # Store key index in stack
    addi x15, x15, 4     # Increment stack pointer



wait_release_7:
    lb x15, 0(x6)           # Read GPIO
    andi x15, x15, 0x0F     # Mask rows
    bnez x15, wait_release_7  # Wait until all rows are HIGH

    j start                 # Then return to scan
#---------------------------------------------------------------------------
KEY_INDEX8:


    addi x31, x31, 7     # Value 7
    sw x31 , 0(x15)      # Store key index in stack
    addi x15, x15, 4     # Increment stack pointer

li   x21, 1 			# Write data RS = 1
li   x20, 55            # Data content: 7  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

wait_release_8:
    lb x15, 0(x6)           # Read GPIO
    andi x15, x15, 0x0F     # Mask rows
    bnez x15, wait_release_8  # Wait until all rows are HIGH

    j start                 # Then return to scan
#---------------------------------------------------------------------------
KEY_INDEX9:


    addi x31, x31, 9     # Value 9
    sw x31 , 0(x15)      # Store key index in stack
    addi x15, x15, 4     # Increment stack pointer

li   x21, 1 			# Write data RS = 1
li   x20, 56            # Data content: 8  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

wait_release_9:
    lb x15, 0(x6)           # Read GPIO
    andi x15, x15, 0x0F     # Mask rows
    bnez x15, wait_release_9  # Wait until all rows are HIGH

    j start                 # Then return to scan
#---------------------------------------------------------------------------
KEY_INDEX10:


    addi x31, x31, 9     # Value 9
    sw x31 , 0(x15)      # Store key index in stack
    addi x15, x15, 4     # Increment stack pointer

li   x21, 1 			# Write data RS = 1
li   x20, 57            # Data content: 9  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

wait_release_10:
    lb x15, 0(x6)           # Read GPIO
    andi x15, x15, 0x0F     # Mask rows
    bnez x15, wait_release_10  # Wait until all rows are HIGH

    j start                 # Then return to scan
#---------------------------------------------------------------------------
KEY_INDEX11:

#C
    addi x31, x31, 12     # Value C (mul)
    sw x31 , 0(x15)      # Store key index in stack
    addi x15, x15, 4     # Increment stack pointer

wait_release_11:
    lb x15, 0(x6)           # Read GPIO
    andi x15, x15, 0x0F     # Mask rows
    bnez x15, wait_release_11  # Wait until all rows are HIGH

    j start                 # Then return to scan
#---------------------------------------------------------------------------
KEY_INDEX12:

#*

    addi x31, x31, 20     # Value dot
    sw x31 , 0(x15)      # Store key index in stack
    addi x15, x15, 4     # Increment stack pointer

wait_release_12:
    lb x15, 0(x6)           # Read GPIO
    andi x15, x15, 0x0F     # Mask rows
    bnez x15, wait_release_12  # Wait until all rows are HIGH

    j start                 # Then return to scan
#---------------------------------------------------------------------------
KEY_INDEX13:


    addi x31, x31, 0     # Value 0
    sw x31 , 0(x15)      # Store key index in stack
    addi x15, x15, 4     # Increment stack pointer

li   x21, 1 			# Write data RS = 1
li   x20, 48            # Data content: 0  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

wait_release_13:
    lb x15, 0(x6)           # Read GPIO
    andi x15, x15, 0x0F     # Mask rows
    bnez x15, wait_release_13  # Wait until all rows are HIGH

    j start                 # Then return to scan
#---------------------------------------------------------------------------
KEY_INDEX14:

##



wait_release_14:
    lb x15, 0(x6)           # Read GPIO
    andi x15, x15, 0x0F     # Mask rows
    bnez x15, wait_release_14  # Wait until all rows are HIGH

    j calculate                 # start calculation
#---------------------------------------------------------------------------
KEY_INDEX15:

#D
    addi x31, x31, 13     # Value D (div)
    sw x31 , 0(x15)      # Store key index in stack
    addi x15, x15, 4     # Increment stack pointer

wait_release_15:
    lb x15, 0(x6)           # Read GPIO
    andi x15, x15, 0x0F     # Mask rows
    bnez x15, wait_release_15  # Wait until all rows are HIGH

    j start                 # Then return to scan	



#---------------------------------------------------------------------------
# Using x19 x20 x21 x18 x16 x17
init_lcd:
    addi x16, x1, 0           # Save return address

    li   x21, 0               # Write command RS = 0
    li   x20, 0x38            # Command content
    jal  x1, out_lcd         # Write to LCD
    li   x20, 2496             # Delay 100us
    jal  x1, delay

    li   x21, 0               # Write command RS = 0
    li   x20, 0x01            # Command content
    jal  x1, out_lcd         # Write to LCD
    li   x20, 49996           # Delay 2ms
    jal  x1, delay

    li   x21, 0               # Write command RS = 0
    li   x20, 0x0C            # Command content
    jal  x1, out_lcd         # Write to LCD
    li   x20, 2496             # Delay 100us
    jal  x1, delay

    li   x21, 0               # Write command RS = 0
    li   x20, 0x06            # Command content
    jal  x1, out_lcd         # Write to LCD
    li   x20, 2496             # Delay 100us
    jal  x1, delay

    addi x1, x16, 0           # Restore return address
    jalr x0,x1,0             # Return from the function
#---------------------------------------------------------------------------
# Using x19 x20 x21 x18 x16 x17
power_reset_lcd:
    addi x16, x1, 0          # Save return address

    li   x19, 0x7030      # Address of LCD
    li   x20, 0xC0000000      # Turn on LCD and Backlight
    sw   x20, 0(x19)
    li   x20, 499996          # Delay 20ms
    jal  x1, delay

    li   x21, 0              # Write command RS = 0
    li   x20, 0x30            # Command content
    jal  x1, out_lcd         # Write to LCD
    li   x20, 104996           # Delay 4.2ms
    jal  x1, delay

    li   x21, 0              # Write command RS = 0
    li   x20, 0x30            # Command content
    jal  x1, out_lcd         # Write to LCD
    li   x20, 49996           # Delay 2ms
    jal  x1, delay

    li   x21, 0              # Write command RS = 0
    li   x20, 0x30            # Command content
    jal  x1, out_lcd         # Write to LCD
    li   x20, 49996           # Delay 2ms
    jal  x1, delay

    addi x1, x16, 0          # Restore return address
    jalr x0,x1,0             # Return from the function
#---------------------------------------------------------------------------
# Using x19 x20 x21 x17
# Input x20 = 8-bit command/data; x21 = RS ( Command = 0, Data = 1 )
out_lcd:
    addi x17, x1, 0           # Save return address
    li   x19, 0x7030          # Address of LCD
    beq  x21, x0, command     # If RS = 0
    addi x20, x20, 1536        # ( RS = 1; EN = 1 ) + Data
    j    send
command:
    addi x20, x20, 1024        # ( RS = 0; EN = 1 ) + Command
send:
    sh   x20, 0(x19)
    li   x20, 2496             # Delay 100us
    jal  x1, delay
    sh   x0, 1(x19)           # Pull EN to low for LCD starts executing
    addi x1, x17, 0           # Restore return address
    jalr x0,x1,0             # Return from the function
#---------------------------------------------------------------------------
# Using x20 x18
#CLOCK = 50 000 000Hz
delay:
    # 20ms  = 249998 – 499996
    # 4.2ms =  52498 – 104996
    # 2ms   =  24998 – 49996
    # 200us =   2498 – 4996
    # 100us =    1248 – 2496
    add  x18, x0, x20
delay_loop:
    addi x18, x18, -1          # Decrement the counter
    bne  x18, x0, delay_loop  # If t0 is not zero, branch back to delay_loop
    jalr x0,x1,0             # Return from the function
#---------------------------------------------------------------------------



