#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <nomad.au3>
#include <pop.au3>
#include <Timers.au3>
#include <Misc.au3>
#include <Address.au3>
#include <KryMemory.au3>
#AutoIt3Wrapper_UseX64=n
#RequireAdmin

$dll = DllOpen("user32.dll")

$l = _Timer_Init()
global $pid,$memory_g,$name,$RunemakerInput,$ManaInput,$HealSpellIn,$HealMana,$HealHp,$Manacurr,$handle,$uhx,$uhy,$playerx,$playery

pop()

Func botgui()

#Region ### START Koda GUI section ### Form=
$Bot = GUICreate("Bot by Qiku v2 rev 1", 182, 246, 358, 163)
$Runeon = GUICtrlCreateCheckbox("Runemaker on", 72, 80, 73, 25)
$RuneLabel = GUICtrlCreateLabel("Runemaker", 16, 8, 68, 17)
$ManaInput = GUICtrlCreateInput("100", 16, 80, 49, 21)
$RunemakerInput = GUICtrlCreateInput("{f12}", 16, 24, 49, 21)
$lightlockLabel = GUICtrlCreateLabel("Light hack", 16, 112, 52, 17)
$Lighton = GUICtrlCreateCheckbox("Voze daj mi swiatlo", 72, 104, 173, 25)
$ManaLabel = GUICtrlCreateLabel("Mana", 88, 8, 36, 17)
$Manacurr = GUICtrlCreateLabel("0", 88, 24, 36, 17)
$Afkon = GUICtrlCreateCheckbox("Anti Afk", 72, 160, 57, 25)
$Label1 = GUICtrlCreateLabel("Mana", 24, 56, 31, 17)
$foodxy = GUICtrlCreateButton("foodxy", 16, 160, 41, 25)
global $Slider1 = GUICtrlCreateSlider(16, 128, 153, 33)
GUICtrlSetLimit(1, 20, 0)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

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

func afk($1,$2,$3,$4)

   $clientname = $hWnd
   controlsend($clientname,"","","{ctrldown}{left}{ctrlup}")
   controlsend($clientname,"","","{ctrldown}{down}{ctrlup}")

EndFunc

 func rune($1,$2,$3,$4)
   $spellname = guictrlread($RunemakerInput)
   $clientname = $hWnd
   $manaclient = guictrlread($ManaInput)

   $finalADDR = "0x" & hex($base_adr+$mana_static)

   $mana = _MemoryPointerRead($finalADDR, $memory_g, $mana_offset,"double")

	$handle = WinGetHandle($clientname, "")

    GUICtrlSetData($Manacurr,$mana[1])
	  if $mana[1] >= $manaclient Then

		controlsend($clientname,"","",$spellname)
		;Sleep(200)
		;ControlClick($handle,"","","right",1,$foodx,$foody)
		;ControlClick($handle,"","","right",1,$foodx,$foody)
		;ControlClick($handle,"","","right",1,$foodx,$foody)
		;ControlClick($handle,"","","right",1,$foodx,$foody)

		;ConsoleWrite(" ")
		;ConsoleWrite($clientname)
		;ConsoleWrite("Mouse Button Pressed" & @CRLF & "X=" & $foodx & @CRLF & "Y=" & $foody & @CRLF)


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
