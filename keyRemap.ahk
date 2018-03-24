;===================    R/M Button
RETURN
#if getKeyState("RButton","P")
LButton::                   ; Switch to next window
sendWindowBack(){ ;Alt Tab is not used since it shows the TaskSwitcher Window
    activeID:=WinGetID("A")
    loop WinGetList() {
        if activeID!=ids[A_Index]
            continue
        win:="ahk_id " ids[A_Index+1]
        ;Use next two lines to send active window one step back without activating the window behind
       ;,WinSetAlwaysOnTop(True, win)
       ;,WinSetAlwaysOnTop(False, win)
       ,winActivate(win)
       ,break
    }
    return
}
return

MButton:: winSizer.start("RButton")   ; WinSizer
MButton Up::
if !winSizer.end()
    send("#{Tab}")
return

WheelUp::                   ; Switch Windows
WheelDown::
if A_ThisHotkey="WheelUp" {
    ; if (taskView.GetCurrentDesktopNumber()=1)  ;Wrap
    ;     taskView.GoToDesktopNumber(0)
    send("#^{Left}")
} else {
    ; if (taskView.GetCurrentDesktopNumber()=taskView.GetDesktopCount())
    ;     taskView.GoToDesktopNumber(1)
    send("#^{Right}")
}
sleep(200)
return

#if getKeyState("MButton","P")                      ; Move window b/w desktops
WheelUp::
WheelDown::
(A_ThisHotkey="WheelUp")? taskView.MoveToDesktopPrev(WinExist("A"),True): taskView.MoveToDesktopNext(WinExist("A"),False)
sleep(200)
return


#if !winActive("ahk_group right_drag")
*RButton up::
Critical()
if !{"MButton":0,"MButton Up":0,"WheelUp":0,"WheelDown":0}.haskey(A_PriorKey)
    send("{Blind}{RButton}")
return
#If

;===================    Over Taskbar
RETURN
#if isOver_mouse("ahk_class Shell_TrayWnd")   ; Alt tab over taskbar
WheelUp::
WheelDown::
send(A_ThisHotkey="WheelUp" ? "^+!{Tab}" : "^!{Tab}")
return
MButton Up:: Send("+^{Esc}")    ; Task manager

#if winActive("ahk_class MultitaskingViewFrame") AND isOver_mouse("ahk_class Shell_TrayWnd")        ; When Task Switching
LButton::send("{Enter}")
#if

;===================    Ditto & Listary
RETURN
XButton2::
Keywait(A_ThisHotkey, "T0.5")
if !ErrorLevel {
    if !ProcessExist("Ditto.exe") {
        Toast.show("Starting Ditto")
       ,Run("D:\Program Files\Ditto\Ditto.exe")
       ,A_DetectHiddenWindows:=True
       ,WinWait("ahk_exe Ditto",,2)
        if ErrorLevel
            return
    }
    Toast.show("Ditto")
   ,Send("^``")
} else {
    !Space:: runListary()
}
return
runListary(){
  static key:="^#``"
        ,Win  :="ahk_class Listary_WidgetWin_0"
        ,Cntrl:="ListarySearchBox1"
        ,Path :="D:\Program Files\Listary"
        ,exe  :="Listary.exe"
        ,opt  :={activateWindow:True, hiddenWindows:False, sendToAll:True}

    Toast.show("Listary")
   ,text:=getSelectedText()
   ,text:=text?text:Clipboard
   ,text:=RegExReplace(RegExReplace(text, "[`t`n]| +"," "), "^ | $|``r")
   ,text:=strlen(text)<100?text:""

    if !ProcessExist(exe) {
        Toast.show("Starting Listary")
       ,Run(Path "\" exe)
       ,A_DetectHiddenWindows:=True
       ,Winwait("ahk_exe " exe,, 2)
        if ErrorLevel
            return False
    }
    Toast.show("Listary")
   ,send(key)
   ,A_DetectHiddenWindows:=False
   ,Winwait("ahk_exe " exe,,2)
    if ErrorLevel
        return False
    sleep(10)
   ,sendTo_pasteText(text, Win " ahk_exe " Prs, Cntrl, opt)
   ,sendTo("^a", Win "ahk_exe " exe, Cntrl, opt)
    return True
}

;===================    winAction & RunText
RETURN
XButton1::
Keywait(A_ThisHotkey, "T0.25")
if !ErrorLevel {
    #w:: winAction.show()
} else {
    !`:: runText.showGUI()
}
return

;===================    Tray Menu
RETURN
^#t::
updateTray(0,A_ScreenHeight-200)
,sleep(300)
,A_TrayMenu.Show()
return
;===================    Invert F1
RETURN
#F1::Send("{F1}")
return
;===================    Open Potplayer
RETURN
#v::
Toast.Show("Starting PotPlayer")
,Run("D:\Program Files\Potplayer\PotplayerMini64.exe " Clipboard)
return

;===================    Open MusicBee
RETURN
#F10::
A_DetectHiddenWindows:=True
if !winExist("ahk_exe MusicBee.exe") {
    Toast.show("Starting MusicBee")
   ,Run("D:\Program Files\MusicBee\MusicBee.exe")
   ,WinWait("ahk_exe MusicBee.exe",,2)
    if ErrorLevel
        return
    Sleep(100)
}
Toast.show("Play/Pause")
,Send("{Media_Play_Pause}")
return

;===================    Listary launcher
; RETURN
; ~LWin & RWin::return    ;Prevents LWin from trigerring when #... (eg: #Tab) is used
; LWin UP:: Send("#``")
; return

;===================    Toggglekeys and CaseMenu
RETURN
CapsLock::
keywait("Capslock", "T0.2")
if ErrorLevel {
    ^CapsLock:: caseMenu.show()
    return
}
NumLock::
ScrollLock::
Insert::
CaseMenu.toggle(A_ThisHotkey)
return

;===================    NetNotify
RETURN
#n:: netNotify(False,,1000)

;===================    DimScreen
RETURN
#F2:: dimScreen(+25)
#F3:: dimScreen(-25)

;===================    Calc/cmd/Notepad
RETURN
#+CapsLock:: Run("notepad.exe")
#^CapsLock:: Run("calc1.exe")
#CapsLock::  Run("cmd.exe")

;===================    Groupy
RETURN
!CapsLock:: Send("#{F12}")
!+CapsLock:: Send("#^{F12}")

;===================    Fences Pages
RETURN
#if winActive("ahk_class WorkerW ahk_exe explorer.exe") AND getKeyState("LButton","P")
WheelUp::
WheelDown::
send("{LButton Up}!{" (A_ThisHotkey="WheelUp"?"WheelDown":"WheelUp") "}")
return
#if