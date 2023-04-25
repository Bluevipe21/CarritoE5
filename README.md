## Car for drawing pictures

### Functionality

This project was carried out during my time at university and involved programming a cart to perform movements and draw an image. The cart used for the project was similar to the one shown below. All of the cart's functions were programmed in assembly language and the project was developed for the Texas Instruments TM4C123GH6PM microcontroller.



<img src="carrito.jpg" style="width:40%">

The Main.s file configures the ports that drive the inputs (buttons) and outputs (H-Bridge circuit) in this project. For the buttons, I used pull-down resistors. As for the outputs, I didn't need to use a particular circuit because I used a module called the DRIVER SHIELD L298N to control the rotation of the car's two motors for certain pictures.

<img src="motor.jpg" style="width:40%">


After executing the configuration of the microcontroller's ports, the Main.s file calls the Read_Button.s file, which is responsible for reading the input signals from the buttons and determining which button was pressed in order to call a corresponding function.



Loop
	;PUSH {LR}
	;LEER PA2
	LDR R3,=PA2                 ; pointer to PA2
	BL  Switch_Input            ; read all of the switches on Port A
    CMP R4, #0x04                   ; R0 == 0x04?
    BEQ PA2PRESSED                  ; if so, switch was pressed
	;LEER PA5
	LDR R3, =PA5                ; pointer to PA5
	BL  Switch_Input            ; read all of the switches on Port A
    CMP R4, #0x20                   ; R0 == 0x20?
    BEQ PA5PRESSED                  ; if so, switch was pressed
	
	;LEER PA6
	LDR R3, =PA6                ; pointer to PA6
	BL  Switch_Input            ; read all of the switches on Port A
    CMP R4, #0x40                   ; R0 == 0x40?
    BEQ PA6PRESSED                  ; if so, switch was pressed
	
	;LEER PA7
	LDR R3, =PA7                ; pointer to PA7
	BL  Switch_Input            ; read all of the switches on Port A
    CMP R4, #0x80                   ; R0 == 0x80?
    BEQ PA7PRESSED                  ; if so, switch was pressed
	;POP {PC}
	B Loop


As previously demonstrated, this portion of the code functions like a switch statement in C, where it reads a value and executes different actions based on the result. The Loop function was exported and imported into the Main.s file, and is subsequently called from within that file in the following code.



		AREA    |.text|, CODE, READONLY, ALIGN=2
        THUMB
        EXPORT  Start
		IMPORT Loop
Start
	BL PORTD_Init ; Configuration of outputs
	BL PortA_Init ; Configuration of inputs
	BL PortF_Init ; Configurations of the led's from the microcontroller
	B Loop 	      ; Read the button pressed


In addition, the IMPORT of the function is defined here. The Start function subsequently executes the Loop function, after which the functions responsible for drawing the pictures - namely, PA2PRESSED, PA5PRESSED, PA6PRESSED, and PA7PRESSED - are called. To use these functions within the Read_Button.s file, they must first be imported from the corresponding files.

1. Funcion1.s
2. Funcion2.s
3. Funcion3.s
4. Funcion4.s


Every file has the corresponding function to do the work. 


