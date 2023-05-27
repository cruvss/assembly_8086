.MODEL SMALL
.STACK 420H
.DATA
MSG1 DB "ENTER A STRING$"
MSG2 DB 50 DUP("$") 
MSG3 DB 50 DUP("$")
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    CALL ASK_INPUT
    CALL NEWLINE
    CALL TAKE_INPUT
    CALL NEWLINE
    CALL REVERSE
    CALL EXIT 
    
    ASK_INPUT PROC
        MOV AH,09H
        LEA DX,MSG1
        INT 21H
        RET
    ENDP ASK_INPUT
    
    NEWLINE PROC
        MOV AH,02H
        MOV DL,13
        INT 21H
        MOV DL,10
        INT 21H
        RET
    ENDP NEWLINE
    
    TAKE_INPUT PROC
        MOV AH,0AH
        LEA DX,MSG2
        INT 21H
        RET
    ENDP TAKE_INPUT
    
    REVERSE PROC
        MOV CX,0 
        MOV SI,1
        MOV CL,MSG2[SI]; LOADING NUMBER OF CHAR USER INPUTTED
        INC CL
        MOV SI,CX
        MOV DI,0 
        DEC CX
        YETA:
        MOV DL,MSG2[SI]
        MOV MSG3[DI],DL
        INC DI 
        DEC SI
        LOOP YETA
        
        CALL NEWLINE
        MOV AH,09H
        LEA DX,MSG3
        INT 21H
        
        RET
    ENDP REVERSE
    
    EXIT PROC
        MOV AH,4CH
        INT 21H
    ENDP EXIT
ENDP MAIN

    
    
    
    
