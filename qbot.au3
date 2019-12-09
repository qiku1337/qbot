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

#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_icon=qbot.ico
#RequireAdmin
#NoTrayIcon

$dll = DllOpen("user32.dll")

;$l = _Timer_Init()
global $pid,$memory_g,$name,$RunemakerInput,$ManaInput,$HealSpellIn,$HealMana,$HealHp,$Manacurr,$handle,$mx,$my,$playerx,$playery,$foodx,$foody
global $id4,$Bot,$namelab,$watchon,$manasx,$manasy

HotKeySet("{insert}", "fish")
HotKeySet("{del}", "manas")

pop()

Func botgui()

#Region ### START Koda GUI section ### Form=
	  $Bot = GUICreate("Bot by Qiku v4", 205, 180, 0, 60)
	  GUICtrlCreateTab(2, 2, 200, 172)
	  GUICtrlCreateTabItem("Runes")
	  $Runeon = GUICtrlCreateCheckbox("Runemaker on", 12, 81, 73, 25)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $RuneLabel = GUICtrlCreateLabel("Runemaker", 12, 63, 68, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Label1 = GUICtrlCreateLabel("Mana", 12, 45, 31, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $ManaInput = GUICtrlCreateInput("120", 92, 61, 49, 22)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $RunemakerInput = GUICtrlCreateCombo("{f12}", 140, 61, 49, 25)
	  GUICtrlSetData(-1, "{f1}|{f2}|{f3}|{f4}|{f5}|{f6}|{f7}|{f8}|{f9}|{f10}|{f11}|{f12}")
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $NameLabel = GUICtrlCreateLabel("Name", 12, 27, 36, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $namelab = GUICtrlCreateLabel(".........", 52, 27, 52, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $ManaLabel = GUICtrlCreateLabel("Mana", 100, 45, 36, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Manacurr = GUICtrlCreateLabel("0", 50, 45, 36, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlSetBkColor(-1, 0xFFFFFF)
	  $Afkon = GUICtrlCreateCheckbox("Anti Afk", 12, 109, 57, 25)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $watchon = GUICtrlCreateCheckbox("Battle logout", 12, 141, 89, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlCreateTabItem("Light")
	  $lightlockLabel = GUICtrlCreateLabel("Light hack", 6, 33, 52, 17)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $Lighton = GUICtrlCreateCheckbox("Boze daj mi swiatlo", 68, 29, 173, 25)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $Slider1 = GUICtrlCreateSlider(20, 53, 153, 33)
	  GUICtrlCreateTabItem("Aim")
	  $foodxy = GUICtrlCreateButton("uhxy", 12, 37, 70, 25)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  $manasxy = GUICtrlCreateButton("manasxy", 108, 37, 70, 25)
	  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	  GUICtrlCreateTabItem("")
	  GUISetState(@SW_SHOW)
	  #EndRegion ### END Koda GUI section ###
_GUICtrlSlider_SetRange($Slider1, 5, 11130)

   ;WinSetOnTop("Bot", "", 1)

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
			   $id3 = _Timer_SetTimer($Bot,10000,"afk")
			Else
			   _Timer_KillTimer($Bot,$id3)
			EndIf

		 Case $watchon
			If _IsChecked($watchon) Then
			   $id4 = _Timer_SetTimer($Bot,200,"watch")
			Else
			   _Timer_KillTimer($Bot,$id4)
			EndIf

		 Case $foodxy
			mouseposf()

		 Case $manasxy
			mouseposm()

	EndSwitch
 WEnd

EndFunc

;funkcja ischeckbox

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
 EndFunc

;funkcje botowe

Func fish()
	  $mx = MouseGetPos(0)
	  $my = MouseGetPos(1)

	  MouseClick("right",$foodx, $foody,1,1)
	  MouseClick("left",$mx,$my,1,1)
	  ;MouseMove($mx,$my,1)
   EndFunc

   Func manas()
	  $mx = MouseGetPos(0)
	  $my = MouseGetPos(1)

	  MouseClick("right",$manasx, $manasy,1,1)
	  MouseClick("left",$mx,$my,1,1)
	  ;MouseMove($mx,$my,1)
EndFunc

func light($1,$2,$3,$4)
   $finalADDR = "0x" & hex($base_adr+$light_static)
   _MemoryPointerWrite($finalADDR, $memory_g, $light_offset, GUICtrlRead($Slider1))
EndFunc

func watch($1,$2,$3,$4)

	  $finalADDR = "0x" & hex($base_adr+$battle_static)
	  $dog = _MemoryPointerRead($finalADDR, $memory_g, $battle_offset)

	  ConsoleWrite($dog & @CRLF)
	  if ($dog[1]>406) Then
		 ConsoleWrite("hau hau" & @CRLF)
		 $clientname = $hWnd
		 controlsend($hWnd,"","","{ctrldown}{q}{ctrlup}")
		 0x0359F784
		 SoundPlay(@WindowsDir & "\media\tada.wav", 1)
		 GUICtrlSetState($watchon,$GUI_UNCHECKED)
		 _Timer_KillTimer($Bot,$id4)
	  Else
		 ConsoleWrite("zzzz" & @CRLF)
	  EndIf
EndFunc

func afk($1,$2,$3,$4)

   controlsend($hWnd,"","","{ctrldown}{left}{ctrlup}")
   controlsend($hWnd,"","","{ctrldown}{down}{ctrlup}")
   ControlSend("","","","{ctrlup}")
   ;Sleep(200)
   ;ControlClick($hWnd,"","","right",1,$foodx,$foody)
   ;ControlClick($hWnd,"","","right",1,$foodx,$foody)

   ;ConsoleWrite("Mouse Button Pressed" & @CRLF & "X=" & $foodx & @CRLF & "Y=" & $foody & @CRLF)
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

EndFunc

Func mouseposf()
   While 1
    Sleep(10) ; This enough to prevent CPU overload <<<<<<<<<<<<<<<<<<<<<<<<
    If _IsPressed("01", $dll) Then
        $foodx = MouseGetPos(0)
		$foody = MouseGetPos(1)
        ConsoleWrite("Mouse Button Pressed" & @CRLF & "X=" & $foodx & @CRLF & "Y=" & $foody & @CRLF)
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
        ConsoleWrite("Mouse Button Pressed" & @CRLF & "X=" & $manasx & @CRLF & "Y=" & $manasy & @CRLF)
	    ExitLoop
        While _IsPressed("01", $dll)
            Sleep(10)
        WEnd
    EndIf
WEnd
EndFunc
