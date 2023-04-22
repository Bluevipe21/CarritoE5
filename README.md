## Carrito para dibujar figuras

### Funcionamiento

Este proyecto lo lleve en la universidad y consistía en hacer que un carrito realizará el movimiento para dibujar una imagen. El carrito era como el que se ve a continuación:

![Carrito de acrilíco](carrito.jpg)

Básicamente se hace que el carrito se mueva con giros y movimientos temporizados utilizando el lenguaje ensamblador en el microcontrolador TM4C123GH6PM de Texas Instruments. Al presionar un botón se realiza una figura. 

El archivo Main.s maneja la configuración de los puertos (que se describen en el) y este llama posteriormente al archivo Read_Button.s que se encarga de leer los botones para saber cuál función realizar. Este último archivo tiene la funcionalidad de llamar a las funciones que dependiendo del botón que se presionó este realiza la acción (dibuja la figura). Las funciones para dibujar las figuras se encuentran en los archivos:

1. Funcion1.s
2. Funcion2.s
3. Funcion3.s
4. Funcion4.s




