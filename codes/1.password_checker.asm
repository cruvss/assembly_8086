.MODEL SMALL
.STACK 100H
.DATA
VAL DB "1369@Sachin$"
INPUT DB 50 DUP("$")
MSG1 DB "!!CORRECT PASSCODE!!$"
MSG2 DB "!!INCORRECT PASSCODE TRYAGAIN!!$"
MSG3 DB "ENTER THE PASSCODE: $"
MSG4 DB " ATTEMPS LEFT..$"
MSG5 DB "!!!!!exiting ......!!!!!$"




.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX
    MOV CX,05H
    
    CALL ASKINPUT
    CALL NEWLINE
    CALL VERIFY
    CALL EXIT 
    
    ASKINPUT PROC
        MOV AH,09H
        LEA DX,MSG3
        INT 21H
        CALL NEWLINE
        CALL TAKEINPUT
        RET
    ENDP ASKINPUT
    
    NEWLINE PROC
        MOV AH,02H
        MOV DL,13
        INT 21H
        MOV DL,10
        INT 21H
        RET
    ENDP NEWLINE
    
    TAKEINPUT PROC
        MOV AH,0AH
        LEA DX,INPUT
        INT 21H
        JMP YETA
    ENDP TAKEINPUT
    
    VERIFY PROC
        YETA:
        MOV SI,2
        MOV DI,0
        UP:
        MOV DL,INPUT[SI]
        INC SI
        CMP DL,0DH
        JE VALID
        MOV BL,VAL[DI] 
        INC DI
        CMP DL,BL
        JNE INVALID
        JMP UP 
        
        INVALID:
        
        DEC CX
        CALL NEWLINE
        MOV AH,09H
        LEA DX,MSG2
        INT 21H
        CALL NEWLINE 
        MOV AH,02H
        MOV DX,CX
        ADD DX,30H
        INT 21H 
        MOV AH,09H
        LEA DX,MSG4
        INT 21H
        CMP CX,0
        JE CRASH
        CALL NEWLINE
        CALL ASKINPUT
        JMP FINISH
        VALID:
        CALL NEWLINE
        MOV AH,09H
        LEA DX,MSG1
        INT 21H
       FINISH:
       INT 20H
    ENDP VERFY
    
    EXIT PROC
        MOV AH,4CH
        INT 21H
        CRASH:
        CALL NEWLINE
        MOV AH,09H
        LEA DX,MSG5
        INT 21H
        CALL NEWLINE
        
        INT 20H
        
        RET
    ENDP EXIT
    
       
    
ENDP MAIN
