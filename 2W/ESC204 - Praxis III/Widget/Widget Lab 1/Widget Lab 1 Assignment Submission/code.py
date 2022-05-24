# Import libraries needed for blinking the LED
import board
import digitalio
# Configure the internal GPIO connected to the LED as a digital output
ledred = digitalio.DigitalInOut(board.GP16)
ledred.direction = digitalio.Direction.OUTPUT
ledgreen = digitalio.DigitalInOut(board.GP15)
ledgreen.direction = digitalio.Direction.OUTPUT
# Configure the internal GPIO connected to the button as a digital input
button = digitalio.DigitalInOut(board.GP14)
button.direction = digitalio.Direction.INPUT
button.pull = digitalio.Pull.UP # Sets the internal resistor to pull-up
# Print a message on the serial console
print('Hello! My LED is controlled by the button.')

#Initializing variables
state = 0
prev_button_val = button.value

# Loop so the code runs continuously
while True:
    button_val = button.value # to prevent errors from changes in button.value mid-loop
    if button_val != prev_button_val: # check if button value has changed
        prev_button_val = button_val # if button value has changed, update the previous button value to current one
        if button_val == 0: # only update LEDs and state if button was PRESSED (instead of released)
            print('button pressed!') # prints message if button is pressed
            state = (state+1) % 3 # sets next state
            # Updating LEDs based on state
            ledred.value = state != 0
            ledgreen.value = state == 2
            print(ledred.value, ledgreen.value) # printing LED values for debugging purposes
