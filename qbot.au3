#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <Timers.au3>
#include <Misc.au3>
#include <Address.au3>
#include <KryMemory.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <nomad.au3>
#include <pop.au3>
#include <GuiSlider.au3>
#include <ComboConstants.au3>
#include <Process.au3>

#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_icon=qbot.ico
#RequireAdmin
;#NoTrayIcon

global $dll = DllOpen("user32.dll")

;$l = _Timer_Init()
global $pid,$memory_g,$name,$RunemakerInput,$ManaInput,$HealSpellIn,$HealMana,$Manacurr,$handle,$HpInput,$Hpcurr,$HealHot
global $mx,$my,$playerx,$playery,$aim1x,$aim1y,$foodx,$foody,$spearx,$speary,$manasx,$manasy
global $id4,$Bot,$namelab,$watchon,$Slider1

pop()

Func botgui()

#Region ### START Koda GUI section ### Form=
	  $Bot = GUICreate("QBot", 209, 265, 0, 60)
	  GUICtrlCreateTab(2, 2, 200, 252)
	  GUICtrlCreateTabItem("Runes")
	  $Runeon = GUICtrlCreateCheckbox("Runemaker on", 116, 157, 73, 25)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $RuneLabel = GUICtrlCreateLabel("Runemaker", 68, 123, 68, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Label1 = GUICtrlCreateLabel("Mana", 12, 49, 31, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $ManaInput = GUICtrlCreateInput("600", 12, 160, 32, 22)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $RunemakerInput = GUICtrlCreateCombo("", 60, 160, 50, 25)
	  GUICtrlSetData(-1, "{f1}|{f2}|{f3}|{f4}|{f5}|{f6}|{f7}|{f8}|{f9}|{f10}|{f11}|{f12}")
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $NameLabel = GUICtrlCreateLabel("Name", 12, 31, 36, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $namelab = GUICtrlCreateLabel("???", 52, 31, 82, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $ManaLabel = GUICtrlCreateLabel("Mana to cast + hotkey", 12, 137, 108, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Manacurr = GUICtrlCreateLabel("0", 50, 49, 28, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Afkon = GUICtrlCreateCheckbox("Anti Afk", 116, 225, 57, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $watchon = GUICtrlCreateCheckbox("Battle logout", 12, 225, 89, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $foodbut = GUICtrlCreateButton("Food xy", 8, 202, 73, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $eatfoodcheck = GUICtrlCreateCheckbox("Eat food", 116, 201, 73, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $Label2 = GUICtrlCreateLabel("Hp", 85, 49, 31, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Hpcurr = GUICtrlCreateLabel("0", 122, 49, 36, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Label3 = GUICtrlCreateLabel("Healbot", 75, 65, 68, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $HpInput = GUICtrlCreateInput("240", 12, 86, 32, 22)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $HealHot = GUICtrlCreateCombo("", 60, 86, 50, 25)
	  GUICtrlSetData(-1, "{f1}|{f2}|{f3}|{f4}|{f5}|{f6}|{f7}|{f8}|{f9}|{f10}|{f11}|{f12}")
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $Healon = GUICtrlCreateCheckbox("Healer On", 116, 83, 73, 25)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlCreateTabItem("Light")
	  $lightlockLabel = GUICtrlCreateLabel("Light hack", 6, 37, 52, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $Lighton = GUICtrlCreateCheckbox("Boze daj mi swiatlo", 60, 33, 173, 25)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $Slider1 = GUICtrlCreateSlider(4, 57, 153, 33)
	  GUICtrlCreateTabItem("Aim")
	  $uhxy = GUICtrlCreateButton("AIM_INSERT", 60, 57, 70, 25)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $manasxy = GUICtrlCreateButton("AIM_PGDN", 60, 137, 70, 25)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $spearbut = GUICtrlCreateButton("Spear_END", 60, 95, 70, 25)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlCreateTabItem("")
	  GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

_GUICtrlSlider_SetRange($Slider1, 5, 35)

WinSetOnTop($Bot, "", 1)

HotKeySet("{insert}", "aim")
HotKeySet("{pgdn}", "manas")
HotKeySet("{end}", "spear")

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		 Case $Runeon
			If _IsChecked($Runeon) Then
			   $id1 = _Timer_SetTimer($Bot,2000,"rune")
			Else
			   _Timer_KillTimer($Bot,$id1)
			EndIf

	    Case $Lighton
			If _IsChecked($Lighton) Then
			   $id2 = _Timer_SetTimer($Bot,100,"light")
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
			Else
			   _Timer_KillTimer($Bot,$id4)
			EndIf

		 Case $eatfoodcheck
			If _IsChecked($eatfoodcheck) Then
			   $id5 = _Timer_SetTimer($Bot,10000,"eatfood")
			Else
			   _Timer_KillTimer($Bot,$id5)
			EndIf

		 Case $Healon
			If _IsChecked($Healon) Then
			   $id6 = _Timer_SetTimer($Bot,100,"healer")
			Else
			   _Timer_KillTimer($Bot,$id6)
			EndIf

		 Case $uhxy
			mouseposa()

		 Case $manasxy
			mouseposm()

		 Case $foodbut
			mouseposf()

		 Case $spearbut
			mouseposs()
	EndSwitch
 WEnd

EndFunc

;funkcja ischeckbox

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
 EndFunc

;funkcje botowe

Func aim()
	  $mx = MouseGetPos(0)
	  $my = MouseGetPos(1)

	  MouseClick("right",$aim1x, $aim1y,1,1)
	  MouseClick("left",$mx,$my,1,1)
	  Sleep(20)
	  ;MouseMove($mx,$my,1)
EndFunc

Func manas()
	  $mx = MouseGetPos(0)
	  $my = MouseGetPos(1)

	  MouseClick("right",$manasx, $manasy,1,1)
	  MouseClick("left",$mx,$my,1,1)
	  Sleep(20)
	  ;MouseMove($mx,$my,1)
EndFunc

Func spear()
	  $mx = MouseGetPos(0)
	  $my = MouseGetPos(1)

	  ;	  MouseClickDrag("left",$mx, $my,$spearx,$speary,1)

	  MouseDown("left")
	  MouseMove($spearx,$speary,1)
	  MouseUp("left")
      Send("{enter}")
	  MouseMove($mx,$my,1)
	  Sleep(50)
EndFunc

Func eatfood($1,$2,$3,$4)
	  $mx = MouseGetPos(0)
	  $my = MouseGetPos(1)
	  MouseClick("right",$foodx, $foody,1,1)
	  MouseMove($mx,$my,1)
EndFunc

func light($1,$2,$3,$4)
   $finalADDR = "0x" & hex($base_adr+$light_static)
   _MemoryPointerWrite($finalADDR, $memory_g, $light_offset, GUICtrlRead($Slider1))
EndFunc

func watch($1,$2,$3,$4)
      $finalADDR = "0x" & hex($base_adr+$battle_static)
	  $battleval = _MemoryPointerRead($finalADDR, $memory_g, $battle_offset)
      ConsoleWrite($battleval[1])
	  if ($battleval[1]>419) Then
		 controlsend($hWnd,"","","{ctrldown}{q}{ctrlup}")
		 SoundPlay(@WindowsDir & "\media\tada.wav", 1)
		 GUICtrlSetState($watchon,$GUI_UNCHECKED)
		 _Timer_KillTimer($Bot,$id4)
	  EndIf
EndFunc

func afk($1,$2,$3,$4)

   controlsend($hWnd,"","","{ctrldown}{left}{ctrlup}")
   Sleep(10)
   controlsend($hWnd,"","","{ctrldown}{up}{ctrlup}")
   Sleep(10)

EndFunc

func rune($1,$2,$3,$4)
   $manaclient = guictrlread($ManaInput)

   $finalADDR = "0x" & hex($base_adr+$mana_static)
   $mana = _MemoryPointerRead($finalADDR, $memory_g, $mana_offset,"double")

   $namefinal = "0x" & hex($base_adr+$name_static)
   $name = _MemoryPointerRead($namefinal, $memory_g, $name_offset,"char[10]")

   $handle = WinGetHandle($hWnd, "")

   GUICtrlSetData($Manacurr,$mana[1])
   GUICtrlSetData($namelab,$name[1])

	  $vkvalue = 17
	  DllCall($dll,"int","keybd_event","int",$vkvalue,"int",0,"long",0,"long",0) ;To press a key
	  DllCall($dll,"int","keybd_event","int",$vkvalue,"int",0,"long",2,"long",0) ;To release a key

	  if $mana[1] >= $manaclient Then
		 $spellname = guictrlread($RunemakerInput)
		 controlsend($hWnd,"","",$spellname)
	  EndIf
   EndFunc

func healer($1,$2,$3,$4)
   $hpclient = guictrlread($HpInput)
   $manaclient = guictrlread($ManaInput)

   $finalADDR = "0x" & hex($base_adr+$hp_static)
   $hp = _MemoryPointerRead($finalADDR, $memory_g, $hp_offset,"double")

   $finalADDRm = "0x" & hex($base_adr+$mana_static)
   $mana = _MemoryPointerRead($finalADDRm, $memory_g, $mana_offset,"double")

   $handle = WinGetHandle($hWnd, "")

   GUICtrlSetData($Hpcurr, $hp[1])
   GUICtrlSetData($Manacurr,$mana[1])

   	  $vkvalue = 17
	  DllCall($dll,"int","keybd_event","int",$vkvalue,"int",0,"long",0,"long",0) ;To press a key
	  DllCall($dll,"int","keybd_event","int",$vkvalue,"int",0,"long",2,"long",0) ;To release a key

	  if $hp[1] <= $hpclient And $mana[1] >= $manaclient Then
		 $spellname = guictrlread($HealHot)
		 controlsend($hWnd,"","",$spellname)
		 ConsoleWrite($mana)
	  EndIf
EndFunc

Func mouseposa()
   While 1
    Sleep(10) ; This enough to prevent CPU overload <<<<<<<<<<<<<<<<<<<<<<<<
    If _IsPressed("01", $dll) Then
        $aim1x = MouseGetPos(0)
		$aim1y = MouseGetPos(1)

	    ExitLoop
        While _IsPressed("01", $dll)
            Sleep(10)
        WEnd
    EndIf
WEnd
EndFunc

Func mouseposm()
   While 1
    Sleep(10) ; This enough to prevent CPU overload <<<<<<<<<<<<<<<<<<<<<<<<
    If _IsPressed("01", $dll) Then
        $manasx = MouseGetPos(0)
		$manasy = MouseGetPos(1)
	    ExitLoop
        While _IsPressed("01", $dll)
            Sleep(10)
        WEnd
    EndIf
WEnd
EndFunc

Func mouseposf()
   While 1
    Sleep(10) ; This enough to prevent CPU overload <<<<<<<<<<<<<<<<<<<<<<<<
    If _IsPressed("01", $dll) Then
        $foodx = MouseGetPos(0)
		$foody = MouseGetPos(1)
	    ExitLoop
        While _IsPressed("01", $dll)
            Sleep(10)
        WEnd
    EndIf
WEnd
EndFunc

Func mouseposs()
   While 1
    Sleep(10) ; This enough to prevent CPU overload <<<<<<<<<<<<<<<<<<<<<<<<
    If _IsPressed("01", $dll) Then
        $spearx = MouseGetPos(0)
		$speary = MouseGetPos(1)
	    ExitLoop
        While _IsPressed("01", $dll)
            Sleep(10)
        WEnd
    EndIf
WEnd
EndFunc
