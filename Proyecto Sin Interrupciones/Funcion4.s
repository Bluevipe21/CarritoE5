;Se deben utilizar resistencias PULL-DOWN




PA2       EQU 0x40004010
PA5       EQU 0x40004080
PA6       EQU 0x40004100
PA7       EQU 0x40004200
FIVESEC    EQU 26666667      ; approximately 5s delay at ~16 MHz clock
THREESEC	EQU 16000000
TWOSEC EQU 10666667
ONESEC EQU 2666667 ;Tiempo para los giros de 90 grados
;Registros para puerto D
LEDS               EQU 0x4000703C   ; Acceso a PD3-PD0
;PD0 enciende con 0x01	----	IN1
;PD1 enciende con 0x02   ---	IN2
;PD2 enciende con 0x04	----	IN3
;PD3 enciende con 0x08	----	IN4
IN1 	EQU 0x01
IN2 	EQU 0x02
IN3 	EQU 0x04
IN4 	EQU 0x08
APAGAR EQU 0x00


RED       EQU 0x02
	
		AREA    |.text|, CODE, READONLY, ALIGN=2
        THUMB
		EXPORT PA7PRESSED
		IMPORT PortF_Output
		IMPORT delay
		IMPORT Loop
PA7PRESSED
	MOV R4,#0
	MOV R4,#RED						;se enciende el led azul PF2
	BL PortF_Output
	NOP
    NOP
	LDR R0,=FIVESEC					;Asigna valor de retardo
	BL delay						;Ejecuta el retardo
	;Aqui comenzar la funcion
	MOV R4,#0						;se asigna 0 al valor de salida de PF2
	BL PortF_Output					;establece valor de salida de PF2
	BL Loop			
			
		ALIGN 
		END