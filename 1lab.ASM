 ; Дана строка из 15 символов. Разработать программу, осуществляющую
 ; круговую перестановку части букв исходной строки.
 ; 8) с пятого символа по четырнадцатый через один;
 format PE console
 entry Start
include 'win32a.inc'
 section '.text' code readable executable
 Start:

 xor eax,eax
 mov ebx, array
 mov esi,4
_swap_start:

 mov al, [ebx+esi]
 mov cl, [ebx+esi+2]
 cmp al,0
 jz _swap_end
 cmp cl,0
 jz _swap_end

 xchg al,cl
 mov [ebx+esi], al
 mov [ebx+esi+2], cl

 add esi,3
 jmp _swap_start
_swap_end:
 push ebx
 push result
 call [printf]

 Exit:
 push exit_msg
 call [printf]

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