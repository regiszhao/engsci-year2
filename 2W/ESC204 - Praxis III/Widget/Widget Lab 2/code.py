'''
ESC204 2022W Widget Lab 2 Assignment
'''

import board
import bitbangio
import adafruit_am2320
import time
import digitalio
import pwmio
import sys

# set up I2C protocol
i2c = bitbangio.I2C(board.GP19, board.GP18)
dhtDevice = adafruit_am2320.AM2320(i2c)

# set up logic inputs to motor driver ("step" and "pulse") as outputs
in1 = digitalio.DigitalInOut(board.GP14)
in2 = digitalio.DigitalInOut(board.GP15)
in1.direction = digitalio.Direction.OUTPUT
in2.direction = digitalio.Direction.OUTPUT

# set up PWM output to motor driver
ena = pwmio.PWMOut(board.GP16)

# set initial duty cycle, direction, and step commands
ena.duty_cycle = 0
in1.value = False
in2.value = True

while True:

    try:
        print("hello")
        # Print the values to the serial port
        temperature_c = dhtDevice.temperature
        time.sleep(0.5)
        humidity = dhtDevice.relative_humidity
        print("AM2320 Temp: {:.1f} C Humidity: {}%".format(temperature_c,humidity))

    except RuntimeError as error:
        # Errors happen fairly often, DHT's are hard to read, just keep trying to run/power cycle Pico
        print(error.args[0])


    if temperature_c >= 25:
        # rotate motor clockwise
        in1.value, in2.value = (False, True)
        ena.duty_cycle = 65535
        print("Motor is rotating CW")

    else:
        ena.duty_cycle = 0 # set speed to zero
        print("Motor isn't rotating")

    time.sleep(0.5)
