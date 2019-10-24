;Se deben utilizar resistencias PULL-DOWN




PA2       EQU 0x40004010
PA5       EQU 0x40004080
PA6       EQU 0x40004100
PA7       EQU 0x40004200
FIVESEC    EQU 26666667      ; approximately 5s delay at ~16 MHz clock
THREESEC	EQU 16000000
TWOSEC EQU 5000000
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
	;Mover recto
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=6500000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=4200000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=3200000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=5800000;Giro de 45
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=8667221
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=5200000;Vuelta antes de la segunda hipotenusa
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=7667221 ;Segunda hipotenusa
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=5400000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=3800000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro ACA EMPIEZA EL CIRCULO
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1700000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto 
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1000000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro 
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1700000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto 
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1000000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro 
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1700000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto 
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1000000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0];ACA VAMOS
	;Giro 
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1700000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto 
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1000000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro 
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1700000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto 
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1000000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro 
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1700000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto 
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1000000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro 
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1700000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto 
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1000000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro 
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1700000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto 
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1000000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro 
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1700000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto 
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1000000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro 
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1700000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto 
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1000000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro 
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=1700000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	
	MOV R4,#0						;se asigna 0 al valor de salida de PF2
	BL PortF_Output					;establece valor de salida de PF2
	BL Loop			
			
		ALIGN 
		END