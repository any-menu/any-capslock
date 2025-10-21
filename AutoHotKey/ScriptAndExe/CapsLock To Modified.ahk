; AutoHotKey 1.1 Capslock Remapping Script 
; 已知BUG：Ctrl Shift F + 连用

;===========================; Mode

Mode_Word := 0	; 词模式
Mode_Line := 0	; 行模式
Mode_Select := 0	; 选择模式 beta

;===========================; Capslock状态

Capslock & Esc::			; 切换大小写
    if GetKeyState("CapsLock", "T") = 1
        SetCapsLockState, AlwaysOff
    else 
        SetCapsLockState, AlwaysOn
    return

init := 0
if (init = 0){			; 防止闪大小锁图标
    Send, {CapsLock Down}{Esc}{Esc}{CapsLock Up}
    init := 1
}

Capslock := 0
CapsLock::			; 单击CL为Esc键
    Send, {ESC}
    return

;===========================; 复合修饰键，方案1，抬起触发词选行选
				; 长按视为按住Ctrl，缺点是词选反应慢

Capslock & f::			; 行选 Mode_Line
    Mode_Line := 1
    KeyWait f
    return
Capslock & f up::
    Mode_Line := 0
    if (A_PriorHotkey = "Capslock & f" && A_PriorKey = "f") {
        Send {Home}{Shift Down}{End}{Shift Up}
    }
    return

Capslock & d::			; 词选 Mode_Word
    Mode_Word := 1
    KeyWait d
    return
Capslock & d up::
    Mode_Word := 0
    if (A_PriorHotkey = "Capslock & d" && A_PriorKey = "d") {
        Send {Ctrl Down}{Left}{Shift Down}{Right}{Shift Up}{Ctrl Up}
    }
    return

Capslock & g::			; 词选 Mode_Word
    Mode_Word := 1
    KeyWait g
    return
Capslock & g up::
    Mode_Word := 0
    if (A_PriorHotkey = "Capslock & g" && A_PriorKey = "g") {
        Send {Ctrl Down}{Left}{Shift Down}{Right}{Shift Up}{Ctrl Up}
    }
    return

Capslock & v::			; 特殊 
    Mode_Special := 1
    KeyWait v
    return
Capslock & v up::
    Mode_Special := 0
    if (A_PriorHotkey = "Capslock & v" && A_PriorKey = "v") {
        Send {Blind}{Ctrl Down}v{ctrl up}
    }
    return

;===========================; 方向区

Capslock & u::			; 上
    if (Mode_Word = 1) {
        Send {Blind}{Ctrl Down}{Home}{Ctrl Up}
    }
    else if (Mode_Line = 1) {
        Send {Blind}{Shift Down}{Up}{Shift Up}
    }
    else if (Mode_Special = 1) {
        SendInput 7
    }
    else {
        Send {Blind}{Up}
    }
    return

Capslock & k::			; 下
    if (Mode_Word = 1) {
        Send {Blind}{Ctrl Down}{End}{Ctrl Up}
    }
    else if (Mode_Line = 1) {
        Send {Blind}{Shift Down}{Down}{Shift Up}
    }
    else if (Mode_Special = 1) {
        SendInput 5
    }
    else {
        Send {Blind}{Down}
    }
    return

Capslock & j::			;左
    if (Mode_Word = 1) {
        Send {Blind}{Ctrl Down}{Left}{Ctrl Up}
    }
    else if (Mode_Line = 1) {
        Send {Blind}{Shift Down}{Left}{Shift Up}
    }
    else if (Mode_Special = 1) {
        SendInput 4
    }
    else {
        Send {Blind}{Left}
    }
    return

Capslock & l::			; 右
    if (Mode_Word = 1) {
        Send {Blind}{Ctrl Down}{Right}{Ctrl Up}
    }
    else if (Mode_Line = 1) {
        Send {Blind}{Shift Down}{Right}{Shift Up}
    }
    else if (Mode_Special = 1) {
        SendInput 6
    }
    else {
        Send {Blind}{Right}
    }
    return

Capslock & h::			; 最左
    if (Mode_Word = 1) {
        Send {Blind}{Shift Down}{Ctrl Down}{Left}{Ctrl Up}{Shift Up}
    }
    else if (Mode_Line = 1) {
        Send {Blind}{Shift Down}{Home}{Shift Up}
    }
    else {
        Send {Blind}{Home}
    }
    return

Capslock & `;::			; 最右
    if (Mode_Word = 1) {
        Send {Blind}{Shift Down}{Ctrl Down}{Right}{Ctrl Up}{Shift Up}
    }
    else if (Mode_Line = 1) {
        Send {Blind}{Shift Down}{End}{Shift Up}
    }
    else {
        Send {Blind}{End}
    }
    return

;===========================; 删除区

Capslock & i::			; 前删
    if (Mode_Word = 1) {
        Send {Blind}{Ctrl Down}{Backspace}{Ctrl Up}
    }
    else if (Mode_Line = 1) {
        Send +{Home}{Backspace}
    }
    else if (Mode_Select = 1) {
        Send +{Home}{Backspace}
    }
    else if (Mode_Special = 1) {
        SendInput 8
    }
    else if getkeystate("shift") = 1
        Send +{Home}{Backspace}
    else
        Send {Backspace}
    return

Capslock & o::			; 后删
    if (Mode_Word = 1) {
        Send {Blind}{Ctrl Down}{Delete}{Ctrl Up}
    }
    else if (Mode_Line = 1) {
        Send +{End}{Backspace}
    }
    else if (Mode_Select = 1) {
        Send +{End}{Backspace}
    }
    else if (Mode_Special = 1) {
        SendInput 9
    }
    else if getkeystate("shift") = 1
        Send +{End}{Delete}
    else
        Send {Delete}
    return

;Capslock & p::
;    if getkeystate("shift") = 1
;        Send {+Home}{Delete}{+End}{Delete}
;    return

;===========================; 增加区

; CL 其他行
Capslock & Space::			; 新增行 (P尾换行，G拷贝换行)
    if (Mode_Line = 1) {
        ;Send {End}{Enter}
        Send {Home}{Shift Down}{End}{Shift Up}{Backspace}
    }
    else if (Mode_Word = 1) {
        Send {Home}{Shift Down}{End}{Shift Up}^c{End}{Enter}^v
    }
    else if (Mode_Special = 1) {
        SendInput 0
    }
    else {
        Send {Blind}{Enter}
    }
    return

+Space::Send {Blind}{Enter}		; 带Shift的换行
^Space::Send {Blind}{Enter}		; 带Ctrl的换行

;===========================; 小键盘区（有部分在其他区里，如增删移区）

Capslock & m::
    if (Mode_Special = 1) {
        SendInput 1
    }
    return

Capslock & ,::
    if (Mode_Special = 1) {
        SendInput 2
    }
    return

Capslock & .::
    if (Mode_Special = 1) {
        SendInput 3
    }
    return
	
Capslock & n::
    if (Mode_Special = 1) {
        SendInput {Asc 46}
    }
    return

;===========================; 替换Ctrl区

Capslock & Z::Send {Blind}{Ctrl Down}z{ctrl up}
Capslock & X::Send {Blind}{Ctrl Down}x{ctrl up}
Capslock & C::Send {Blind}{Ctrl Down}c{ctrl up}
Capslock & B::Send {Blind}{Ctrl Down}b{ctrl up}

Capslock & Q::
    Mode_Select := 1
    Send {Blind}{Shift Down}
    KeyWait q
    return
Capslock & Q up::
    Mode_Select := 0
    Send {Blind}{Shift Up}
    return
Capslock & W::Send {Blind}{Ctrl Down}z{Ctrl Up}
Capslock & E::Send {Blind}{Ctrl Down}x{Ctrl Up}
Capslock & R::Send {Blind}{Ctrl Down}c{Ctrl Up}
Capslock & T::Send {Blind}{Ctrl Down}v{Ctrl Up}

Capslock & A::Send {Blind}{Ctrl Down}a{Ctrl Up}
Capslock & S::Send {Blind}{Ctrl Down}s{Ctrl Up}

Capslock & `::Send {Blind}{ctrl down}`{ctrl up}
Capslock & 1::Send {Blind}{ctrl down}1{ctrl up}
Capslock & 2::Send {Blind}{ctrl down}2{ctrl up}
Capslock & 3::Send {Blind}{ctrl down}3{ctrl up}
Capslock & 4::Send {Blind}{ctrl down}4{ctrl up}
Capslock & 5::Send {Blind}{ctrl down}5{ctrl up}
Capslock & 6::Send {Blind}{ctrl down}6{ctrl up}

;===========================;

Capslock & [::SendInput {Blind}{PgUp Down}
Capslock & [ up::SendInput {Blind}{PgUp Up}
Capslock & ]::SendInput {Blind}{PgDn Down}
Capslock & ] up::SendInput {Blind}{PgDn Up}
Capslock & /::SendInput ^+{Right} {Delete}

; Win 热键
#c::Run calc ; 原动作是叫小娜
#n::Run notepad

; RShift 热键
RShift::SendInput {Blind}{Shift Up Control Down}
RShift up::SendInput {Blind}{Control Up}
return

; A 数字
;A & H::Send 0
;A & J::Send 1
;A & K::Send 2
;A & L::Send 3
;A & `;::Send 4
;A & '::Send .
;A & Y::Send 5
;A & U::Send 6
;A & I::Send 7
;A & O::Send 8
;A & P::Send 9
;A & Space::Send 0
;A::Send, a
;Return
