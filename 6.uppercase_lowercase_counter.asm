.MODEL SMALL
.STACK 100H
.DATA
MSG DB "ENTER A STRING$"
MSG1 DB "TOTAL NUMBER OF UPPERCASE=$"
MSG2 DB "TOTAL NUMBER OF LOWERCASE=$"
INPUT DB 50 DUP("$")
.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX
    
    CALL ASKINPUT
    CALL NEXTLINE
    CALL TAKEINPUT
    CALL NEXTLINE
    CALL COUNT
    CALL DISPLAY
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
        MOV AH,0AH
        LEA DX,INPUT
        INT 21H
        RET
    ENDP TAKEINPUT
    
    COUNT PROC
        MOV BL,0
        MOV BH,0
        MOV SI,2
        UP:
        MOV DL,INPUT[SI]
        INC SI
        CMP DL,0DH
        JE EXIT1
        CMP DL,' '
        JE L1
        CMP DL,'A'
        JB LCOUNT
        CMP DL,'Z'
        JA LCOUNT
        INC BH
        JMP UP
        
        LCOUNT:
        INC BL
        MOV CX,BX
        L1:
        JMP UP
        EXIT1:RET
    ENDP COUNT
    
    DISPLAY PROC
    LEA DX,MSG1
    MOV AH,09H
    INT 21H
    
    MOV DL,BH
    CMP DL,09H
    JA CONVERSION
    ADD DL,30H
    MOV AH,02H
    INT 21H
    JMP NEXT
    
    CONVERSION:
    MOV AX,0
    MOV CL,0AH
    MOV AL,BH
    DIV CL
    ADD AX,3030H
    MOV DX,AX
    MOV AH,02H
    INT 21H 
    MOV DL,DH
    INT 21H
    
    NEXT:
    CALL NEXTLINE
    LEA DX,MSG2
    MOV AH,09H
    INT 21H
    
    MOV DL,BL
    CMP DL,09H
    JA CONVERSION1
    ADD DL,30H
    MOV AH,02H
    INT 21H
    JMP NEXT1
    
    CONVERSION1:
    MOV AX,0
    MOV CL,0AH
    MOV AL,BL
    DIV CL
    ADD AX,3030H
    MOV DX,AX
    MOV AH,02H
    INT 21H 
    MOV DL,DH
    INT 21H       
    NEXT1:RET
    ENDP DISPLAY
    
    EXIT PROC
        MOV AH,4CH
        INT 21H
        RET
    ENDP EXIT
    
ENDP MAIN
  
    
    
    
    
    

        
       
        
       
        