## Car for drawing pictures

### Functionality

This project was carried out during my time at university and involved programming a cart to perform movements and draw an image. The cart used for the project was similar to the one shown below. All of the cart's functions were programmed in assembly language and the project was developed for the Texas Instruments TM4C123GH6PM microcontroller.



<img src="carrito.jpg" style="width:40%">

The Main.s file configures the ports that drive the inputs (buttons) and outputs (H-Bridge circuit) in this project. For the buttons, I used pull-down resistors. As for the outputs, I didn't need to use a particular circuit because I used a module called the DRIVER SHIELD L298N to control the rotation of the car's two motors for certain pictures.

<img src="motor.jpg" style="width:40%">


After the Main.s file executes the configuration of the ports for the microcontroller, the Read_Button.s file is called, which is responsible for reading the inputs (buttons) and determining which one was pressed in order to call a function.

Loop
	;PUSH {LR}
	;LEER PA2
	LDR R3,=PA2     ; pointer to PA2
	BL  Switch_Input                 ; read all of the switches on Port A
    CMP R4, #0x04                   ; R0 == 0x04?
    BEQ PA2PRESSED                  ; if so, switch was pressed
	;LEER PA5
	LDR R3, =PA5      ; pointer to PA5
	BL  Switch_Input                 ; read all of the switches on Port A
    CMP R4, #0x20                   ; R0 == 0x20?
    BEQ PA5PRESSED                  ; if so, switch was pressed
	
	;LEER PA6
	LDR R3, =PA6      ; pointer to PA6
	BL  Switch_Input                 ; read all of the switches on Port A
    CMP R4, #0x40                   ; R0 == 0x40?
    BEQ PA6PRESSED                  ; if so, switch was pressed
	
	;LEER PA7
	LDR R3, =PA7      ; pointer to PA7
	BL  Switch_Input                 ; read all of the switches on Port A
    CMP R4, #0x80                   ; R0 == 0x80?
    BEQ PA7PRESSED                  ; if so, switch was pressed
	;POP {PC}
	B Loop

As its seen before this part of the code works as a switch in C that reads a value and depending of it will do something. This Loop function was exported and imported in the Main.s. In the next code we called the function from the Main.s

		AREA    |.text|, CODE, READONLY, ALIGN=2
        THUMB
        EXPORT  Start
		IMPORT Loop
Start
	BL PORTD_Init ; Función para la configuracion de salidas
	BL PortA_Init ; Función para la configuracion de entradas (botones)
	BL PortF_Init ; Función para la configuración de los leds propios del microcontrolador
	B Loop


Also we see that the IMPORT of the function is made it here. And inside the Start function is executed the Loop function. After this the functions to drawing the pictures are called, this functions are PA2PRESSED, PA5PRESSED, PA6PRESSED and PA7PRESSED. To use this functions inside the Read_Button.s we have to import the functions from the next files:

1. Funcion1.s
2. Funcion2.s
3. Funcion3.s
4. Funcion4.s


Every file has the corresponding function to do the work. 


