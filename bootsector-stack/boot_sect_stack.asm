mov ah, 0x0e ; tty mode

mov bp, 0x8000 ; address far away from 0x7c00 so we don't get overwritten
mov sp, bp ; if stack is empty the sp points to bp

push 'A'
push 'B'
push 'C'

; to show how the stack grows downwards
mov al, [0x7ffe] ; 0x8000 - 2
int 0x10

; accessing [0x8000] won't work as you can only access the top
mov al, [0x8000]
int 0x10

; recover the characters using standard procedure: 'pop'
; We can only pop full words so we need a auxiliary register to manipulate
; teh lower byte
pop bx
mov al, bl
int 0x10 ; prints C

pop bx
mov al, bl
int 0x10 ; prints B

pop bx
mov al, bl
int 0x10 ; prints A

; data that has been pop'd from the stack is garbage now
mov al, [0x8000]
int 0x10

jmp $
times 510-($-$$) db 0
dw 0xaa55
