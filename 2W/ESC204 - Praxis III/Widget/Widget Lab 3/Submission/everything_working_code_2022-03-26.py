'''
ESC204 2022W Widget Lab 3IoT, Part 9
Task: Publish sensor data to Adafruit IO Dashboard using MQTT.
'''
# SPDX-FileCopyrightText: Brent Rubell for Adafruit Industries
# SPDX-License-Identifier: MIT


###############ADAFRUIT IO IMPORTS#################

import time
from microcontroller import cpu
import board
import busio
from digitalio import DigitalInOut
from adafruit_esp32spi import adafruit_esp32spi
from adafruit_esp32spi import adafruit_esp32spi_wifimanager
import adafruit_esp32spi.adafruit_esp32spi_socket as socket
import adafruit_minimqtt.adafruit_minimqtt as MQTT
from adafruit_io.adafruit_io import IO_MQTT


##############ULTRASONIC################

import board
import digitalio
import time
import adafruit_hcsr04

###############PHOTORESISTOR#############

#Two Photoresistor capable code
import analogio
import time
from board import *

################################HARDWARE CODE################

PHOTORESISTANCE_THRESHOLD = 0.19 #IF LESS THAN THIS VALUE, PLASTIC IS BAD QUALITY.
ULTRASONIC_THRESHOLD = 6.0 # IF LESS THAN THIS VALUE, THERE IS A PLASTIC BOTTLE DETECTED.

sonar_LED_SIDE = adafruit_hcsr04.HCSR04(trigger_pin=board.D11, echo_pin=board.D12)
sonar_PHOTO_SIDE = adafruit_hcsr04.HCSR04(trigger_pin=board.D10, echo_pin=board.D9)


INT_MODE = 0
VOLT_MODE = 1
mode = VOLT_MODE
ADC_HIGH = 65535
photoresistor_ONE = analogio.AnalogIn(A0)
photoresistor_TWO = analogio.AnalogIn(A1)
ADC_REF = photoresistor_ONE.reference_voltage
led1 = digitalio.DigitalInOut(board.D3)
led1.direction = digitalio.Direction.OUTPUT
led2 = digitalio.DigitalInOut(board.D2)
led2.direction = digitalio.Direction.OUTPUT
led1.value = True
led2.value = True


def adc_to_voltage(adc_value):
    return ADC_REF * (float(adc_value)/float(ADC_HIGH))

def calculate_average(list_values):
    sum_items = 0
    #print(list_values)
    for eachItem in list_values:
        sum_items = sum_items + eachItem
    return (sum_items/len(list_values))


############################IOT SYSTEM CODE########################################


# Define callback functions which will be called when certain events happen.
# pylint: disable=unused-argument


def connected(client):
    # Connected function will be called when the client is connected to Adafruit IO.
    print("Connected to Adafruit IO! ")

def subscribe(client, userdata, topic, granted_qos):
    # This method is called when the client subscribes to a new feed.
    print("Subscribed to {0} with QOS level {1}".format(topic, granted_qos))


# pylint: disable=unused-argument
def disconnected(client):
    # Disconnected function will be called when the client disconnects.
    print("Disconnected from Adafruit IO!")


# Get wifi details and more from a secrets.py file
try:
    from secrets import secrets
except ImportError:
    print("WiFi secrets are kept in secrets.py, please add them there!")
    raise

# Set up SPI pins
esp32_cs = DigitalInOut(board.CS1)
esp32_ready = DigitalInOut(board.ESP_BUSY)
esp32_reset = DigitalInOut(board.ESP_RESET)

# Connect RP2040 to the WiFi module's ESP32 chip via SPI, then connect to WiFi
spi = busio.SPI(board.SCK1, board.MOSI1, board.MISO1)
esp = adafruit_esp32spi.ESP_SPIcontrol(spi, esp32_cs, esp32_ready, esp32_reset)
wifi = adafruit_esp32spi_wifimanager.ESPSPI_WiFiManager(esp, secrets)

# Configure the RP2040 Pico LED Pin as an output
led_pin = DigitalInOut(board.LED)
led_pin.switch_to_output()

# Connect to WiFi
print("Connecting to WiFi...")
wifi.connect()

# Initialize MQTT interface with the esp interface
MQTT.set_socket(socket, esp)

# Initialize a new MQTT Client object
mqtt_client = MQTT.MQTT(
    broker="io.adafruit.com",
    port=secrets["port"],
    username=secrets["aio_username"],
    password=secrets["aio_key"],
)





# Initialize an Adafruit IO MQTT Client
io = IO_MQTT(mqtt_client)

# Connect the callback methods defined above to Adafruit IO
io.on_connect = connected
io.on_disconnect = disconnected

# Connect to Adafruit IO
print("Connecting to Adafruit IO...")
try:
    io.connect()
except:
    print("Could not connect to IO")


###############################FULL HARDWARE LOOP CODE####################
while True:
    LED_side_ultrasonic_distance = sonar_LED_SIDE.distance
    PHOTO_side_ultrasonic_distance = sonar_PHOTO_SIDE.distance
    
    achieved_both_ULTRASONIC = False
    #######GET DATA FROM THE ULTRASONIC SENSOR########
    try:
        print((LED_side_ultrasonic_distance))
        print((PHOTO_side_ultrasonic_distance))
        achieved_both_ULTRASONIC = True
    except RuntimeError:
        print("Retrying!")
        achieved_both_ULTRASONIC = False
        pass


    #######GET DATA FROM THE PHOTORESISTOR#########

    photo1_value = adc_to_voltage(photoresistor_ONE.value)
    photo2_value = adc_to_voltage(photoresistor_TWO.value)
    print("PhotoResistor1:" + str(photo1_value))
    print("PhotoResistor2:" + str(photo2_value))

    list_photoresistances = [photo1_value,photo2_value]
    average_photoresistance = calculate_average(list_photoresistances)

    if achieved_both_ULTRASONIC:
        average_ultrasonic = calculate_average([LED_side_ultrasonic_distance, PHOTO_side_ultrasonic_distance])
    else: average_ultrasonic = -1

    quality_assessment = 0
    publish = False

    if (average_ultrasonic != -1):

        print([sonar_LED_SIDE.distance,PHOTO_side_ultrasonic_distance])

        if ((LED_side_ultrasonic_distance < ULTRASONIC_THRESHOLD) and (PHOTO_side_ultrasonic_distance < ULTRASONIC_THRESHOLD)):
            print("PLASTIC IS PRESENT - ULTRASONIC")
            if average_photoresistance > PHOTORESISTANCE_THRESHOLD:
                print("PLASTIC IS GOOD QUALITY - PHOTORESISTANCE")
                quality_assessment = 1
            else:
                print("PLASTIC IS BAD QUALITY - PHOTORESISTANCE")
                quality_assessment = 0
            user_decision = input("s to Save, r to re-test")
            
            #If the user indicated they wanted to save the plastic value, then publish to IOT
            if (user_decision == "s"):
                publish = True
            else:
                publish = False
                
            if (publish):
                io.publish("item-quality", quality_assessment)
        else:
            print("PLASTIC IS NOT PRESENT - ULTRASONIC")
    else:
        print("ULTRASONIC SENSORS NOT AVAILABLE")

    time.sleep(1)



#########################OLD IOT LOOP###################
#prv_refresh_time = 0.0
#while True:
#    # Send a new temperature reading to IO every 10 seconds
#    if (time.monotonic() - prv_refresh_time) > 5:
#        # publish it to io
#        print("publishing to io")
#        io.publish("welcome-dashboard", .5)
#        print("Published!")
#        prv_refresh_time = time.monotonic()
