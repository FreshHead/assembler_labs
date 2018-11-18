format PE Console 4.0
entry Start
include 'win32a.inc'
section '.text' code readable executable
Start:
 invoke printf, _insert_x
 push x
 push mesInp
 call [scanf]
;1)
 xor edx,edx
 mov eax, 300000
 mov ecx, 81
 div ecx
 ; 2) EDX:EAX/[x]=EAX [%EDX]
 mov eax,edx
 xor edx,edx
 idiv [x]
 push eax

 ;3) X*10-1
 mov eax, [x]
 mov ecx, 10
 imul ecx

 pop ebx
 add eax,ebx
 dec eax

 ;mov eax, [x]

 ;y = [x] + 37
 push eax
 push mesInp
 call [printf]
 ;invoke printf, mesInp, y
 ;mov eax, [a]
 ;imul [b]
 ;jno NotOverflow
 ;push errMes
 ;call [printf]
; jmp Stop

;NotOverflow:
; push eax
; push dword[b]
; push dword[a]
; push mesMul
; call [printf]
Stop:
 call [getch]
Exit:
 push 0
 call [ExitProcess]
section '.data' data readable writeable
 _insert_x db 'insert x:', 0
 mesMul db '%d * %d = %d', 0dh, 0ah, 0
 mesInp db '%d',0
 x dd 0
; b dd 0
 errMes db 'Overflow EAX', 0dh, 0ah, 0
section '.idata' import data readable
 library kernel, 'KERNEL32.DLL', msvcrt, 'msvcrt.dll'

 import msvcrt, printf, 'printf', getch, '_getch', scanf, 'scanf'
 import kernel, ExitProcess, 'ExitProcess'