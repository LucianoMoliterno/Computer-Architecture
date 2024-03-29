	#INCLUDE<P16F628.INC>
		__CONFIG 3F10
		
;DECLARACION DE ESPACIOS DE MEMORIA A USAR		
		CBLOCK	0X20
		D1
		D2
		D3
		D4
		AUX_W
		AUX_STATUS
		CONT_AR	
		CONT_AR_2
		ENDC		

;DECLARACION DE CONSTATNES
#DEFINE BTN_G1 	PORTA,6 ;Boton G1
#DEFINE BTN_G2 	PORTA,7 ;Boton G2
#DEFINE BTN_R 	PORTA,4 ;Boton R
#DEFINE BTN_M 	PORTB,0 ;Boton M

#DEFINE PIN_D1 	3 ;puerto 3
#DEFINE PIN_D2 	2 ;puerto 2
#DEFINE PIN_D3 	0 ;puerto 0
#DEFINE PIN_D4 	1 ;puerto 1

#DEFINE	CTRL_DISPLAY	PORTA
#DEFINE	APAGAR_DISPLAYS CLRF	PORTA

;DECLARACION DE MACROS

MOSTRAR	MACRO	DIGITO,PIN
		APAGAR_DISPLAYS
		MOVF	DIGITO,W
		CALL	TAB_DISPLAY
		MOVWF	PORTB
		BSF		CTRL_DISPLAY,PIN
		ENDM

SUMAR	MACRO	DIGITO
		INCF	DIGITO,1
		MOVF	DIGITO,W
		XORLW	.10
		BTFSC	STATUS,Z
		CLRF	DIGITO
		ENDM

RESTAR	MACRO	DIGITO
		DECF	DIGITO,1
		MOVF	DIGITO,W
		XORLW	.10
		BTFSC	STATUS,Z
		CLRF	DIGITO
		ENDM
;---------------------------------------------------------------------------------------;


;INICIO DEL PROGRAMA		
		
		ORG		0X00
		GOTO	CONFI
		ORG		0X04		

;RUTINA DE INTERRUPCION
;DESBORDA EL TIMER CADA 5ms
;MUESTRA TODOS LOS DIGITOS DE ACUERDO A LAS VARIABLES D1:4

;GUARDA STATUS Y W EN VARIABLES AUXILIARES
		BCF		INTCON,T0IF
		BCF		INTCON,GIE		
		MOVWF	AUX_W
		MOVLW	STATUS
		MOVWF	AUX_STATUS
;MULTIPLEXADO DE DISPLAYS
		BTFSC	CTRL_DISPLAY,PIN_D1
		GOTO	MOSTRAR_D2			
		BTFSC	CTRL_DISPLAY,PIN_D2
		GOTO	MOSTRAR_D3
		BTFSC	CTRL_DISPLAY,PIN_D3
		GOTO	MOSTRAR_D4
		
		MOSTRAR	D1,PIN_D1
		GOTO 	FIN_T0I

MOSTRAR_D2
		MOSTRAR D2,PIN_D2
		GOTO 	FIN_T0I

MOSTRAR_D3
		MOSTRAR D3,PIN_D3
		GOTO 	FIN_T0I

MOSTRAR_D4
		MOSTRAR	D4,PIN_D4
		
FIN_T0I
;REINICIA TIMER Y RECUPERA STATUS Y W
		MOVLW	.236
		MOVWF	TMR0
		MOVF	AUX_STATUS,W
		MOVWF	STATUS
		MOVF	AUX_W,W
		RETFIE

;CONFIGURACION
		
CONFI
		MOVLW	0X07
		MOVWF	CMCON; CMCON SE TIENE QUE ESTABLECER EN 7 PARA USAR TODO EL PORTA
		MOVLW	.236
		MOVWF	TMR0
		BSF		STATUS,RP0
		MOVLW	b'00000001'
		MOVWF	TRISB	
		MOVLW	b'11110000'
		MOVWF	TRISA
		BCF		OPTION_REG,T0CS
		BCF		OPTION_REG,PSA
		BSF		OPTION_REG,PS0
		BSF		OPTION_REG,PS1
		BSF		OPTION_REG,PS2
		BSF		INTCON,GIE
		BSF		INTCON,T0IE
		BCF		STATUS,RP0

;RUTINA PRINCIPAL
;INCREMENTA DE 0 A 9 CADA DIGITO DEPENDIENDO QUE BOT?N SE TOCA. 

		CLRF	PORTA
		CLRF	PORTB

		; D1-4 display

		CLRF	D1 
		CLRF	D2
		CLRF	D3
		CLRF	D4
BOTONES
		BTFSC	BTN_G1
		CALL	DEMORA_AR
		BTFSC	BTN_G1
		SUMAR	D4
		BTFSC	BTN_G2
		CALL	DEMORA_AR
		BTFSC	BTN_G2
		RESTAR	D4
		BTFSC	BTN_R
		CALL	DEMORA_AR
		BTFSC	BTN_R
		SUMAR	D2
		BTFSC	BTN_M
		CALL	DEMORA_AR
		BTFSC	BTN_M
		SUMAR	D1
		GOTO 	BOTONES


DEMORA_AR
		MOVLW	.255
		MOVWF	CONT_AR
LOOP_AR
		MOVLW	.255
		MOVWF	CONT_AR_2
LOOP_AR_2
		DECFSZ	CONT_AR_2,1
		GOTO	LOOP_AR_2
		DECFSZ	CONT_AR,1
		GOTO	LOOP_AR
		RETURN
			
;CONVERSOR A DISPLAY
;RB1->SEG A
;RB2->SEG B 
;RB3->SEG C
;RB4->SEG D
;RB5->SEG E 
;RB6->SEG F
;RB7->SEG G

TAB_DISPLAY
		ADDWF	PCL,1
		;         GFEDCBA-
		RETLW	b'01111111'	
		RETLW	b'00001101'
		RETLW	b'10110111'
		RETLW	b'10011111'
		RETLW	b'11001101'
		RETLW	b'11011011'
		RETLW	b'11111011'
		RETLW	b'00001111'
		RETLW	b'11111111'
		RETLW	b'11001111'
		
		END