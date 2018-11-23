; Вычислить: 8) Y=300000%81/X+X*10-1
format PE Console 4.0
entry Start
include 'win32a.inc'
section '.text' code readable executable
Start:
 invoke printf, _insert_x
 push x
 push mesInp
 call [scanf]
 ; 1) 300000%81 div деление без знака r/m32 -> EAX  Остаток в EDX
 xor edx,edx
 mov eax, 300000
 mov ecx, 81
 div ecx

 ; 2) (1)/X idiv деление со знаком EDX:EAX/r/m32=EAX Остаток в EDX
 mov eax,edx
 xor edx,edx
 idiv [x]
 push eax

 ; 3) X*10
 mov eax, [x]
 mov ecx, 10
 imul ecx

 ; 4) (2)+(3)-1
 pop ebx
 add eax,ebx
 dec eax

 push eax
 push mesInp
 call [printf]
Stop:
 call [getch]
Exit:
 push 0
 call [ExitProcess]
section '.data' data readable writeable
 _insert_x db 'insert x:', 0
 mesInp db '%d',0
 x dd ?
section '.idata' import data readable
 library kernel, 'KERNEL32.DLL', msvcrt, 'msvcrt.dll'

 import msvcrt, printf, 'printf', getch, '_getch', scanf, 'scanf'
 import kernel, ExitProcess, 'ExitProcess'