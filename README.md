# VHDL-Number-Guessing-Game
**The reason the file names do not match to the project is because I initially started with a button mash game, but transitioned to a number guessing game, without making a new file/project**
Number guessing game using BASYS 3 Board

# How to play?
The device randomly generates a number from [0-9] (including 0 and 9), and the user must try to guess that number using switches 0 to 9(sw0 - sw9) on the BASYS 3 board. If the user wants to guess the number 4, the user will flip Switch 4 (sw4) to its on position.

If the user gets it right, the number will display on the 7 Segement Display, and the first LED will light up. 
    The user can then press the "Right" button to reset the game, which allows them to play again, this time the device will generate a different number.
If the user gets it wrong, nothing will happen, and the user can keep guessing.


