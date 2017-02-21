#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <nomad.au3>
#include <Timers.au3>

$l = _Timer_Init()
global $pid,$memory,$name,$RunemakerInput,$ManaInput,$NameIn,$HealSpellIn,$HealMana,$HealHp

Func pop()
   #Region ### START Koda GUI section ### Form=C:\Users\Qiku\Desktop\autoit gui\Forms\Pop.kxf
   $Pop = GUICreate("pop", 148, 181, 1486, 46)
   $NameLabExe = GUICtrlCreateLabel("Client Exe", 32, 16, 61, 17)
   $NameExeIn = GUICtrlCreateInput("Dolnera.exe", 32, 40, 81, 21)
   $OkBut = GUICtrlCreateButton("OK", 16, 136, 113, 25)
   $NameLab = GUICtrlCreateLabel("Client Name", 32, 72, 61, 17)
   $NameIn = GUICtrlCreateInput("Dolnera", 32, 96, 81, 21)
   GUISetState(@SW_SHOW)
   #EndRegion ### END Koda GUI section ###

   While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
	   Case $GUI_EVENT_CLOSE
			Exit

	 Case $OkBut
	    $clientname = GUICtrlRead($NameExeIn)

		if ProcessExists($clientname) Then
		   ConsoleWrite("tak")
		Else
		   ConsoleWrite ("nie")
	    EndIf

	   $pid = ProcessExists($clientname)
	   $memory = _MemoryOpen($pid)
	   $name = $NameLab

	   GUISetState(@SW_HIDE)
	   botgui()
	EndSwitch
 WEnd
 EndFunc

 pop()

Func botgui()

   #Region ### START Koda GUI section ### Form=
   $Bot = GUICreate("Bot by Qiku v2 rev 1", 230, 220, 1486, 46)
   $Runeon = GUICtrlCreateCheckbox("Runemaker on", 128, 32, 73, 25)
   $RuneLabel = GUICtrlCreateLabel("Runemaker", 40, 8, 60, 17)
   $ManaInput = GUICtrlCreateInput("300", 40, 64, 57, 21)
   $RunemakerInput = GUICtrlCreateInput("{f12}", 40, 32, 57, 21)
   $AimlockLabel = GUICtrlCreateLabel("Aimlock", 48, 104, 36, 17)
   $Aimlockon = GUICtrlCreateCheckbox("Aimlock on", 128, 96, 73, 25)
   $ManaLabel = GUICtrlCreateLabel("Mana", 120, 64, 36, 17)
   $Manacurr = GUICtrlCreateLabel("0", 160, 64, 36, 17)
   $Afkon = GUICtrlCreateCheckbox("Anti Afk", 128, 8, 73, 25)
   $HealLab = GUICtrlCreateLabel("Auto heal", 48, 136, 49, 17)
   $Healon = GUICtrlCreateCheckbox("Heal on", 128, 128, 73, 25)
   $HealSpellIn = GUICtrlCreateInput("{f3}", 48, 160, 49, 21)
   $HealMana = GUICtrlCreateInput("80", 128, 160, 49, 21)
   $HealHp = GUICtrlCreateInput("250", 48, 180, 49, 25)
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
			   $id3 = _Timer_SetTimer($Bot,200,"afk")
			Else
			   _Timer_KillTimer($Bot,$id3)
			EndIf

		 Case $Healon
			If _IsChecked($Healon) Then
			   $id4 = _Timer_SetTimer($Bot,200,"heal")
			Else
			   _Timer_KillTimer($Bot,$id4)
			EndIf

	EndSwitch
 WEnd

EndFunc

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc

func aim($1,$2,$3,$4)

	_MemoryWrite(0x0071C5E8,$memory,7)

EndFunc

func afk($1,$2,$3,$4)

    $clientname = guictrlread($NameIn)
	controlsend($clientname,"","","{ctrldown}{left}{ctrlup}")
	controlsend($clientname,"","","{ctrldown}{down}{ctrlup}")

EndFunc

 func rune($1,$2,$3,$4)
	$spellname = guictrlread($RunemakerInput)
	$clientname = guictrlread($NameIn)
	$manaclient = guictrlread($ManaInput)
	$mana = _MemoryRead(0x005C682C,$memory)

	  if $mana >= $manaclient Then

		controlsend($clientname,"","",$spellname)

	  EndIf

EndFunc

 func heal($1,$2,$3,$4)
	$spellname = guictrlread($HealSpellIn)

	$clientname = guictrlread($NameIn)
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














