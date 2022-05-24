'''
ESC204 2022W Widget Lab 2, Part 12
Task: Use PWM to modulate the brightness of an LED.
'''
import board
import pwmio
import time

# set up LED as PWM output
led = pwmio.PWMOut(board.GP16, frequency=1000, duty_cycle=0)

# run PWM
while True:
    for duty in range(0,65535,50):
        # increasing duty cycle
        led.duty_cycle = duty# Up
        time.sleep(0.001)

    for duty in range(65535,0,-50):
        # decreasing duty cycle
        led.duty_cycle = duty# Up
        time.sleep(0.001)
