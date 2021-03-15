#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Includes\qbot.ico
#AutoIt3Wrapper_Outfile_x64=qbot_8.0.Exe
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_UseX64 = Y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
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
#include "Includes/sql.au3"
#include <Includes/ImageSearch.au3>
#include <pop.au3>
#include <Includes/motd.au3>


#include <Includes/address/address_Askara.au3>

#Region
;#AutoIt3Wrapper_UseX64=n

#pragma compile(FileVersion, 0.0.5.1, 0.0.5.1)
#pragma compile(FileDescription, QBot-Tibia bot)
#pragma compile(ProductName, QBot)
#pragma compile(LegalCopyright, © Wiktor Skrobinski)
#EndRegion


HotKeySet("{PAUSE}", "KILL")

global $dll = DllOpen("user32.dll")

$l = _Timer_Init()
global $pid,$memory_g,$name,$ver="80",$handle,$targetspellinput,$Manacurr,$Hpcurr
global $mx,$my,$playerx,$playery,$aim1x,$aim1y,$foodx,$foody,$spearx,$speary,$manasx,$manasy,$trainx,$trainy,$sdx,$sdy,$fishx,$fishy,$wedkax,$wedkay
global $id4,$Bot,$namelab,$watchon,$fishsqm,$mana_global,$hp_global
global $HpInput1,$HpInput2,$MpInput1,$MpInput2,$ManaInput1,$ManaInput2,$ManaInput3,$HealHot1,$HealHot2,$HealHot3,$ManaHot1,$ManaHot2,$ManaHot3
global $aim1xy = ["0","0"],$aim2xy = ["0","0"],$aim3xy = ["0","0"],$aim4xy = ["0","0"],$fishxy[2] = ["0","0"],$liferingxy[2] = ["0","0"],$slotxy[2] = ["0","0"],$lootxy[2] = ["0","0"]
global $reccnt = 0,$cntup = 0,$fadeon = 0,$logon = 1,$logdel = 0
global $ch100x = 0, $ch100y = 0
global $gtlx = 0, $gtly = 0
global $ifcd = 1

checklic_day()
;pop()

Func KILL()
   saveconfigall()
   Exit 0
EndFunc

Func botgui()

#Region ### START Koda GUI section ### Form=
	  $Bot_1 = GUICreate("Qbot ("&$pid&")", 215, 360, 0, 60)

	  $butinfo1 = GUICtrlCreateButton("?", 170, 3, 20, 20, $BS_CENTER)
	  $but_motd = GUICtrlCreateButton("M", 190, 3, 20, 20, $BS_CENTER)

	  $Ramka = GUICtrlCreateTab(2, 2, 210, 352)
	  GUICtrlCreateTabItem("Healer")
	  $NameLabel = GUICtrlCreateLabel("Name", 12, 24, 36, 17)

	  $namelab = GUICtrlCreateLabel("???", 52, 24, 68, 17)

	  $Label1 = GUICtrlCreateLabel("Mana", 12, 55, 31, 17)
	  $Label2 = GUICtrlCreateLabel("Str heal", 5, 150, 50, 27)
	  $Label3 = GUICtrlCreateLabel("Soft heal", 5, 95, 50, 17)

	  $Manacurr = GUICtrlCreateLabel("0", 50, 55, 30, 17)

	  $Label2 = GUICtrlCreateLabel("Hp", 13, 39, 31, 17)

	  $Hpcurr = GUICtrlCreateLabel("0", 50, 39, 30, 17)

	  $Afkon = GUICtrlCreateCheckbox("Safe log", 147, 30, 53, 25)
	  $Lighton = GUICtrlCreateCheckbox("Full light", 147, 50, 53, 25)

	  $Label3 = GUICtrlCreateLabel("Delay, %hp/mana,  hotkey, on/off", 19, 71, 164, 17)

	  global $heal1del = GUICtrlCreateInput(_loadconfig("healdel"), 7, 120, 41, 22)
	  global $senzu1del = GUICtrlCreateInput(_loadconfig("sen1del"), 7, 196, 41, 22)
	  global $senzu2del = GUICtrlCreateInput(_loadconfig("sen2del"), 7, 221, 41, 22)
	  global $senzu3del = GUICtrlCreateInput(_loadconfig("sen3del"), 7, 246, 41, 22)

	  $HpInput1 = GUICtrlCreateInput(_loadconfig("hp1"), 52, 84, 32, 22)
	  $MpInput1 = GUICtrlCreateInput(_loadconfig("mp1"), 52, 107, 32, 22)

	  $HpInput2 = GUICtrlCreateInput(_loadconfig("hp2"), 52, 134, 32, 22)
	  $MpInput2 = GUICtrlCreateInput(_loadconfig("mp2"), 52, 157, 32, 22)

	  $ManaInput1 = GUICtrlCreateInput(_loadconfig("mi1"), 52, 196, 32, 22)
	  $ManaInput3 = GUICtrlCreateInput(_loadconfig("mi3"), 52, 246, 32, 22)
	  global $FishInput = GUICtrlCreateInput(_loadconfig("fi"), 52, 271, 32, 22)

	  $fishxybut = GUICtrlCreateButton("Water", 7, 271, 42, 22, $BS_CENTER)

	  $liferingxybut = GUICtrlCreateButton("XY", 52, 295, 32, 22, $BS_CENTER)
	  $slotxybut = GUICtrlCreateButton("Slot XY", 92, 295, 50, 22, $BS_CENTER)
	  global $lifecolor = GUICtrlCreateLabel("Lifering", 12, 298, 36, 17)

	  $HealHot1 = GUICtrlCreateCombo(_loadconfig("healhotkey1"), 92, 97, 50, 25)
	  GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")
	  $HealHot2 = GUICtrlCreateCombo(_loadconfig("healhotkey2"), 92, 147, 50, 25)
	  GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")

	  $ManaHot1 = GUICtrlCreateCombo(_loadconfig("manahotkey1"), 92, 196, 50, 25)
	  GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")
	  $ManaHot2 = GUICtrlCreateCombo(_loadconfig("manahotkey2"), 92, 221, 50, 25)
	  GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")
	  $ManaHot3 = GUICtrlCreateCombo(_loadconfig("manahotkey3"), 92, 246, 50, 25)
	  GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")

	  global $ManaHot4 = GUICtrlCreateCombo(_loadconfig("manahotkey4"), 92, 271, 50, 25)
	  GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12")

	  $heal1on = GUICtrlCreateCheckbox("Heal", 147, 123, 41, 20)
	  $senzu1on = GUICtrlCreateCheckbox("Manas", 147, 197, 47, 20)
	  $senzu2on = GUICtrlCreateCheckbox("Food", 147, 221, 41, 20)
	  $senzu3on = GUICtrlCreateCheckbox("Rune", 147, 243, 41, 25)
	  $fishingon = GUICtrlCreateCheckbox("Fish", 147, 268, 41, 25)
	  $lfieringon = GUICtrlCreateCheckbox("Life ring", 147, 293, 52, 25)
	  $unstuckbut = GUICtrlCreateButton("Ctrl unstuck", 100, 3, 70, 20)

	  $change100gold = GUICtrlCreateCheckbox("Change 100", 12, 320, 80, 25)
	  $lootbut = GUICtrlCreateButton("Loot XY", 92, 320, 50, 22, $BS_CENTER)
	  $looton = GUICtrlCreateCheckbox("Loot", 147, 320, 52, 25)


	  GUICtrlCreateTabItem("Aim")

	  ;$hotkey1but = GUICtrlCreateButton("SHOOT1_XY", 12, 52, 70, 25)
	  ;$hotkey2but = GUICtrlCreateButton("SHOOT2_XY", 12, 82, 70, 25)
      ;$hotkey3but = GUICtrlCreateButton("SHOOT3_XY", 12, 112, 70, 25)
	  $hotkey4but = GUICtrlCreateButton("DRAG1_XY", 12, 142, 70, 25)

	  $hoton = GUICtrlCreateCheckbox("Hotkeys on", 52, 190, 81, 17)

	  GUICtrlCreateLabel("Key", 124, 23, 23, 18)

	  ;global $hotkey_1 = GUICtrlCreateInput(_loadconfig("hotkey_1"), 122, 53, 49, 22)
	  ;global $hotkey_2 = GUICtrlCreateInput(_loadconfig("hotkey_2"), 122, 82, 49, 22)
	  ;global $hotkey_3 = GUICtrlCreateInput(_loadconfig("hotkey_3"), 122, 112, 49, 22)
	  global $hotkey_4 = GUICtrlCreateInput(_loadconfig("hotkey_4"), 122, 143, 49, 22)

	  GUICtrlCreateTabItem("")
	  GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


WinSetOnTop($Bot, "", 1)
$id0 = _Timer_SetTimer($Bot,10,"name")
$id99 = _Timer_SetTimer($Bot,1000,"nameupdate")
$id98 = _Timer_SetTimer($Bot,1000,"fade")
$id97 = _Timer_SetTimer($Bot,1000*60*60*12,"license")
;$id96 = _Timer_SetTimer($Bot,1000*60*5,"telemetry_update")

While 1
   $nMsg = GUIGetMsg()

   Switch $nMsg
    Case $GUI_EVENT_CLOSE
	  saveconfigall()
		 Exit

	Case $butinfo1
		help_kas()

	Case $but_motd
		motd()

	Case $heal1on
		If _IsChecked($heal1on) Then
			IF guictrlread($heal1del) == "" Or guictrlread($heal1del) <> 100 Then
				MsgBox($MB_OK,"Info","Ustaw Delay 100 healbot")
				GUICtrlSetState($heal1on,$GUI_UNCHECKED)
			Else
				;$id1 = _Timer_SetTimer($Bot,guictrlread($heal1del),"_heal1")
				$id1 = _Timer_SetTimer($Bot,10,"_heal1")
				global $healcd = guictrlread($heal1del)
				$ifcd = 1
			EndIf
		Else
			_Timer_KillTimer($Bot,$id1)
			$healcd = 0
		EndIf

	Case $senzu1on
		If _IsChecked($senzu1on) Then
			IF guictrlread($senzu1del) == "" Or guictrlread($senzu1del) < 200 Then
				MsgBox($MB_OK,"Info","Ustaw Delay w milisekundach (pierwsza kolumna) wiecej jak 200")
				GUICtrlSetState($senzu1on,$GUI_UNCHECKED)
			Else
				$id4 = _Timer_SetTimer($Bot,guictrlread($senzu1del),"_senzu1")
			EndIf
		 Else
			_Timer_KillTimer($Bot,$id4)
		 EndIf

	Case $senzu2on
		If _IsChecked($senzu2on) Then
			IF guictrlread($senzu2del) == "" Or guictrlread($senzu2del) < 200 Then
				MsgBox($MB_OK,"Info","Ustaw Delay w milisekundach (pierwsza kolumna) wiecej jak 200")
				GUICtrlSetState($senzu2on,$GUI_UNCHECKED)
			Else
				$id5 = _Timer_SetTimer($Bot,guictrlread($senzu2del),"_senzu2")
			EndIf
		Else
			_Timer_KillTimer($Bot,$id5)
		EndIf

	Case $senzu3on
		If _IsChecked($senzu3on) Then
			IF guictrlread($senzu3del) == "" Or guictrlread($senzu3del) < 200 Then
				MsgBox($MB_OK,"Info","Ustaw Delay w milisekundach (pierwsza kolumna) wiecej jak 200")
				GUICtrlSetState($senzu3on,$GUI_UNCHECKED)
			Else
				$id6 = _Timer_SetTimer($Bot,guictrlread($senzu3del),"_senzu3")
			EndIf
		Else
			_Timer_KillTimer($Bot,$id6)
		EndIf

	Case $fishingon
		If _IsChecked($fishingon) Then
			$id7 = _Timer_SetTimer($Bot,1200,"_fishing")
		Else
			_Timer_KillTimer($Bot,$id7)
		EndIf

	Case $lfieringon
		If _IsChecked($lfieringon) Then
			$id8 = _Timer_SetTimer($Bot,1000,"_lifering")
		Else
			_Timer_KillTimer($Bot,$id8)
	EndIf

	  Case $Afkon
		 If _IsChecked($Afkon) Then
			$id9 = _Timer_SetTimer($Bot,20,"afk")
			global $battlevaltemp = $battleval_global[1]
		 Else
			_Timer_KillTimer($Bot,$id9)
		 EndIf

	  Case $Lighton
		 If _IsChecked($Lighton) Then
			$id10 = _Timer_SetTimer($Bot,20,"light")
		 Else
			_Timer_KillTimer($Bot,$id10)
		 EndIf

	   Case $change100gold
		   If _IsChecked($change100gold) Then
			$id11 = _Timer_SetTimer($Bot,300,"change100")
		 Else
			_Timer_KillTimer($Bot,$id11)
		 EndIf

	   Case $looton
		   If _IsChecked($looton) Then
			$id12 = _Timer_SetTimer($Bot,300,"lootgold")
		 Else
			_Timer_KillTimer($Bot,$id12)
		 EndIf

	  Case $hoton
		 If _IsChecked($hoton) Then
			opt("MouseCoordMode", 1)
;			HotKeySet("{" & guictrlread($hotkey_1) & "}", "_aim_hotkey_1")
;			   $hotkey1temp = "{" & guictrlread($hotkey_1) & "}"
;			HotKeySet("{" & guictrlread($hotkey_2) & "}", "_aim_hotkey_2")
;			   $hotkey2temp = "{" & guictrlread($hotkey_2) & "}"
;			HotKeySet("{" & guictrlread($hotkey_3) & "}", "_aim_hotkey_3")
;			   $hotkey3temp = "{" & guictrlread($hotkey_3) & "}"
			HotKeySet("{" & guictrlread($hotkey_4) & "}", "_drag_hotkey_1")
			   $hotkey4temp = "{" & guictrlread($hotkey_4) & "}"
		 Else
;			HotKeySet($hotkey1temp)
;			HotKeySet($hotkey2temp)
;			HotKeySet($hotkey3temp)
			HotKeySet($hotkey4temp)
		 EndIf
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
	Case $hotkey4but
		 $aim4xy = _mousepos(1)
	Case $fishxybut
		 $fishxy = _mousepos(0)
	Case $liferingxybut
		$liferingxy = _mousepos(0)
	Case $slotxybut
		$slotxy = _mousepos(0)
	Case $lootbut
		   $lootxy = _mousepos(0)

	  Case $unstuckbut
		 unstuck()

	EndSwitch

WEnd

EndFunc

Func saveconfigall()
   _saveconfig($heal1del,"healdel")
   _saveconfig($senzu1del,"sen1del")
   _saveconfig($senzu2del,"sen2del")
   _saveconfig($senzu3del,"sen3del")

   _saveconfig($HpInput1,"hp1")
   _saveconfig($MpInput1,"mp1")
   _saveconfig($HpInput2,"hp2")
   _saveconfig($MpInput2,"mp2")

   _saveconfig($ManaInput1,"mi1")
   _saveconfig($ManaInput3,"mi3")
   _saveconfig($FishInput,"fi")


   _saveconfig($HealHot1,"healhotkey1")
   _saveconfig($HealHot2,"healhotkey2")

   _saveconfig($ManaHot1,"manahotkey1")
   _saveconfig($ManaHot2,"manahotkey2")
   _saveconfig($ManaHot3,"manahotkey3")
   _saveconfig($ManaHot4,"manahotkey4")

   ;_saveconfig($hotkey_1,"hotkey_1")
   ;_saveconfig($hotkey_2,"hotkey_2")
   ;_saveconfig($hotkey_3,"hotkey_3")
   _saveconfig($hotkey_4,"hotkey_4")
EndFunc

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc

func fade($1,$2,$3,$4)
   If $fadeon == 1 Then
	  $cntup = $cntup+1
   EndIf
   $gethp = 1

   If $logon == 0 Then
	  $logdel = $logdel + 1
   EndIf

   If $logdel == 2 Then
	  $logon = 1
	  $logdel = 0
   EndIf
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
   $name = _MemoryPointerRead($namefinal, $memory_g, $name_offset,"char[10]")

   $finalADDR = "0x" & hex($base_adr+$mana_static)
   $mana_global = _MemoryPointerRead($finalADDR, $memory_g, $mana_offset,"double")

   $finalADDRh = "0x" & hex($base_adr+$hp_static)
   $hp_global = _MemoryPointerRead($finalADDRh, $memory_g, $hp_offset,"double")

   $finalADDRh_max = "0x" & hex($base_adr+$hp_max_static)
   global $hp_max_global = _MemoryPointerRead($finalADDRh_max, $memory_g, $hp_max_offset,"double")

   $finalcap = "0x" & hex($base_adr+$cap_static)
   global $cap_global = _MemoryPointerRead($finalcap, $memory_g, $cap_offset,"double")

   $finalADDRlogin = "0x" & hex($base_adr+$iflogin_static)
   global $islogin_global = _MemoryPointerRead($finalADDRlogin, $memory_g, $iflogin_offset)

   $finalrslot = "0x" & hex($base_adr+$rslot_static)
   global $ringslot_global = _MemoryPointerRead($finalrslot, $memory_g, $rslot_offset)

	$finalADDRbat = "0x" & hex($base_adr+$battle_static)
    global $battleval_global = _MemoryPointerRead($finalADDRbat, $memory_g, $battle_offset)
EndFunc

func nameupdate($1,$2,$3,$4)
   GUICtrlSetData($Manacurr,$mana_global[1])
   GUICtrlSetData($Hpcurr, $hp_global[1])
   If $islogin_global[1] == 0 Then
	  GUICtrlSetData($namelab,"Disconnected")
   Else
	  GUICtrlSetData($namelab,$name[1])
   EndIf

   If $cntup == 3 Then
	  ToolTip("")
	  $cntup = 0
	  $fadeon = 0
   EndIf
EndFunc

func light($1,$2,$3,$4)
   $finalADDR = "0x" & hex($base_adr+$light_static)
   _MemoryPointerWrite($finalADDR, $memory_g, $light_offset, 55060)
EndFunc

func change100($1,$2,$3,$4)
		Local $search = _ImageSearch('Includes\img\100.bmp', 0, $ch100x, $ch100y, 0)
		If $search = 1 Then
			;_MouseClickPlus($hwnd,"right",$ch100x+15,$ch100y+15,1)
			local $mxy = MouseGetPos()
			MouseClick("right",$ch100x+15, $ch100y+15,1,1)
		    MouseMove($mxy[0],$mxy[1],1)
		EndIf
EndFunc

func lootgold($1,$2,$3,$4)
	    local $mxy = MouseGetPos()

		;_MouseDragPlus($hWnd,"left",$gtlx+5,$gtly+5,$aim4xy[0],$aim4xy[1])
		;KeySend($hwnd,"RETURN")

		Local $search = _ImageSearchArea('Includes\img\1.bmp', 0, $lootxy[0], $lootxy[1], @DesktopWidth, @DesktopHeight, $gtlx, $gtly, 0)
		If $search = 1 Then
			MouseMove($gtlx+15, $gtly+15,1)
			MouseDown("left")
			MouseMove($aim4xy[0], $aim4xy[1],1)
			MouseUp("left")
			Send("{enter}")
			MouseMove($mxy[0],$mxy[1],1)
		EndIf

		$search = _ImageSearchArea('Includes\img\2.bmp', 0, $lootxy[0], $lootxy[1], @DesktopWidth, @DesktopHeight, $gtlx, $gtly, 0)
		If $search = 1 Then
			MouseMove($gtlx+15, $gtly+15,1)
			MouseDown("left")
			MouseMove($aim4xy[0], $aim4xy[1],1)
			MouseUp("left")
			Send("{enter}")
			MouseMove($mxy[0],$mxy[1],1)
		EndIf

		$search = _ImageSearchArea('Includes\img\3.bmp', 0, $lootxy[0], $lootxy[1], @DesktopWidth, @DesktopHeight, $gtlx, $gtly, 0)
		If $search = 1 Then
			MouseMove($gtlx+15, $gtly+15,1)
			MouseDown("left")
			MouseMove($aim4xy[0], $aim4xy[1],1)
			MouseUp("left")
			Send("{enter}")
			MouseMove($mxy[0],$mxy[1],1)
		EndIf

		$search = _ImageSearchArea('Includes\img\4.bmp', 0, $lootxy[0], $lootxy[1], @DesktopWidth, @DesktopHeight, $gtlx, $gtly, 0)
		If $search = 1 Then
			MouseMove($gtlx+15, $gtly+15,1)
			MouseDown("left")
			MouseMove($aim4xy[0], $aim4xy[1],1)
			MouseUp("left")
			Send("{enter}")
			MouseMove($mxy[0],$mxy[1],1)
		EndIf
EndFunc

func telemetry_update($1,$2,$3,$4)
   telemetry($hardid,$name[1],$servername_global)
EndFunc

func license($1,$2,$3,$4)
	If getlicence($hardid) >= 1 Then
		ConsoleWrite("OK")
		Else
			Exit
		EndIf
EndFunc

func _heal1($1,$2,$3,$4)
   $hpinlow = guictrlread($HpInput1)
   $mpinlow = guictrlread($MpInput1)
   $hpinhi = guictrlread($HpInput2)
   $mpinhi = guictrlread($MpInput2)
   $hp_pc = $hp_global[1] * 100 / $hp_max_global[1]
   if $healcd == 0 Then
	  if $hp_pc <= $hpinhi And $mana_global[1] >= $mpinhi Then
		 $spellname = guictrlread($HealHot2)
		 KeySend($hwnd,$spellname)
		 ;ConsoleWrite("STRONG"&@CRLF)
		 $healcd = guictrlread($heal1del)
		 $ifcd = 1
	  ElseIf $hp_pc <= $hpinhi And $mana_global[1] <= $mpinhi Then
		 ;donothing
		 ;ConsoleWrite("Nothing"&@CRLF)
		 $healcd = guictrlread($heal1del)
		 $ifcd = 1
	  ElseIf $hp_pc <= $hpinlow And $mana_global[1] >= $mpinlow Then
		 $spellname = guictrlread($HealHot1)
		 KeySend($hwnd,$spellname)
		 ;ConsoleWrite("SOFT"&@CRLF)
		 $healcd = guictrlread($heal1del)
		 $ifcd = 1
	  EndIf
   EndIf

   If $ifcd == 1 Then
	   $healcd = $healcd - 10
	   If $healcd == 0 Then $ifcd = 0
   EndIf

   ConsoleWrite($healcd&@CRLF)
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
	  if $mana_global[1] >= guictrlread($ManaInput3) Then
		 KeySend($hwnd,guictrlread($ManaHot3))
	  EndIf
EndFunc

func _fishing($1,$2,$3,$4)
	  $range = 2*50
	  If $cap_global[1] >= guictrlread($FishInput) Then
		KeySend($hwnd,guictrlread($ManaHot4))
		_MouseClickPlusW($hwnd,"left",Round($fishxy[0]+Random($range*-1, $range)),Round($fishxy[1]+Random($range*-1, $range)),1)
	  EndIf
EndFunc

func _lifering($1,$2,$3,$4)
	ConsoleWrite($ringslot_global[1]&@CRLF)
	If $ringslot_global[1] == 0 Then
		_MouseDragPlusW($hWnd,"left",$liferingxy[0],$liferingxy[1],$slotxy[0],$slotxy[1])
		;ConsoleWrite("LAJF RING"&@CRLF)
	EndIf
EndFunc

func afk($1,$2,$3,$4)
   If $logon == 1 Then
	  if ($battleval_global[1] <> $battlevaltemp And $islogin_global[1] <> 0) Then
		WinActivate($hWnd)
	    Send("^q")
		SoundPlay(@WindowsDir & "\media\tada.wav", 0)
		 $logon = 0
	  EndIf
   EndIf
EndFunc

Func unstuck()
   	  $vkvalue = 17
	  DllCall($dll,"int","keybd_event","int",$vkvalue,"int",0,"long",0,"long",0) ;To press a key
	  DllCall($dll,"int","keybd_event","int",$vkvalue,"int",0,"long",2,"long",0) ;To release a key
EndFunc

Func _color()
	Local $user32 = DllOpen("user32.dll")
    While 1
    Sleep(10)
    If _IsPressed("01", $dll) Then
		local $xy = MouseGetPos()
        Local $iColor = PixelGetColor($xy[0], $xy[1])
		GUICtrlSetColor($lifecolor,$iColor)

		Return $xy
		DllClose($user32)
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