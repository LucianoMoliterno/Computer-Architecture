;INICIALIZACION DEL PROGRAMA
				#include		<P16F628A.INC>                      ;TIPO DE PIC UTILIZADO
				LIST			P=16F628A                           ;PROCESADOR


				__CONFIG		3F10                                ;CONFIGURACIÓN DEL GRABADOR


				ORG				0x00								

;CONFIGURANDO PUERTOS A Y B
Inicio	
				bsf				STATUS,RP0	
				movlw			B'11111111'
				movwf			TRISA								
				movlw			B'11111001'
				movwf			TRISB								
				movlw			B'11001000'							
				movwf			OPTION_REG							
				bcf				STATUS,RP0
				movlw			0x07
				movwf			CMCON
				clrf			INTCON
				clrf			PORTA			
				clrf			PORTB
			
;ENVIANDO EL ASCENSOR A PB POR PRIMERA VEZ
				bsf				PORTB,2								;SE INDICA QUE DEBE BAJAR (YA QUE SE DESEA IR A PB)
				bcf				PORTB,1								;ENCIENDE EL MOTOR
Apb				btfss			PORTA,3								;PREGUNTA SI LA PUERTA ESTÁ CERRADA (1)
		        call			Emergencia							;SI LA PUERTA ESTÁ ABIERTA ENTRA Y LLAMA A LA RUTINA DE EMERGENCIA
			 	btfss			PORTA,0								;PREGUNTA SI ESTÁ EN PB (SI EL SENSOR RA0 ESTÁ EN 1) --
		      	goto			Apb									;REPITE EL PROCESO HASTA QUE SE ENCUENTRE EN PB
		     	bsf				PORTB,1								;APAGA EL MOTOR
		      	bcf				PORTB,2								;INDICA QUE NO DEBE SEGUIR BAJANDO
;BUCLE PRINCIPAL DEL PROGRAMA
Bucle			call			Emergencia							;LLAMO A EMERGENCIA
				call 			Pulsadores							;VERIFICO PULSADORES
				goto 			Bucle 								;VUELVO A COMENZAR EL BUCLE PRINCIPAL DEL PROGRAMA


;RUTINA DE SELECCION DE PISO

Pulsadores		btfsc			PORTB,4								;SI BOTON PARA IR A PB NO FUE PULSADO SALTEA A VERIFICAR EL SIGUIENTE
				call			PB
				btfsc			PORTB,5								;SI BOTON PARA IR A Piso1 NO FUE PULSADO SALTEA A VERIFICAR EL SIGUIENTE
				call			Piso1
				btfsc			PORTB,6								;SI BOTON PARA IR A Piso2 NO FUE PULSADO SALTEA A VERIFICAR EL SIGUIENTE
				call			Piso2
				return

;PROCESO DE IR A PLANTA BAJA
PB				bsf				PORTB,2								;SE INDICA QUE DEBE BAJAR (YA QUE SE DESEA IR A PB)
				bcf				PORTB,1								;ENCIENDE EL MOTOR
IrAPB			btfss			PORTA,3								;PREGUNTA SI LA PUERTA ESTÁ CERRADA
		        call			Emergencia							;SI LA PUERTA ESTÁ ABIERTA ENTRA Y LLAMA A LA RUTINA DE EMERGENCIA
			 	btfss			PORTA,0								;PREGUNTA SI ESTÁ EN PB (SI EL SENSOR RA0 ESTÁ EN 1, SALTEO EL GOTO) --
		      	goto			IrAPB								;REPITE EL PROCESO HASTA QUE SE ENCUENTRE EN PB
		     	bsf				PORTB,1								;APAGA EL MOTOR
		      	bcf				PORTB,2								;INDICA QUE NO DEBE SEGUIR BAJANDO
		      	return
			
;PROCESO PARA IR AL PRIMER PISO
Piso1			btfsc	PORTA,0										;SI ESTA EN PLANTA BAJA SUBE
				goto	Subir1P
				btfsc	PORTA,2										;SI ESTA EN EL SEGUNDO PISO BAJA
				goto	Bajar1P
				return
			

;RUTINA PARA SUBIR 1 PISO 
Subir1P			bcf				PORTB,2		   						;PONGO EL MOTOR PARA SUBIR
				bcf				PORTB,1         					;PRENDO EL MOTOR
Rutina1PS		btfss			PORTA,3								;PREGUNTA SI LA PUERTA ESTÁ CERRADA
		        call			Emergencia							;SI LA PUERTA ESTÁ ABIERTA ENTRA Y LLAMA A LA RUTINA DE EMERGENCIA
				btfss			PORTA,1								;Chequeo si estoy en el piso 1
				goto			Rutina1PS 							;Sino llegue al piso 1 itero, sigo chequeando.
				bsf				PORTB,1								;APAGO EL MOTOR
				return

;RUTINA PARA BAJAR AL 1 PISO
Bajar1P			bsf				PORTB,2        						;PONGO EL MOTOR PARA BAJAR
				bcf				PORTB,1         					;PRENDO EL MOTOR
Rutina1PB		btfss			PORTA,3								;PREGUNTA SI LA PUERTA ESTÁ CERRADA
		        call			Emergencia							;SI LA PUERTA ESTÁ ABIERTA ENTRA Y LLAMA A LA RUTINA DE EMERGENCIA
				btfss			PORTA,1         					;Chequeo si estoy en pb
				goto			Rutina1PB       					;Sino llegue al pb itero, sigo chequeando
				bsf				PORTB,1         					;APAGO EL MOTOR
				return


;PROCESO DE IR AL SEGUNDO PISO
				
Piso2			bsf				PORTB,2								;SE INDICA QUE DEBE SUBIR (YA QUE SE DESEA IR A PISO2)
				bcf				PORTB,1								;ENCIENDE EL MOTOR
IrAP2			btfss			PORTA,3								;PREGUNTA SI LA PUERTA ESTÁ CERRADA
		        call			Emergencia							;SI LA PUERTA ESTÁ ABIERTA ENTRA Y LLAMA A LA RUTINA DE EMERGENCIA
			 	btfss			PORTA,2								;PREGUNTA SI ESTÁ EN PISO2 (SI EL SENSOR RA2 ESTÁ EN 1) --
		      	goto			IrAP2								;REPITE EL PROCESO HASTA QUE SE ENCUENTRE EN PISO2
		     	bsf				PORTB,1								;APAGA EL MOTOR
		      	bcf				PORTB,2								;INDICA QUE NO DEBE SEGUIR BAJANDO
		      	return

;RUTINA DE EMERGENCIA EN CASO DE PUERTA ABIERTA

Emergencia		bsf				PORTB,1								;APAGA MOTOR
				bsf				PORTB,0        						;CIERRA PUERTA CABINA
seguir			btfss			PORTA,3 							;SALTEA GOTO SI ESTA CERRADO (1)
				goto			seguir
				bcf				PORTB,1								;PRENDE MOTOR
				return
				
				end
;FINAL DEL PROGRAMA 