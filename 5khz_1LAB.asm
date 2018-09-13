;Este es un comentario, esta es una plantilla

    list p=18f4550			;Modelo del microcontrolador

    #include<p18f4550.inc>		;Llamo a la librería de nombre de los regs

    

    ;Zona de los bits de configuración (falta)
    
    CONFIG  FOSC = XT_XT	  ; Oscillator Selection bits (XT oscillator (XT))
    ;CONFIG  FOSC = INTOSCIO_EC	  ; Oscillator Selection bits (XT oscillator (XT))

    CONFIG  PWRT = ON             ; Power-up Timer Enable bit (PWRT enabled)

    CONFIG  BOR = OFF             ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)

    CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))

    CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)

    CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)



    CONFIG  CCP2MX = ON           ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)

    CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)
    
MODE EQU 0x0063

	org 0x0000
	clrf MODE

	goto configuro
	
	org 0x0008

	goto interrop
	
	org 0x0020

configuro:
	    clrf TRISD
    
	    ;movlw 0x62
	    
	    ;movwf OSCCON	;para modificar la frecuencia a 4MHz
    
	    bsf TRISB, 0
	    
	    bcf TRISB, 4	;Puerto B4 como salida, por donde saldrá la onda cuadrada
	    
	    movlw 0xC8

	    movwf T0CON		;Timer0 con 1:1
	    
	    movlw 0x90

	    movwf INTCON	;Interrupción habilitada para INT0
	    
	    bsf INTCON2, INTEDG0

inicio:	    tstfsz MODE
    
	    goto twenty
	    
	    movlw 0x3F
	    
	    movwf LATD
    
	    bcf LATB, 4
	    
	    goto inicio
	   
twenty:	    movlw .1
	    
	    cpfseq MODE
    
	    goto fifty
	    
	    movlw 0x06
	    
	    movwf LATD
    
	    bsf LATB, 4
	    
	    movlw .226	    ;216
	    
	    movwf TMR0L
	    
	    bcf INTCON, 2
	    
	    call papa
	    
	    bcf LATB, 4
	    
	    movlw .118	    ;96
	    
	    nop
	    nop
	    nop
	    
	    movwf TMR0L
	    
	    bcf INTCON, 2
	    
	    call papa
	    
	    goto twenty
	    
fifty:	    movlw .2
	    
	    cpfseq MODE
    
	    goto sxdix
	    
	    movlw 0x5B
	    
	    movwf LATD
    
	    btg LATB, 4
	    
	    movlw .178	    ;156
	    
	    nop
	    nop
	    nop
	    
	    movwf TMR0L
	    
	    bcf INTCON, 2
	    
	    call papa
	    
	    goto fifty
	    
sxdix:	    movlw .3
	    
	    cpfseq MODE
    
	    goto hundred
	    
	    movlw 0x4F
	    
	    movwf LATD
    
	    bsf LATB, 4
	    
	    movlw .126	    ;116
	    
	    movwf TMR0L
	    
	    bcf INTCON, 2
	    
	    call papa
	    
	    bcf LATB, 4
	    
	    movlw .218	    ;196
	    
	    nop
	    nop
	    nop
	    
	    movwf TMR0L
	    
	    bcf INTCON, 2
	    
	    call papa
	    
	    goto sxdix	   
	    
hundred:    movlw .4
	    
	    cpfseq MODE
    
	    goto inicio
    
	    movlw 0x66
	    
	    movwf LATD
    
	    bsf LATB, 4
	    
	    goto hundred
	    
papa:	    btfss INTCON, TMR0IF
	    
	    goto papa
	    
	    return

interrop:   bcf INTCON, INT0IF
	    
	    incf MODE
    
	    movlw .5
	    
	    cpfslt MODE
    
	    clrf MODE
	    
	    retfie
	    

	    end