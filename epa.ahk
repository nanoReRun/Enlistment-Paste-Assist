#Requires AutoHotkey v2.0
#SingleInstance Force

course_list := Array()
index := 1

; ===========================
;  OPEN FILE FOR course_list
; ===========================
file_name := FileSelect("1", "Open txt file:")
if (file_name = "")
    return

try
{
    Loop read, file_name
    {
        course_list.Push(A_LoopReadLine)
    }
}
catch as Err
{
    MsgBox "Can't open '" file_name "' for reading."
        . "`n`n" Type(Err) ": " Err.Message
    return
}

ToolTip "Helper running"
SetTimer(() => ToolTip(), -1500)


; =========
;  HOTKEYS
; =========

`::
{
    global course_list, index

    A_Clipboard := course_list[index]
    ToolTip "copied to clipboard"

    Send "^v"

    index := (index >= course_list.Length) ? 1 : index + 1
}

; Resets the index of the list. Once pressed
^`::
{
    global index := 1
}
