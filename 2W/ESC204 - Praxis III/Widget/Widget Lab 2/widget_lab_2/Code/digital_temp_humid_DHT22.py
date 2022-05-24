'''
ESC204 2022W Widget Lab 2, Part 8
Task: Take readings using a DHT22 digital temperature/humidity sensor.
'''

import board
import adafruit_dht
import time

# DHT22 setup
DHT_PIN = board.GP1
dhtDevice = adafruit_dht.DHT22(DHT_PIN)

# read values from DHT sensor every 0.5 seconds
while True:
    try:
        # Print the values to the serial port
        temperature_c = dhtDevice.temperature
        temperature_f = temperature_c * (9 / 5) + 32
        humidity = dhtDevice.humidity
        print("DHT22      Temp: {:.1f} C    Humidity: {}% ".format(temperature_c, humidity))
    except RuntimeError as error:
		# Errors happen fairly often, DHT's are hard to read, just keep going
        print(error.args[0])

    time.sleep(0.5)
