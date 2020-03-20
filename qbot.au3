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
#include <ComboConstants.au3>
#include <Process.au3>
#include <mouse.au3>


#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_icon=qbot.ico
#RequireAdmin
;#NoTrayIcon

HotKeySet("{PAUSE}", "KILL")
global $dll = DllOpen("user32.dll")

;$l = _Timer_Init()
global $pid,$memory_g,$name,$RunemakerInput,$ManaInput,$HealSpellIn,$HealMana,$Manacurr,$handle,$HpInput,$Hpcurr,$HealHot,$Manaheal,$Capcurr,$Battlecurr
global $mx,$my,$aim1x,$aim1y,$foodx,$foody,$spearx,$speary,$manasx,$manasy,$trainx,$trainy,$sdx,$sdy,$fishx,$fishy,$wedkax,$wedkay,$handx,$handy
global $id4,$Bot,$namelab,$watchon,$Slider1,$color,$fishsqm
global $reccnt = 0,$reconnectmin

pop()

Func KILL()
    Exit 0
EndFunc

Func botgui()

#Region ### START Koda GUI section ### Form=
	  $Bot = GUICreate("Qbot V4.1", 213, 320, 0, 60)
	  $Ramka = GUICtrlCreateTab(2, 2, 210, 310)
	  GUICtrlCreateTabItem("Runes")
	  $butinfo2 = GUICtrlCreateButton("?", 175, 3, 20, 20, $BS_CENTER)

	  $NameLabel = GUICtrlCreateLabel("Name", 20, 27, 56, 17)
	  $namelab = GUICtrlCreateLabel("???", 60, 27, 188, 17)
	  $hplabel = GUICtrlCreateLabel("Hp", 21, 45, 31, 17)
	  $Hpcurr = GUICtrlCreateLabel("0", 58, 45, 36, 17)
	  $manalabel = GUICtrlCreateLabel("Mana", 20, 61, 31, 17)
	  $Manacurr = GUICtrlCreateLabel("0", 58, 61, 28, 17)
	  $caplabel = GUICtrlCreateLabel("Cap", 91, 45, 31, 17)
	  $Capcurr = GUICtrlCreateLabel("0", 118, 45, 36, 17)
	  $battlelabel = GUICtrlCreateLabel("Screen player +2sqm", 151, 45, 33, 39)
	  $Battlecurr = GUICtrlCreateLabel("0", 188, 45, 36, 17)

	  $Label3 = GUICtrlCreateLabel("Healbot", 91, 69, 68, 17)
	  $HpInput = GUICtrlCreateInput("300", 20, 82, 32, 22)
	  $Manaheal = GUICtrlCreateInput("25", 20, 102, 32, 22)
	  $HealHot = GUICtrlCreateCombo("", 60, 90, 50, 25)
	  GUICtrlSetData(-1, "{f1}|{f2}|{f3}|{f4}|{f5}|{f6}|{f7}|{f8}|{f9}|{f10}|{f11}|{f12}")
	  $Healon = GUICtrlCreateCheckbox("Healer On", 124, 87, 73, 25)


	  $RuneLabel = GUICtrlCreateLabel("Runemaker", 68, 127, 68, 17)
	  $ManaLabel = GUICtrlCreateLabel("Mana to cast + hotkey", 44, 141, 108, 17)
	  $ManaInput = GUICtrlCreateInput("100", 20, 164, 32, 22)
	  $RunemakerInput = GUICtrlCreateCombo("", 60, 164, 50, 25)
	  GUICtrlSetData(-1, "{f1}|{f2}|{f3}|{f4}|{f5}|{f6}|{f7}|{f8}|{f9}|{f10}|{f11}|{f12}")
      $Runeon = GUICtrlCreateCheckbox("Runemaker on", 124, 161, 73, 25)

	  $Afkon = GUICtrlCreateCheckbox("Anti Afk", 124, 229, 60, 17)
	  $Afkon2 = GUICtrlCreateCheckbox("Anti Afk2", 124, 249, 60, 17)

	  $watchon = GUICtrlCreateCheckbox("Player on battle logout", 20, 210, 159, 17)
	  $reconnecton = GUICtrlCreateCheckbox("Reconnect", 20, 230, 70, 17)
	  $reconnectmin = GUICtrlCreateInput("5", 95, 230, 20, 20)
	  $foodbut = GUICtrlCreateButton("Food xy", 18, 190, 93, 17)
	  $fishingbut = GUICtrlCreateButton("Fishing xy", 18, 250, 50, 17)
	  $wedkabut = GUICtrlCreateButton("Wedka xy", 67, 250, 53, 17)
	  $eatfoodcheck = GUICtrlCreateCheckbox("Eat food", 124, 190, 73, 17)
	  $fishingon = GUICtrlCreateCheckbox("Fish zasieg", 18, 270, 73, 17)
	  $fishsqm = GUICtrlCreateInput("1", 95, 270, 20, 20)

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
	  $trainon = GUICtrlCreateCheckbox("Auto target on", 84, 36, 85, 17)
	  $handxy = GUICtrlCreateButton("Hand xy", 4, 65, 73, 25)
	  $labeltrain = GUICtrlCreateLabel("Podnos spear co", 4, 90, 90, 18)
	  $podnospearcheck = GUICtrlCreateCheckbox("sec", 120, 90, 90, 18)
	  $spearpickdel = GUICtrlCreateInput("10", 90, 87, 20, 20)

	  GUICtrlCreateTabItem("")
	  GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


WinSetOnTop($Bot, "", 1)

$id0 = _Timer_SetTimer($Bot,100,"name")
$id99 = _Timer_SetTimer($Bot,1000,"nameupdate")

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
			$id5 = _Timer_SetTimer($Bot,1000*15,"eatfood")
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
			$id7 = _Timer_SetTimer($Bot,2000,"train")
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

	  Case $podnospearcheck
		 If _IsChecked($podnospearcheck) Then
			$id10 = _Timer_SetTimer($Bot,guictrlread($spearpickdel)*1000,"autospear")
		 Else
			_Timer_KillTimer($Bot,$id10)
		 EndIf

	  Case $reconnecton
		 If _IsChecked($reconnecton) Then
			$id11 = _Timer_SetTimer($Bot,1000,"reconnect")
		 Else
			_Timer_KillTimer($Bot,$id11)
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

	  Case $handxy
		 mouseposhand()

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
   global $name = _MemoryPointerRead($namefinal, $memory_g, $name_offset,"char[20]")

   $finalADDR = "0x" & hex($base_adr+$mana_static)
   global $mana_global = _MemoryPointerRead($finalADDR, $memory_g, $mana_offset,"double")

   $finalADDRh = "0x" & hex($base_adr+$hp_static)
   global $hp_global = _MemoryPointerRead($finalADDRh, $memory_g, $hp_offset,"double")

   $finalADDRcap = "0x" & hex($base_adr+$cap_static)
   global $cap_global = _MemoryPointerRead($finalADDRcap, $memory_g, $cap_offset,"double")

   $finalADDRbat = "0x" & hex($base_adr+$battle_static)
   global $battleval_global = _MemoryPointerRead($finalADDRbat, $memory_g, $battle_offset)

   $finalADDRlogin = "0x" & hex($base_adr+$iflogin_static)
   global $islogin_global = _MemoryPointerRead($finalADDRlogin, $memory_g, $iflogin_offset)
EndFunc

func nameupdate($1,$2,$3,$4)
   GUICtrlSetData($Manacurr,$mana_global[1])
   GUICtrlSetData($Hpcurr, $hp_global[1])
   If $islogin_global[1] == 0 Then
	  GUICtrlSetData($namelab,"Disconnected")
   Else
	  GUICtrlSetData($namelab,$name[1])
   EndIf
   GUICtrlSetData($Capcurr,$cap_global[1])
   $bval = $battleval_global[1]   ;($battleval_global[1]-420)/22
   GUICtrlSetData($Battlecurr,$bval)
EndFunc

Func autospear($1,$2,$3,$4)
	  _MouseDragPlus($hwnd,"left",$trainx,$trainy,$handx,$handy)
	  controlsend($hWnd,"","","{enter}")
EndFunc

Func eatfood($1,$2,$3,$4)
	  _MouseClickPlus($hwnd,"right",$foodx,$foody,1)
EndFunc

func light($1,$2,$3,$4)
   $finalADDR = "0x" & hex($base_adr+$light_static)
   _MemoryPointerWrite($finalADDR, $memory_g, $light_offset, 55060)
EndFunc

func watch($1,$2,$3,$4)
	  if ($battleval_global[1]>1) Then
		 controlsend($hWnd,"","","{ctrldown}{q}{ctrlup}")
		 SoundPlay(@WindowsDir & "\media\tada.wav", 1)
		 ;GUICtrlSetState($watchon,$GUI_UNCHECKED)
		 ;_Timer_KillTimer($Bot,$id4)
		 unstuck()
	  EndIf
   EndFunc

func reconnect($1,$2,$3,$4)
	  ;0 albo 257
	  ConsoleWrite($reccnt&@LF)
	  If $islogin_global[1] == 0 Then
		 $reccnt = $reccnt+1
		 If $reccnt >= guictrlread($reconnectmin)*60 Then
			ControlSend($hWnd,"","","{enter}")
		 EndIf
	  Else
		 $reccnt = 0
	  EndIf
EndFunc

func afk($1,$2,$3,$4)
   ControlSend($hWnd,"","","{CTRLdown}{UP}{CTRLUP}")
   Sleep(10)
   ControlSend($hWnd,"","","{CTRLdown}{down}{CTRLUP}")

   unstuck()
EndFunc

func afk2($1,$2,$3,$4)

   WinActivate($hWnd)
   Send("^{UP}")
   Send("^{DOWN}")

EndFunc

func fishing($1,$2,$3,$4)
	  $range = guictrlread($fishsqm)*50
	  If $cap_global[1] >= 6 Then
		 _MouseClickPlus($hwnd,"right",$wedkax,$wedkay,1)
		 Sleep(5)
		 _MouseClickPlus($hwnd,"left",Round($fishx+Random($range*-1, $range)),Round($fishy+Random($range*-1, $range)),1)
	  EndIf
EndFunc

func rune($1,$2,$3,$4)
   $manaclient = guictrlread($ManaInput)
	  if $mana_global[1] >= $manaclient Then
		 $spellname = guictrlread($RunemakerInput)
		 controlsend($hWnd,"","",$spellname)
	  EndIf
EndFunc

func healer($1,$2,$3,$4)
   $hpclient = guictrlread($HpInput)
   $manaclient = guictrlread($Manaheal)
	  if $hp_global[1] <= $hpclient And $mana_global[1] >= $manaclient Then
		 $spellname = guictrlread($HealHot)
		 controlsend($hWnd,"","",$spellname)
	  EndIf
EndFunc

func train($1,$2,$3,$4)

   $finalADDR = "0x" & hex($base_adr+$ifattack_static)
   $ifattack = _MemoryPointerRead($finalADDR, $memory_g, $ifattack_offset)
   if $ifattack[1] == 0 Then
	  _MouseClickPlus($hwnd,"right",$trainx,$trainy,1)
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

Func mouseposhand()
   While 1
    Sleep(10) ; This enough to prevent CPU overload <<<<<<<<<<<<<<<<<<<<<<<<
    If _IsPressed("01", $dll) Then
        $handx = MouseGetPos(0)
		$handy = MouseGetPos(1)
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

