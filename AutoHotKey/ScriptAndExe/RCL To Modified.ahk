; AutoHotKey 1.1 Capslock Remapping Script 

; RCL 第一行
; 需要注意，在EmEditor这种不选择文本进行复制会复制整一行的软件内，该功能会出现bug
' & `:: ; 代码块
  clipboardBackup := ClipboardAll ; 保存当前剪贴板内容
  Clipboard := "====" ; 先复制个flag
  Send ^c ; 复制选中文本
  ClipWait ; 等待剪贴板内容更新
  ; Sleep, 100 ; 延迟100毫秒 ; 但好像第一次使用该功能总是会有bug
  selectedText := Clipboard ; 要取出再判断否则会出bug
  if (selectedText == "====") {
    Clipboard := "```````n`n``````" ; 需要用两个反引号转义为一个
    Send ^v ; 粘贴
    Send {Up}{End}
  } else {
    codeWrap := "``````"
    Clipboard := codeWrap "`n" selectedText "`n" codeWrap "`n" ; 放入剪贴板
    Send ^v ; 粘贴
  }
  Clipboard := clipboardBackup ; 恢复剪贴板原始内容
Return

' & 1:: ; 反引号
  clipboardBackup := ClipboardAll ; 保存当前剪贴板内容
  Clipboard := "====" ; 先复制个flag
  Send ^c ; 复制选中文本
  ClipWait ; 等待剪贴板内容更新
  ; Sleep, 100 ; 延迟100毫秒 ; 但好像第一次使用该功能总是会有bug
  selectedText := Clipboard ; 要取出再判断否则会出bug
  if (selectedText == "====") {
    Clipboard := """"""  ; 连续两个双引号表示一个双引号
    Send ^v ; 粘贴
    Send {Left}
  } else {
    wrappedText := """" selectedText """"
    Clipboard := """" selectedText """" ; 放入剪贴板
    Send ^v ; 粘贴
  }
  Clipboard := clipboardBackup ; 恢复剪贴板原始内容
Return

' & 2:: ; 小括号
  clipboardBackup := ClipboardAll ; 保存当前剪贴板内容
  Clipboard := "====" ; 先复制个flag
  Send ^c ; 复制选中文本
  ClipWait ; 等待剪贴板内容更新
  ; Sleep, 100 ; 延迟100毫秒 ; 但好像第一次使用该功能总是会有bug
  selectedText := Clipboard ; 要取出再判断否则会出bug
  if (selectedText == "====") {
    Clipboard := "()" ; 放入剪贴板
    Send ^v ; 粘贴
    Send {Left}
  } else {
    Clipboard := "(" selectedText ")" ; 放入剪贴板
    Send ^v ; 粘贴
  }
  Clipboard := clipboardBackup ; 恢复剪贴板原始内容
Return

; RCL 第二行1
' & q::Send {!}
' & w::Send {?}
' & e::Send, =
' & r::Send, _
' & t::Send, {+}
' & g::Send, -
' & tab::Send,　　
; 这里输出两个全角空格
' & CapsLock::Send,{Space}{Space}{Space}{Space}
; 这里输出4个半角空格
;' & f::Send, 重复上屏

' & s::Send,  ……
' & d::Send, 、

' & x::Send, *
' & v::Send, ——
;' & b::Send, 常用

; 右手类
' & j::Send, (
' & u::Send, {U+003a}{U+0020}
; 半角空格加空格
' & k::Send, {'{}
' & i::Send, {'}}
' & h::Send, [
' & y::Send, ]
' & l::Send, <
' & o::Send, >


; ' & h::Send '
+':: Send "
'::Send '

return