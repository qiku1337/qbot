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
#include <pop.au3>


;#include <address_Realesta.au3>
;#include <address_Nostalrius.au3>
#include <Includes/address_Mastercores.au3>

#Region
;#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_icon=qbot.ico

#pragma compile(FileVersion, 0.0.5.1, 0.0.5.1)
#pragma compile(FileDescription, QBot-Tibia bot)
#pragma compile(ProductName, QBot)
#pragma compile(LegalCopyright, © Wiktor Skrobinski)
#EndRegion

#RequireAdmin
#NoTrayIcon

HotKeySet("{PAUSE}", "KILL")

;global $dll = DllOpen("user32.dll")

$RunningTime = TimerInit()

;GetCurrentSoftwareVersion()
;doVersionCheck()


global $pid,$memory_g,$name
global $handx,$handy
global $id4,$id5,$id6,$id9,$Bot,$namelab,$watchon,$color,$fishsqm,$bval

global $aim1xy = ["0","0"],$aim2xy = ["0","0"],$aim3xy = ["0","0"],$aim4xy = ["0","0"],$trainxy = ["0","0"],$foodxy = ["0","0"]
global $spearxy = ["0","0"],$fishxy = ["0","0"], $rodxy = ["0","0"], $handxy = ["0","0"], $aimuhxy  = ["0","0"], $aimplxy = ["0","0"]
global $reccnt = 0,$cntup = 0,$fadeon = 0,$gethp = 1,$maxhp

global $demo = 0

pop()

Func KILL()
    saveconfigall()
    Exit 0
EndFunc

Func saveconfigall()
   _saveconfig($HpInput,"healhp")
   _saveconfig($Manaheal,"healmana")
   _saveconfig($HealHot,"healhotkey")
   _saveconfig($ManaInput,"runemana")
   _saveconfig($RunemakerInput,"runehotkey")
   _saveconfig($reconnectmin,"recconect_time")
   _saveconfig($hotkey_1,"hotkey_1")
   _saveconfig($hotkey_2,"hotkey_2")
   _saveconfig($hotkey_3,"hotkey_3")
   _saveconfig($hotkey_4,"hotkey_4")
EndFunc

Func botgui()

#Region ### START Koda GUI section ### Form=
	  $Bot = GUICreate("Qbot V.4.4("&$pid&")", 215, 340, 0, 60)
	  $Ramka = GUICtrlCreateTab(2, 2, 210, 330)
	  GUICtrlCreateTabItem("Runes")
	  $butinfo1 = GUICtrlCreateButton("?", 175, 3, 20, 20, $BS_CENTER)
	  ;global $List2= GUICtrlCreateList("", 30, 332, 129, 184)
	  $NameLabel = GUICtrlCreateLabel("Name", 20, 27, 56, 17)
	  $namelab = GUICtrlCreateLabel("???", 60, 27, 188, 17)
	  $hplabel = GUICtrlCreateLabel("Hp", 21, 45, 31, 17)
	  global $Hpcurr = GUICtrlCreateLabel("0", 58, 45, 36, 17)
	  $manalabel = GUICtrlCreateLabel("Mana", 20, 61, 31, 17)
	  global $Manacurr = GUICtrlCreateLabel("0", 58, 61, 28, 17)
	  $caplabel = GUICtrlCreateLabel("Cap", 91, 45, 31, 17)
	  global $Capcurr = GUICtrlCreateLabel("0", 118, 45, 36, 17)
	  $battlelabel = GUICtrlCreateLabel("Screen player +2sqm", 151, 45, 33, 39)
	  global $Battlecurr = GUICtrlCreateLabel("0", 188, 45, 36, 17)

	  $Label3 = GUICtrlCreateLabel("Healbot", 91, 69, 68, 17)
	  global $HpInput = GUICtrlCreateInput(_loadconfig("healhp"), 20, 82, 32, 22)
	  global $Manaheal = GUICtrlCreateInput(_loadconfig("healmana"), 20, 102, 32, 22)
	  global $HealHot = GUICtrlCreateCombo(_loadconfig("healhotkey"), 60, 90, 50, 25)
	  GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12|uh")
	  global $Healon = GUICtrlCreateCheckbox("Healer On", 124, 87, 73, 20)
	  $uhxybut = GUICtrlCreateButton("UH", 160, 110, 20, 20)
	  $plxybut = GUICtrlCreateButton("PL", 140, 110, 20, 20)

	  $RuneLabel = GUICtrlCreateLabel("Runemaker", 68, 127, 68, 17)
	  $ManaLabel = GUICtrlCreateLabel("Mana to cast + hotkey", 44, 141, 108, 17)
	  global $ManaInput = GUICtrlCreateInput(_loadconfig("runemana"), 20, 164, 32, 22)
	  global $RunemakerInput = GUICtrlCreateCombo(_loadconfig("runehotkey"), 60, 164, 50, 25)
	  GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")
      $Runeon = GUICtrlCreateCheckbox("Runemaker on", 124, 161, 73, 25)

	  $Afkon = GUICtrlCreateCheckbox("Anti Afk", 124, 229, 60, 17)
	  $Afkon2 = GUICtrlCreateCheckbox("Anti Afk2", 124, 249, 60, 17)

	  $watchon = GUICtrlCreateCheckbox("Safe logout", 20, 210, 90, 17)
	  $alarmon = GUICtrlCreateCheckbox("Attack alarm", 124, 210, 80, 17)
	  $reconnecton = GUICtrlCreateCheckbox("Reconnect", 20, 230, 70, 17)
	  global $reconnectmin = GUICtrlCreateInput(_loadconfig("recconect_time"), 95, 230, 20, 20)
	  $foodbut = GUICtrlCreateButton("Food xy", 18, 190, 93, 17)
	  $fishingbut = GUICtrlCreateButton("Fishing xy", 18, 250, 50, 17)
	  $wedkabut = GUICtrlCreateButton("Wedka xy", 67, 250, 53, 17)
	  global $eatfoodcheck = GUICtrlCreateCheckbox("Eat food", 124, 190, 73, 17)
	  global $fishingon = GUICtrlCreateCheckbox("Fish around", 18, 270, 73, 17)
	  $fishsqm = GUICtrlCreateInput("2", 95, 270, 20, 20)
	  $fishlabel = GUICtrlCreateLabel("SQM from fishing xy", 120, 270, 52, 27)
	  $unstuckbut = GUICtrlCreateButton("Help me my ctrl is stuck!", 18, 300, 150, 27)

	  GUICtrlCreateTabItem("Light")
	  $lightlockLabel = GUICtrlCreateLabel("Light hack", 28, 29, 52, 17)

	  $Lighton = GUICtrlCreateCheckbox("Boze daj mi swiatlo", 36, 49, 117, 25)

	  GUICtrlCreateTabItem("Aim")
	  $butinfo2 = GUICtrlCreateButton("?", 175, 3, 20, 20, $BS_CENTER)
	  $hotkey1but = GUICtrlCreateButton("SHOOT1_XY", 12, 52, 70, 25)
	  $hotkey2but = GUICtrlCreateButton("SHOOT2_XY", 12, 82, 70, 25)
      $hotkey3but = GUICtrlCreateButton("SHOOT3_XY", 12, 112, 70, 25)
	  $hotkey4but = GUICtrlCreateButton("DRAG1_XY", 12, 142, 70, 25)

	  $hoton = GUICtrlCreateCheckbox("Hotkeys on", 60, 196, 81, 17)
	  $Label4 = GUICtrlCreateLabel("Key", 132, 29, 23, 18)

	  global $hotkey_1 = GUICtrlCreateInput(_loadconfig("hotkey_1"), 122, 53, 49, 22)
	  global $hotkey_2 = GUICtrlCreateInput(_loadconfig("hotkey_2"), 122, 82, 49, 22)
	  global $hotkey_3 = GUICtrlCreateInput(_loadconfig("hotkey_3"), 122, 112, 49, 22)
	  global $hotkey_4 = GUICtrlCreateInput(_loadconfig("hotkey_4"), 122, 143, 49, 22)

	  $TabSheet1 = GUICtrlCreateTabItem("Train")
	  $butinfo3 = GUICtrlCreateButton("?", 175, 3, 20, 20, $BS_CENTER)
	  $trainxybut = GUICtrlCreateButton("Monster xy", 4, 34, 73, 25)
	  $trainon = GUICtrlCreateCheckbox("Auto target on", 84, 36, 85, 17)
	  $handxybut = GUICtrlCreateButton("Hand xy", 4, 65, 73, 25)
	  $labeltrain = GUICtrlCreateLabel("Podnos spear co", 4, 90, 90, 18)
	  $podnospearcheck = GUICtrlCreateCheckbox("sec", 120, 90, 90, 18)
	  $spearpickdel = GUICtrlCreateInput("10", 90, 87, 20, 20)

	  GUICtrlCreateTabItem("")
	  GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

;ConsoleWrite(FileGetVersion(@ScriptDir & "\qbot.exe"))

WinSetOnTop($Bot, "", 1)

$id0 = _Timer_SetTimer($Bot,100,"name")
$id99 = _Timer_SetTimer($Bot,1000,"nameupdate")
$id98 = _Timer_SetTimer($Bot,1000,"fade")
;$id97 = _Timer_SetTimer($Bot,500,"battlelist")

While 1
   $nMsg = GUIGetMsg()

   Switch $nMsg
   Case $GUI_EVENT_CLOSE
		 saveconfigall()
		 Exit

	  Case $butinfo1
		 help1()

	  Case $butinfo2
		 help2()

	  Case $butinfo3
		 help3()

	  Case $Runeon
		 If _IsChecked($Runeon) Then
		    $id1 = _Timer_SetTimer($Bot,1000*2,"rune")
		 Else
		    _Timer_KillTimer($Bot,$id1)
		 EndIf

	  Case $Lighton
		 If _IsChecked($Lighton) Then
			$id2 = _Timer_SetTimer($Bot,20,"light")
		 Else
			_Timer_KillTimer($Bot,$id2)
		 EndIf

	  Case $Afkon
		 If _IsChecked($Afkon) Then
			$id3 = _Timer_SetTimer($Bot,1000*60*5,"afk")
		 Else
			_Timer_KillTimer($Bot,$id3)
		 EndIf

	  Case $watchon
		 If _IsChecked($watchon) Then
			$id4 = _Timer_SetTimer($Bot,50,"watch")
			$gethp = 1
		 Else
			_Timer_KillTimer($Bot,$id4)
		 EndIf

	  Case $eatfoodcheck
		 If _IsChecked($eatfoodcheck) Then
			$id5 = _Timer_SetTimer($Bot,1000*15,"eatfood")
		 Else
			_Timer_KillTimer($Bot,$id5)
		 EndIf

	  Case $Healon
		 If _IsChecked($Healon) Then
			$id6 = _Timer_SetTimer($Bot,333,"healer")
		 Else
			_Timer_KillTimer($Bot,$id6)
		 EndIf

	  Case $trainon
		 If _IsChecked($trainon) Then
			$id7 = _Timer_SetTimer($Bot,2000,"train")
		 Else
			_Timer_KillTimer($Bot,$id7)
		 EndIf

	  Case $Afkon2
		 If _IsChecked($Afkon2) Then
			$id8 = _Timer_SetTimer($Bot,1000*60*5,"afk2")
		 Else
			_Timer_KillTimer($Bot,$id8)
		 EndIf

	  Case $fishingon
		 If _IsChecked($fishingon) Then
			$id9 = _Timer_SetTimer($Bot,1200,"fishing")
		 Else
			_Timer_KillTimer($Bot,$id9)
		 EndIf

	  Case $podnospearcheck
		 If _IsChecked($podnospearcheck) Then
			$id10 = _Timer_SetTimer($Bot,guictrlread($spearpickdel)*1000,"autospear")
		 Else
			_Timer_KillTimer($Bot,$id10)
		 EndIf

	  Case $reconnecton
		 If _IsChecked($reconnecton) Then
			$id11 = _Timer_SetTimer($Bot,1000,"reconnect")
		 Else
			_Timer_KillTimer($Bot,$id11)
		 EndIf

	  Case $alarmon
		 If _IsChecked($alarmon) Then
			$id12 = _Timer_SetTimer($Bot,100,"alarm")
		 Else
			_Timer_KillTimer($Bot,$id12)
		 EndIf

	  Case $hoton
		 If _IsChecked($hoton) Then
			opt("MouseCoordMode", 1)
			HotKeySet("{" & guictrlread($hotkey_1) & "}", "_aim_hotkey_1")
			   $hotkey1temp = "{" & guictrlread($hotkey_1) & "}"
			HotKeySet("{" & guictrlread($hotkey_2) & "}", "_aim_hotkey_2")
			   $hotkey2temp = "{" & guictrlread($hotkey_2) & "}"
			HotKeySet("{" & guictrlread($hotkey_3) & "}", "_aim_hotkey_3")
			   $hotkey3temp = "{" & guictrlread($hotkey_3) & "}"
			HotKeySet("{" & guictrlread($hotkey_4) & "}", "_drag_hotkey_1")
			   $hotkey4temp = "{" & guictrlread($hotkey_4) & "}"
		 Else
			HotKeySet($hotkey1temp)
			HotKeySet($hotkey2temp)
			HotKeySet($hotkey3temp)
			HotKeySet($hotkey4temp)
		 EndIf

	  Case $hotkey1but
		 $aim1xy = _mousepos(1)

	  Case $hotkey2but
		 $aim2xy = _mousepos(1)

	  Case $hotkey3but
		 $aim3xy = _mousepos(1)

	  Case $hotkey4but
		 $aim4xy = _mousepos(1)

	  Case $foodbut
		 $foodxy = _mousepos(0)

	  Case $trainxybut
		 $trainxy = _mousepos(0)

	  Case $fishingbut
		 $fishxy = _mousepos(0)

	  Case $wedkabut
		 $rodxy = _mousepos(0)

	  Case $handxybut
		 $handxy = _mousepos(0)

	  Case $uhxybut
		 $aimuhxy = _mousepos(0)

	  Case $plxybut
		 $aimplxy = _mousepos(0)

	  Case $unstuckbut
		 unstuck()

	EndSwitch

WEnd

EndFunc

;funkcja ischeckbox

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc

;funkcje botowe

Func _aim_hotkey_1()
	  local $mxy = MouseGetPos()
	  If $aim1xy[0] == 0 Then
		 error99()
	  Else
		 MouseClick("right",$aim1xy[0], $aim1xy[1],1,1)
		 MouseClick("left",$mxy[0],$mxy[1],1,1)
	  EndIf
EndFunc

Func _aim_hotkey_2()
	  local $mxy = MouseGetPos()
	  If $aim2xy[0] == 0 Then
		 error99()
	  Else
		 MouseClick("right",$aim2xy[0], $aim2xy[1],1,1)
		 MouseClick("left",$mxy[0],$mxy[1],1,1)
	  EndIf
EndFunc

Func _aim_hotkey_3()
	  local $mxy = MouseGetPos()
	  If $aim3xy[0] == 0 Then
		 error99()
	  Else
		 MouseClick("right",$aim3xy[0], $aim3xy[1],1,1)
		 MouseClick("left",$mxy[0],$mxy[1],1,1)
	  EndIf
EndFunc

Func _drag_hotkey_1()
	  local $mxy = MouseGetPos()
	  	  If $aim4xy[0] == 0 Then
		  error99()
	  Else
		 MouseDown("left")
		 MouseMove($aim4xy[0], $aim4xy[1],1)
		 MouseUp("left")
		 Send("{enter}")
		 MouseMove($mxy[0],$mxy[1],1)
	  EndIf
EndFunc

Func _uh_hotkey_1()
	  If $aimuhxy[0] == 0 Or $aimplxy[0] == 0 Then
		 GUICtrlSetState($Healon,$GUI_UNCHECKED)
		 _Timer_KillTimer($Bot,$id6)
		 error99()
	  Else
		 _MouseClickPlus($hWnd,"right",$aimuhxy[0],$aimuhxy[1],1)

		 _MouseClickPlus($hWnd,"left",$aimplxy[0],$aimplxy[1],1)
	  EndIf
EndFunc

 ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

func name($1,$2,$3,$4)
   $namefinal = "0x" & hex($base_adr+$name_static)
   global $name = _MemoryPointerRead($namefinal, $memory_g, $name_offset,"char[20]")

   $finalADDR = "0x" & hex($base_adr+$mana_static)
   global $mana_global = _MemoryPointerRead($finalADDR, $memory_g, $mana_offset,"double")

   $finalADDRh = "0x" & hex($base_adr+$hp_static)
   global $hp_global = _MemoryPointerRead($finalADDRh, $memory_g, $hp_offset,"double")

   $finalADDRcap = "0x" & hex($base_adr+$cap_static)
   global $cap_global = _MemoryPointerRead($finalADDRcap, $memory_g, $cap_offset,"double")

   $finalADDRbat = "0x" & hex($base_adr+$battle_static)
   global $battleval_global = _MemoryPointerRead($finalADDRbat, $memory_g, $battle_offset)

   $finalADDRlogin = "0x" & hex($base_adr+$iflogin_static)
   global $islogin_global = _MemoryPointerRead($finalADDRlogin, $memory_g, $iflogin_offset)


   If $demo == 1 Then
	  local $time = Round(TimerDiff($RunningTime)/1000)
	  local $left = 180
	  WinSetTitle($Bot,"",$left-$time & " DEMO exit")
	  If TimerDiff($RunningTime)/1000 > $left Then
	  ;If $name[1] <> "Horhe" Then
		 KILL()
	  EndIf
   EndIf
EndFunc

func nameupdate($1,$2,$3,$4)
   GUICtrlSetData($Manacurr,$mana_global[1])
   GUICtrlSetData($Hpcurr, $hp_global[1])
   If $islogin_global[1] == 0 Then
	  GUICtrlSetData($namelab,"Disconnected")
   Else
	  GUICtrlSetData($namelab,$name[1])
   EndIf
   GUICtrlSetData($Capcurr,$cap_global[1])
   $bval = ($battleval_global[1]-419)/22
   ;battleval_global[1]-256
   GUICtrlSetData($Battlecurr,$bval)

   If $cntup == 3 Then
	  ToolTip("")
	  $cntup = 0
	  $fadeon = 0
   EndIf
EndFunc

func fade($1,$2,$3,$4)
   If $fadeon == 1 Then
	  $cntup = $cntup+1
   EndIf
   $gethp = 1
EndFunc

func battlelist($1,$2,$3,$4)
		 global $offset_node = _Get_Node_Offset()
		 ConsoleWrite('Current offset node = ' & Hex($offset_node) & @CRLF)
		 ConsoleWrite('START SEARCHING...' & @CRLF)
		 _Get_Creatures($memory_g)
		 ConsoleWrite('END SEARCHING' & @CRLF)
EndFunc

Func autospear($1,$2,$3,$4)
   _MouseDragPlus($hWnd,"left",$trainxy[0],$trainxy[1],$handxy[0],$handxy[1])
   controlsend($hWnd,"","","{enter}")
EndFunc

Func eatfood($1,$2,$3,$4)
   If $foodxy[0] == 0 And $foodxy[1] Then
	  GUICtrlSetState($eatfoodcheck,$GUI_UNCHECKED)
	  _Timer_KillTimer($Bot,$id5)
	  error99()
   Else
	  _MouseClickPlus($hWnd,"right",$foodxy[0],$foodxy[1],1)
   EndIf
EndFunc

func light($1,$2,$3,$4)
   $finalADDR = "0x" & hex($base_adr+$light_static)
   _MemoryPointerWrite($finalADDR, $memory_g, $light_offset, 55060)
EndFunc

func watch($1,$2,$3,$4)
   if (($battleval_global[1]-419)/22>=1) Then
	  controlsend($hWnd,"","","{ctrldown}{q}{ctrlup}")
	  SoundPlay(@WindowsDir & "\media\tada.wav", 0)
	  GUICtrlSetState($watchon,$GUI_UNCHECKED)
	  _Timer_KillTimer($Bot,$id4)
	  unstuck()
   EndIf
EndFunc

func alarm($1,$2,$3,$4)
   If $gethp == 1 Then
	  $maxhp = $hp_global[1]
	  $gethp = 0
   EndIf

   If ($maxhp>$hp_global[1]) Then
	  SoundPlay(@WindowsDir & "\media\tada.wav", 0)
	  $gethp = 1
   EndIf
EndFunc

func reconnect($1,$2,$3,$4)
   ;0 albo 257
   ConsoleWrite($reccnt& " " & $islogin_global[1]&@LF)
   If $islogin_global[1] == 0 Then
	  $reccnt = $reccnt+1
	  If $reccnt >= guictrlread($reconnectmin)*60 Then
		 KeySend($hwnd,"RETURN")
		 GUICtrlSetState($watchon,$GUI_CHECKED)
		 $id4 = _Timer_SetTimer($Bot,50,"watch")
		 $reccnt = 0
		 If $islogin_global[1] <> 0 Then
			$reccnt = 0
		 EndIf
	  EndIf
   Else
	  $reccnt = 0
   EndIf
EndFunc

func afk($1,$2,$3,$4)
   ControlSend($hwnd,"","","{CTRLDOWN}{UP}{CTRLUP}")
   Sleep(100)
   ControlSend($hwnd,"","","{CTRLDOWN}{DOWN}{CTRLUP}")
   unstuck()
EndFunc

func afk2($1,$2,$3,$4)

   WinActivate($hWnd)
   Send("^{UP}")
   Send("^{DOWN}")

EndFunc

func fishing($1,$2,$3,$4)
   If $fishxy[0] == 0 And $fishxy[1] And $rodxy[0] And $rodxy[1] Then
	  GUICtrlSetState($fishingon,$GUI_UNCHECKED)
	  _Timer_KillTimer($Bot,$id9)
	  error99()
   Else
	  $range = guictrlread($fishsqm)*50
	  If $cap_global[1] >= 6 Then
		 _MouseClickPlus($hwnd,"right",$rodxy[0],$rodxy[1],1)
		 _MouseClickPlus($hwnd,"left",Round($fishxy[0]+Random($range*-1, $range)),Round($fishxy[1]+Random($range*-1, $range)),1)
	  EndIf
   EndIf
EndFunc

func rune($1,$2,$3,$4)
   $manaclient = guictrlread($ManaInput)
	  if $mana_global[1] >= $manaclient Then
		 $spellname = guictrlread($RunemakerInput)
		 KeySend($hwnd,$spellname)
		 ;controlsend($hWnd,"","",$spellname)
		 ;unstuck()
	  EndIf
EndFunc

func healer($1,$2,$3,$4)
   $hpclient = guictrlread($HpInput)
   $manaclient = guictrlread($Manaheal)
   If guictrlread($HealHot) <> "uh" Then
	  if $hp_global[1] <= $hpclient And $mana_global[1] >= $manaclient Then
		 $spellname = guictrlread($HealHot)
		 KeySend($hwnd,$spellname)
		 ;controlsend($hWnd,"","",$spellname)
	  EndIf
   Else
	  If $hp_global[1] <= $hpclient Then
		 _BlockInputEx(3)
		 _uh_hotkey_1()
		 _BlockInputEx(0)
	  EndIf
   EndIf
EndFunc

func train($1,$2,$3,$4)
   $finalADDR = "0x" & hex($base_adr+$ifattack_static)
   $ifattack = _MemoryPointerRead($finalADDR, $memory_g, $ifattack_offset)
   if $ifattack[1] == 0 Then
	  _MouseClickPlus($hwnd,"right",$trainxy[0],$trainxy[1],1)
   EndIf
EndFunc

; Mouse positions <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

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

Func getpixel()
   While 1
    Sleep(10)
    If _IsPressed("01", $dll) Then
	    $pixelx = MouseGetPos(0)
		$pixely = MouseGetPos(1)
		$color = PixelGetColor($pixelx,$pixely,$hWnd)
	    ExitLoop
        While _IsPressed("01", $dll)
            Sleep(10)
        WEnd
    EndIf
   WEnd
EndFunc

Func unstuck()
	  Local $user32 = DllOpen("user32.dll")
   	  $vkvalue = 17
	  DllCall($user32,"int","keybd_event","int",$vkvalue,"int",0,"long",0,"long",0) ;To press a key
	  DllCall($user32,"int","keybd_event","int",$vkvalue,"int",0,"long",2,"long",0) ;To release a key

	  $vkvalue2 = 16
	  DllCall($user32,"int","keybd_event","int",$vkvalue2,"int",0,"long",0,"long",0) ;To press a key
	  DllCall($user32,"int","keybd_event","int",$vkvalue2,"int",0,"long",2,"long",0) ;To release a key
	  DllClose($user32)
EndFunc

Func _Get_Node_Offset ()

        ; set default values for offsets
	Local $last_node = 0x0
	Local $offset_node = 0x0

        ; why 200? It means that we will incresing our $offset_node 200*0x4 (most time we will use offsets 0x44, 0xD4, 0x184, 0x304) but its good range if will more creatures on screen.
	For $i = 0 To 200

		Local $offset[4] = [Null, $offset_node, 0xC, 0x20]
		Local $name =_MemoryReadStdString($base_adr + 0x0048B594, $memory_g, $offset)
		 If $name <> "" Then
			;ConsoleWrite($name&@CRLF)
		 EndIf

		If StringLen($name) > 2 and StringLen($name) < 32 Then
			Local $last_node = $offset_node
		EndIf

		$offset_node += 0x4
		;ConsoleWrite(Hex($offset_node)&@CRLF)
	Next
	Return $last_node
EndFunc

Func _MemoryReadStdString ($address, $handle, $offset)
	Local $addr_start = '0x' & Hex(_MemoryPointerRead($address, $handle, $offset)[0], 8)    ;==> example 0x8A16308
	Local $str_length = _MemoryRead($addr_start + 0x10, $handle, 'byte')

	If $str_length < 16 Then
		Return BinaryToString(_MemoryRead($addr_start, $handle, 'char[15]'))
    Else
		$str_pointer = '0x' & Hex(_MemoryRead($addr_start, $handle), 8)
		Return BinaryToString(_MemoryRead($str_pointer, $handle, 'char[32]'))
	EndIf
	Return ""
EndFunc

Func _Get_Creatures ($handle)
   ;base addresses and battle list offsets:
   Local $BASE_ADDRESS = $base_adr
   Local $addrBattleStart = 0x0048B594
   Local $offset_posx = 0xC
   Local $offset_posy = 0x10
   Local $offset_posz = 0x14
   Local $offset_id = 0x1C
   Local $offset_name = 0x20
   Local $offset_hpperc = 0x38
   Local $offset_direction = 0x3C
   Local $offset_node = _Get_Node_Offset ()    ;==> last node offset we found it in function above
   Local $scan = 0
   GUICtrlSetData($List2, "")
   Local $offset[4] = [Null, $offset_node, 0xC, $offset_name] ;==> offsets to first creature name [ 0x44, 0xC, 0x20]

        ; read memory for first creature name
	Local $name = _MemoryReadStdString($BASE_ADDRESS + $addrBattleStart, $handle, $offset)
        ; In this loop we will increasing array with offset by 0x0 until $name of creature will equal empty string "" -> end of battle list.
	While $scan < 20
		Local $addrStart = '0x' & StringRight(Hex(_MemoryPointerRead($BASE_ADDRESS + $addrBattleStart, $handle, $offset)[0]-$offset_name),8)

		Local $posx = _MemoryRead($addrStart+$offset_posx, $handle)
		Local $posy = _MemoryRead($addrStart+$offset_posy, $handle)
		Local $posz = _MemoryRead($addrStart+$offset_posz, $handle, 'byte')   ;==> only 1 byte
		Local $id = _MemoryRead($addrStart+$offset_id, $handle)
                Local $hpperc = _MemoryRead($addrStart+$offset_hpperc, $handle, 'byte')   ;==> only 1 byte
                Local $dir = _MemoryRead($addrStart+$offset_direction, $handle)

		If $posz < 20 Then

			;ConsoleWrite('$id = ' & $id & ', $posx = ' & $posx& ', $posy = ' & $posy & ', $posz = ' & $posz &  ', $hpperc = ' & $hpperc & ', dir = ' & $dir & ', $name = ' & $name & @CRLF)
			GUICtrlSetData($List2,'$name = ' & $name & @CRLF)
                EndIf
		;_ArrayDisplay($offset)
                ; at end we must add to array next creature offset 0x0 at index nr 1. [0x44, 0xC, 0x20] + 0x0 -> [0x44, 0x0, 0xC, 0x20]
		_ArrayInsert($offset, 2, 0x0)
		$name =_MemoryReadStdString($BASE_ADDRESS + $addrBattleStart, $handle, $offset)   ;==> read memory for name of new creature
		$scan += 1
		For $i = 0 to Ubound($offset) - 1 ; We have an array with three elements but the last index is two.
			ConsoleWrite($offset[$i] & " ")
	    Next

	WEnd
EndFunc
