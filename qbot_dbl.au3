#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <StaticConstants.au3>
#include <StringConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <Timers.au3>
#include <Misc.au3>
#include <GUIListBox.au3>
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

#include <Includes/address/address_dbl.au3>

#Region
;#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_icon=qbot.ico

#pragma compile(FileVersion, 0.0.5.1, 0.0.5.1)
#pragma compile(FileDescription, QBot-Tibia bot)
#pragma compile(ProductName, QBot)
#pragma compile(LegalCopyright, © Wiktor Skrobinski)
#EndRegion

#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_icon=qbot.ico


#RequireAdmin
#NoTrayIcon
HotKeySet("{PAUSE}", "KILL")

global $dll = DllOpen("user32.dll")

;$l = _Timer_Init()
global $pid,$memory_g,$handle,$targetspellinput,$Manacurr,$Hpcurr
global $mx,$my,$playerx,$playery,$aim1x,$aim1y,$foodx,$foody,$spearx,$speary,$manasx,$manasy,$trainx,$trainy,$sdx,$sdy,$fishx,$fishy,$wedkax,$wedkay
global $id4,$Bot,$namelab,$watchon,$fishsqm
global $aim1xy = ["0","0"],$aim2xy = ["0","0"],$aim3xy = ["0","0"],$aim4xy = ["0","0"]
global $reccnt = 0,$cntup = 0,$fadeon = 0,$turn = 0

$RunningTime = TimerInit()
global $demo = 0


;checklic()
pop()

Func KILL()
   saveconfigall()
   Exit 0
EndFunc

Func saveconfigall()
   _saveconfig($heal1del,"healdel")
   _saveconfig($senzu1del,"sen1del")
   _saveconfig($senzu2del,"sen2del")
   _saveconfig($senzu3del,"sen3del")
   _saveconfig($senzu4del,"sen4del")
   _saveconfig($senzu5del,"sen5del")

   _saveconfig($HpInput1,"hp1")
   _saveconfig($MpInput1,"mp1")
   _saveconfig($HpInput2,"hp2")
   _saveconfig($MpInput2,"mp2")

   _saveconfig($ManaInput1,"mi1")
   _saveconfig($ManaInput3,"mi3")
   _saveconfig($ManaInput4,"mi4")


   _saveconfig($HealHot1,"healhotkey1")
   _saveconfig($HealHot2,"healhotkey2")

   _saveconfig($ManaHot1,"manahotkey1")
   _saveconfig($ManaHot2,"manahotkey2")
   _saveconfig($ManaHot3,"manahotkey3")
   _saveconfig($ManaHot4,"manahotkey4")
   _saveconfig($ManaHot5,"manahotkey5")

   ;_saveconfig($hotkey_1,"hotkey_1")
   ;_saveconfig($hotkey_2,"hotkey_2")
   ;_saveconfig($hotkey_3,"hotkey_3")
   ;_saveconfig($hotkey_4,"hotkey_4")
EndFunc

Func botgui()

#Region ### START Koda GUI section ### Form=
	  $Bot_1 = GUICreate("Qbot DBL", 215, 351, 0, 60)
	  $Ramka = GUICtrlCreateTab(2, 2, 210, 352)
	  GUICtrlCreateTabItem("Bot")
	  $NameLabel = GUICtrlCreateLabel("Name", 12, 24, 36, 17)

	  $namelab = GUICtrlCreateLabel("???", 52, 24, 68, 17)

	  $Label1 = GUICtrlCreateLabel("Mana", 12, 55, 31, 17)
	  $Label2 = GUICtrlCreateLabel("Pwr heal", 5, 150, 50, 27)
	  $Label3 = GUICtrlCreateLabel("Soft heal", 5, 95, 50, 17)

	  $Manacurr = GUICtrlCreateLabel("0", 50, 55, 30, 17)

	  $Label2 = GUICtrlCreateLabel("Hp", 13, 39, 31, 17)

	  $Hpcurr = GUICtrlCreateLabel("0", 50, 39, 30, 17)

	  $Afkon = GUICtrlCreateCheckbox("Anti Afk", 147, 35, 53, 25)

	  $Label3 = GUICtrlCreateLabel("Delay, hp/mana,  hotkey,    on/off", 19, 71, 164, 17)

	  global $heal1del = GUICtrlCreateInput(_loadconfig("healdel"), 7, 120, 41, 22)
	  global $senzu1del = GUICtrlCreateInput(_loadconfig("sen1del"), 7, 196, 41, 22)
	  global $senzu2del = GUICtrlCreateInput(_loadconfig("sen2del"), 7, 221, 41, 22)
	  global $senzu3del = GUICtrlCreateInput(_loadconfig("sen3del"), 7, 246, 41, 22)
	  global $senzu4del = GUICtrlCreateInput(_loadconfig("sen4del"), 7, 271, 41, 22)
	  global $senzu5del = GUICtrlCreateInput(_loadconfig("sen5del"), 7, 296, 41, 22)

	  global $HpInput1 = GUICtrlCreateInput(_loadconfig("hp1"), 52, 84, 32, 22)
	  global $MpInput1 = GUICtrlCreateInput(_loadconfig("mp1"), 52, 107, 32, 22)

	  global $HpInput2 = GUICtrlCreateInput(_loadconfig("hp2"), 52, 134, 32, 22)
	  global $MpInput2 = GUICtrlCreateInput(_loadconfig("mp2"), 52, 157, 32, 22)

	  global $ManaInput1 = GUICtrlCreateInput(_loadconfig("mi1"), 52, 196, 32, 22)
	  global $ManaInput3 = GUICtrlCreateInput(_loadconfig("mi3"), 52, 246, 32, 22)
	  global $ManaInput4 = GUICtrlCreateInput(_loadconfig("mi4"), 52, 271, 32, 22)

	  global $HealHot1 = GUICtrlCreateCombo(_loadconfig("healhotkey1"), 92, 97, 50, 25)
	  GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")
	  global $HealHot2 = GUICtrlCreateCombo(_loadconfig("healhotkey2"), 92, 147, 50, 25)
	  GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")

	  global $ManaHot1 = GUICtrlCreateCombo(_loadconfig("manahotkey1"), 92, 196, 50, 25)
	  GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")
	  global $ManaHot2 = GUICtrlCreateCombo(_loadconfig("manahotkey2"), 92, 221, 50, 25)
	  GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")
	  global $ManaHot3 = GUICtrlCreateCombo(_loadconfig("manahotkey3"), 92, 246, 50, 25)
	  GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")

	  global $ManaHot4 = GUICtrlCreateCombo(_loadconfig("manahotkey4"), 92, 271, 50, 25)
	  GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")
	  global $ManaHot5 = GUICtrlCreateCombo(_loadconfig("manahotkey5"), 92, 296, 50, 25)
	  GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")

	  $heal1on = GUICtrlCreateCheckbox("Heal", 147, 123, 41, 20)

	  $senzu1on = GUICtrlCreateCheckbox("Manas", 147, 197, 47, 20)

	  $senzu2on = GUICtrlCreateCheckbox("Food", 147, 221, 41, 20)

	  $senzu3on = GUICtrlCreateCheckbox("Rune", 147, 243, 41, 25)

	  $senzu4on = GUICtrlCreateCheckbox("Auto spell", 147, 269, 61, 25)
	  $senzu5on = GUICtrlCreateCheckbox("Auto target", 147, 294, 61, 25)

	  $unstuckbut = GUICtrlCreateButton("Help me my ctrl is stuck!", 18, 320, 150, 27)

	  ;GUICtrlCreateTabItem("Aim")

	  ;$hotkey1but = GUICtrlCreateButton("SHOOT1_XY", 12, 52, 70, 25)
	  ;$hotkey2but = GUICtrlCreateButton("SHOOT2_XY", 12, 82, 70, 25)
      ;$hotkey3but = GUICtrlCreateButton("SHOOT3_XY", 12, 112, 70, 25)
	  ;$hotkey4but = GUICtrlCreateButton("DRAG1_XY", 12, 142, 70, 25)

	  ;$hoton = GUICtrlCreateCheckbox("Hotkeys on", 52, 190, 81, 17)

	  ;$Label4 = GUICtrlCreateLabel("Key", 124, 23, 23, 18)

	  ;global $hotkey_1 = GUICtrlCreateInput(_loadconfig("hotkey_1"), 122, 53, 49, 22)
	  ;global $hotkey_2 = GUICtrlCreateInput(_loadconfig("hotkey_2"), 122, 82, 49, 22)
	  ;global $hotkey_3 = GUICtrlCreateInput(_loadconfig("hotkey_3"), 122, 112, 49, 22)
	  ;global $hotkey_4 = GUICtrlCreateInput(_loadconfig("hotkey_4"), 122, 143, 49, 22)

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

	  Case $senzu2on
		 If _IsChecked($senzu2on) Then
			$id5 = _Timer_SetTimer($Bot,guictrlread($senzu2del),"_senzu2")
		 Else
			_Timer_KillTimer($Bot,$id5)
		 EndIf

	  Case $senzu3on
		 If _IsChecked($senzu3on) Then
			$id6 = _Timer_SetTimer($Bot,guictrlread($senzu3del),"_senzu3")
		 Else
			_Timer_KillTimer($Bot,$id6)
		 EndIf

	  Case $senzu4on
		 If _IsChecked($senzu4on) Then
			$id7 = _Timer_SetTimer($Bot,guictrlread($senzu4del),"_senzu4")
		 Else
			_Timer_KillTimer($Bot,$id7)
		 EndIf

	  Case $senzu5on
		 If _IsChecked($senzu5on) Then
			$id8 = _Timer_SetTimer($Bot,guictrlread($senzu5del),"_senzu5")
		 Else
			_Timer_KillTimer($Bot,$id8)
		 EndIf

	  Case $Afkon
		 If _IsChecked($Afkon) Then
			$id9 = _Timer_SetTimer($Bot,1000*60*5,"afk")
		 Else
			_Timer_KillTimer($Bot,$id9)
		 EndIf

;	  Case $hoton
;		 If _IsChecked($hoton) Then
;			opt("MouseCoordMode", 1)
;			HotKeySet("{" & guictrlread($hotkey_1) & "}", "_aim_hotkey_1")
;			   $hotkey1temp = "{" & guictrlread($hotkey_1) & "}"
;			HotKeySet("{" & guictrlread($hotkey_2) & "}", "_aim_hotkey_2")
;			   $hotkey2temp = "{" & guictrlread($hotkey_2) & "}"
;			HotKeySet("{" & guictrlread($hotkey_3) & "}", "_aim_hotkey_3")
;			   $hotkey3temp = "{" & guictrlread($hotkey_3) & "}"
;			HotKeySet("{" & guictrlread($hotkey_4) & "}", "_drag_hotkey_1")
;			   $hotkey4temp = "{" & guictrlread($hotkey_4) & "}"
;		 Else
;			HotKeySet($hotkey1temp)
;		HotKeySet($hotkey2temp)
;			HotKeySet($hotkey3temp)
;			HotKeySet($hotkey4temp)
;		 EndIf
;
;	  Case $hotkey1but
;		 $aim1xy = _mousepos(1)
;
;	  Case $hotkey2but
;		 $aim2xy = _mousepos(1)
;
;	  Case $hotkey3but
;		 $aim3xy = _mousepos(1)
;
;	  Case $hotkey4but
;		 $aim4xy = _mousepos(1)
	  Case $unstuckbut
		 unstuck()

	EndSwitch

WEnd

EndFunc

;funkcja ischeckbox

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc

func fade($1,$2,$3,$4)
   If $fadeon == 1 Then
	  $cntup = $cntup+1
   EndIf
   $gethp = 1
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

 ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

func name($1,$2,$3,$4)
   $namefinal = "0x" & hex($base_adr+$name_static)
   global $name = _MemoryPointerRead($namefinal, $memory_g, $name_offset,"char[25]")

   $finalADDR = "0x" & hex($base_adr+$mana_static)
   global $mana_global = _MemoryPointerRead($finalADDR, $memory_g, $mana_offset,"double")

   $finalADDRh = "0x" & hex($base_adr+$hp_static)
   global $hp_global = _MemoryPointerRead($finalADDRh, $memory_g, $hp_offset,"double")

   $finalADDRlogin = "0x" & hex($base_adr+$iflogin_static)
   global $islogin_global = _MemoryPointerRead($finalADDRlogin, $memory_g, $iflogin_offset)

   $finalADDRa = "0x" & hex($base_adr+$ifattack_static)
   global $ifattack_global = _MemoryPointerRead($finalADDRa, $memory_g, $ifattack_offset)

   $finalADDRa2 = "0x" & hex($base_adr+$ifattack_static2)
   global $ifattack_global2 = _MemoryPointerRead($finalADDRa2, $memory_g, $ifattack_offset2)

   If $demo == 1 Then
	  local $time = Round(TimerDiff($RunningTime)/1000)
	  local $left = 60
	  ;WinSetTitle($Bot,"",$left-$time & " DEMO exit")
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
	  $charn = StringRegExp($name[1], '(?i)player_name=(.*?)&cpu', 2)
	  If IsArray($charn) Then
		 GUICtrlSetData($namelab,$charn[1])
		 ConsoleWrite($name[1]&@CRLF)
	  EndIf
   EndIf

   If $cntup == 3 Then
	  ToolTip("")
	  $cntup = 0
	  $fadeon = 0
   EndIf
EndFunc

func telemetry_update($1,$2,$3,$4)
   telemetry($hardid,$name,$servername_global)
EndFunc

func _heal1($1,$2,$3,$4)
   $hpinlow = guictrlread($HpInput1)
   $mpinlow = guictrlread($MpInput1)
   $hpinhi = guictrlread($HpInput2)
   $mpinhi = guictrlread($MpInput2)
	  if $hp_global[1] <= $hpinhi And $mana_global[1] >= $mpinhi Then
		 $spellname = guictrlread($HealHot2)
		 KeySend($hwnd,$spellname)
		 ;ConsoleWrite("STRONG"&@CRLF)
	  ElseIf $hp_global[1] <= $hpinhi And $mana_global[1] <= $mpinhi Then
		 ;donothing
		 ;ConsoleWrite("Nothing"&@CRLF)
	  ElseIf $hp_global[1] <= $hpinlow And $mana_global[1] >= $mpinlow Then
		 $spellname = guictrlread($HealHot1)
		 KeySend($hwnd,$spellname)
		 ;ConsoleWrite("SOFT"&@CRLF)
	  EndIf
EndFunc

func _senzu1($1,$2,$3,$4)
   $manain = guictrlread($ManaInput1)
	  if $mana_global[1] <= $manain Then
		 $spellname = guictrlread($ManaHot1)
		 KeySend($hwnd,$spellname)
	  EndIf
   EndFunc

func _senzu2($1,$2,$3,$4)
		 $spellname = guictrlread($ManaHot2)
		 KeySend($hwnd,$spellname)
EndFunc

func _senzu3($1,$2,$3,$4)
   $manain = guictrlread($ManaInput3)
	  if $mana_global[1] >= $manain Then
		 $spellname = guictrlread($ManaHot3)
		 KeySend($hwnd,$spellname)
	  EndIf
EndFunc

Func _senzu4($1,$2,$3,$4)
   $manain = guictrlread($ManaInput4)
	  if $ifattack_global[1] <> 0 Then
		 $spellname = guictrlread($ManaHot4)
		 KeySend($hwnd,$spellname)
	  EndIf
EndFunc

Func _senzu5($1,$2,$3,$4)
	  if $ifattack_global[1] <> 0 Then
		 ConsoleWrite("NOT"&@CRLF)
	  Else
		 ConsoleWrite("TAK"&@CRLF)
		 $spellname = guictrlread($ManaHot5)
		 KeySend($hwnd,$spellname)
	  EndIf
EndFunc

func afk($1,$2,$3,$4)
   If $turn == 0 Then
	  ControlSend($hWnd,"","","{CTRLdown}{left}{CTRLUP}")
	  $turn = 1
   Else
	  ControlSend($hWnd,"","","{CTRLdown}{right}{CTRLUP}")
	  $turn = 0
   EndIf
   unstuck()
EndFunc

Func unstuck()
   	  $vkvalue = 17
	  DllCall($dll,"int","keybd_event","int",$vkvalue,"int",0,"long",0,"long",0) ;To press a key
	  DllCall($dll,"int","keybd_event","int",$vkvalue,"int",0,"long",2,"long",0) ;To release a key
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