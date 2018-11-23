; Ввести с клавиатуры строку символов. Вывести на экран её
; двоичное представление.
format PE Console 4.0
entry Start
include 'win32a.inc'
section '.text' code readable executable
Start:
 invoke printf, _insert_x
 invoke scanf, mesInp, x

 mov ebx, x
 mov esi, 0 ; индекс для итерации по строке
 _begin:
  mov al, [ebx+esi]
  cmp al,0
  jz Stop
  mov di, 7
 _continue:
  cmp di,-1
  jz _loop_end
  mov al, [ebx+esi]
  mov cx, di
  shr al, cl
  and al,1
  push eax
  push mesBinary
  call [printf]
  dec di
  jmp _continue
 _loop_end:
  push mesSpace
  call [printf]
  inc esi
  jmp _begin
Stop:
 call [getch]
Exit:
 push 0
 call [ExitProcess]
section '.data' data readable writeable
 _insert_x db 'insert a string:', 0
 mesMul db '%d * %d = %d', 0dh, 0ah, 0
 mesInp db '%s',0
 mesBinary db '%u',0
 mesSpace db ' ',0
 x dd ?
 errMes db 'Overflow EAX', 0dh, 0ah, 0
section '.idata' import data readable
 library kernel, 'KERNEL32.DLL', msvcrt, 'msvcrt.dll'

 import msvcrt, printf, 'printf', getch, '_getch', scanf, 'scanf'
 import kernel, ExitProcess, 'ExitProcess'