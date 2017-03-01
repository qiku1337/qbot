#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <nomad.au3>
#include <pop.au3>
#include <Timers.au3>
#include <Misc.au3>
$dll = DllOpen("user32.dll")

$l = _Timer_Init()
global $pid,$memory,$name,$RunemakerInput,$ManaInput,$HealSpellIn,$HealMana,$HealHp,$Manacurr,$handle
global $uhx,$uhy,$playerx,$playery

HotKeySet("{Numpad1}", "uhxy")
HotKeySet("{Numpad2}", "playerxy")

pop()

Func botgui()

   #Region ### START Koda GUI section ### Form=C:\Users\Qiku\Desktop\autoit gui\Forms\Bot.kxf
   $Bot = GUICreate("Bot by Qiku v2 rev 1", 232, 222, 1486, 46)
   $Runeon = GUICtrlCreateCheckbox("Runemaker on", 128, 32, 73, 25)
   $RuneLabel = GUICtrlCreateLabel("Runemaker", 40, 8, 60, 17)
   $ManaInput = GUICtrlCreateInput("300", 40, 64, 57, 21)
   $RunemakerInput = GUICtrlCreateInput("{f12}", 40, 32, 57, 21)
   $AimlockLabel = GUICtrlCreateLabel("Aimlock", 40, 104, 36, 17)
   $Aimlockon = GUICtrlCreateCheckbox("Aimlock on", 128, 96, 73, 25)
   $ManaLabel = GUICtrlCreateLabel("Mana", 128, 64, 36, 17)
   $Manacurr = GUICtrlCreateLabel("0", 168, 64, 36, 17)
   $Afkon = GUICtrlCreateCheckbox("Anti Afk", 128, 8, 57, 25)
   $HealLab = GUICtrlCreateLabel("Auto heal", 40, 136, 49, 17)
   $Healon = GUICtrlCreateCheckbox("Heal on", 128, 128, 73, 25)
   $HealSpellIn = GUICtrlCreateInput("{f3}", 40, 160, 49, 21)
   $HealMana = GUICtrlCreateInput("80", 128, 160, 49, 21)
   $HealHp = GUICtrlCreateInput("250", 40, 180, 49, 21)
   $Hotk = GUICtrlCreateLabel("Hotk", 8, 32, 27, 17)
   $Label1 = GUICtrlCreateLabel("Mana", 8, 64, 31, 17)
   $Label2 = GUICtrlCreateLabel("Hotk", 8, 160, 27, 17)
   $Label3 = GUICtrlCreateLabel("Hp", 8, 184, 31, 17)
   $Label4 = GUICtrlCreateLabel("Mana", 95, 160, 33, 17)
   $UhOn = GUICtrlCreateCheckbox("Manasek on", 128, 184, 65, 17)
   $foodxy = GUICtrlCreateButton("foodxy", 184, 8, 41, 25)
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

	    Case $Aimlockon
			If _IsChecked($Aimlockon) Then
			   $id2 = _Timer_SetTimer($Bot,100,"aim")
			Else
			   _Timer_KillTimer($Bot,$id2)
			EndIf

	    Case $Afkon
			If _IsChecked($Afkon) Then
			   $id3 = _Timer_SetTimer($Bot,20000,"afk")
			Else
			   _Timer_KillTimer($Bot,$id3)
			EndIf

		 Case $Healon
			If _IsChecked($Healon) Then
			   $id4 = _Timer_SetTimer($Bot,100,"heal")
			Else
			   _Timer_KillTimer($Bot,$id4)
			EndIf

	     Case $UhOn
			If _IsChecked($UhOn) Then
			   $id5 = _Timer_SetTimer($Bot,1000,"uh")
			Else
			   _Timer_KillTimer($Bot,$id5)
			EndIf
	     Case $foodxy
			mousepos()

	EndSwitch
 WEnd

EndFunc

;hotkeye

Func uhxy()
	  $uhx = MouseGetPos(0)
	  $uhy = MouseGetPos(1)
EndFunc

Func playerxy()
	  $playerx = MouseGetPos(0)
	  $playery = MouseGetPos(1)
EndFunc

;funkcja ischeckbox

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
 EndFunc

;funkcje botowe

func aim($1,$2,$3,$4)

	_MemoryWrite(0x0071C5E8,$memory,7)

EndFunc

func afk($1,$2,$3,$4)

    $clientname = guictrlread($hWnd)
	;controlsend($clientname,"","","{ctrldown}{left}{ctrlup}")
	;controlsend($clientname,"","","{ctrldown}{down}{ctrlup}")

EndFunc

 func rune($1,$2,$3,$4)
	$spellname = guictrlread($RunemakerInput)
	$clientname = $hWnd
	$manaclient = guictrlread($ManaInput)
	$mana = _MemoryRead(0x005C682C,$memory)
	$handle = WinGetHandle($clientname, "")

    GUICtrlSetData($Manacurr,$mana)
	  if $mana >= $manaclient Then

		controlsend($clientname,"","",$spellname)
		Sleep(200)
		ControlClick($handle,"","","right",1,$foodx,$foody)
		ControlClick($handle,"","","right",1,$foodx,$foody)
		ControlClick($handle,"","","right",1,$foodx,$foody)
		ControlClick($handle,"","","right",1,$foodx,$foody)

		ConsoleWrite(" ")
		ConsoleWrite($clientname)
		ConsoleWrite("Mouse Button Pressed" & @CRLF & "X=" & $foodx & @CRLF & "Y=" & $foody & @CRLF)


	  EndIf

EndFunc

 func heal($1,$2,$3,$4)
	$spellname = guictrlread($HealSpellIn)

	$clientname = $hWnd
	$healmana1 = GUICtrlRead($HealMana)
	$hpheal1 = guictrlread($HealHp)

	$mana = _MemoryRead(0x005C682C,$memory)
	$hp = _MemoryRead(0x005C6848,$memory)


	  if $mana >= $healmana1 Then
		 if $hp <= $hpheal1 Then

			controlsend($clientname,"","",$spellname)

			ConsoleWrite("healing ")

		 EndIf
	  EndIf

EndFunc

func uh($1,$2,$3,$4)
	$clientname = $hWnd
	$hpheal1 = guictrlread($HealHp)
	$handle = WinGetHandle($clientname, "")

	$healmana1 = GUICtrlRead($HealMana)

	$hp = _MemoryRead(0x005C6848,$memory)
    $mana = _MemoryRead(0x005C682C,$memory)

		 if $mana <= $healmana1 Then

			ControlClick($handle,"","","right",1,$uhx,$uhy)
			Sleep(200)
			ControlClick($handle,"","","left",1,$playerx,$playery)
			ConsoleWrite($uhx)
			ConsoleWrite("/")
			ConsoleWrite($uhy)
			ConsoleWrite(" ")

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














