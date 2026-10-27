include Irvine32.inc

STR_LEN = 20

; Bug 3 fix: field order MUST match C++ struct layout exactly.
; C++ has: age first, then first_name, then last_name.
; Mismatched order caused every field access to read from the wrong offset.
Person struct
    age        dword ?
    first_name byte  STR_LEN dup(?)
    last_name  byte  STR_LEN dup(?)
Person ends

.data
    comma byte ', ', 0
    line  byte ' | ', 0

.code

showAll PROC C p:PTR Person, sz:DWORD
    mov esi, p
    mov ecx, sz

    allLoop:
        lea edx, (Person ptr [esi]).last_name
        call WriteString

        mov edx, offset comma
        call WriteString

        ; Bug 4 fix: added missing comma after edx
        lea edx, (Person ptr [esi]).first_name
        call WriteString

        mov edx, offset line
        call WriteString

        mov eax, (Person ptr [esi]).age
        call WriteDec

        call Crlf

        add esi, type Person
        LOOP allLoop
    ret
showAll ENDP


showYoungest proc c p:ptr Person, sz:dword
    mov ecx, sz
    mov esi, p

    mov eax, (Person ptr [esi]).age  ; seed min with first element
    add esi, type Person
    dec ecx                          ; Bug 6 fix: already consumed element 0,
                                     ; so loop only needs sz-1 more iterations

    findYoungest:
        mov ebx, (Person ptr [esi]).age
        ; Bug 5 fix: was "cmp eax, current / ja skip" which skipped when
        ; eax was LARGER — meaning it only updated upward (finding max).
        ; For minimum: skip when current >= running min, update when current < min.
        cmp ebx, eax
        jge skip
        mov eax, ebx                 ; new minimum found
    skip:
        add esi, type Person
        LOOP findYoungest

    ; Bug 7 fix: result was computed but never displayed
    call WriteDec
    call Crlf
    ret
showYoungest endp


showOldest proc c p:ptr Person, sz:dword
    mov esi, p
    mov ecx, sz

    mov eax, (Person ptr [esi]).age  ; seed max with first element
    add esi, type Person
    dec ecx

    L1:
        mov ebx, (Person ptr [esi]).age
        cmp ebx, eax
        jle L2
        mov eax, ebx                 ; new maximum found
    L2:
        add esi, type Person
        loop L1

    call WriteDec
    call Crlf
    ret
showOldest endp


showAverage proc c p:PTR Person, sz:dword
    push ebx
    push esi
    mov esi, p
    mov ecx, sz
    xor eax, eax
    xor ebx, ebx

    accumulate:
        cmp ebx, ecx
        jge done_loop
        mov edx, ebx
        imul edx, type Person        ; sizeof Person also works, type is idiomatic
        add edx, esi
        add eax, [edx]               ; [edx] = age (offset 0 after struct fix)
        inc ebx
        jmp accumulate

    done_loop:
        xor edx, edx
        div ecx                      ; eax = sum / sz

    ; Bug 8 fix: result was computed but never displayed
    call WriteDec
    call Crlf

    pop esi
    pop ebx
    ret
showAverage ENDP

end 