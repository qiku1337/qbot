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
#include <help.au3>
#include <GuiSlider.au3>
#include <ComboConstants.au3>
#include <Process.au3>
#include <SendMessage.au3>

#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_icon=qbot.ico
#RequireAdmin
;#NoTrayIcon

global $dll = DllOpen("user32.dll")

;$l = _Timer_Init()
global $pid,$memory_g,$name,$RunemakerInput,$ManaInput,$HealSpellIn,$HealMana,$Manacurr,$handle,$HpInput,$Hpcurr,$HealHot,$Manaheal
global $mx,$my,$playerx,$playery,$aim1x,$aim1y,$foodx,$foody,$spearx,$speary,$manasx,$manasy,$trainx,$trainy,$sdx,$sdy,$fishx,$fishy,$wedkax,$wedkay
global $id4,$Bot,$namelab,$watchon,$Slider1,$color,$fishsqm

pop()

Func botgui()

#Region ### START Koda GUI section ### Form=
	  $Bot = GUICreate("Qbot V3.3", 213, 289, 0, 60)
	  $Ramka = GUICtrlCreateTab(2, 2, 210, 282)
	  GUICtrlCreateTabItem("Runes")
	  $butinfo2 = GUICtrlCreateButton("?", 175, 3, 20, 20, $BS_CENTER)

      $Runeon = GUICtrlCreateCheckbox("Runemaker on", 124, 161, 73, 25)

	  $RuneLabel = GUICtrlCreateLabel("Runemaker", 68, 127, 68, 17)

	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Label1 = GUICtrlCreateLabel("Mana", 20, 45, 31, 17)

	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $ManaInput = GUICtrlCreateInput("100", 20, 164, 32, 22)

	  $RunemakerInput = GUICtrlCreateCombo("", 60, 164, 50, 25)
	  GUICtrlSetData(-1, "{f1}|{f2}|{f3}|{f4}|{f5}|{f6}|{f7}|{f8}|{f9}|{f10}|{f11}|{f12}")

	  $NameLabel = GUICtrlCreateLabel("Name", 20, 27, 36, 17)

	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $namelab = GUICtrlCreateLabel("???", 60, 27, 58, 17)

	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $ManaLabel = GUICtrlCreateLabel("Mana to cast + hotkey", 44, 141, 108, 17)

	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Manacurr = GUICtrlCreateLabel("0", 58, 45, 28, 17)

	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Afkon = GUICtrlCreateCheckbox("Anti Afk", 124, 229, 60, 17)
	  $Afkon2 = GUICtrlCreateCheckbox("Anti Afk2", 124, 249, 60, 17)

	  $watchon = GUICtrlCreateCheckbox("Battle logout", 20, 210, 89, 17)

	  $foodbut = GUICtrlCreateButton("Food xy", 18, 190, 93, 17)

	  $fishingbut = GUICtrlCreateButton("Fishing xy", 18, 230, 50, 17)
	  $wedkabut = GUICtrlCreateButton("Wedka xy", 67, 230, 53, 17)

	  $eatfoodcheck = GUICtrlCreateCheckbox("Eat food", 124, 190, 73, 17)

	  $fishingon = GUICtrlCreateCheckbox("Fish zasieg", 18, 250, 73, 17)
	  $fishsqm = GUICtrlCreateInput("1", 95, 250, 20, 20)

	  $Label2 = GUICtrlCreateLabel("Hp", 21, 61, 31, 17)

	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Hpcurr = GUICtrlCreateLabel("0", 58, 61, 36, 17)

	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Label3 = GUICtrlCreateLabel("Healbot", 91, 69, 68, 17)

	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $HpInput = GUICtrlCreateInput("300", 20, 82, 32, 22)

	  $Manaheal = GUICtrlCreateInput("25", 20, 102, 32, 22)

	  $HealHot = GUICtrlCreateCombo("", 60, 90, 50, 25)
	  GUICtrlSetData(-1, "{f1}|{f2}|{f3}|{f4}|{f5}|{f6}|{f7}|{f8}|{f9}|{f10}|{f11}|{f12}")

	  $Healon = GUICtrlCreateCheckbox("Healer On", 124, 87, 73, 25)

	  GUICtrlCreateTabItem("Light")
	  $lightlockLabel = GUICtrlCreateLabel("Light hack", 28, 29, 52, 17)

	  $Lighton = GUICtrlCreateCheckbox("Boze daj mi swiatlo", 36, 49, 117, 25)

	  GUICtrlCreateTabItem("Aim")
	  $butinfo3 = GUICtrlCreateButton("?", 175, 3, 20, 20, $BS_CENTER)

	  $uhxy = GUICtrlCreateButton("SHOOT1_XY", 12, 52, 70, 25)

	  $manasxy = GUICtrlCreateButton("SHOOT2_XY", 12, 82, 70, 25)

	  $spearbut = GUICtrlCreateButton("DRAG1_XY", 12, 142, 70, 25)

	  $sdxy = GUICtrlCreateButton("SHOOT3_XY", 12, 112, 70, 25)

	  $hoton = GUICtrlCreateCheckbox("Hotkeys on", 60, 196, 81, 17)

	  $Label4 = GUICtrlCreateLabel("Key", 132, 29, 23, 18)

	  $hotkey_1 = GUICtrlCreateInput("insert", 122, 53, 49, 22)

	  $hotkey_2 = GUICtrlCreateInput("pgdn", 122, 82, 49, 22)

	  $hotkey_3 = GUICtrlCreateInput("", 122, 112, 49, 22)

	  $hotkey_4 = GUICtrlCreateInput("end", 122, 143, 49, 22)

	  $TabSheet1 = GUICtrlCreateTabItem("Train")
	  $trainxy = GUICtrlCreateButton("Monster xy", 4, 34, 73, 25)

	  $trainon = GUICtrlCreateCheckbox("Training on", 84, 36, 81, 17)

	  GUICtrlCreateTabItem("")
	  GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


WinSetOnTop($Bot, "", 1)
$id0 = _Timer_SetTimer($Bot,500,"name")
While 1
   $nMsg = GUIGetMsg()

   Switch $nMsg
	  Case $GUI_EVENT_CLOSE
		 Exit

	  Case $butinfo2
		 help1()

	  Case $butinfo3
		 help2()

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

	  Case $hoton
		 If _IsChecked($hoton) Then
			HotKeySet("{" & guictrlread($hotkey_1) & "}", "aim")
			   $hotkey1temp = "{" & guictrlread($hotkey_1) & "}"
			HotKeySet("{" & guictrlread($hotkey_2) & "}", "manas")
			   $hotkey2temp = "{" & guictrlread($hotkey_2) & "}"
			HotKeySet("{" & guictrlread($hotkey_3) & "}", "esde")
			   $hotkey3temp = "{" & guictrlread($hotkey_3) & "}"
			HotKeySet("{" & guictrlread($hotkey_4) & "}", "spear")
			   $hotkey4temp = "{" & guictrlread($hotkey_4) & "}"
		 Else
			HotKeySet($hotkey1temp)
			HotKeySet($hotkey2temp)
			HotKeySet($hotkey3temp)
			HotKeySet($hotkey4temp)
		 EndIf

	  Case $uhxy
		 mouseposa()

	  Case $manasxy
		 mouseposm()

	  Case $sdxy
		 mousepossd()

	  Case $foodbut
		 mouseposf()

	  Case $spearbut
		 mouseposs()

	  Case $trainxy
		 mousepost()

	  Case $fishingbut
		 mouseposfish()

	  Case $wedkabut
		 mouseposwedka()

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
	  ;Sleep(20)
EndFunc

Func esde()
	  $mx = MouseGetPos(0)
	  $my = MouseGetPos(1)

	  MouseClick("right",$sdx, $sdy,1,1)
	  MouseClick("left",$mx,$my,1,1)
	  ;Sleep(20)
EndFunc

Func spear()
	  $mx = MouseGetPos(0)
	  $my = MouseGetPos(1)

	  MouseDown("left")
	  MouseMove($spearx,$speary,1)
	  MouseUp("left")
      Send("{enter}")
	  MouseMove($mx,$my,1)
	  ;Sleep(50)
EndFunc

 ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

func name($1,$2,$3,$4)
   $namefinal = "0x" & hex($base_adr+$name_static)
   $name = _MemoryPointerRead($namefinal, $memory_g, $name_offset,"char[10]")

   GUICtrlSetData($namelab,$name[1])
EndFunc

Func eatfood($1,$2,$3,$4)
	  $mx = MouseGetPos(0)
	  $my = MouseGetPos(1)
	  WinActivate($hWnd)
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
	  if ($battleval[1]>420) Then
		 controlsend($hWnd,"","","{ctrldown}{q}{ctrlup}")
		 SoundPlay(@WindowsDir & "\media\tada.wav", 1)
		 GUICtrlSetState($watchon,$GUI_UNCHECKED)
		 _Timer_KillTimer($Bot,$id4)
		 unstuck()
	  EndIf
	  ConsoleWrite($battleval[1])
EndFunc

func afk($1,$2,$3,$4)

   ;WinActivate($hWnd)
   ;Send("^{UP}")
   ;Send("^{DOWN}")

   ControlSend($hWnd,"","","{CTRLDOWN}{UP}{CTRLUP}")
   Sleep(10)
   ControlSend($hWnd,"","","{CTRLDOWN}{LEFT}{CTRLUP}")

   unstuck()

EndFunc

func afk2($1,$2,$3,$4)

   WinActivate($hWnd)
   Send("^{UP}")
   Send("^{DOWN}")

EndFunc

func fishing($1,$2,$3,$4)

	  $mx = MouseGetPos(0)
	  $my = MouseGetPos(1)
	  $range = guictrlread($fishsqm)*50


	  MouseClick("right",$wedkax, $wedkay,1,1)
	  MouseClick("left",$fishx+Random($range*-1, $range),$fishy+Random($range*-1, $range),1,1)
	  MouseMove($mx,$my,1)

EndFunc

func rune($1,$2,$3,$4)
   $manaclient = guictrlread($ManaInput)

   $finalADDR = "0x" & hex($base_adr+$mana_static)
   $mana = _MemoryPointerRead($finalADDR, $memory_g, $mana_offset,"double")

   $finalADDRh = "0x" & hex($base_adr+$hp_static)
   $hp = _MemoryPointerRead($finalADDRh, $memory_g, $hp_offset,"double")

   ;$handle = WinGetHandle($hWnd, "")

   GUICtrlSetData($Manacurr,$mana[1])
   GUICtrlSetData($Hpcurr, $hp[1])

	  if $mana[1] >= $manaclient Then
		 $spellname = guictrlread($RunemakerInput)
		 controlsend($hWnd,"","",$spellname)
	  EndIf

EndFunc

func healer($1,$2,$3,$4)
   $hpclient = guictrlread($HpInput)
   $manaclient = guictrlread($Manaheal)

   $finalADDR = "0x" & hex($base_adr+$hp_static)
   $hp = _MemoryPointerRead($finalADDR, $memory_g, $hp_offset,"double")

   $finalADDRm = "0x" & hex($base_adr+$mana_static)
   $mana = _MemoryPointerRead($finalADDRm, $memory_g, $mana_offset,"double")

   ;$handle = WinGetHandle($hWnd, "")

   GUICtrlSetData($Hpcurr, $hp[1])
   GUICtrlSetData($Manacurr,$mana[1])

	  if $hp[1] <= $hpclient And $mana[1] >= $manaclient Then
		 $spellname = guictrlread($HealHot)
		 controlsend($hWnd,"","",$spellname)
		 ConsoleWrite($mana)
	  EndIf

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

Func mousepossd()
   While 1
    Sleep(10) ; This enough to prevent CPU overload <<<<<<<<<<<<<<<<<<<<<<<<
    If _IsPressed("01", $dll) Then
        $sdx = MouseGetPos(0)
		$sdy = MouseGetPos(1)
	    ExitLoop
        While _IsPressed("01", $dll)
            Sleep(10)
        WEnd
    EndIf
   WEnd
EndFunc

Func mouseposfish()
   While 1
    Sleep(10) ; This enough to prevent CPU overload <<<<<<<<<<<<<<<<<<<<<<<<
    If _IsPressed("01", $dll) Then
        $fishx = MouseGetPos(0)
		$fishy = MouseGetPos(1)
	    ExitLoop
        While _IsPressed("01", $dll)
            Sleep(10)
        WEnd
    EndIf
   WEnd
EndFunc

Func mouseposwedka()
   While 1
    Sleep(10) ; This enough to prevent CPU overload <<<<<<<<<<<<<<<<<<<<<<<<
    If _IsPressed("01", $dll) Then
        $wedkax = MouseGetPos(0)
		$wedkay = MouseGetPos(1)
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

