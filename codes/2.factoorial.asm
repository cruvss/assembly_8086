
.MODEL SMALL
.STACK 64
.DATA
MSG1 DB "ENTER A NUMBER BETWEEN 0-9: $"
MSG2 DB "THE FACTORIAL OF ENTERED NUMBER IS : $"

.CODE 
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX
    
    CALL TAKE_INPUT
    CALL NEWLINE
    CALL CHECK_IF_0_OR_1
    CALL FACT_CALC
    CALL EXIT
    
    
    TAKE_INPUT PROC
        MOV AH,09H
        LEA DX,MSG1
        INT 21H
        
        MOV AH,01H
        INT 21H
        RET
        
    ENDP TAKE_INPUT
    
    DISP_MSG PROC 
        MOV AH,09H
        LEA DX,MSG2
        INT 21H
        RET
    ENDP DISP_PROC
    
    
    NEWLINE PROC
        MOV BL,AL
        MOV AH,02H
        MOV DX,13
        INT 21H
        MOV DX,10
        INT 21H
        MOV AL,BL
        RET
    ENDP NEWLINE
    
    
    CHECK_IF_0_OR_1 PROC
        CMP AL,31H
        JE SKIP
        CMP AL,30H
        JE ADD_AND_SKIP
        MOV AH,0
        RET
    ENDP CHECK_IF_0_OR_1 
    
    FACT_CALC PROC
        MOV BX,DX
        MOV CX,AX
        CALL DISP_MSG
        MOV DX,BX
        MOV AX,CX
      
        MOV CX,AX
        SUB CX,01

        SUB AX,30H
        SUB CX,30H

        UP:
        MUL CX
        LOOP UP

        MOV CX,0AH
        MOV BX,0
        HERE:
        MOV DX,0
        DIV CX
        ADD DX,30H
        PUSH DX
        INC BX
        CMP AX,0
        JA HERE
        MOV CX,BX
        MOV AH,02H
       
        SHOW:
        POP DX
        INT 21H
        LOOP SHOW
        MOV AH,4CH 
        INT 21H
        RET  
    ENDP FACT_CALC
    
    EXIT PROC
        MOV AH,4CH
        INT 21H
        RET
    ENDP EXIT
    

        SKIP:
        CALL DISP_MSG
        MOV DL,31H
        MOV AH,02H
        INT 21H
        CALL EXIT
        
        ADD_AND_SKIP: 
        CALL DISP_MSG
        MOV DL,31H 
        INT 21H
        CALL EXIT
        




























