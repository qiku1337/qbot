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
global $pid,$memory_g,$name,$RunemakerInput,$ManaInput,$HealSpellIn,$HealMana,$Manacurr,$handle,$HpInput,$Hpcurr,$HealHot,$Manaheal
global $mx,$my,$playerx,$playery,$aim1x,$aim1y,$foodx,$foody,$spearx,$speary,$manasx,$manasy,$trainx,$trainy,$pixelx,$pixely
global $id4,$Bot,$namelab,$watchon,$Slider1,$color

pop()

Func botgui()

#Region ### START Koda GUI section ### Form=
	  $Bot = GUICreate("QBot", 211, 267, 0, 60)

	  $Ramka = GUICtrlCreateTab(2, 2, 200, 252)

	  GUICtrlCreateTabItem("Runes")
	  $Runeon = GUICtrlCreateCheckbox("Runemaker on", 108, 151, 73, 25)
	  $RuneLabel = GUICtrlCreateLabel("Runemaker", 60, 117, 68, 17)
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Label1 = GUICtrlCreateLabel("Mana", 4, 43, 31, 17)
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $ManaInput = GUICtrlCreateInput("100", 4, 154, 32, 22)

	  $RunemakerInput = GUICtrlCreateCombo("", 52, 154, 50, 25)
	  GUICtrlSetData(-1, "{f1}|{f2}|{f3}|{f4}|{f5}|{f6}|{f7}|{f8}|{f9}|{f10}|{f11}|{f12}")
	  $NameLabel = GUICtrlCreateLabel("Name", 4, 25, 36, 17)
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $namelab = GUICtrlCreateLabel("???", 44, 25, 82, 17)
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $ManaLabel = GUICtrlCreateLabel("Mana to cast + hotkey", 4, 131, 108, 17)
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Manacurr = GUICtrlCreateLabel("0", 42, 43, 28, 17)
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Afkon = GUICtrlCreateCheckbox("Anti Afk", 108, 219, 57, 17)
	  $watchon = GUICtrlCreateCheckbox("Battle logout", 4, 219, 89, 17)
	  $foodbut = GUICtrlCreateButton("Food xy", 0, 196, 73, 17)
	  $eatfoodcheck = GUICtrlCreateCheckbox("Eat food", 108, 195, 73, 17)
	  $Label2 = GUICtrlCreateLabel("Hp", 77, 43, 31, 17)
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Hpcurr = GUICtrlCreateLabel("0", 114, 43, 36, 17)
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Label3 = GUICtrlCreateLabel("Healbot", 67, 59, 68, 17)
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $HpInput = GUICtrlCreateInput("300", 4, 80, 32, 22)
	  $Manaheal = GUICtrlCreateInput("25", 4, 100, 32, 22)
	  $HealHot = GUICtrlCreateCombo("", 52, 80, 50, 25)
	  GUICtrlSetData(-1, "{f1}|{f2}|{f3}|{f4}|{f5}|{f6}|{f7}|{f8}|{f9}|{f10}|{f11}|{f12}")
	  $Healon = GUICtrlCreateCheckbox("Healer On", 108, 77, 73, 25)

	  GUICtrlCreateTabItem("Light")
	  $lightlockLabel = GUICtrlCreateLabel("Light hack", 4, 35, 52, 17)
	  $Lighton = GUICtrlCreateCheckbox("Boze daj mi swiatlo", 4, 55, 173, 25)

	  GUICtrlCreateTabItem("Aim")
	  $uhxy = GUICtrlCreateButton("AIM_INSERT", 52, 51, 70, 25)
	  $manasxy = GUICtrlCreateButton("AIM_PGDN", 52, 131, 70, 25)
	  $spearbut = GUICtrlCreateButton("Spear_END", 52, 89, 70, 25)
	  $hoton = GUICtrlCreateCheckbox("Hotkeys on", 52, 162, 81, 17)

	  $TabSheet1 = GUICtrlCreateTabItem("Train")
	  $trainxy = GUICtrlCreateButton("Monster xy", 12, 40, 73, 25)
	  $trainon = GUICtrlCreateCheckbox("Training on", 92, 42, 81, 17)
	  ;$pixel = GUICtrlCreateButton("Redbox Pixel", 12, 40, 73, 25)

	  GUICtrlCreateTabItem("")
	  GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


WinSetOnTop($Bot, "", 1)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		 Case $Runeon
			If _IsChecked($Runeon) Then
			   $id1 = _Timer_SetTimer($Bot,1000*2,"rune")
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
			   $id5 = _Timer_SetTimer($Bot,1000*10,"eatfood")
			Else
			   _Timer_KillTimer($Bot,$id5)
			EndIf

		 Case $Healon
			If _IsChecked($Healon) Then
			   $id6 = _Timer_SetTimer($Bot,100,"healer")
			Else
			   _Timer_KillTimer($Bot,$id6)
			EndIf

		 Case $trainon
			If _IsChecked($trainon) Then
			   $id7 = _Timer_SetTimer($Bot,1000*10,"train")
			Else
			   _Timer_KillTimer($Bot,$id7)
			EndIf

		 Case $hoton
			If _IsChecked($hoton) Then
			   HotKeySet("{insert}", "aim")
			   HotKeySet("{pgdn}", "manas")
			   HotKeySet("{end}", "spear")
			Else
			   HotKeySet("{insert}")
			   HotKeySet("{pgdn}")
			   HotKeySet("{end}")
			EndIf

		 Case $uhxy
			mouseposa()

		 Case $manasxy
			mouseposm()

		 Case $foodbut
			mouseposf()

		 Case $spearbut
			mouseposs()

		 Case $trainxy
			mousepost()

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
EndFunc

Func spear()
	  $mx = MouseGetPos(0)
	  $my = MouseGetPos(1)

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
   _MemoryPointerWrite($finalADDR, $memory_g, $light_offset, 55060)
EndFunc

func watch($1,$2,$3,$4)
      $finalADDR = "0x" & hex($base_adr+$battle_static)
	  $battleval = _MemoryPointerRead($finalADDR, $memory_g, $battle_offset)
      ConsoleWrite($battleval[1])
	  if ($battleval[1]>420) Then
		 controlsend($hWnd,"","","{ctrldown}{q}{ctrlup}")
		 SoundPlay(@WindowsDir & "\media\tada.wav", 1)
		 GUICtrlSetState($watchon,$GUI_UNCHECKED)
		 _Timer_KillTimer($Bot,$id4)
	  EndIf
	  ConsoleWrite($battleval[1])
	  unstuck()

EndFunc

func afk($1,$2,$3,$4)

   controlsend($hWnd,"","","{ctrldown}{left}{ctrlup}")
   Sleep(10)
   controlsend($hWnd,"","","{ctrldown}{up}{ctrlup}")
   Sleep(10)

   unstuck()

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

	  if $mana[1] >= $manaclient Then
		 $spellname = guictrlread($RunemakerInput)
		 controlsend($hWnd,"","",$spellname)
	  EndIf

	  unstuck()

EndFunc

func healer($1,$2,$3,$4)
   $hpclient = guictrlread($HpInput)
   $manaclient = guictrlread($Manaheal)

   $finalADDR = "0x" & hex($base_adr+$hp_static)
   $hp = _MemoryPointerRead($finalADDR, $memory_g, $hp_offset,"double")

   $finalADDRm = "0x" & hex($base_adr+$mana_static)
   $mana = _MemoryPointerRead($finalADDRm, $memory_g, $mana_offset,"double")

   $handle = WinGetHandle($hWnd, "")

   GUICtrlSetData($Hpcurr, $hp[1])
   GUICtrlSetData($Manacurr,$mana[1])

	  if $hp[1] <= $hpclient And $mana[1] >= $manaclient Then
		 $spellname = guictrlread($HealHot)
		 controlsend($hWnd,"","",$spellname)
		 ConsoleWrite($mana)
	  EndIf

   unstuck()

EndFunc

func train($1,$2,$3,$4)

   $finalADDR = "0x" & hex($base_adr+$ifattack_static)
   $ifattack = _MemoryPointerRead($finalADDR, $memory_g, $ifattack_offset)
   if $ifattack[1] == 0 Then
	  $windowTitle = WinGetTitle("[ACTIVE]")
	  $mx = MouseGetPos(0)
	  $my = MouseGetPos(1)
	  WinActivate($hWnd)
	  MouseClick("right",$trainx, $trainy,1,1)
	  MouseMove($mx,$my,1)
	  WinActivate($windowTitle)
   EndIf
EndFunc

; Mouse positions <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

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

Func getpixel()
   While 1
    Sleep(10) ; This enough to prevent CPU overload <<<<<<<<<<<<<<<<<<<<<<<<
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
   	  $vkvalue = 17
	  DllCall($dll,"int","keybd_event","int",$vkvalue,"int",0,"long",0,"long",0) ;To press a key
	  DllCall($dll,"int","keybd_event","int",$vkvalue,"int",0,"long",2,"long",0) ;To release a key
EndFunc

