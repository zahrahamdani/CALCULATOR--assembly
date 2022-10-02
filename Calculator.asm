include emu8086.inc
 ;declarations of the macros and replaces the macro names with real code 
 
org 100h   
; defines where the machine code  is to place in memory.
 
jmp start                           
; Jump over data declaration. 

msg:     db      "1-Add",0dh,0ah,"2-Multiply",0dh,0ah,"3-Subtract",0dh,0ah,"4-Divide", 0Dh,0Ah,"5-Square", 0Dh,0Ah,"6-Cube",0Dh,0Ah,"7-Percentage",0Dh,0Ah,"8-Comparison",0Dh,0Ah, '$'
;showing menu to user for selecting functions
 
msg2:    db      0dh,0ah,"Enter First No : $"                                      
;message to get first number from user  

msg3:    db      0dh,0ah,"Enter Second No : $"
;message to get second number from user 
 
msg4:    db      0dh,0ah,"Invalid Choice  $" 
;message when user enters number other than given in menu  
 
msg5:    db      0dh,0ah,"Result : $"                                              
;message to show with calculated result     

msg6:    db      0dh,0ah,'Thank you for using the calculator! Press any key to exit... ', 0Dh,0Ah, '$'
;message at the end of program to exit the console 


start:  
; procedure where user's choice is defined  
    
        mov ah,9
        mov dx, offset msg 
        int 21h
        mov ah,0
        ; First we will display the first message from which user can choose the operation using 'int 21h'.
                               
        int 16h  
; Then we will use 'int 16h' to read a key press, to know the operation which user choosed.eg 1 for addition

; The keypress will be stored in 'al' so, we will comapre to 1 in case of addition,with 2 in case of multiply and so on....
 
        cmp al,31h
        ;comparing al with 31h,31h=ascii code of 1  
        
        je Addition
        ;in case al=1 then jump to 'Addition' and Zero flag is set 
        
        cmp al,32h 
        ;comparing al with 32h, 32h=ascii code of 2
        
        je Multiply 
        ;if al=2 then jump to 'Multiply' and zero flag is set
        
        cmp al,33h
        ;comparing al with 33h, 33h= ascci code of 3
        
        je Subtract 
        ;jump to 'Subtract' if al=3, zero flag is set
        
        cmp al,34h  
        ;comparing al ith 34h, 34h= ascii code 0f 4
        
        je Divide 
        ;jump to 'Divide' if al=4, zero flag is set   
        
        cmp al,35h 
        ;comparing al with 35h, 35h=ascii code of 5
        
        je Square 
        ;jump to 'Square' if al=5, zero flag is set 
        
        cmp al,36h
        ;comparing al with 36h, 36h=ascii code of 6
        
        je Cube
        ;jump to 'Cube' if al=6, zero flaf is set 
        
        cmp al,37h
        ;comparing al with 37h, 37h=ascii code of 7
        
        je Percentage 
        ;jump to 'Percentage' if al=7, zero flaf is set 
        
        cmp al,38h
        ;comparing al with 38h, 38h=ascii code of 8
        
        je Comparison
        ;jump to 'Comparison' if al=8, zero flag is set
        
        mov ah,09h 
        ;writes the string at the cursor position
        
        mov dx, offset msg4 
        ;incase any number other than 1-8
        
        int 21h 
        
        mov ah,0 
        
        int 16h
        ;to read a key press 
        
        jmp start
        ;to start all over
        


InputNo:
;This procedure is for  to take input from user and put it into stack 
   
        
        mov ah,0
        int 16h     
        ; We will use int 16h to read a key press   
          
        mov dx,0 
        ;putting value 0 in dx
         
        mov bx,1 
        ;putting value 1 in bx 
        
        cmp al,0dh 
        ; The keypress will be stored in al so, we will comapre to 0dh which represent the enter key, to know wheter he finished entering the number or not. 
            
        je FormNo 
        ; If it's the enter key then this mean we already have our number stored in the stack, so we will return it back using 'FormNo'.

        sub ax,30h 
        ; Subtracting 30 from the the value of ax to convert the value of key press from ascii to decimal.

        call ViewNo
         ; Calling ViewNo to view the key we pressed on the screen.
        
        mov ah,0
         ; We will mov 0 to ah before we push ax to the stack bec we only need the value in al.
        
        push ax
         ; Push the contents of ax to the stack.  
        
        inc cx 
         ; We will add 1 to cx as this represent the counter for the number of digit.  
        
        jmp InputNo  
         ; Then we will jump back to input number to either take another number or press enter.         
   

; We took each number separatly so we need to form our number and store in one bit 







FormNo:
;This procedure is made so that when user presses enter key  and identifies digits entered number     

        pop ax 
        ;pop the contents of ax from stack 
        
        push dx
        ;push the contents of dx in stack, it is currently empty, to add with unit place  value of the entered number 
             
        mul bx 
        ;multiplying bx i.e 1, the firt number that is the unit place digit will get multiplied with 1
        
        pop dx
        ;pop the contents of dx from stack
        
        add dx,ax
        ;adding dx and ax.. it is basically adding 0 other then unit value eg. entered number is 234 so it will be 004,first in last out 
        
        mov ax,bx 
        ;moving contents of bx into ax , we assume result is in bx
              
        mov bx,10
        ;to make 10's place  
        
        push dx
        ;to push contents of dx into stack
        
        mul bx
        ;t multiply with 10
        
        pop dx
        ;to pop the contents of dx from stack
        
        mov bx,ax 
        ;moving contents of ax into bx;
        
        dec cx
        ;As the number is made in reverse order so decrement means to make numbers after unit place
        
        cmp cx,0
        ;When all the digits of first value is made then the counter  becomes 0 ,if cx=0 we have formed all numbers
         
        jne FormNo
        ;it will jump to 'FormNo' to make the next number as counter is 0 and first number is made
        
        ret  
        ;end of procedure 


              
View:
;This procedure is for printing the result after the desired function is performed 
       
        mov ax,dx 
        ;ax was pushed because it has 30h, moving the vontents of dx into ax
        
        mov dx,0  
        ;putting the value 0 in dx
        
        div cx 
        ;as value of cx=10000, dividing it with cx to delete points
        
        call ViewNo
        ;calling 'ViewNo function to view entered numbers
        
        mov bx,dx 
        ;moving contents of dx ie 0 in bx
        
        mov dx,0
        ;dx=0
        
        mov ax,cx  
        ;moving contents of cx into ax
        
        mov cx,10 
        ;to remove point
        
        div cx
        ;dividing with 10000
        
        mov dx,bx 
        ;moving contents of bc into dx
        
        mov cx,ax
        ;moving contents of ax into cx
               
        cmp ax,0
        ;comparing it with 0 to print the total number
        
        jne View      
        ;jump to 'View' 
        
        ret
        ;exit procedure



ViewNo:     
;to view or display both entered values

; We will push ax and dx to the stack because we will change there values while viewing then we will pop them back from        
; the stack we will do these so, we don't affect their contents.
        
        push ax
         
        push dx 

     
        mov dx,ax
        ; We will mov the value to dx as interrupt 21h expect that the output is stored in it   

       
        add dl,30h
        ; Add 30 to its value to convert it back to ascii  
        mov ah,2
        int 21h
        pop dx 
        ;pop because it has been displayed
                        
        pop ax 
        ;pop because it has been displayed 
             
        ret 
        ;to exit the procedure
      
   

exit:
;This procedure is made to print the "Exit Message" on Screen after the user has performed desired functions
   
        mov dx,offset msg6 
        ;moving offset address of 'msg6' into dx , display message 6
        
        mov ah, 09h
        int 21h
        ;printing the message  

        mov ah, 0
        int 16h  
        ;'int 16h' to read a key press
        
        ret
        ;end procedure
            
                       
Addition: 
;This procedure is for the first function of this calculator i.e Addition 
  
        printn 
        
; Let us handle the case of addition operation.   

        mov ah,09h 
        ;;to display a string character
        
        mov dx, offset msg2 
        ;;input first value from user 

        int 21h  
        ;; First we will display this message 'Enter first no:' also using int 21h.
        
        mov cx,0
        ;we will initialize cx=0 as incerement will occur here 

        call InputNo 
        ; We will call 'InputNo' to handle our input as we will take each number seprately.
         
        push dx
        ;pushing contents of dx into stack  
        
        mov ah,9
        mov dx, offset msg3 
        ; ;input second value
        
        int 21h


        mov cx,0 
        ; We will move to cx 0 because we will increment on it later in InputNo  
        
        call InputNo
        ;we will call input procedure as every input will be taken seperately
        
        pop bx
        add dx,bx
        push dx 
        mov ah,9 
        
        mov dx, offset msg5
        ;display result 
        
        
        int 21h
        mov cx,10000
        ;range this calculator can calculate 
        
        pop dx
        ;pop the result stroed in dx
        
        call View
        ;call view to see result
         
        jmp exit
        ;jump to 'exit' as user wanted to perform addition 
            




Multiply:  

        printn  
        
        mov ah,09h  
                 
        mov dx, offset msg2
        ;input first value from user
        int 21h 
        
        mov cx,0 
        ;;we will initialize cx=0 as incerement will occur here
        
        call InputNo
        ;; We will call 'InputNo' to handle our input as we will take each number seprately.
        
        push dx
        
        mov ah,9    
        
        mov dx, offset msg3
        ;;input first value from user
        
        int 21h 
        mov cx,0
         ;We will move to cx 0 because we will increment on it later in InputNo 
         
        call InputNo
         ;;we will call input procedure as every input will be taken seperately
         
        pop bx
        mov ax,dx
        mul bx 
        mov dx,ax
        push dx 
        mov ah,9 
        
        mov dx, offset msg5
        ;to display result
        
        int 21h  
        
        mov cx,10000
        ;range this calculator can calculate
        
        pop dx
        ;pop the result stored in dx
        
        call View
        ;to view the result
         
        jmp exit
        ;jump to 'exit' as user wanted to perform Multiplication 



Subtract:
;This procedure is for subtraction

        printn
           
        mov ah,09h
        ;to display a string character
        
        mov dx, offset msg2
        ;input first value from user
        
        int 21h
        
        mov cx,0 
        ;we will initialize cx=0 as incerement will occur here
        
        call InputNo
        ;we will call input procedure as every input will be taken seperately
        
        push dx
        mov ah,9 
        
        mov dx, offset msg3 
         ;input second value
         
        int 21h 
        mov cx,0  
        ;;We will move to cx 0 because we will increment on it later in InputNo 
        
        call InputNo 
        
        pop bx
        ;pop contents of bx from stack 
        
        sub bx,dx 
        ;bx-dx
        
        mov dx,bx 
        ;result is stored back in dx
        
        push dx
        ;push result which is in dx into stack
         
        mov ah,9
        mov dx, offset msg5
        ;to display result
        
        int 21h
        
        mov cx,10000  
        ;  ;range this calculator can calculate
        
        pop dx
        ;pop the result stored in dx
        
        call View 
        ;to view the result
        
        jmp exit
        ;to jump to 'exit' as user wanted to perform subtraction 
        
        
            


Divide: 
; Let us handle the case of division operation.
        printn
        mov ah,09h
        mov dx, offset msg2
;Moving first message(input1) to dx register.  

        int 21h
;Displaying message 'Enter first no:' using int 21h.

        mov cx,0
        call InputNo
;Calling 'InputNo' to handle our input as we will take each number seprately.

        push dx
        mov ah,9
        mov dx, offset msg3
;Moving second message(Input2) to dx registor.   

        int 21h
;Displaying message 'Enter second no:' also using int 21h.
 
        mov cx,0
;Moving to cx 0 because we will increment on it later in InputNo. 

        call InputNo
;Calling 'InputNo' again to handle our input as we did earlier.

        pop bx
        mov ax,bx
;Moving first input into register ax.

        mov cx,dx                    
        
;Moving 2nd input into register cx.
        mov dx,0
        mov bx,0
        div cx
;Dividing the value of Cx from ax register.

        mov bx,dx
        mov dx,ax
        push bx 
        push dx
;Pushing dx into stack. 

        mov ah,9
        mov dx, offset msg5
;Moving dx(result) to result message. 

        int 21h
;Printing the result message.  

        mov cx,10000
        pop dx
        call View
;Calling view to show output.
        pop bx                
        
        cmp bx,0
        je exit 
        jmp exit
;Exiting the function.             





Square:
        
; Let us handle the case of Square operation.

        printn
        mov ah,09h
        mov dx, offset msg2
;Moving first message(input1) to dx register.

        int 21h
;Displaying message 'Enter first no:' using int 21h.

        mov cx,0
        call InputNo
;Calling 'InputNo' as our single input will be handled twice.
;No need move cx 0 to increment as single input.
        push dx
        mov ah,9
        pop bx
        mov ax,dx 
;Moving first input in ax register.    

        mul dx
;Multiplying input1 to ax.    

        mov dx,ax 
;Moving output(square) to dx register. 

        push dx
;Pushing dx(result) into stack.   

        mov ah,9
        mov dx, offset msg5
;Moving dx(result) to result message.        

        int 21h
;Printing the result message.  

        mov cx,10000
        pop dx
        call View
;Calling view to show output.    

        jmp exit
;Exiting the function.             





Cube:
; Let us handle the case of Cube operation.
        printn
        mov ah,09h
        mov dx, offset msg2 
;Moving first message(input1) to dx register.

        int 21h 
;Displaying message 'Enter first no:' using int 21h.

        mov cx,0
        call InputNo
;Calling 'InputNo' as our single input will be handled twice.
        push dx
        mov ah,9      
        pop bx 
        mov ax,dx
;Moving first input in ax register.

        mul dx
;Multiplying dx to ax. 
 
        mov dx,ax
;Moving square to dx.
        mul bx
;Multiplying again.
        mov dx,ax
;moving result to dx registor.
        push bx
        push dx
;Pushing result into stack. 
        mov ah,9
        mov dx, offset msg5
;Moving dx(result) to result message.        

        int 21h
;Printing the result message.
        mov cx,10000
        pop dx
        call View
;Calling view to show output. 
 
        jmp exit
;Exiting the function.             






Percentage:     

        printn
;for moving to new line.
        print "Obtain marks"
        printn 
        print "Enter number : "
;Takes number of subject as input.
        call scan_num
        mov ax,cx
;Moves 1st input from cx to ax. 
        printn  
    
        print "Enter Total Number : "
;Enters total number.
        call scan_num  
    
        mov bx,100
;moving 100 to reg bx. 

        mul bx            
                          
;multiplying ax with bx.
        div cx                           
;dividing ax with cx.   
 
        printn
        print "The percentage  = "
    
        call print_num
;displaying ax reg.    

        print ' %'
    
        jmp exit            
;Exiting the function.








Comparison:

print 'Enter 1st number: '
; Taking 1st input.   

call scan_num 
mov ax,cx
;moving value from cx to ax registor.  

printn
printn
print 'Enter 2nd number: '
; Taking 2nd input.
call scan_num 
mov bx,cx                                 

;moving its value from cx to ax registor. 


printn
printn


cmp ax, bx
; Comparing whether they are equal or not.   

je EQUAL
; Jump to Equal box, where we print the equal msg 


CMP AX, BX                                               

; again compare to check the first is greater or lesser 

jl Smaller
; if greater, jump to greater to print a greater msg

cmp ax, bx  
; again compare to check the first is greater or lesser 

jg Great
; if greater, jump to greater to print a greater msg

Great:
print 'First Number is Greater than Second Number.'
jmp exit


Smaller:
print 'First Number is Smaller than Second Number.'
jmp exit


Equal:
print 'Both numbers are equal.' 

jmp exit  
;jump to exit as user wanted to perform Comparision function




DEFINE_SCAN_NUM  
DEFINE_PRINT_NUM_UNS
DEFINE_PRINT_NUM
ret
