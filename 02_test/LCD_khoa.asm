    jal  x1, power_reset_lcd
    jal  x1, init_lcd

    # li   x8, 0x7000
    # li   x9, 0xFFFFFFFF
    # sw   x9, 0(x8)

    li   x15, 1               # Write data RS = 1
    li   x9, 72              # Data content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 1248             # Delay 100us
    jal  x1, delay

    li   x15, 1               # Write data RS = 1
    li   x9, 101             # Data content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 1248             # Delay 100us
    jal  x1, delay

    li   x15, 1               # Write data RS = 1
    li   x9, 108             # Data content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 1248             # Delay 100us
    jal  x1, delay

    li   x15, 1               # Write data RS = 1
    li   x9, 108             # Data content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 1248             # Delay 100us
    jal  x1, delay

    li   x15, 1               # Write data RS = 1
    li   x9, 111             # Data content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 1248             # Delay 100us
    jal  x1, delay

    li   x15, 1               # Write data RS = 1
    li   x9, 32              # Data content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 1248             # Delay 100us
    jal  x1, delay

    li   x15, 1               # Write data RS = 1
    li   x9, 87              # Data content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 1248             # Delay 100us
    jal  x1, delay

    li   x15, 1               # Write data RS = 1
    li   x9, 111             # Data content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 1248             # Delay 100us
    jal  x1, delay

    li   x15, 1               # Write data RS = 1
    li   x9, 114             # Data content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 1248             # Delay 100us
    jal  x1, delay

    li   x15, 1               # Write data RS = 1
    li   x9, 108             # Data content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 1248             # Delay 100us
    jal  x1, delay

    li   x15, 1               # Write data RS = 1
    li   x9, 100             # Data content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 1248             # Delay 100us
    jal  x1, delay

    li   x15, 1               # Write data RS = 1
    li   x9, 33              # Data content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 1248             # Delay 100us
    jal  x1, delay

here:
    j    here

#---------------------------------------------------------------------------
# Using x8 x9 x15 x5 x16 x17
init_lcd:
    addi x16, x1, 0           # Save return address

    li   x15, 0               # Write command RS = 0
    li   x9, 0x38            # Command content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 1248             # Delay 100us
    jal  x1, delay

    li   x15, 0               # Write command RS = 0
    li   x9, 0x01            # Command content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 24998           # Delay 2ms
    jal  x1, delay

    li   x15, 0               # Write command RS = 0
    li   x9, 0x0C            # Command content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 1248             # Delay 100us
    jal  x1, delay

    li   x15, 0               # Write command RS = 0
    li   x9, 0x06            # Command content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 1248             # Delay 100us
    jal  x1, delay

    addi x1, x16, 0           # Restore return address
    jalr x0,x1,0             # Return from the function
#---------------------------------------------------------------------------
# Using x8 x9 x15 x5 x16 x17
power_reset_lcd:
    addi x16, x1, 0           # Save return address

    li   x8, 0x7030          # Address of LCD
    li   x9, 0xC0000000      # Turn on LCD and Backlight
    sw   x9, 0(x8)
    li   x9, 249998          # Delay 20ms
    jal  x1, delay

    li   x15, 0               # Write command RS = 0
    li   x9, 0x30            # Command content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 52498           # Delay 4.2ms
    jal  x1, delay

    li   x15, 0               # Write command RS = 0
    li   x9, 0x30            # Command content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 24998           # Delay 200us
    jal  x1, delay

    li   x15, 0               # Write command RS = 0
    li   x9, 0x30            # Command content
    jal  x1, out_lcd         # Write to LCD
    li   x9, 24998           # Delay 200us
    jal  x1, delay

    addi x1, x16, 0           # Restore return address
    jalr x0,x1,0             # Return from the function
#---------------------------------------------------------------------------
# Using x8 x9 x15 x17
# Input x9 = 8-bit command/data; x15 = RS ( Command = 0, Data = 1 )
out_lcd:
    addi x17, x1, 0           # Save return address
    li   x8, 0x7030          # Address of LCD
    beq  x15, x0, command     # If RS = 0
    addi x9, x9, 1536        # ( RS = 1; EN = 1 ) + Data
    j    send
command:
    addi x9, x9, 1024        # ( RS = 0; EN = 1 ) + Command
send:
    sh   x9, 0(x8)
    li   x9, 1248             # Delay 100us
    jal  x1, delay
    sh   x0, 1(x8)           # Pull EN to low for LCD starts executing
    addi x1, x17, 0           # Restore return address
    jalr x0,x1,0             # Return from the function
#---------------------------------------------------------------------------
# Using x9 x5
#CLOCK = 25 000 000Hz
delay:
    # 20ms  = 124 999 - 249998
    # 4.2ms =  26 249 - 52498
    # 2ms   =  12 499 - 24998
    # 200us =   1 249 - 2498
    # 100us =     624 - 1248
    add  x5, x0, x9
delay_loop:
    addi x5, x5, -1          # Decrement the counter
    bne  x5, x0, delay_loop  # If t0 is not zero, branch back to delay_loop
    jalr x0,x1,0             # Return from the function