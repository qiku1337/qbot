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
global $pid,$memory_g,$name,$RunemakerInput,$ManaInput,$HealSpellIn,$HealMana,$HealHp,$Manacurr,$handle,$uhx,$uhy,$playerx,$playery,$foodx,$foody
global $id4,$Bot,$namelab,$watchon

pop()

Func botgui()

#Region ### START Koda GUI section ### Form=
$Bot = GUICreate("Bot by Qiku v4", 184, 214, 0, 60)
$Runeon = GUICtrlCreateCheckbox("Runemaker on", 72, 80, 73, 25)
$RuneLabel = GUICtrlCreateLabel("Runemaker", 16, 8, 68, 17)
$ManaInput = GUICtrlCreateInput("100", 16, 80, 49, 21)
;$RunemakerInput = GUICtrlCreateInput("{f12}", 16, 24, 49, 21)
$RunemakerInput = GUICtrlCreateCombo("", 16, 24, 49, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "{f1}|{f2}|{f3}|{f4}|{f5}|{f6}|{f7}|{f8}|{f9}|{f10}|{f11}|{f12}", "{f12}")
$lightlockLabel = GUICtrlCreateLabel("Light hack", 16, 112, 52, 17)
$Lighton = GUICtrlCreateCheckbox("Boze daj mi swiatlo", 72, 104, 173, 25)
$ManaLabel = GUICtrlCreateLabel("Mana", 88, 8, 36, 17)
$Manacurr = GUICtrlCreateLabel("0", 94, 24, 36, 17)
$Afkon = GUICtrlCreateCheckbox("Anti Afk", 72, 160, 57, 25)
$Label1 = GUICtrlCreateLabel("Mana", 24, 56, 31, 17)
$foodxy = GUICtrlCreateButton("foodxy", 16, 160, 41, 25)
global $Slider1 = GUICtrlCreateSlider(16, 128, 153, 33)
$watchon = GUICtrlCreateCheckbox("Battle logout", 72, 192, 89, 17)
$NameLabel = GUICtrlCreateLabel("Name", 136, 8, 36, 17)
$namelab = GUICtrlCreateLabel(".........", 136, 25, 52, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
_GUICtrlSlider_SetRange($Slider1, 5, 11130)

   WinSetOnTop("Bot", "", 1)

   While 1
	$nMsg = GUIGetMsg()

	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		 Case $Runeon
			If _IsChecked($Runeon) Then
			   $id1 = _Timer_SetTimer($Bot,700,"rune")
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
			mousepos()
	EndSwitch
 WEnd

EndFunc

;funkcja ischeckbox

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
 EndFunc

;funkcje botowe

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
   ;Sleep(200)
   ;ControlClick($clientname,"","","right",1,$foodx,$foody)
   ;ControlClick($clientname,"","","right",1,$foodx,$foody)

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

Func mousepos()
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
