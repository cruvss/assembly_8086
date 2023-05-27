.MODEL SMALL
.STACK 100H
.DATA
MSG DB "Sum of 100 even natural number is: $"
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    CALL DISPLAY
    CALL FIND_SUM
    ;CALL CLEARSCREEN 
    CALL DECIMAL
    CALL EXIT
    
    DISPLAY PROC
        LEA DX,MSG
        MOV AH,09H
        INT 21H
        RET
    ENDP DISPLAY
    
    FIND_SUM PROC
      MOV AX,01H
        MOV BX,00H
        MOV CX,0
        UP:
        ROR AX,1
        JC NEXT_NUM
        ROL AX,1
        ADD BX,AX
        INC CX
        JMP L1
        NEXT_NUM:
        ROL AX,1
        L1:
        INC AX
        CMP CX,100
        JNE UP
        RET
    ENDP FIND_SUM 
    
    CLEARSCREEN PROC
        MOV AX,0002H
        INT 10H
        RET
    ENDP CLEARSCREEN
    
    DECIMAL PROC
        MOV AX,BX
        MOV BX,0 
        MOV CX,0AH
        UPP: 
        MOV DX,0
        DIV CX       
        ADD DX,30H
        PUSH DX
        INC BX
        CMP AX,0
        JNZ UPP
        MOV CX,BX
        MOV AH,02H
        DISP:
        POP DX
        INT 21H
        LOOP DISP
        RET
    ENDP DECIMAL
    
    EXIT PROC
        MOV AH,4CH
        INT 21H
        RET
    ENDP EXIT
ENDP MAIN
        
    
    
    
        
        

