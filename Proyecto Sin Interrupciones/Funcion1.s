;Se deben utilizar resistencias PULL-DOWN



PA2       EQU 0x40004010
PA5       EQU 0x40004080
PA6       EQU 0x40004100
PA7       EQU 0x40004200
FIVESEC    EQU 26666667      ; approximately 5s delay at ~16 MHz clock
THREESEC	EQU 16000000
TWOSEC EQU 5000000
;ONESEC EQU 2150555 ;Tiempo para los giros de 90 grados
ONESEC EQU 3900000
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


;Registros para puerto F de salidas	
GPIO_PORTF_DATA_R  EQU 0x400253FC

RED       EQU 0x02
BLUE      EQU 0x04
GREEN     EQU 0x08		
		AREA    |.text|, CODE, READONLY, ALIGN=2
        THUMB
		EXPORT PA2PRESSED
		EXPORT PortF_Output
		EXPORT delay
		IMPORT Loop
PA2PRESSED
	MOV R4,#(GREEN+BLUE)						
	BL PortF_Output
	NOP
    NOP
	LDR R0,=FIVESEC
	BL delay ;Retardo de 5 segundos
	;Mover recto
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=TWOSEC
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=4500000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=TWOSEC
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=4600000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=TWOSEC
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Giro
	LDR R1,=(IN1)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=4400000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	;Mover recto
	LDR R1,=(IN1+IN3)
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]                    ; [R0] = R1 = 9 PD0 ENCIENDE - IN4
	LDR R0,=7000000
	BL delay
	LDR R1,=APAGAR
	LDR R0, =LEDS ;se asigna R0 como registro de control para los puertos D
	STR R1, [R0]
	
	MOV R4,#0						;se asigna 0 al valor de salida de PF2
	BL PortF_Output					;establece valor de salida de PF2
	BL Loop		
PortF_Output
    LDR R3, =GPIO_PORTF_DATA_R ; puntero para datos del Port F 
    STR R4, [R3]               ; escribir a PF3-1
    BX  LR	
delay                  ; if so, switch 1 pressed
    SUBS R0, R0, #1                 ; R0 = R0 - 1 (count = count - 1)
    BNE delay                       ; if count (R0) != 0, skip to 'delay'
    BX  LR                          ; return	
		ALIGN
		END