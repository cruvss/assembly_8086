.MODEL SMALL
.STACK 100H
.DATA
MSG DB "ENTER TWO NUMBER$"
NUM1 DB ?
NUM2 DB ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
CALL ASKINPUT
CALL NEXTLINE
CALL TAKEINPUT
CALL NEXTLINE 
CALL CLEARSCREEN
CALL MULTIPLY_AND_DISPLAY
CALL EXIT

ASKINPUT PROC 
    MOV AH,09H
    LEA DX,MSG
    INT 21H
    RET
ENDP ASKINPUT

NEXTLINE PROC
    MOV AH,02H
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H
    RET
ENDP NEXTLINE

TAKEINPUT PROC
    MOV AH,01H
    INT 21H
    MOV NUM1,AL
    INT 21H
    MOV NUM2,AL
    RET
ENDP TAKEINPUT

CLEARSCREEN PROC
    MOV AH,00H
    MOV AL,02H
    INT 10H
    RET
ENDP CLEARSCREEN

MULTIPLY_AND_DISPLAY PROC
    MOV CL,NUM1
    SUB CL,30H
    MOV AL,NUM2
    SUB AL,30H
    MUL CL
    
    MOV BX,0
    MOV CX,0
    MOV CX,0AH
    
    UP:
    MOV DX,0
    DIV CX
    ADD DX,30H
    INC BX
    PUSH DX
    CMP AX,0
    JA UP
    
    MOV CX,BX
    MOV AH,02H
    SHOW:
    POP DX
    INT 21H
    LOOP SHOW
    RET
ENDP MULTIPLY_AND_DISPLAY

EXIT PROC
    MOV AH,4CH
    INT 21H
    RET
ENDP EXIT

    




    
    
       
    
      
       