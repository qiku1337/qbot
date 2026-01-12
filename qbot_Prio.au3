#include <ButtonConstants.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <StaticConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <Timers.au3>
#include <Misc.au3>
#include <GUIListBox.au3>
#include <Array.au3>
#include <Process.au3>
#include <WinAPI.au3>

#include <Includes/memory1.au3>
#include <Includes/memory2.au3>
#include <Includes/BlockInputEx.au3>
#include <Includes/help.au3>
#include <Includes/config.au3>
#include <Includes/mouse.au3>
#include <Includes/sql.au3>
#include <pop.au3>

#include <Includes/Address/address_prio.au3>

#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_icon=qbot.ico
#RequireAdmin
#NoTrayIcon
HotKeySet("{PAUSE}", "KILL")

global $dll = DllOpen("user32.dll")

$l = _Timer_Init()
global $pid,$memory_g,$name,$handle,$targetspellinput,$Manacurr,$Hpcurr
global $cntup,$trainxy = 0
global $id4,$Bot,$namelab,$fadeon
global $HpInput1,$HpInput2,$HpInput3,$ManaInput1,$ManaInput2,$ManaInput3,$HealHot1,$HealHot2,$HealHot3,$ManaHot1,$ManaHot2,$ManaHot3


checklic()

Func KILL()
   Exit 0
EndFunc

Func saveconfigall()
   _saveconfig($heal1del,"heal1del")

   _saveconfig($senzu1del,"senzu1del")

   _saveconfig($HpInput1,"HpInput1")
   _saveconfig($HpInput2,"HpInput2")
   _saveconfig($HpInput3,"HpInput3")

   _saveconfig($ManaInput1,"ManaInput1")
   _saveconfig($ManaInput2,"ManaInput2")
   _saveconfig($ManaInput3,"ManaInput3")

   _saveconfig($HealHot1,"HealHot1")
   _saveconfig($HealHot2,"HealHot2")
   _saveconfig($HealHot3,"HealHot3")

   _saveconfig($ManaHot1,"ManaHot1")
   _saveconfig($ManaHot2,"ManaHot2")
   _saveconfig($ManaHot3,"ManaHot3")

   _saveconfig($targetdel,"targetdel")
   _saveconfig($atkspldel,"atkspldel")
   _saveconfig($atksplmp,"atksplmp")
   _saveconfig($atksplin,"atksplin")
EndFunc

Func botgui()

#Region ### START Koda GUI section ### Form=
		 $Bot = GUICreate("Qbot PrioDB", 214, 290, 0, 60)
		 $Ramka = GUICtrlCreateTab(2, 2, 210, 282)
		 GUICtrlCreateTabItem("Runes")
		 $butinfo2 = GUICtrlCreateButton("?", 171, 0, 20, 20, $BS_CENTER)

		 $NameLabel = GUICtrlCreateLabel("Name", 16, 24, 36, 17)

		 $namelab = GUICtrlCreateLabel("???", 56, 24, 58, 17)

		 $Label1 = GUICtrlCreateLabel("Mana", 16, 58, 31, 17)

		 $Manacurr = GUICtrlCreateLabel("0", 54, 58, 30, 17)

		 $Label2 = GUICtrlCreateLabel("Hp", 17, 42, 31, 17)

		 $Hpcurr = GUICtrlCreateLabel("0", 54, 42, 30, 17)

		 $Afkon = GUICtrlCreateCheckbox("Anti Afk", 40, 257, 60, 17)

		 $Afkon2 = GUICtrlCreateCheckbox("Biegaj^V", 112, 257, 60, 17)

		 $Label3 = GUICtrlCreateLabel("Delay, hp/mana,  hotkey,    on/off", 23, 74, 164, 17)

		 global $heal1del = GUICtrlCreateInput(_loadconfig("heal1del"), 11, 87, 41, 22)

		 global $senzu1del = GUICtrlCreateInput(_loadconfig("senzu1del"), 11, 167, 41, 22)

		 global $HpInput1 = GUICtrlCreateInput(_loadconfig("HpInput1"), 56, 87, 32, 22)
		 global $HpInput2 = GUICtrlCreateInput(_loadconfig("HpInput2"), 56, 112, 32, 22)
		 global $HpInput3 = GUICtrlCreateInput(_loadconfig("HpInput3"), 56, 137, 32, 22)
		 global $ManaInput1 = GUICtrlCreateInput(_loadconfig("ManaInput1"), 56, 167, 32, 22)
		 global $ManaInput2 = GUICtrlCreateInput(_loadconfig("ManaInput2"), 56, 192, 32, 22)
		 global $ManaInput3 = GUICtrlCreateInput(_loadconfig("ManaInput3"), 56, 217, 32, 22)

		 global $HealHot1 = GUICtrlCreateCombo(_loadconfig("HealHot1"), 96, 87, 50, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
		 GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")
		 global $HealHot2 = GUICtrlCreateCombo(_loadconfig("HealHot2"), 96, 111, 50, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
		 GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")
		 global $HealHot3 = GUICtrlCreateCombo(_loadconfig("HealHot3"), 96, 137, 50, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
		 GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")

		 global $ManaHot1 = GUICtrlCreateCombo(_loadconfig("ManaHot1"), 96, 167, 50, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
		 GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")
		 global $ManaHot2 = GUICtrlCreateCombo(_loadconfig("ManaHot2"), 96, 192, 50, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
		 GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")
		 global $ManaHot3 = GUICtrlCreateCombo(_loadconfig("ManaHot3"), 96, 217, 50, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
		 GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")

		 $heal1on = GUICtrlCreateCheckbox("Heal", 151, 84, 55, 20)

		 $senzu1on = GUICtrlCreateCheckbox("Mana", 151, 164, 55, 20)

		 $TabSheet1 = GUICtrlCreateTabItem("Train")
		 $trainxybut = GUICtrlCreateButton("Monster xy", 55, 33, 65, 17)
		 $trainon = GUICtrlCreateCheckbox("Targeting on", 124, 33, 81, 17)
		 global $targetdel = GUICtrlCreateInput(_loadconfig("targetdel"), 12, 31, 41, 22)
		 global $atksplin = GUICtrlCreateCombo(_loadconfig("atksplin"), 100, 64, 50, 25)
		 GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")

		 global $atkspldel = GUICtrlCreateInput(_loadconfig("atkspldel"), 12, 64, 41, 22)
		 global $atksplmp = GUICtrlCreateInput(_loadconfig("atksplmp"), 56, 64, 41, 22)
		 $atksplon = GUICtrlCreateCheckbox("Target spell", 152, 65, 49, 17)
		 GUICtrlCreateTabItem("")
		 GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###



WinSetOnTop($Bot, "", 1)
$id0 = _Timer_SetTimer($Bot,200,"name")
$id99 = _Timer_SetTimer($Bot,1000,"nameupdate")
$id98 = _Timer_SetTimer($Bot,1000,"fade")
$id97 = _Timer_SetTimer($Bot,1000*60,"telemetry_update")
While 1
   $nMsg = GUIGetMsg()

   Switch $nMsg
   Case $GUI_EVENT_CLOSE
	  saveconfigall()
		 Exit

	  Case $butinfo2
		 help1()

	  Case $heal1on
		 If _IsChecked($heal1on) Then
		    $id1 = _Timer_SetTimer($Bot,guictrlread($heal1del),"_heal1")
		 Else
		    _Timer_KillTimer($Bot,$id1)
		 EndIf


	  Case $senzu1on
		 If _IsChecked($senzu1on) Then
			$id4 = _Timer_SetTimer($Bot,guictrlread($senzu1del),"_senzu1")
		 Else
			_Timer_KillTimer($Bot,$id4)
		 EndIf

	  Case $trainon
		 If _IsChecked($trainon) Then
			$id7 = _Timer_SetTimer($Bot,guictrlread($targetdel),"train")
		 Else
			_Timer_KillTimer($Bot,$id7)
		 EndIf

	  Case $Afkon2
		 If _IsChecked($Afkon2) Then
			$id8 = _Timer_SetTimer($Bot,200,"afk2")
		 Else
			_Timer_KillTimer($Bot,$id8)
		 EndIf

	  Case $Afkon
		 If _IsChecked($Afkon) Then
			$id9 = _Timer_SetTimer($Bot,11200,"afk")
		 Else
			_Timer_KillTimer($Bot,$id9)
		 EndIf

	  Case $atksplon
		 If _IsChecked($atksplon) Then
			$id10 = _Timer_SetTimer($Bot,guictrlread($atkspldel),"train_spell")
		 Else
			_Timer_KillTimer($Bot,$id10)
		 EndIf

	  Case $trainxybut
		 $trainxy = _mousepos(0)

	EndSwitch

WEnd

EndFunc

;funkcja ischeckbox

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc

;funkcje botowe



 ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

func name($1,$2,$3,$4)
   $namefinal = "0x" & hex($base_adr+$name_static)
   global $name = _MemoryPointerRead($namefinal, $memory_g, $name_offset,"char[10]")

   $finalADDR = "0x" & hex($base_adr+$mana_static)
   global $mana_global = _MemoryPointerRead($finalADDR, $memory_g, $mana_offset,"double")

   $finalADDRh = "0x" & hex($base_adr+$hp_static)
   global $hp_global = _MemoryPointerRead($finalADDRh, $memory_g, $hp_offset,"double")

   $finalADDR = "0x" & hex($base_adr+$ifattack_static)
   global $ifattack_global = _MemoryPointerRead($finalADDR, $memory_g, $ifattack_offset)
EndFunc

func nameupdate($1,$2,$3,$4)
   GUICtrlSetData($Manacurr,$mana_global[1])
   GUICtrlSetData($Hpcurr, $hp_global[1])
   GUICtrlSetData($namelab,$name[1])
EndFunc

func telemetry_update($1,$2,$3,$4)
   telemetry($hardid,$name[1],$servername_global)
EndFunc

func fade($1,$2,$3,$4)
   If $fadeon == 1 Then
	  $cntup = $cntup+1
   EndIf
   $gethp = 1
   If $cntup == 3 Then
	  ToolTip("")
	  $cntup = 0
	  $fadeon = 0
   EndIf
EndFunc

func _heal1($1,$2,$3,$4)
   $hpin1 = guictrlread($HpInput1)
   $hpin2 = guictrlread($HpInput2)
   $hpin3 = guictrlread($HpInput3)
	  if $hp_global[1] <= $hpin3 And guictrlread($HealHot3) <> "" Then
		 KeySend($hwnd,guictrlread($HealHot3))
		 ConsoleWrite("STR"&@CRLF)
	  ElseIf $hp_global[1] <= $hpin2 And guictrlread($HealHot2) <> "" Then
		 KeySend($hwnd,guictrlread($HealHot2))
		 ConsoleWrite("MID"&@CRLF)
	  ElseIf $hp_global[1] <= $hpin1 And guictrlread($HealHot1) <> "" Then
		 KeySend($hwnd,guictrlread($HealHot1))
		 ConsoleWrite("SOFT"&@CRLF)
	  EndIf
EndFunc

func _senzu1($1,$2,$3,$4)
   $mpin1 = guictrlread($ManaInput1)
   $mpin2 = guictrlread($ManaInput2)
   $mpin3 = guictrlread($ManaInput3)
	  if $mana_global[1] <= $mpin3 And guictrlread($ManaHot3) <> "" Then
		 KeySend($hwnd,guictrlread($ManaHot3))
		 ConsoleWrite("STR"&@CRLF)
	  ElseIf $mana_global[1] <= $mpin2 And guictrlread($ManaHot2) <> "" Then
		 KeySend($hwnd,guictrlread($ManaHot2))
		 ConsoleWrite("MID"&@CRLF)
	  ElseIf $mana_global[1] <= $mpin1 And guictrlread($ManaHot1) <> "" Then
		 KeySend($hwnd,guictrlread($ManaHot1))
		 ConsoleWrite("SOFT"&@CRLF)
	  EndIf
EndFunc

func _senzu2($1,$2,$3,$4)
   $manain = guictrlread($ManaInput2)
	  if $mana_global[1] <= $manain Then
		 $spellname = guictrlread($ManaHot2)
		 KeySend($hwnd,$spellname)
	  EndIf
   EndFunc

func _senzu3($1,$2,$3,$4)
   $manain = guictrlread($ManaInput3)
	  if $mana_global[1] <= $manain Then
		 $spellname = guictrlread($ManaHot3)
		 KeySend($hwnd,$spellname)
	  EndIf
EndFunc

func afk($1,$2,$3,$4)
   ControlSend($hWnd,"","","{CTRLdown}{UP}{CTRLUP}")
   Sleep(10)
   ControlSend($hWnd,"","","{CTRLdown}{DOWN}{CTRLUP}")
   unstuck()
EndFunc

func afk2($1,$2,$3,$4)
   ControlSend($hWnd,"","","{UP}")
   Sleep(10)
   ControlSend($hWnd,"","","{UP}")
   Sleep(10)
   ControlSend($hWnd,"","","{UP}")
   Sleep(10)
   ControlSend($hWnd,"","","{DOWN}")
   Sleep(10)
   ControlSend($hWnd,"","","{DOWN}")
   Sleep(10)
   ControlSend($hWnd,"","","{DOWN}")
   Sleep(10)
EndFunc

func train($1,$2,$3,$4)
		 if $ifattack_global[1] == 0 AND $trainxy <> 0 Then
		 _MouseClickPlus($hwnd,"left",$trainxy[0],$trainxy[1],1)
	  EndIf
EndFunc

func train_spell($1,$2,$3,$4)
   if $ifattack_global[1] <> 0 Then
	  if $mana_global[1] >= GUICtrlRead($atksplmp) Then
		 $spellname = guictrlread($atksplin)
		 KeySend($hwnd,$spellname)
	  EndIf
   EndIf
EndFunc

; Mouse positions <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

Func mousepost()
   While 1
    Sleep(10) ; This enough to prevent CPU overload <<<<<<<<<<<<<<<<<<<<<<<<
    If _IsPressed("01", $dll) Then
        $trainx = MouseGetPos(0)
		$trainy = MouseGetPos(1)
	    ExitLoop
        While _IsPressed("01", $dll)
            Sleep(10)
        WEnd
    EndIf
   WEnd
EndFunc

Func _mousepos($opt = 0)
   Local $user32 = DllOpen("user32.dll")
   While 1
    Sleep(10)
    If _IsPressed("01", $user32) Then
	     $fadeon = 1
		 $cntup = 0
		  SoundPlay(@WindowsDir & "\media\Ring06.wav", 0);powiadomienie.wav
		 If $opt == 1 Then
			opt("MouseCoordMode", 1)
			Sleep(100)
			local $xy = MouseGetPos()
			ToolTip("OK:"&$xy[0]&"/"&$xy[1],$xy[0]-40,$xy[1]-40)
			DllClose($user32)
			Return $xy
		 ElseIf $opt == 0 Then
		    opt("MouseCoordMode", 0)
			Sleep(100)
		    local $xy = MouseGetPos()
		    ToolTip("OK:"&$xy[0]&"/"&$xy[1],$xy[0]-40,$xy[1]-40)
			DllClose($user32)
		    Return $xy
		 While _IsPressed("01", $user32)
            Sleep(10)
		 WEnd
	  EndIf
    EndIf
   WEnd
EndFunc

Func unstuck()
   	  $vkvalue = 17
	  DllCall($dll,"int","keybd_event","int",$vkvalue,"int",0,"long",0,"long",0) ;To press a key
	  DllCall($dll,"int","keybd_event","int",$vkvalue,"int",0,"long",2,"long",0) ;To release a key
EndFunc

