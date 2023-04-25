## Car for drawing pictures

### Functionality

This project was carried out during my time at university and involved programming a cart to perform movements and draw an image. The cart used for the project was similar to the one shown below. All of the cart's functions were programmed in assembly language and the project was developed for the Texas Instruments TM4C123GH6PM microcontroller.



<img src="carrito.jpg" style="width:40%">

The Main.s file configures the ports that drive the inputs (buttons) and outputs (H-Bridge circuit) in this project. For the buttons, I used pull-down resistors. As for the outputs, I didn't need to use a particular circuit because I used a module called the DRIVER SHIELD L298N to control the rotation of the car's two motors for certain pictures.

<img src="motor.jpg" style="width:40%">


After the Main.s file executes the configuration of the ports for the microcontroller, the Read_Button.s file is called, which is responsible for reading the inputs (buttons) and determining which one was pressed in order to call a function.


1. Funcion1.s
2. Funcion2.s
3. Funcion3.s
4. Funcion4.s




