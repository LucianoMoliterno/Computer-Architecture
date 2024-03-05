# Computer Architecture (Assembler programming)
## In this repo you will find:

## 1.Mplab
## 2.Use of Proteus 
## 3.Using the Datasheet (PIC16F84A - Timer 0)
## 4.Exercises:
### Exercise 1: Based on a circuit composed of a PIC16F628A with LEDs on the RB0, RB1, RB2 and RB3 terminals, it is desired to develop a series of programs that allow:
#### [a] Turn on all the LEDs.
#### [b] Turn all LEDs on and off every one second.
#### [c] Same [b] but they are on for one second and off for 500ms.
#### [d] Turn on the LEDs from RB0 to RB3 with a delay of 500ms between them.
#### [e] Same point [d] but once they all turn on, they must begin to turn off from RB3 to RB0 with the same delay and carry out the entire cycle indefinitely.

### Exercise 2: Based on a circuit composed of a PIC16F628A with a button on terminal RB0 and an LED on terminals RB1 and RB2, develop the programs that allow:
#### [a] Turn on both LEDs when the button is pressed.
#### [b] Turn on the LEDs when the button is pressed and turn them off when pressed again.
#### [c] Perform the following sequence as the button is pressed: turn on RB1, turn on RB2, turn off RB1, turn off RB2.
#### [d] Same point [c] with interruption by RB0.

### Exercise 3: Based on a circuit composed of a PIC16F628A with a button on terminal RB0 and a display connected to terminals RB1-RB7:
#### [a] Count from 0 to 15 in hexadecimal each time the button is pressed and show the result on the display. When it reaches 15 the counter resets.
#### [b] Same point [a] but when it reaches 15 the counter begins to count down to 0. The sequence repeats indefinitely. 
#### [c] Same point [c] but the counter performs the sequence automatically. With the RB0 button you must be able to pause or resume the process. The step between number and number must be 1 second and must be done by using Timer 0 and interrupting by RB0

## 5.TP Elevator
## 6.TP Led Board
### A) Create a program that allows adding two three-digit hexadecimal numbers on the board according to the following sequence:
#### 1. A number is written on the displays. With the G1 button you increase the number on the board and with the G2 button you subtract it.
#### 2. The M button is pressed to allow entry of the second number.
#### 3. The second number is written. With the G1 button you increase the number on the board and with the G2 button you subtract it.
#### 4. The M button is pressed and the result is displayed.
#### 5. If you press the R button you start the program again.
#### If at any part of the sequence the power is cut off, it must be started from that place when connected again.
### B) Make a program that allows you to subtract two three-digit hexadecimal numbers on the board according to the following sequence:
#### 1. A number is written on the displays. With the G1 button you increase the number on the board and with the G2 button you subtract it.
#### 2. The M button is pressed to allow entry of the second number.
#### 3. The second number is written. With the G1 button you increase the number on the board and with the G2 button you subtract it.
#### 4. The M button is pressed and the result is displayed by doing N1-N2. If the result is negative, turn on the G segment of the display that is next to the last lit digit. (Ex: if the result gives -FF, turn on the g segment of the display 3, if it gives -9, turn on the g segment of the display 2).
#### 5. If you press the R button you start the program again.
#### If at any part of the sequence the power is cut off, it must be started from that place when connected again.
### C) Create a program that allows you to multiply two two-digit hexadecimal numbers on the board according to the following sequence:
#### 1. Both numbers are written on the board. With the G1 button the first number will be incremented and with the G2 button the second will be incremented. Pressing the R button resets both numbers.
#### 2. The M button is pressed and the multiplication is shown on the screen. Pressing the R button returns to step 1 (Numbers are not deleted).
#### If at any part of the sequence the power is cut off, it must be started from that place when connected again.
### D) Create a program that allows adding two three-digit decimal numbers on the board according to the following sequence:
#### 1. A number is written on the displays. With the G1 button you increase the number on the board and with the G2 button you subtract it.
#### 2. The M button is pressed to allow entry of the second number.
#### 3. The second number is written. With the G1 button you increase the number on the board and with the G2 button you subtract it.
#### 4. The M button is pressed and the result is displayed.
#### 5. If you press the R button you start the program again.
#### If at any part of the sequence the power is cut off, it must be started from that place when connected again.
### E) Create a program that allows you to subtract two three-digit decimal numbers on the board according to the following sequence:
#### 1. A number is written on the displays. With the G1 button you increase the number on the board and with the G2 button you subtract it.
#### 2. The M button is pressed to allow entry of the second number.
#### 3. The second number is written. With the G1 button you increase the number on the board and with the G2 button you subtract it.
#### 4. The M button is pressed and the result is displayed by doing N1-N2. If the result is negative, turn on the G segment of the display that is next to the last lit digit. (Ex: if the result gives -85, turn on the g segment of the display 3, if it gives -9, turn on the g segment of the display 2).
#### 5. If you press the R button you start the program again.
#### If at any part of the sequence the power is cut off, it must be started from that place when connected again.
### F) Create a program that allows you to multiply two two-digit decimal numbers on the board according to the following sequence:
#### 1. Both numbers are written on the board. With the G1 button the first number will be incremented and with the G2 button the second will be incremented. Pressing the R button resets both numbers.
#### 2. The M button is pressed and the multiplication is shown on the screen. Pressing the R button returns to step 1 (Numbers are not deleted).
#### If at any part of the sequence the power is cut off, it must be started from that place when connected again.