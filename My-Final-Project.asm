data_seg segment
    
     names db 81 dup (?)
     names_number dw ?
     names_length dw ?
     
     error db "You should enter a number between <1 to 6> $"
     
     S1_msg1_numberOfNames db  "Enter number of names choose from <1 to 9> : $"
     S1_msg2_lengthOfNames db  "Enter a length for names from <1 to 9> : $"
     S1_msg3_mistake db  "Value must be from <1 to 9> $"
     S1_S2_names_number dw ?
     
     S2_msg1_enteringNames db  "Enter a name: $"
     S2_msg2_error1 db "You should enter small letters! $"
     S2_msg3_no_length db "You should go to service 1 to enter length and number of names $"
     
     S5_msg1_namesToBeDisplayed db "Enter number of names to be displayed or space to exit: $"
     S5_msg2_error1 db "You should enter a number... $"
     S5_msg3_error2 db "input should be in the range of entered names... $" 
     S5_S4_S3_no_names db "You should go to service 2 to enter names... $"
     
     
     NewLine db 0ah,0dh, "$"
;------------------------------------------------------------------    
    mas1 db  "welcom to Name Sorting app ", 0ah,0dh, "$"
    mas2 db  "choose a service from the fallowing: ",0ah,0dh,"$"
    mas3 db  "press 1 to Enter number and length of names ",0ah,0dh,"$"
    mas4 db  "press 2 to Enter the names ",0ah,0dh,"$"
    mas5 db  "press 3 to Apply Ascending sorting  ",0ah,0dh,"$"
    mas6 db  "press 4 to Apply Descending sorting ",0ah,0dh,"$"
    mas7 db  "press 5 to Display sorted names",0ah,0dh,"$"
    mas8 db  "press 6 to Exit $"
    mas9 db  "insert value of a service : $"
    
    
    msg6 db  "Thank you for using our application,Farewell... ",0ah,0dh,"$"

data_seg ends    
    
stack_seg segment
    
    dw 16 dup (0)
    
stack_seg ends

code_seg segment
    
    main_prog proc far
            
             Assume SS:stack_seg,CS:code_seg,DS:data_seg
            
            mov ax, data_seg
            mov DS, ax            
;-------------------------------------------------------------------------            
            
            Beginning:  
            
            mov dx,offset mas1
            mov ah, 9
            int 21h
    
            mov dx,offset mas2
            mov ah,9
            int 21h
    
            mov dx,offset mas3
            mov ah,9
            int 21h
    
            mov dx,offset mas4
            mov ah,9
            int 21h
    
            mov dx,offset mas5
            mov ah,9
            int 21h
    
            mov dx,offset mas6
            mov ah,9
            int 21h
    
            mov dx,offset mas7
            mov ah,9
            int 21h
    
            mov dx,offset mas8
            mov ah,9
            int 21h
             
            mov dx,offset NewLine
            mov ah,9
            int 21h
    
            mov dx,offset mas9
            mov ah,9
            int 21h
      ;----------------------------------finish of typing Main Menu      
            mov ah, 1
            int 21h
            sub al, 30h
            mov cl, al 
            
            mov dx,offset NewLine
            mov ah,9
            int 21h 
            
            cmp cl, 7
            jae mismatch
            
            ; we are doing comparisons to choose which service to provide
            cmp cl,1
            je  Service1 
            
            cmp cl,2
            je  Service2
            
            cmp cl,3
            je Service3
            
            cmp cl,4
            je Service4
            
            cmp cl,5
            je Service5
            
            cmp cl,6
            je exit 
            
            mismatch:
            
                mov dx, offset NewLine
                mov ah, 9
                int 21h
                
                mov dx, offset error
                mov ah, 9
                int 21h 
                
                mov dx, offset NewLine
                mov ah, 9
                int 21h
            jmp Beginning
            ; the fallowing lines are the services
            
;===============================================================================================================================
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
;===============================================================================================================================
            
            exit: 
            
            mov dx,offset msg6
            mov ah,9
            int 21h
            
            mov ah,00h
            int 21h 

;===============================================================================================================================
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
;===============================================================================================================================
            
            Service5: 
            
              cmp names[0], 00    ; This condition will see if the first val in the
              je no_names3        ; array empty or not
                                  ; if empty will exit from serveic --5--
                               
              mov bx, [names_number]  ; the value of names_number will go to BL 
              add bx, 30h             ; here we added 30h to 
       again32:    
              mov dx, offset S5_msg1_namesToBeDisplayed
              mov ah, 9
              int 21h
              
              mov cx, 0   ; To make sure CX value is 0.
              
              mov ah, 1
              int 21h 
              
              cmp al , 20h      ; if the user inter space (space = 20h ) then get
              je  getting_out   ; of service-5

              cmp al, 30h   ; To handle values below or equal to 0.
              jbe mistake1 
              
              cmp al, bl    ; To handle values above than->
              ja mistake2   ; the entered names in the first->
                            ; service.
              
              sub al, 30h   ; Subtract to get the real value.
               
              mov cl, al    ; To count outer loop by entered-> 
                            ; names that must be displayed.
                            
              lea si, names ; take the addres of start of array 
              
              mov dx, offset NewLine
              mov ah, 9
              int 21h

  print_next_name:         
              
              push cx ; The value of CX for the outer loop. =====================================
              
              mov cx,9 ; The value of CX for the inner loop.
       
       print_out:
              
              mov dx, [si] 
              
              mov ah, 2
              int 21h
              
              inc si
              
              loop print_out
              
              mov dx, offset NewLine
              mov ah, 9
              int 21h 
              
              
              pop cx    ; used stack ================================================
              
              loop print_next_name 
              
              getting_out:
              
              mov dx, offset NewLine
              mov ah, 9
              int 21h 
              
;********************************************************************************************
;*                                                                                         ;*
;*                                                                                         ;*
                                      jmp Beginning                                        ;*
;*                                                                                         ;*
;*                                                                                         ;*
;********************************************************************************************             
              
      no_names3:
      
              mov dx, offset NewLine
              mov ah, 9
              int 21h 
              
              mov dx , offset S5_S4_S3_no_names
              mov ah, 9
              int 21h
              
              mov dx, offset NewLine
              mov ah, 9
              int 21h 
              
              jmp getting_out
                           
      mistake1: 
      
              mov dx, offset NewLine
              mov ah, 9
              int 21h
              
              mov dx, offset S5_msg2_error1
              mov ah, 9
              int 21h     
              
              mov dx, offset NewLine
              mov ah, 9
              int 21h
              
              jmp again32
              
      mistake2:
                
              mov dx, offset NewLine
              mov ah, 9
              int 21h
              
              mov dx, offset S5_msg3_error2
              mov ah, 9
              int 21h     
              
              mov dx, offset NewLine
              mov ah, 9
              int 21h
              
              jmp again32   
           
;===============================================================================================================================
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
;===============================================================================================================================            
           ; this is bubble sort Descending sorting 
           
            Service4:
            
        cmp names[0], 00    ; This condition will see if the first val in the
        je no_names2        ; array empty or not
                            ; if empty will exit from serveic--4--
            
        mov cx, names_number
        dec cx               ; number of iteration is = numberOfNames - 1
        
        outer_loop1:
        
        mov bp, cx
        push cx      ; I used stack ====================================================
        
        lea si, names
        mov bx, si
        add bx, 9
        mov cx, bp
        
        one_more1:
        
        mov al, [bx]
        cmp [si], al
        jb swap_names1 
        je cmp_next_letter1
        
      back1: 
        
        mov si, bx
        add bx, 9
        
        here1:
        
        loop one_more1
        
        pop cx      ; I used stack ====================================================
        
        loop outer_loop1
        
        exiting_ser4:

;********************************************************************************************
;*                                                                                         ;*
;*                                                                                         ;*
                                      jmp Beginning                                        ;*
;*                                                                                         ;*
;*                                                                                         ;*
;******************************************************************************************** 
        
;//////////////////////////////////////////////////////////////
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        
        swap_names1: 
        push cx ; the value of cx for inner loop ========================================
        
        mov cx, 9
        swapping1: 
        mov al, [bx]
        mov dl, [si]      ; al has BX, dl has SI
        mov [bx], dl
        mov [si],al
        inc si
        inc bx
        
        loop swapping1
        
        pop cx       ; I used stack ========================================================
        
        jmp here1
        
         no_names2: 
         
                 mov dx,offset NewLine
                 mov ah,9 
                 int 21h 
        
                 mov dx,offset S5_S4_S3_no_names
                 mov ah,9 
                 int 21h 
                        
                 mov dx, offset NewLine
                 mov ah,9 
                 int 21h 
                        
                 mov dx, offset NewLine
                 mov ah,9 
                 int 21h 
                                         
                 jmp exiting_ser4 
                 
        cmp_next_letter1:
                 
                 mov al, [bx+1]
                 cmp [si+1] , al
                 jb swap_names1:
                 
                 jmp back1                 
           
;===============================================================================================================================
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
;===============================================================================================================================
            
            Service3:  
            
        cmp names[0], 00    ; This condition will see if the first val in the
        je no_names         ; array empty or not
                            ; if empty will exit from serveic--3-- 
                                
        mov cx, names_number
        dec cx     
        
        outer_loop:
        
        mov bp, cx
        push cx      ; I used stack here. ====================================================
        
        lea si, names
        mov bx, si
        add bx, 9
        mov cx, bp
        
        one_more:
        
        mov al, [bx]
        cmp [si], al
        ja swap_names
        je cmp_next_letter 
        
    back:    
        
        mov si, bx
        add bx, 9
        
        here:
        
        loop one_more
        
        pop cx     ; I used stack here again. ===================================================
        
        loop outer_loop 
        
        exiting_ser3:
        
;********************************************************************************************
;*                                                                                         ;*
;*                                                                                         ;*
                                      jmp Beginning                                        ;*
;*                                                                                         ;*
;*                                                                                         ;*
;******************************************************************************************** 
        
;//////////////////////////////////////////////////////////////
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        
        swap_names: 
                 push cx ; the value of cx for inner loop | I used to stack  ========================
        
                  mov cx, 9 
                  swapping: 
                  mov al, [bx]
                  mov dl, [si]      ; al has BX, dl has SI
                  mov [bx], dl
                  mov [si],al
                  inc si
                  inc bx
        
                  loop swapping
        
                  pop cx       ; I used stack ===========================================================
        
                  jmp here 
         
         no_names: 
         
                 mov dx,offset NewLine
                 mov ah,9 
                 int 21h 
        
                 mov dx,offset S5_S4_S3_no_names
                 mov ah,9 
                 int 21h 
                        
                 mov dx, offset NewLine
                 mov ah,9 
                 int 21h 
                        
                 mov dx, offset NewLine
                 mov ah,9 
                 int 21h 
                                         
                 jmp exiting_ser3                                                                  
          
          cmp_next_letter:
                 
                 mov al, [bx+1]
                 cmp [si+1] , al
                 ja swap_names:
                 
                 jmp back
;===============================================================================================================================
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
;===============================================================================================================================     
            
            Service2: 
            
        lea bx, names_length ; Here we'll see if the length has been entered or not?
        cmp [bx], 00         ; if not will ask the user to go to service--1--
        je no_length
                 
        mov al , 9                  ; 9 is the maximum number of names will take 
        mov bx , S1_S2_names_number ; contain number of names
        mul bl
        mov S1_S2_names_number, ax  ; value is 27
        
        mov bx, 0        ; bx will work as a counter 
                         ; to exit when the user enter
                         ; the desired number of names
        lea si, names
        
        next_name:
        
        mov cx, names_length 
        
  number_is_entered:      
        
        mov dx, offset S2_msg1_enteringNames
        mov ah, 9
        int 21h 
        
              fill_in:
        
              mov ah, 1
              int 21h 
              
              cmp al, 0dh    ; if the user entered "enter" will go to next name
              je outer 
              
              cmp al , 61h
              jb a_number_entered
              
              cmp al , 7ah
              ja a_number_entered
              
        
              mov [si], al   ; move the char to array names
              inc si
        
              loop fill_in
        
        outer:
        
        mov dx, offset NewLine
        mov ah, 9
        int 21h
        
        inc bx       ;from this line to----> 
        mov al, 9
        mul bl 
        mov si, ax   ;<---> this line, here we calculated the start of the next name position
                     ;SI should points to
        
        cmp si, S1_S2_names_number 
        jae near_beginning           ; if SI is above or equal to number of names should finish the enter processes
        jmp next_name        ; if SI is below the desired names we take the next name 
              
        near_beginning:
            mov ax, names_number
            mov S1_S2_names_number, ax       
;********************************************************************************************
;*                                                                                         ;*
;*                                                                                         ;*
                                      jmp Beginning                                        ;*
;*                                                                                         ;*
;*                                                                                         ;*
;******************************************************************************************** 
          a_number_entered:  
          
                 mov dx,offset NewLine
                 mov ah,9 
                 int 21h 
        
                 mov dx,offset S2_msg2_error1
                 mov ah,9 
                 int 21h 
                        
                 mov dx, offset NewLine
                 mov ah,9 
                 int 21h  
                 
                 jmp number_is_entered 
                 
          no_length:
                                  
                 mov dx,offset NewLine
                 mov ah,9 
                 int 21h 
        
                 mov dx,offset S2_msg3_no_length
                 mov ah,9 
                 int 21h 
                        
                 mov dx, offset NewLine
                 mov ah,9 
                 int 21h 
                        
                 mov dx, offset NewLine
                 mov ah,9 
                 int 21h
                 
                 jmp near_beginning            
             
;===============================================================================================================================
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
;===============================================================================================================================
            
            Service1: 
            
            cmp [names_number] , 0      ; If the user enter names again without exiting the program
            ja delete_old_names         ; will check to delete the previous entry...   
       
        names_have_deleted:
        
        ; here will take the value of number of names...
        
        again:
        mov dx, offset S1_msg1_numberOfNames
        mov ah, 9
        int 21h
        
        mov ah, 1
        int 21h     ; After the user enter a number will check
                    ; the value that he entered.
                     
                     ; start of condition
        mov bl, 3Ah  ; 3A = ':',after number 9 ('9' = 39h)
        cmp al, bl
        jae check
                      ; At this condition will check if value
                      ; if al is between 1 and 9 other than 
                      ; that there will be an error message.
                                            
        mov bl, 2fh   ; 2F = '/' ,Before #0 ('0' = 30h)
        cmp al, bl
        jbe check   ; end of condition                
        
        sub al, 30h
        mov ah, 0
        mov names_number, ax 
        mov S1_S2_names_number, ax
        
        mov dx, offset NewLine
        mov ah, 9
        int 21h 
        
;//////////////////////////////////////////////////////////////        
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\       

        ; here will take the value of name's length
        
        again2:
        mov dx, offset S1_msg2_lengthOfNames
        mov ah, 9
        int 21h
        
        mov ah, 1
        int 21h
        
        mov bl, 3Ah  ; start of condition
        cmp al, bl
        jae check2
                      ; here will check if value if al
                      ; is between 1 and 9 other than 
                      ; that there will be an error message
        mov bl, 2fh
        cmp al, bl
        jbe check2   ; end of condition
        
        sub al, 30h        
        mov ah, 0
        mov names_length, ax 
        
        mov dx,offset NewLine
        mov ah,9
        int 21h
           
;********************************************************************************************
;*                                                                                         ;*
;*                                                                                         ;*
                                      jmp Beginning                                        ;*
;*                                                                                         ;*
;*                                                                                         ;*
;******************************************************************************************** 
        
;//////////////////////////////////////////////////////////////        
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        delete_old_names: 
               
          mov al , 9
          mov bx, [names_number] 
          mul bl
          mov cx, ax
          
          lea si, names
                       
       deleting:
                        
          mov [si] , 0
                          
          inc si 
                          
          loop deleting
                        
     jmp names_have_deleted:         
       
        ; the fallwoing check is for < names number>
        ; if the user enter a wrong value...
        
        check:
        mov dx, offset NewLine
        mov ah, 9
        int 21h
        
        mov dx, offset S1_msg3_mistake
        mov ah, 9
        int 21h
        
        mov dx, offset NewLine
        mov ah, 9
        int 21h
        
        jmp again         
        
        ; the fallowing check2 is for the length of names
        ; if the user entered a wrong value...
         
        check2:
        mov dx, offset NewLine
        mov ah, 9
        int 21h
        
        mov dx, offset S1_msg3_mistake
        mov ah, 9
        int 21h
        
        mov dx, offset NewLine
        mov ah, 9
        int 21h
        
        jmp again2           
;===============================================================================================================================
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
;===============================================================================================================================            
    main_prog endp
    
code_seg ends

end main_prog                 