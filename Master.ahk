;Use AutoHotkey_2.0-a100-52515e2

Suspend(True)
;#include %A_ScriptDir%  ;Sets dir for includes. No longer needed in v2
#include Directives.ahk

#include <ini>
#include <Toast>
#include <Timer>
#include <ReloadScriptOnEdit>

tip("Tray")
#include Tray.ahk
trayMenu()

tip("SuspendOnFS")
#include <SuspendOnFS>
DelayedTimer.set(Func("suspendOnFS").bind(False,[
        ,"ahk_exe PotPlayerMini64.exe"
        ,"ahk_exe PotPlayer.exe"
        ,"ahk_exe chrome.exe"
        ,"ahk_exe vivaldi.exe"                  ]), 100)


tip("DimScreen")
#include <DimScreen>
; dimScreen(120)

tip("TaskView")
#include <TaskView>
;#include <TaskView_Temp>
TaskView.init()

tip("HotCorners")
#include <HotCorners>
HotCorners.register("TL",Func("send").bind("#{Tab}"))
HotCorners.register("BL",Func("send").bind("#x"    ))
HotCorners.register("BR",Func("send").bind("#a"    ))
Timer.set(objbindMethod(HotCorners,"run"),100)

tip("UnwantedPopupBlocker")
#include UnwantedPopupBlocker.ahk
DelayedTimer.set("UnwantedPopupBlocker", 100)

tooltip("Transparent")
#include <Transparent>
DelayedTimer.set(Func("Transparent_TaskbarGlass").bind(4), 500)
Transparent_Windows.set("ahk_class CabinetWClass ahk_exe explorer.exe")
Transparent_Windows.set("ahk_class PX_WINDOW_CLASS ahk_exe sublime_text.exe",250)
DelayedTimer.set(ObjBindMethod(Transparent_Windows,"run"), 500)
;DelayedTimer.set(Func("Transparent_MaxBG").bind("ahk_exe ImageGlass.exe","3C3C3C"), 500)
;DelayedTimer.set(Func("Transparent_MaxBG").bind("ahk_exe nomacs.exe"    ,"F0F0F0"), 500)

tip("PIP")
#include <PIP>
PIP.__new([  {title:"ahk_exe PotPlayerMini64.exe ahk_class PotPlayer64" ,type:"VJT"}
            ,{title:"ahk_exe PotPlayer.exe ahk_class PotPlayer64"       ,type:"VJT"}
            ,{title:"ahk_exe chrome.exe"                                ,type:"CJT"}
            ,{title:"ahk_exe vivaldi.exe"                                ,type:"CJT"}
            ,{title:"ahk_exe cmd.exe"     , set:"cmd"                   ,type:  "T"}
            ,{title:"ahk_exe calc.exe"    , set:"calc"   , maxheight:500,type:  "N"}
            ,{title:"ahk_exe calc1.exe"   , set:"calc"   , maxheight:500,type:  "N"}
            ])
DelayedTimer.set(ObjbindMethod(PIP,"run"), 100)

tip("CapsLockOffTimer")
#include <CapsLockOffTimer>
DelayedTimer.set(Func("CapsLockOffTimer").bind(60000), 1000)

tip("CaseMenu")
#include <CaseMenu>
CaseMenu.init()

;tip("MicroWindows")
;#include MicroWindows.ahk

;tip("WinAction")
;#include WinAction.ahk ; Refactor
;winAction.__new("winAction.ini")    ; Multiple winaction can be created by using obj1:=new winaction("iniName.ini"), ...

tip("WinSizer")
#include <WinSizer>

;tip("WinProbe")
;#include WinProbe.ahk
;; winProbe.activate()

;tip("RunText")
;#include RunText.ahk  ;Needs serious Refactoring!!
;global runTextObj:=new runText("Runtext.ini")

tip("Internet")
#include Internet.ahk
DelayedTimer.set("netNotify", 5000, True)

tip("ReloadScriptOnEdit")
DelayedTimer.set(func("ReloadScriptOnEdit").bind([A_ScriptDir "\*.ahk", A_ScriptDir "\*.ini"]), 2000, {runatStart:True})

tip("AutoUpdate (v2a)")
#include <AutoUpdateAHKv2a>
;DelayedTimer.set("AutoUpdateAHK", 3600000, {runatStart:True})

Suspend(False)

tip("Initializing all Timers")
DelayedTimer.startAll()

ToolTip()

;Required for HotKeys
GroupAdd("right_drag", "ahk_exe mspaint.exe"  )
GroupAdd("right_drag", "ahk_exe mspaint1.exe" )
GroupAdd("right_drag", "ahk_exe cmd.exe"      )
GroupAdd("right_drag", "ahk_exe vivaldi.exe"  )

;Required for HotStrings
GroupAdd("AutoBracket", "ahk_exe notepad.exe"     )
GroupAdd("AutoBracket", "ahk_exe mathematica.exe" )
GroupAdd("AutoBracket", "ahk_exe chrome.exe"      )

Toast.show("Script Loaded")

;;============================== End of auto-execute
RETURN
#include HotKeys.ahk
#include *i HotStringsPrivate.ahk ;Has personal data in this file, so it is ignored from github
#include HotStrings.ahk

;==================================================
/*  To convert
    ------------
    internet    redo
    microWindows
    runText
    winAction
    winProbe    discard
    toast       improve hotkeys
    TaskView    Update
 */

; Following are temporary lines designed to make the script run without errors till the rest is converted
class RunText {
    showGUI(){
        return tip("runtext")
    }
}
class winAction{
    show(){
        return tip("winaction")
    }
}