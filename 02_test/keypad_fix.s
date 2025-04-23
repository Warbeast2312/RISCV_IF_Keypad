#     Col0 Col1 Col2 Col3
#    -------------------
# R0 |  0 |  1 |  2 |  3
# R1 |  4 |  5 |  6 |  7
# R2 |  8 |  9 | 10 | 11
# R3 | 12 | 13 | 14 | 15

.equ GPIO_ADDR_OUT, 0x7004 # GPIO for ROWS
.equ GPIO_ADDR_IN,  0x7810 # GPIO for COLUMNS


jal  x1, power_reset_lcd
jal  x1, init_lcd

start:
#Initialize GPIO for keypad
li x6, 0x7004            # GPIO output address
li x2, 0xF0            # Set all rows high (GPIO_0[7:4])
sb x2, 0(x6)            # Set GPIO_0[7:4] to high

#####################
li x31, 100
delay_stable:
    addi x31, x31, -1
    bnez x31, delay_stable



scan_columns:
    # Set row 1 low, others high (GPIO_0[7:4])
    li x2, 0xE0 # 1110 0000
    sb x2, 0(x6)
#####################
# li x31, 100
# delay_stable_scan1:
#     addi x31, x31, -1
#     bnez x31, delay_stable_scan1

delay_200ms_1:
    li x31, 5000          # Outer loop counter
outer_loop_1:
    li x30, 2000          # Inner loop counter
inner_loop_1:
    addi x30, x30, -1
    bnez x30, inner_loop_1
    addi x31, x31, -1
    bnez x31, outer_loop_1




    # Read columns
    li x9, 0x7810             # Input - columns address
    lbu x7, 0(x9)              # Read GPIO state
    andi x7, x7, 0x0F         # Mask columns (GPIO[3:0])
    
    # Check key 1 press
    li x10, 0x0E                # Column 1 mask (1110)
    beq x7, x10, handle_key0    # If key 1 is pressed, jump to handle_key0

    # Check key 2 press
    li x10, 0x0D                # Column 2 mask (1101)  
    beq x7, x10, handle_key1    # If key 2 is pressed, jump to handle_key1

    # Check key 3 press
    li x10, 0x0B                # Column 3 mask (1011)
    beq x7, x10, handle_key2    # If key 3 is pressed, jump to handle_key2


    # Check key A press
    li x10, 0x07                # Column 4 mask (0111)
    beq x7, x10, handle_key3    # If key 4 is pressed, jump to handle_key3



    #Set row 2 low, others high (GPIO_0[7:4])
    li x2, 0xD0 
    sb x2, 0(x6)
#####################
# li x31, 100
# delay_stable_scan2:
#     addi x31, x31, -1
#     bnez x31, delay_stable_scan2

delay_200ms_2:
    li x31, 5000          # Outer loop counter
outer_loop_2:
    li x30, 2000          # Inner loop counter
inner_loop_2:
    addi x30, x30, -1
    bnez x30, inner_loop_2
    addi x31, x31, -1
    bnez x31, outer_loop_2




    # Read columns
    li x9, 0x7810             # Input - columns address
    lbu x7, 0(x9)              # Read GPIO state
    andi x7, x7, 0x0F         # Mask columns (GPIO[7:4])
    
    # Check key 4 press
    li x10, 0x0E                # Column 1 mask (1110)
    beq x7, x10, handle_key4    # If key 4 is pressed, jump to handle_key4

    # Check key 5 press
    li x10, 0x0D                # Column 2 mask (1101)  
    beq x7, x10, handle_key5    ## If key 5 is pressed, jump to handle_key5

    # Check key 6 press
    li x10, 0x0B                # Column 3 mask (1011)
    beq x7, x10, handle_key6    ## If key 6 is pressed, jump to handle_key6


    # Check key B press
    li x10, 0x07                # Column 4 mask (0111)
    beq x7, x10, handle_key7    ## If key 7 is pressed, jump to handle_key7


    #Set row 3 low, others high (GPIO_0[7:4])
    li x2, 0xB0
    sb x2, 0(x6)
#####################
# li x31, 100
# delay_stable_scan3:
#     addi x31, x31, -1
#     bnez x31, delay_stable_scan3

delay_200ms_3:
    li x31, 5000          # Outer loop counter
outer_loop_3:
    li x30, 2000          # Inner loop counter
inner_loop_3:
    addi x30, x30, -1
    bnez x30, inner_loop_3
    addi x31, x31, -1
    bnez x31, outer_loop_3


    
        # Read columns
        li x9, 0x7810             # Input - columns address
        lbu x7, 0(x9)              # Read GPIO state
        andi x7, x7, 0x0F         # Mask columns (GPIO[7:4])
        
        # Check key 7 press
        li x10, 0x0E                # Column 1 mask (1110)
        beq x7, x10, handle_key8    ## If key 7 is pressed, jump to handle_key8
    
        # Check key 8 press
        li x10, 0x0D                # Column 2 mask (1101)  
        beq x7, x10, handle_key9    ## If key 8 is pressed, jump to handle_key9
    
        # Check key 9 press
        li x10, 0x0B                # Column 3 mask (1011)
        beq x7, x10, handle_key10   ## If key 9 is pressed, jump to handle_key10
    
    
        # Check key C press
        li x10, 0x07                # Column 4 mask (0111)
        beq x7, x10, handle_key11   ## If key C is pressed, jump to handle_key11


    #Set row 4 low, others high (GPIO_0[7:4])
    li x2, 0x70
    sb x2, 0(x6)

#####################
# li x31, 100
# delay_stable_scan4:
#     addi x31, x31, -1
#     bnez x31, delay_stable_scan4

delay_200ms_4:
    li x31, 5000          # Outer loop counter
outer_loop_4:
    li x30, 2000          # Inner loop counter
inner_loop_4:
    addi x30, x30, -1
    bnez x30, inner_loop_4
    addi x31, x31, -1
    bnez x31, outer_loop_4


    
        # Read columns
        li x9, 0x7810             # Input - columns address
        lbu x7, 0(x9)              # Read GPIO state
        andi x7, x7, 0x0F         # Mask columns (GPIO[7:4])
        
        # Check key * press
        li x10, 0x0E                # Column 1 mask (1110)
        beq x7, x10, handle_key12   ## If key * is pressed, jump to handle_key12
    
        # Check key 0 press
        li x10, 0x0D                # Column 2 mask (1101)  
        beq x7, x10, handle_key13   ## If key 0 is pressed, jump to handle_key13
    
        # Check key # press
        li x10, 0x0B                # Column 3 mask (1011)
        beq x7, x10, handle_key14   ## If key # is pressed, jump to handle_key14 
    
    
        # Check key 15 press
        li x10, 0x07                # Column 4 mask (0111)
        beq x7, x10, handle_key15   ## If key 15 is pressed, jump to handle_key15 


j scan_columns
###############################################################################################################
   
handle_key0:

jal  x1, delay_200ms

li   x21, 1 			# Write data RS = 1
li   x20, 49            # Data content: 1  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

j wait_release

handle_key1:

jal  x1, delay_200ms

li   x21, 1 			# Write data RS = 1
li   x20, 50            # Data content: 2  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

j wait_release


handle_key2:

jal  x1, delay_200ms

li   x21, 1 			# Write data RS = 1
li   x20, 51            # Data content: 3  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

j wait_release



handle_key3:

jal  x1, delay_200ms

li   x21, 1 			# Write data RS = 1
li   x20, 65            # Data content: A  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

j wait_release


handle_key4:

jal  x1, delay_200ms

li   x21, 1 			# Write data RS = 1
li   x20, 52            # Data content: 4  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

j wait_release

handle_key5:

jal  x1, delay_200ms

li   x21, 1 			# Write data RS = 1
li   x20, 53            # Data content: 5  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

j wait_release

handle_key6:

jal  x1, delay_200ms

li   x21, 1 			# Write data RS = 1
li   x20, 54            # Data content: 6  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

j wait_release

handle_key7:

#B
jal  x1, delay_200ms

li   x21, 1 			# Write data RS = 1
li   x20, 66            # Data content: B  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay


j wait_release


handle_key8:

jal  x1, delay_200ms

li   x21, 1 			# Write data RS = 1
li   x20, 55            # Data content: 7  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

j wait_release

handle_key9:

jal  x1, delay_200ms

li   x21, 1 			# Write data RS = 1
li   x20, 56            # Data content: 8  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

j wait_release

handle_key10:

jal  x1, delay_200ms

li   x21, 1 			# Write data RS = 1
li   x20, 57            # Data content: 9  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

j wait_release

handle_key11:

#C
jal  x1, delay_200ms

li   x21, 1 			# Write data RS = 1
li   x20, 67            # Data content: C  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

j wait_release



handle_key12:

#*

jal  x1, delay_200ms

li   x21, 1 			# Write data RS = 1
li   x20, 46            # Data content: .  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

j wait_release

handle_key13:

jal  x1, delay_200ms

li   x21, 1 			# Write data RS = 1
li   x20, 48            # Data content: 0  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

j wait_release

handle_key14:

##
jal  x1, delay_200ms

li   x21, 1 			# Write data RS = 1
li   x20, 35            # Data content: #  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay

j wait_release

handle_key15:

#D
jal  x1, delay_200ms

li   x21, 1 			# Write data RS = 1
li   x20, 68            # Data content: D  
jal  x1, out_lcd		# Write to LCD
li   x20, 2496 			# Delay 100us
jal  x1, delay


j wait_release








    # Wait for key release	
wait_release:

    # Check if key release (all columns HIGH)

    # Read columns
    li x11, 0x7810             # Input - columns address
    lb x12, 0(x11)              # Read GPIO state
    andi x12, x12, 0x0F         # Mask columns (GPIO[7:4])




    li x13, 0x0F                # Column all high mask (1111)
    beq x12, x13, scan_columns         # If all columns are high, jump to start
    j wait_release


#Subroutine to delay 200ms
delay_200ms:
addi x17, x1, 0           # Save return address
    li x31, 5000          # Outer loop counter
outer_loop:
    li x30, 1000          # Inner loop counter
inner_loop:
    addi x30, x30, -1
    bnez x30, inner_loop
    addi x31, x31, -1
    bnez x31, outer_loop
    addi x1, x17, 0           # Restore return address
    jalr x0,x1,0             # Return from the function


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