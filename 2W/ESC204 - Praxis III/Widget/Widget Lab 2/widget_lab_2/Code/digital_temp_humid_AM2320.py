'''
ESC204 2022W Widget Lab 2, Part 8
Task: Take readings using an AM2320 digital temperature/humidity sensor.
'''

import board
import bitbangio
import adafruit_am2320
import time

# set up I2C protocol
i2c = bitbangio.I2C(board.GP17, board.GP16)
dhtDevice = adafruit_am2320.AM2320(i2c)

# read values from AM2320 sensor every 2 seconds (with gap in between temp and humidity readings)
while True:
    try:
        # Print the values to the serial port
        temperature_c = dhtDevice.temperature
        time.sleep(0.5)
        humidity = dhtDevice.relative_humidity
        print("AM2320      Temp: {:.1f} C      Humidity: {}% ".format(temperature_c,humidity))

    except RuntimeError as error:
		# Errors happen fairly often, DHT's are hard to read, just keep trying to run/power cycle Pico
        print(error.args[0])

    time.sleep(1.5)
