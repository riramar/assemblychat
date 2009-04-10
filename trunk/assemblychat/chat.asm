;********************************************************************************************
; 
; Projeto   : Chat (Protocolo RP) versao 1.0
; Arquivo   : CHAT.ASM
; Professor : Wilson Ruiz
; Alunos    : Ricardo Iramar dos Santos e Fernando Medeiro Silva
; Data      : 11/05/2002
; 
;********************************************************************************************


;********************************************************************************************
; 
; Inicio do programa
; 


	CR 	EQU	13
	LF	EQU	10

	DOSSEG
	.MODEL SMALL
	.STACK
	.DATA	

	PA	EQU	0380h		;Porta A
	PB	EQU	0381h		;Porta B
	PC	EQU	0382h		;Porta C
	PP	EQU	0383h		;Porta Programacao
	
	inicial	DB	      '*----------------------------------------------------------------------------*'
		DB	CR,LF,'|       _                           _     _        ____ _   _    _  _____    |'
       		DB	CR,LF,'|      / \   ___ ___  ___ _ __ ___ | |__ | |_   _ / ___| | | |  / \|_   _|   |'
      		DB	CR,LF,'|     / _ \ / __/ __|/ _ \ `_ ` _ \| `_ \| | | | | |   | |_| | / _ \ | |     |'
     		DB	CR,LF,'|    / ___ \\__ \__ \  __/ | | | | | |_) | | |_| | |___|  _  |/ ___ \| |     |'
    		DB	CR,LF,'|   /_/   \_\___/___/\___|_| |_| |_|_.__/|_|\__, |\____|_| |_/_/   \_\_|     |'
		DB	CR,LF,'|                                            |___/                           |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'| Projeto   : Assembly Chat (Protocolo RP) versao 1.0                        |'
		DB	CR,LF,'| Professor : Wilson Ruiz                                                    |'
		DB	CR,LF,'| Alunos    : Ricardo Iramar dos Santos e Fernando Medeiro Silva             |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'*----------------------------------------------------------------------------*'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'| Lista de comandos desconectado:                                            |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'| c         ->   conectar                                                    |'
		DB	CR,LF,'| s         ->   sair                                                        |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'| Lista de comandos conectado:                                               |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'| [Esc]     ->   desconectar                                                 |'
		DB	CR,LF,'| [Enter]   ->   enviar mensagem                                             |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'*----------------------------------------------------------------------------*'
		DB	'$'

	final	DB	      '*----------------------------------------------------------------------------*'
		DB	CR,LF,'|                         _____   _              _                           |'
		DB	CR,LF,'|                        |_   _|_| |_  __ _ _  _| |                          |'
		DB	CR,LF,'|                          | |/ _| ` \/ _` | || |_|                          |'
		DB	CR,LF,'|                          |_|\__|_||_\__,_|\_,_(_)                          |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'|                      Programa finalizado com sucesso!                      |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'*----------------------------------------------------------------------------*'
		DB	'$'

	erro	DB	      '*----------------------------------------------------------------------------*'
		DB	CR,LF,'|            _____       _        ___           __ _ _    _        _         |'
		DB	CR,LF,'|           |_   _|__ __| |__ _  |_ _|_ ___ ___/_/| (_)__| |__ _  | |        |'
		DB	CR,LF,'|             | |/ -_) _| / _` |  | || ` \ V / _` | | / _` / _` | |_|        |'
		DB	CR,LF,'|             |_|\___\__|_\__,_| |___|_||_\_/\__,_|_|_\__,_\__,_| (_)        |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'|             Precione somente as teclas contidas na lista de comando        |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'*----------------------------------------------------------------------------*'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'| Lista de comandos desconectado:                                            |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'| c         ->   conectar                                                    |'
		DB	CR,LF,'| s         ->   sair                                                        |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'| Lista de comandos conectado:                                               |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'| [Esc]     ->   desconectar                                                 |'
		DB	CR,LF,'| [Enter]   ->   enviar mensagem                                             |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'*----------------------------------------------------------------------------*'
		DB	'$'

        envia   DB      CR,LF,'*----------------------------------------------------------------------------*'
		DB	CR,LF,'|                    ___         _              _       _                    |'
		DB	CR,LF,'|                   | __|_ ___ _(_)__ _ _ _  __| |___  (_)                   |'
		DB	CR,LF,'|                   | _|| ` \ V / / _` | ` \/ _` / _ \  _                    |'
		DB	CR,LF,'|                   |___|_||_\_/|_\__,_|_||_\__,_\___/ (_)                   |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'*----------------------------------------------------------------------------*'
		DB	CR,LF,'$'

        recebe  DB      CR,LF,'*----------------------------------------------------------------------------*'
		DB	CR,LF,'|                  ___            _                _       _                 |'
		DB	CR,LF,'|                 | _ \___ __ ___| |__ ___ _ _  __| |___  (_)                |'
		DB	CR,LF,'|                 |   / -_) _/ -_) `_ Y -_) ` \/ _` / _ \  _                 |'
		DB	CR,LF,'|                 |_|_\___\__\___|_.__|___|_||_\__,_\___/ (_)                |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'*----------------------------------------------------------------------------*'
		DB	CR,LF,'$'

	ctd01	DB	      '------------------------------------------------------------------------------'
		DB	CR,LF,'|             ____                      _                  _                 |'
		DB	CR,LF,'|            / ___|___  _ __   ___  ___| |_ __ _ _ __   __| | ___            |'
		DB	CR,LF,'|           | |   / _ \| `_ \ / _ \/ __| __/ _` | `_ \ / _` |/ _ \           |'
		DB	CR,LF,'|           | |__| (_) | | | |  __/ (__| || (_| | | | | (_| | (_) |          |'
		DB	CR,LF,'|            \____\___/|_| |_|\___|\___|\__\__,_|_| |_|\__,_|\___/           |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'------------------------------------------------------------------------------'
		DB	CR,LF,'$'

	ctd02	DB	      '//////////////////////////////////////////////////////////////////////////////'
		DB	CR,LF,'|             ____                      _                  _                 |'
		DB	CR,LF,'|            / ___|___  _ __   ___  ___| |_ __ _ _ __   __| | ___            |'
		DB	CR,LF,'|           | |   / _ \| `_ \ / _ \/ __| __/ _` | `_ \ / _` |/ _ \           |'
		DB	CR,LF,'|           | |__| (_) | | | |  __/ (__| || (_| | | | | (_| | (_) |          |'
		DB	CR,LF,'|            \____\___/|_| |_|\___|\___|\__\__,_|_| |_|\__,_|\___/           |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\'
		DB	CR,LF,'$'

	ctd03	DB	      '||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'
		DB	CR,LF,'|             ____                      _                  _                 |'
		DB	CR,LF,'|            / ___|___  _ __   ___  ___| |_ __ _ _ __   __| | ___            |'
		DB	CR,LF,'|           | |   / _ \| `_ \ / _ \/ __| __/ _` | `_ \ / _` |/ _ \           |'
		DB	CR,LF,'|           | |__| (_) | | | |  __/ (__| || (_| | | | | (_| | (_) |          |'
		DB	CR,LF,'|            \____\___/|_| |_|\___|\___|\__\__,_|_| |_|\__,_|\___/           |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'
		DB	CR,LF,'$'

	ctd04	DB	      '\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\'
		DB	CR,LF,'|             ____                      _                  _                 |'
		DB	CR,LF,'|            / ___|___  _ __   ___  ___| |_ __ _ _ __   __| | ___            |'
		DB	CR,LF,'|           | |   / _ \| `_ \ / _ \/ __| __/ _` | `_ \ / _` |/ _ \           |'
		DB	CR,LF,'|           | |__| (_) | | | |  __/ (__| || (_| | | | | (_| | (_) |          |'
		DB	CR,LF,'|            \____\___/|_| |_|\___|\___|\__\__,_|_| |_|\__,_|\___/           |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'//////////////////////////////////////////////////////////////////////////////'
		DB	CR,LF,'$'

	desco	DB	      '*----------------------------------------------------------------------------*'
		DB	CR,LF,'|        ____                                     _            _       _     |'
		DB	CR,LF,'|       |  _ \  ___ ___  ___ ___  _ __   ___  ___| |_ __ _  __| | ___ | |    |'
		DB	CR,LF,'|       | | | |/ _ Y __|/ __/ _ \| `_ \ / _ \/ __| __/ _` |/ _` |/ _ \| |    |'
		DB	CR,LF,'|       | |_| |  __|__ \ (_| (_) | | | |  __/ (__| || (_| | (_| | (_) |_|    |'
		DB	CR,LF,'|       |____/ \___|___/\___\___/|_| |_|\___|\___|\__\__,_|\__,_|\___/(_)    |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'*----------------------------------------------------------------------------*'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'| Lista de comandos desconectado:                                            |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'| c         ->   conectar                                                    |'
		DB	CR,LF,'| s         ->   sair                                                        |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'| Lista de comandos conectado:                                               |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'| [Esc]     ->   desconectar                                                 |'
		DB	CR,LF,'| [Enter]   ->   enviar mensagem                                             |'
		DB	CR,LF,'|                                                                            |'
		DB	CR,LF,'*----------------------------------------------------------------------------*'
		DB	'$'

	.CODE


;********************************************************************************************
; 
; Inicio da procedure CHAT
; 

PUBLIC CHAT
CHAT proc

	mov	dx	,	PP		;seleciona porta de programacao
	mov	al	,	0083h		;seleciona o modo de programacao
	out	dx	,	al
	mov	dx	,	PA		;seleciona porta A
	mov	al	,	0000h		;reseta porta A
	out	dx	,	al
	mov	dx	,	PB		;seleciona porta B
	mov	al	,	0000h		;reseta porta B
	out	dx	,	al
	mov	dx	,	PC		;seleciona porta C
	mov	al	,	0000h		;reseta porta C
	out	dx	,	al

	call	CLS				;funcao para limpar a tela
        call    MOLDURA

	mov	ax	,	@data
	mov	ds	,	ax
	mov	es	,	ax
	cld
	mov	ah	,	0009h
	lea	dx	,	inicial		;imprime na tela a mensagem inicial
	int	21h

inicio:
	mov	ah	,	0008h		;leitura de teclado sem eco
	int	21h

	cmp	al	,	0073h		;vc teclou s para sair?
	jne	ntcs
	call	CLS
        call    MOLDURA
	mov	ah	,	0009h
	lea	dx	,	final		;imprime na tela a mensagem final
	int	21h
	jmp	fim

ntcs:
	cmp	al	,	0063h		;vc teclou c para conectar?
	jne	ntcc
	call	CLS
        call    MOLDURA
	call	CONECTAR
	jmp	inicio
	
ntcc:
	call	CLS
        call    MOLDURA
	mov	ah	,	0009h
	lea	dx	,	erro		;imprime a mensagem de tecla errada
	int	21h
	jmp	inicio

fim:
	mov	ah	,	4Ch		;finaliza o programa
	int	21h

CHAT endp

; 
; Fim da procedure CHAT
; 
;********************************************************************************************


;********************************************************************************************
; 
; Inicio da procedure MOLDURA
; 

PUBLIC MOLDURA
MOLDURA proc

        push    ax
        push    bx
        push    cx
        push    dx

	push	bp				;moldura
	mov	bp	,	sp		;salva ponteiro de base anterior
	mov	ah	,	0BH		;servico 0BH, define cor
	mov	bh	,	00H		;define fundo
	mov	bl	,	03H		;usa cor 01 (azul)
	int	10h				;requisita o servico de video
	pop	bp				;recupera o ponteiro de base anterior

        pop     dx
        pop     cx
        pop     bx
        pop     ax

	ret

MOLDURA endp

; 
; Fim da procedure MOLDURA
; 
;********************************************************************************************


;********************************************************************************************
; 
; Inicio da procedure ESPERA
; 

PUBLIC ESPERA
ESPERA proc

        push    ax
        push    bx
        push    cx
        push    dx

	mov	ax	,	3333h
volta01:
	dec	ax
	cmp	ax	,	0000h
	je	sai01
	mov	bx	,	1111h
volta02:
	dec	bx
	cmp	bx	,	0000h
	je	sai02
	jmp	volta02
sai02:
	jmp	volta01
sai01:

        pop     dx
        pop     cx
        pop     bx
        pop     ax

	ret

ESPERA endp

; 
; Fim da procedure ESPERA
; 
;********************************************************************************************


;********************************************************************************************
; 
; Inicio da procedure CLS
; 

PUBLIC CLS
CLS proc

        push    ax
        push    bx
        push    cx
        push    dx

	mov	al	,	0003h		;defini modo texto e limpar tela
	mov	ah	,	0000h
	int	10h

        pop     dx
        pop     cx
        pop     bx
        pop     ax

	ret

CLS endp

; 
; Fim da procedure CLS
; 
;********************************************************************************************


;********************************************************************************************
; 
; Inicio da macro POS
; 

POS MACRO  Linha, Coluna

        push    ax
        push    bx
        push    cx
        push    dx

	MOV	AH	,	0002h
	MOV	DH	,	Linha
	MOV	DL	,	Coluna
	MOV	BH	,	0000h
	INT	10H

        pop     dx
        pop     cx
        pop     bx
        pop     ax

ENDM

; 
;********************************************************************************************


;********************************************************************************************
; 
; Inicio da procedure CONECTAR
; 

PUBLIC CONECTAR
CONECTAR proc

	mov	dx	,	PC			;checando se o outro micro ja tentou conectar
	in	al	,	dx
	cmp	al	,	00000001b
	je	conectando

	mov	al	,	00010000b
	out	dx	,	al
volta03:
	in	al	,	dx
	cmp	al	,	00010001b
	je	conectado
	call	ESCREVE_CONECTANDO
	jmp	volta03

conectando:
	mov	al	,	00010000b
	out	dx	,	al
	call	RECEBENDO
	jmp sai03

conectado:
	call	ENVIANDO

sai03:		
	ret

CONECTAR endp

; 
; Fim da procedure CONECTAR
; 
;********************************************************************************************


;********************************************************************************************
; 
; Inicio da procedure ENVIANDO
; 

PUBLIC ENVIANDO
ENVIANDO proc

	mov	ah	,	0009h
	lea	dx	,	envia		;imprime a mensagem de enviando
	int	21h

envoutrocara:
        mov     ah      ,       0008h           ;leitura do teclado sem eco
	int	21h
	mov	bl	,	al		;armazena o caracter em bl

	mov	dx	,	PC
	mov	al	,	00110001b
	out	dx	,	al		;posso enviar um caracter?

envcara:
	in	al	,	dx
	cmp	al	,	00110011b	;posso enviar um caracter?
	je	envcarapula			;pode
	jmp	envcara				;nao pode

envcarapula:
	mov	dx	,	PA
	mov	al	,	bl		;recupera caracter
	out	dx	,	al		;envio do caracter


	cmp	al	,	000Dh		;teclei [enter] para terminar a msg
	je	envfim
	cmp	al	,	001Bh		;teclei [esc] para desconectar
	je	envdesco

        mov     ah      ,       0002h
        mov     dl      ,       al
        int     21h                             ;envio do caracter para tela

	mov	dx	,	PC
	mov	al	,	00010011b
	out	dx	,	al		;ja enviei, vc recebeu o caracter?

envcaraok:
	in	al	,	dx
	cmp	al	,	00010001b	;ja enviei, vc recebeu o caracter?
	je	envoutrocara			;recebi
	jmp	envcaraok			;nao nao recebi


envfim:
	mov	dx	,	PC
	mov	al	,	00010011b
	out	dx	,	al		;fim da mensagem, ouviu?

envnaofim:
	in	al	,	dx
	cmp	al	,	00010001b	;fim da mensagem, ouviu?
	je	envfimok			;sim
	jmp	envnaofim			;nao

envfimok:	
;        call    CLS
        call    MOLDURA
	call	RECEBENDO

envdesco:
	mov	dx	,	PC
	mov	al	,	00010011b
        out     dx      ,       al              ;desconectar?

envnaodesc:
	in	al	,	dx
        cmp     al      ,       00010001b       ;desconectar?
        je      envdescok                        ;sim
        jmp     envnaodesc                       ;nao

envdescok: 

	call	DESCONECTADO

	ret

ENVIANDO endp

; 
; Fim da procedure ENVIANDO
; 
;********************************************************************************************


;********************************************************************************************
; 
; Inicio da procedure RECEBENDO
; 

PUBLIC RECEBENDO
RECEBENDO proc

	mov	ah	,	0009h
	lea	dx	,	recebe		;imprime a mensagem de enviando
	int	21h

	mov	dx	,	PC

reccara:
	in	al	,	dx
	cmp	al	,	00010011b	;vc esta enviando um caracter?
	je	reccarapula			;esta enviando
	jmp	reccara				;não esta enviando

reccarapula:
	mov	al	,	00110011b	;pode enviar o caracter
	out	dx	,	al

reccaraok:
	in	al	,	dx
	cmp	al	,	00110001b	;vc ja enviou o caracter?
	je	reccaraokpula			;ja enviei
	jmp	reccaraok			;nao enviei

reccaraokpula:
	mov	dx	,	PB
	in	al	,	dx

	cmp	al	,	000Dh		;vc teclo [enter] para terminar a msg?
	je	recfim

	cmp	al	,	001Bh		;vc teclo [esc] para desconectar?
	je	recdesco

        mov     ah      ,       0002h
        mov     dl      ,       al
        int     21h                             ;envio do caracter para tela


	mov	dx	,	PC
	mov	al	,	00010001b	;ja recebi o caracter
	out	dx	,	al

        jmp     reccara

recfim:
	mov	dx	,	PC
recnaofim:
	in	al	,	dx
	cmp	al	,	00110001b	;fim da mensagem?
	je	recfimok			;sim
	jmp	recnaofim			;nao

recfimok:
	mov	al	,	00010001b	;fim da mensagem
	out	dx	,	al

;       call    CLS
        call    MOLDURA
	call	ENVIANDO

recdesco:
	mov	dx	,	PC
recnaodesc:
	in	al	,	dx
        cmp     al      ,       00110001b       ;desconectar?
        je      recdescok                        ;sim
        jmp     recnaodesc                       ;nao

recdescok:
        mov     al      ,       00010001b       ;desconectar
	out	dx	,	al

	call	DESCONECTADO

	ret

RECEBENDO endp

; 
; Fim da procedure RECEBENDO
; 
;********************************************************************************************


;********************************************************************************************
; 
; Inicio da procedure DESCONECTADO
; 

PUBLIC DESCONECTADO
DESCONECTADO proc

	mov	dx	,	PA		;seleciona porta A
	mov	al	,	0000h		;reseta porta A
	out	dx	,	al
	mov	dx	,	PB		;seleciona porta B
	mov	al	,	0000h		;reseta porta B
	out	dx	,	al
	mov	dx	,	PC		;seleciona porta C
	mov	al	,	0000h		;reseta porta C
	out	dx	,	al

	call	CLS				;funcao para limpar a tela
        call    MOLDURA

	mov	ah	,	0009h
	lea	dx	,	desco		;imprime na tela a mensagem inicial
	int	21h

descinicio:
	mov	ah	,	0008h		;leitura de teclado sem eco
	int	21h

	cmp	al	,	0073h		;vc teclou s para sair?
	jne	descntcs
	call	CLS
        call    MOLDURA
	mov	ah	,	0009h
	lea	dx	,	final		;imprime na tela a mensagem final
	int	21h
	jmp	descfim

descntcs:
	cmp	al	,	0063h		;vc teclou c para conectar?
	jne	descntcc
	call	CLS
        call    MOLDURA
	call	CONECTAR
	jmp	descinicio
	
descntcc:
	call	CLS
        call    MOLDURA
	mov	ah	,	0009h
	lea	dx	,	erro		;imprime a mensagem de tecla errada
	int	21h
	jmp	descinicio

descfim:
	mov	ah	,	4Ch		;finaliza o programa
	int	21h

DESCONECTADO endp

; 
; Fim da procedure DESCONECTADO
; 
;********************************************************************************************


;********************************************************************************************
; 
; Inicio da procedure ESCREVE_CONECTANDO
; 

PUBLIC ESCREVE_CONECTANDO
ESCREVE_CONECTANDO proc
	

        push    ax
        push    bx
        push    cx
        push    dx

	call	ESPERA
	POS	9	,	0
	mov	ah	,	0009h
	lea	dx	,	ctd01		;imprime na tela a mensagem conectando
	int	21h
	call	ESPERA
	POS	9	,	0
	lea	dx	,	ctd02		;imprime na tela a mensagem conectando
	int	21h
	POS	9	,	0
	call	ESPERA
	lea	dx	,	ctd03		;imprime na tela a mensagem conectando
	int	21h
	POS	9	,	0
	call	ESPERA
	lea	dx	,	ctd04		;imprime na tela a mensagem conectando
	int	21h

        pop     dx
        pop     cx
        pop     bx
        pop     ax

	ret

ESCREVE_CONECTANDO endp

; 
; Fim da procedure ESCREVE_CONECTANDO
; 
;********************************************************************************************


; 
; Fim do programa
; 
;********************************************************************************************

end
