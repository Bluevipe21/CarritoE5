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
        EXPORT  Start
		IMPORT Loop
Start
	BL PORTD_Init ;configuracion de salidas
	BL PortA_Init ;configuracion de entradas
	BL PortF_Init
	B Loop
 
PortF_Init
    LDR R1, =SYSCTL_RCGCGPIO_R      ; 1)Activar reloj para puerto F
    LDR R0, [R1]                 
    ORR R0, R0, #0x20               ; El #0x20 es para el reloj del puerto F
    STR R0, [R1]                  
    NOP
    NOP                             
    LDR R1, =GPIO_PORTF_LOCK_R      ; 2) desbloquea el registro bloqueado
    LDR R0, =0x4C4F434B             ; desbloquea GPIO Port F Commit Register
    STR R0, [R1]                    
    LDR R1, =GPIO_PORTF_CR_R        ; habilita funciones para Port F
    MOV R0, #0xFF                   ; 1 significa permitir acceso
    STR R0, [R1]                    
    LDR R1, =GPIO_PORTF_AMSEL_R     ; 3) deshabilita la funcion analogica
    MOV R0, #0                      ; 0 significa el analogico esta apagado
    STR R0, [R1]                    
    LDR R1, =GPIO_PORTF_PCTL_R      ; 4) configura como GPIO
    MOV R0, #0x00000000             ; 0 significa configurar Port F como GPIO
    STR R0, [R1]                  
    LDR R1, =GPIO_PORTF_DIR_R       ; 5) se pone el bit de registro
    MOV R0,#0x0E                    ; PF0 and PF7-4 input, PF3-1 salidas
    STR R0, [R1]                    
    LDR R1, =GPIO_PORTF_AFSEL_R     ; 6) puerto de regulador de funcion
    MOV R0, #0                      ; 0 deshabilitar la funcion alterna 
    STR R0, [R1]                                  
    LDR R1, =GPIO_PORTF_DEN_R       ; 7) habilita Port F como puerto digital
    MOV R0, #0x0E                   ; 1 significa habilitar como I/O
    STR R0, [R1]                   
    BX  LR			

PORTD_Init
    ; 1) Activar reloj para puerto D
    LDR R1, =SYSCTL_RCGCGPIO_R      ; R1 = &SYSCTL_RCGCGPIO_R
    LDR R0, [R1]                    ; R0 = [R1]
    ORR R0, R0, #SYSCTL_RCGC2_GPIOD ; R0 = R0|SYSCTL_RCGC2_GPIOD
    STR R0, [R1]                    ; [R1] = R0
    NOP
    NOP                             ; Permite tiempo para activarse
    ; 2) no need to unlock PD3-0
    ; 3) disable analog functionality
    LDR R1, =GPIO_PORTD_AMSEL_R     ; R1 = &GPIO_PORTD_AMSEL_R
    LDR R0, [R1]                    ; R0 = [R1]
    BIC R0, R0, #0x0F               ; R0 = R0&~0x0F (deshabilita la funcion analogica en PD3-0)
    STR R0, [R1]                    ; [R1] = R0    
    ; 4) configure as GPIO
    LDR R1, =GPIO_PORTD_PCTL_R      ; R1 = &GPIO_PORTD_PCTL_R
    LDR R0, [R1]                    ; R0 = [R1]
    MOV R2, #0x0000FFFF             ; R2 = 0x0000FFFF
    BIC R0, R0, R2                  ; R0 = R0&~0x0000FFFF (clear port control field for PD3-0)
    STR R0, [R1]                    ; [R1] = R0

    ; 5) set direction register
    LDR R1, =GPIO_PORTD_DIR_R       ; R1 = &GPIO_PORTD_DIR_R
    LDR R0, [R1]                    ; R0 = [R1]
    ORR R0, R0, #0x0F               ; R0 = R0|0x0F (make PD3-0 output)
    STR R0, [R1]                    ; [R1] = R0
    ; 6) regular port function
    LDR R1, =GPIO_PORTD_AFSEL_R     ; R1 = &GPIO_PORTD_AFSEL_R
    LDR R0, [R1]                    ; R0 = [R1]
    BIC R0, R0, #0x0F               ; R0 = R0&~0x0F (disable alt funct on PD3-0)
    STR R0, [R1]                    ; [R1] = R0
    ; enable 8mA drive (only necessary for bright LEDs)
    LDR R1, =GPIO_PORTD_DR8R_R      ; R1 = &GPIO_PORTD_DR8R_R
    LDR R0, [R1]                    ; R0 = [R1]
    ORR R0, R0, #0x0F               ; R0 = R0|0x0F (habilita 8mA drive en PD3-0)
    STR R0, [R1]                    ; [R1] = R0
    ; 7) enable digital port
    LDR R1, =GPIO_PORTD_DEN_R       ; R1 = &GPIO_PORTD_DEN_R
    LDR R0, [R1]                    ; R0 = [R1]
    ORR R0, R0, #0x0F               ; R0 = R0|0x0F (habilita las I/O digitales en PD3-0)
    STR R0, [R1]                    ; [R1] = R0

    BX  LR

PortA_Init
	;BL DisableInterrupts
    LDR R1, =SYSCTL_RCGCGPIO_R         ; 1) activate clock for Port A
    LDR R0, [R1]                 
    ORR R0, R0, #0x01               ; set bit 0 to turn on clock
    STR R0, [R1]                  
    NOP
    NOP                             ; allow time for clock to finish
    ;PA5                                ; 2) no need to unlock Port A                 
    LDR R1, =GPIO_PORTA_AMSEL_R     ; 3) disable analog functionality
    LDR R0, [R1]                    
    BIC R0, #0x20                   ; 0 means analog is off
    STR R0, [R1]                    
    LDR R1, =GPIO_PORTA_PCTL_R      ; 4) configure as GPIO
    LDR R0, [R1]                    
    BIC R0, #0x00F00000             ; 0 means configure PA5 as GPIO
    STR R0, [R1]                  
    LDR R1, =GPIO_PORTA_DIR_R       ; 5) set direction register
    LDR R0, [R1]                    
    BIC R0, #0x20                   ; PA5 input
    STR R0, [R1]                    
    LDR R1, =GPIO_PORTA_AFSEL_R     ; 6) regular port function
    LDR R0, [R1]                    
    BIC R0, #0x20                   ; 0 means disable alternate function 
    STR R0, [R1]                                 
    LDR R1, =GPIO_PORTA_DEN_R       ; 7) enable Port A digital port
    LDR R0, [R1]                    
    ORR R0, #0x20                   ; 1 means enable digital I/O
    STR R0, [R1]       
	
    ;PA2
	NOP                            ; allow time for clock to finish
    NOP                                ; 2) no need to unlock Port A                 
    LDR R1, =GPIO_PORTA_AMSEL_R     ; 3) disable analog functionality
    LDR R0, [R1]                    
    BIC R0, #0x04                   ; 0 means analog is off
    STR R0, [R1]                    
    LDR R1, =GPIO_PORTA_PCTL_R      ; 4) configure as GPIO
    LDR R0, [R1]                    
    BIC R0, #0x00F00000             ; 0 means configure PA5 as GPIO
    STR R0, [R1]                  
    LDR R1, =GPIO_PORTA_DIR_R       ; 5) set direction register
    LDR R0, [R1]                    
    BIC R0, #0x04                   ; PA5 input
    STR R0, [R1]                    
    LDR R1, =GPIO_PORTA_AFSEL_R     ; 6) regular port function
    LDR R0, [R1]                    
    BIC R0, #0x04                   ; 0 means disable alternate function 
    STR R0, [R1]                                 
    LDR R1, =GPIO_PORTA_DEN_R       ; 7) enable Port A digital port
    LDR R0, [R1]                    
    ORR R0, #0x04                   ; 1 means enable digital I/O
    STR R0, [R1]                   
    ;PA6
	NOP                            ; allow time for clock to finish
    NOP                                ; 2) no need to unlock Port A                 
    LDR R1, =GPIO_PORTA_AMSEL_R     ; 3) disable analog functionality
    LDR R0, [R1]                    
    BIC R0, #0x40                   ; 0 means analog is off
    STR R0, [R1]                    
    LDR R1, =GPIO_PORTA_PCTL_R      ; 4) configure as GPIO
    LDR R0, [R1]                    
    BIC R0, #0x00F00000             ; 0 means configure PA5 as GPIO
    STR R0, [R1]                  
    LDR R1, =GPIO_PORTA_DIR_R       ; 5) set direction register
    LDR R0, [R1]                    
    BIC R0, #0x40                   ; PA5 input
    STR R0, [R1]                    
    LDR R1, =GPIO_PORTA_AFSEL_R     ; 6) regular port function
    LDR R0, [R1]                    
    BIC R0, #0x40                   ; 0 means disable alternate function 
    STR R0, [R1]                                 
    LDR R1, =GPIO_PORTA_DEN_R       ; 7) enable Port A digital port
    LDR R0, [R1]                    
    ORR R0, #0x40                   ; 1 means enable digital I/O
    STR R0, [R1]
	
	;PA7
	NOP                            ; allow time for clock to finish
    NOP                                ; 2) no need to unlock Port A                 
    LDR R1, =GPIO_PORTA_AMSEL_R     ; 3) disable analog functionality
    LDR R0, [R1]                    
    BIC R0, #0x80                   ; 0 means analog is off
    STR R0, [R1]                    
    LDR R1, =GPIO_PORTA_PCTL_R      ; 4) configure as GPIO
    LDR R0, [R1]                    
    BIC R0, #0x00F00000             ; 0 means configure PA5 as GPIO
    STR R0, [R1]                  
    LDR R1, =GPIO_PORTA_DIR_R       ; 5) set direction register
    LDR R0, [R1]                    
    BIC R0, #0x80                   ; PA5 input
    STR R0, [R1]                    
    LDR R1, =GPIO_PORTA_AFSEL_R     ; 6) regular port function
    LDR R0, [R1]                    
    BIC R0, #0x80                   ; 0 means disable alternate function 
    STR R0, [R1]                                 
    LDR R1, =GPIO_PORTA_DEN_R       ; 7) enable Port A digital port
    LDR R0, [R1]                    
    ORR R0, #0x80                   ; 1 means enable digital I/O
    STR R0, [R1]
	
    BX  LR
		
		ALIGN
		END