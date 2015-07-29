; Listing generated by Microsoft (R) Optimizing Compiler Version 18.00.30501.0 

	TITLE	C:\Users\Simon\Documents\GitHub\Game-of-Life\Input.cpp
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

PUBLIC	?g_aiKeyStates@@3PAW4EKeyState@@A		; g_aiKeyStates
_BSS	SEGMENT
?g_aiKeyStates@@3PAW4EKeyState@@A DD 0100H DUP (?)	; g_aiKeyStates
_BSS	ENDS
PUBLIC	?InitInput@@YAXXZ				; InitInput
PUBLIC	?KeyDownEvent@@YAXW4EKeyState@@@Z		; KeyDownEvent
PUBLIC	?KeyUpEvent@@YAXW4EKeyState@@@Z			; KeyUpEvent
PUBLIC	?KeyHit@@YA_NW4EKeyCode@@@Z			; KeyHit
PUBLIC	?KeyHeld@@YA_NW4EKeyCode@@@Z			; KeyHeld
; Function compile flags: /Ogtp
; File c:\users\simon\documents\github\game-of-life\input.cpp
;	COMDAT ?KeyHeld@@YA_NW4EKeyCode@@@Z
_TEXT	SEGMENT
_eKeyCode$ = 8						; size = 4
?KeyHeld@@YA_NW4EKeyCode@@@Z PROC			; KeyHeld, COMDAT

; 74   : {

	push	ebp
	mov	ebp, esp

; 75   : 	if (g_aiKeyStates[eKeyCode] == kNotPressed)

	mov	eax, DWORD PTR _eKeyCode$[ebp]
	cmp	DWORD PTR ?g_aiKeyStates@@3PAW4EKeyState@@A[eax*4], 0
	jne	SHORT $LN1@KeyHeld

; 76   : 	{
; 77   : 		return false;

	xor	al, al

; 81   : }

	pop	ebp
	ret	0
$LN1@KeyHeld:

; 78   : 	}
; 79   : 	g_aiKeyStates[eKeyCode] = kHeld;

	mov	DWORD PTR ?g_aiKeyStates@@3PAW4EKeyState@@A[eax*4], 2

; 80   : 	return true;

	mov	al, 1

; 81   : }

	pop	ebp
	ret	0
?KeyHeld@@YA_NW4EKeyCode@@@Z ENDP			; KeyHeld
_TEXT	ENDS
; Function compile flags: /Ogtp
; File c:\users\simon\documents\github\game-of-life\input.cpp
;	COMDAT ?KeyHit@@YA_NW4EKeyCode@@@Z
_TEXT	SEGMENT
_eKeyCode$ = 8						; size = 4
?KeyHit@@YA_NW4EKeyCode@@@Z PROC			; KeyHit, COMDAT

; 61   : {

	push	ebp
	mov	ebp, esp

; 62   : 	if (g_aiKeyStates[eKeyCode] == kPressed)

	mov	eax, DWORD PTR _eKeyCode$[ebp]
	cmp	DWORD PTR ?g_aiKeyStates@@3PAW4EKeyState@@A[eax*4], 1
	jne	SHORT $LN1@KeyHit

; 63   : 	{
; 64   : 		g_aiKeyStates[eKeyCode] = kHeld;

	mov	DWORD PTR ?g_aiKeyStates@@3PAW4EKeyState@@A[eax*4], 2

; 65   : 		return true;

	mov	al, 1

; 68   : }

	pop	ebp
	ret	0
$LN1@KeyHit:

; 66   : 	}
; 67   : 	return false;

	xor	al, al

; 68   : }

	pop	ebp
	ret	0
?KeyHit@@YA_NW4EKeyCode@@@Z ENDP			; KeyHit
_TEXT	ENDS
; Function compile flags: /Ogtp
; File c:\users\simon\documents\github\game-of-life\input.cpp
;	COMDAT ?KeyUpEvent@@YAXW4EKeyState@@@Z
_TEXT	SEGMENT
_Key$ = 8						; size = 4
?KeyUpEvent@@YAXW4EKeyState@@@Z PROC			; KeyUpEvent, COMDAT

; 49   : {

	push	ebp
	mov	ebp, esp

; 50   : 	g_aiKeyStates[Key] = kNotPressed;

	mov	eax, DWORD PTR _Key$[ebp]
	mov	DWORD PTR ?g_aiKeyStates@@3PAW4EKeyState@@A[eax*4], 0

; 51   : }

	pop	ebp
	ret	0
?KeyUpEvent@@YAXW4EKeyState@@@Z ENDP			; KeyUpEvent
_TEXT	ENDS
; Function compile flags: /Ogtp
; File c:\users\simon\documents\github\game-of-life\input.cpp
;	COMDAT ?KeyDownEvent@@YAXW4EKeyState@@@Z
_TEXT	SEGMENT
_Key$ = 8						; size = 4
?KeyDownEvent@@YAXW4EKeyState@@@Z PROC			; KeyDownEvent, COMDAT

; 36   : {

	push	ebp
	mov	ebp, esp

; 37   : 	if (g_aiKeyStates[Key] == kNotPressed)

	mov	ecx, DWORD PTR _Key$[ebp]
	xor	eax, eax
	cmp	DWORD PTR ?g_aiKeyStates@@3PAW4EKeyState@@A[ecx*4], eax
	setne	al
	inc	eax
	mov	DWORD PTR ?g_aiKeyStates@@3PAW4EKeyState@@A[ecx*4], eax

; 38   : 	{
; 39   : 		g_aiKeyStates[Key] = kPressed;
; 40   : 	}
; 41   : 	else
; 42   : 	{
; 43   : 		g_aiKeyStates[Key] = kHeld;
; 44   : 	}
; 45   : }

	pop	ebp
	ret	0
?KeyDownEvent@@YAXW4EKeyState@@@Z ENDP			; KeyDownEvent
_TEXT	ENDS
; Function compile flags: /Ogtp
; File c:\users\simon\documents\github\game-of-life\input.cpp
;	COMDAT ?InitInput@@YAXXZ
_TEXT	SEGMENT
?InitInput@@YAXXZ PROC					; InitInput, COMDAT

; 22   : {

	push	edi

; 23   : 	// Initialise input data
; 24   : 	for (int i = 0; i < kMaxKeyCodes; ++i)
; 25   : 	{
; 26   : 		g_aiKeyStates[i] = kNotPressed;

	mov	ecx, 256				; 00000100H
	xor	eax, eax
	mov	edi, OFFSET ?g_aiKeyStates@@3PAW4EKeyState@@A ; g_aiKeyStates
	rep stosd
	pop	edi

; 27   : 	}
; 28   : }

	ret	0
?InitInput@@YAXXZ ENDP					; InitInput
_TEXT	ENDS
END