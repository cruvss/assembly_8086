.MODEL SMALL
.STACK 100H
.DATA
MSG DB "ENTER A WORD$"
INPUT DB 10 DUP("$")
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    CALL DISPLAY
    CALL NEXTLINE
    CALL TAKEINPUT
    CALL CLEARSCREEN
    CALL CONVERSION
    CALL EXIT
    
    DISPLAY PROC 
        LEA DX,MSG
        MOV AH,09H
        INT 21H
        RET
    ENDP DISPLAY
    
    TAKEINPUT PROC
        LEA DX,INPUT
        MOV AH,0AH
        INT 21H
        RET
    ENDP TAKEINPUT
    
    CLEARSCREEN PROC
        MOV AX,0002H
        INT 10H
        RET
    ENDP CLEARSCREEN
    
    CONVERSION PROC 
        MOV SI,2
        NEXT:
        MOV DL,INPUT[SI]
        MOV BX,SI
        INC SI
        AND BX,1
        CMP BX,0
        JE LOWERCASE
        
        CMP DL,0DH
        JE BYE
        CMP DL,'A'
        JB UCASE
        CMP DL,'Z'
        JA UCASE
        
        MOV AH,02H
        INT 21H
        
        JMP NEXT
        
        LOWERCASE:
        CMP DL,0DH
        JE BYE
        CMP DL,'a'
        JB LCASE
        CMP DL,'z'
        JA LCASE
        
        MOV AH,02H
        INT 21H
        
        JMP NEXT
        
        UCASE:
        SUB DL,20H
        MOV AH,02H
        INT 21H
        JMP NEXT
        
        LCASE:
        ADD DL,20H
        MOV AH,02H
        INT 21H
        JMP NEXT
        
        
     
        
        BYE:
        RET
    ENDP CONVERSION
    
    NEXTLINE PROC
        MOV AH,02H
        MOV DL,13
        INT 21H
        MOV DL,10 
        INT 21H
        RET
    EXIT PROC
        MOV AH,4CH
        INT 21H
    ENDP EXIT
ENDP MAIN






















