;Se deben utilizar resistencias PULL-DOWN

;Registros para puerto A
GPIO_PORTA_DIR_R   EQU 0x40004400
GPIO_PORTA_AFSEL_R EQU 0x40004420
GPIO_PORTA_PUR_R   EQU 0x40004510
GPIO_PORTA_DEN_R   EQU 0x4000451C
GPIO_PORTA_LOCK_R  EQU 0x40004520
GPIO_PORTA_CR_R    EQU 0x40004524
GPIO_PORTA_AMSEL_R EQU 0x40004528
GPIO_PORTA_PCTL_R  EQU 0x4000452C
GPIO_IS_R 		   EQU 0x40004404
GPIO_IBE_R		   EQU 0x40004408
GPIO_IEV_R		   EQU 0x4000440C
GPIO_IM_R		   EQU 0x40004410
GPIO_ICR_R		   EQU 0x4000441C


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
GPIO_PORTD_DIR_R   EQU 0x40007400	;establece si será entrada o salida
GPIO_PORTD_AFSEL_R EQU 0x40007420	;deshabilita otras funciones, establece el puerto como I/O
GPIO_PORTD_DR8R_R  EQU 0x40007508	;GPIO 8-mA Drive Select
GPIO_PORTD_DEN_R   EQU 0x4000751C	;habilita la función digital
GPIO_PORTD_AMSEL_R EQU 0x40007528	;funciones analogicas
GPIO_PORTD_PCTL_R  EQU 0x4000752C	;habilita los puertos como GPIO
SYSCTL_RCGCGPIO_R  EQU 0x400FE608	;registro de reloj en general
SYSCTL_RCGC2_GPIOD EQU 0x00000008   ; puerto D Clock Gating Control

;Registros para puerto F	
GPIO_PORTF_DATA_R  EQU 0x400253FC
GPIO_PORTF_DIR_R   EQU 0x40025400
GPIO_PORTF_AFSEL_R EQU 0x40025420
GPIO_PORTF_DEN_R   EQU 0x4002551C
GPIO_PORTF_LOCK_R  EQU 0x40025520
GPIO_PORTF_CR_R    EQU 0x40025524
GPIO_PORTF_AMSEL_R EQU 0x40025528
GPIO_PORTF_PCTL_R  EQU 0x4002552C
RED       EQU 0x02
BLUE      EQU 0x04
GREEN     EQU 0x08
		AREA    |.text|, CODE, READONLY, ALIGN=2
        THUMB
		EXPORT Loop
		IMPORT PA2PRESSED
		IMPORT PA5PRESSED	
		IMPORT PA6PRESSED
		IMPORT PA7PRESSED
Loop
	;PUSH {LR}
	;LEER PA2
	LDR R3,=PA2     ; pointer to PA2
	BL  Switch_Input                 ; read all of the switches on Port A
    CMP R4, #0x04                   ; R0 == 0x04?
    BEQ PA2PRESSED                  ; if so, switch 1 pressed
	;LEER PA5
	LDR R3, =PA5      ; pointer to PA5
	BL  Switch_Input                 ; read all of the switches on Port A
    CMP R4, #0x20                   ; R0 == 0x20?
    BEQ PA5PRESSED                  ; if so, switch 1 pressed
	
	;LEER PA6
	LDR R3, =PA6      ; pointer to PA6
	BL  Switch_Input                 ; read all of the switches on Port A
    CMP R4, #0x40                   ; R0 == 0x40?
    BEQ PA6PRESSED                  ; if so, switch 1 pressed
	
	;LEER PA7
	LDR R3, =PA7      ; pointer to PA7
	BL  Switch_Input                 ; read all of the switches on Port A
    CMP R4, #0x80                   ; R0 == 0x80?
    BEQ PA7PRESSED                  ; if so, switch 1 pressed
	;POP {PC}
	B Loop
		
Switch_Input
    LDR R4, [R3]      ; read just PA5
    BX  LR  	
	
		ALIGN
		END
	