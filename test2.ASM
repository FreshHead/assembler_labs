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
 ;mov esi, 5
 ;mov al, [ebx+esi+1]
 ;mov al, [array+esi+1]
 mov al, [ebx+3]

 mov [ebx], al
 xor edx,edx
 mov eax,ebx
 xor ecx,ecx
 mov ecx,9
 some = 9
 _begin:
 mov dl, [ebx]
 ;dec ecx
; mov save_ECX, ECX

 cmp edx,0
 jz Exit

 push edx
 push string
 call [printf]
 inc ebx
 push 0
 ccall [getchar]

 some = some -1
 ;mov [some], ecx
 ;mov ecx, some


 loop _begin
 Exit:
 push 0
 ccall [getchar]
 push 0
 call [ExitProcess]

 section '.data' data readable writeable
 a db 10
 b db 50
 c dd 0
 array db 1, 2, 3, 4, 5, 6, 7, 8, 9, 0; 0 is terminal symbol
 save_ECX dd 9
 string db 'Val=%d',0

 section '.idata' data readable import
 library kernel32, 'kernel32.dll', \
msvcrt, 'msvcrt.dll'
 import kernel32, ExitProcess, 'ExitProcess'
 import msvcrt, printf, \
'printf', getchar,'_fgetchar'