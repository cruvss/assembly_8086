.MODEL SMALL
.STACK 100H
.DATA
NUM DW 1234,9999,4356,2332,0001
MSG DB "DISPLAYING SORTED NUMBERS $"
.CODE
MAIN PROC
    
    
    MOV AX,@DATA
    MOV DS,AX
    
    CALL SORT_NUMBERS
    CALL DISPLAY_RESULT
    CALL EXIT
    
    SORT_NUMBERS PROC
            
        MOV CH,04H ;OUTER LOOP COUNTER
        
        HERE1:
        MOV CL,04H ;INNER LOOP COUNTER
        LEA SI,NUM
        
        HERE:
        MOV AX,[SI]
        MOV BX,[SI+2]
        CMP AX,BX
        JNA SKIP
        MOV [SI],BX
        MOV [SI+2],AX
        SKIP:
        INC SI
        INC SI
        DEC CL
        JNZ HERE ;INNER LOOP
        DEC CH
        JNZ HERE1 ; OUTER LOOP
        RET
    ENDP SORT_NUMBERS
    
    DISPLAY_RESULT PROC
        LEA DX,MSG
        MOV AH,09H
        INT 21H
        
        
        MOV SI,0
        MOV DI,5 ;USING DI AS COUNTER
        AGAIN:
        CALL NEWLINE
        MOV AX,NUM[SI]
        MOV CX,0AH
        MOV BX,0000H
        UP:
        MOV DX,0000H
        DIV CX
        ADD DX,30H
        PUSH DX
        INC BX
        CMP AX,0
        JA UP
        MOV CX,BX
        MOV AH,02H
        SHOW:
        POP DX
        INT 21H
        LOOP SHOW
        INC SI
        INC SI
        DEC DI
        JNZ AGAIN
        RET
    ENDP DISPLAT_RESULT
    
    
    NEWLINE PROC
        MOV AH,02H
        MOV DX,13
        INT 21H
        MOV DX,10
        INT 21H
        RET
    ENDP NEWLINE 
    
    EXIT PROC
        INT 20H
        RET
    ENDP EXIT
       
ENDP MAIN


    

