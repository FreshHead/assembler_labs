 format PE console
 entry Start
include 'win32a.inc'
 section '.text' code readable executable
 Start:
 ;mov eax, 0x12345678
 ;mov [c], eax
 ;mov [0x00402000], byte 100

 xor eax,eax
 mov ebx, array
 ;mov esi, 0
 ;mov al, [ebx+esi+1]
 ;mov al, [array+esi+1]
 mov esi,4
_swap_start:

 mov al, [ebx+esi]
 mov cl, [ebx+esi+1]
 cmp al,0
 jz _swap_end
 cmp cl,0
 jz _swap_end

 xchg al,cl
 mov [ebx+esi], al
 mov [ebx+esi+1], cl

 ;mov al, [ebx+3]

 ;mov [ebx], al
 add esi,2
 jmp _swap_start
_swap_end:
 push ebx
 push result
 call [printf]

 Exit:
 push exit_msg
 call [printf]

 push 0
 ccall [getchar]
 push 0
 call [ExitProcess]

 section '.data' data readable writeable
 exit_msg db 13,10,'Press <ENTER> to exit...',0
 array db "123456789abcdef",0; 0 is terminal symbol
 save_ECX dd 9
 result db 'result: %s ',0

 section '.idata' data readable import
 library kernel32, 'kernel32.dll', \
msvcrt, 'msvcrt.dll'
 import kernel32, ExitProcess, 'ExitProcess'
 import msvcrt, printf, \
'printf', getchar,'_fgetchar'