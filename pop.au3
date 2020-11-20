#include <WinAPIDiag.au3>
#include <Crypt.au3>

global $List1, $List2, $hWnd
global $ots
global $clientexe_global, $key_global,$NameExeIn2, $hardid

Func pop()

#Region ### START Koda GUI section ### Form=
		$Pop = GUICreate("QBOT Select Client", 180, 368, 0, 60)
		global $NameExeIn = GUICtrlCreateCombo("Select ots", 24, 8, 129, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))

		If $ver == "74" Then
			GUICtrlSetData(-1, "OLDtibia74|Realesta7.4|Nostalrius7.4|WeAreTibia7.4|WeAreTibia7.4_OGL")
		ElseIf $ver == "80" Then
			GUICtrlSetData(-1, "Realera8.0|Kasteria/Askara8.0")
		EndIf

		$OkBut = GUICtrlCreateButton("OK", 24, 324, 129, 25)
		$bclientl = GUICtrlCreateButton("Click for check clients id", 24, 296, 129, 25, $BS_CENTER)
		$butinfo1 = GUICtrlCreateButton("?", 155, 8, 20, 20, $BS_CENTER)
		$List1 = GUICtrlCreateList("", 24, 40, 129, 240)
		GUICtrlSetData(-1, "")
		GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

   While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
	   Case $GUI_EVENT_CLOSE
			Exit

	  Case $OkBut

		 $wybor = ControlCommand($Pop, "", $List1, "GetCurrentSelection")
		 if ProcessExists($wybor) Then
		    SetPrivilege("SeDebugPrivilege", 1)

			$pid = $wybor

			$kryProc = _Process_Open($pid)
			global $base_adr = _Process_GetBaseAddress($kryProc)
			$memory_g = _MemoryOpen($pid)
			$hWnd = _GetHwndFromPID($pid)
	        GUISetState(@SW_HIDE)
			botgui()
		Else

		   MsgBox(NULL,"Error", "Wybierz najpierw client ID!!")

	    EndIf
     Case $bclientl
		   GUICtrlSetData($List1, "")
		   checkid()

     Case $butinfo1
	    MsgBox($MB_OK,"Info","Najpierw kliknij check clients id, nastepnie zaznacz id clienta i przycisk ok")
	EndSwitch
 WEnd
 EndFunc

Func checkid()
   changeaddress()
   $aProcessList = ProcessList()
   For $i = 1 To $aProcessList[0][0]
	  If StringRegExp($aProcessList[$i][0], $NameExeIn2) Then
		  GUICtrlSetData($List1, $aProcessList[$i][1])
	  EndIf
	  ;If StringRegExp($list[$i][0], "^" & $sString & "\d+\.exe$") Then ProcessClose($list[$i][0])
   Next
EndFunc

Func changeaddress()
	;ConsoleWrite(GUICtrlRead($NameExeIn)&@CRLF)
	If GUICtrlRead($NameExeIn) == "Select ots" Then
		MsgBox($MB_OK,"Info","Wybierz otsa!!")
		$NameExeIn2 = "blank"
	EndIf
	If GUICtrlRead($NameExeIn) == "Realesta7.4" Then
		#include <Includes\Address\address_Realesta.au3>
		$NameExeIn2 = $clientexe_global
	EndIf
	If GUICtrlRead($NameExeIn) == "OLDtibia74" Then
		#include <Includes\Address\address_oldTibia.au3>
		$NameExeIn2 = $clientexe_global
	EndIf
	If GUICtrlRead($NameExeIn) == "Nostalrius7.4" Then
		#include <Includes\Address\address_nos.au3>
		$NameExeIn2 = $clientexe_global
	EndIf
	If GUICtrlRead($NameExeIn) == "WeAreTibia7.4" Then
		#include <Includes\Address\address_WAT.au3>
		$NameExeIn2 = $clientexe_global
	EndIf
	If GUICtrlRead($NameExeIn) == "WeAreTibia7.4_OGL" Then
		#include <Includes\Address\address_WAT_OGL.au3>
		$NameExeIn2 = $clientexe_global
	EndIf
	If GUICtrlRead($NameExeIn) == "Realera8.0" Then
		#include <Includes\Address\address_realera.au3>
		$NameExeIn2 = $clientexe_global
	EndIf
	If GUICtrlRead($NameExeIn) == "Kasteria/Askara8.0" Then
		#include <Includes\Address\address_Askara2.au3>
		$NameExeIn2 = $clientexe_global
	EndIf
EndFunc

Func _GetHwndFromPID($PID)
	$hWnd = 0
	$winlist = WinList()
	Do
		For $i = 1 To $winlist[0][0]
			If $winlist[$i][0] <> "" Then
				$iPID2 = WinGetProcess($winlist[$i][1])
				If $iPID2 = $PID Then
					$hWnd = $winlist[$i][1]
					ExitLoop
				EndIf
			EndIf
		Next
	Until $hWnd <> 0
	Return $hWnd
EndFunc

func checklic()
   $hardid   = _WinAPI_UniqueHardwareID(BitOR($UHID_MB, $UHID_CPU))
   $hardid = StringTrimLeft($hardid, 1)
   $hardid = StringTrimRight($hardid, 1)

   #Region ### START Koda GUI section ### Form=
	  $Pop1 = GUICreate("License key - DONT PANIC", 379, 144, 400, 300)
	  $hardid_s = GUICtrlCreateInput($hardid, 8, 8, 361, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
	  $Label1 = GUICtrlCreateLabel("This is your ID,copy it and contact with author to keep using bot", 8, 32, 356, 17, $SS_CENTER)
	  $Label2 = GUICtrlCreateLabel("To na gorze to Twoje ID, skopiuj je i wyślj na qiku00@gmail.com", 8, 56, 364, 17, $SS_CENTER)
	  $hardid_p = GUICtrlCreateInput(_loadconfig("serialkey"), 8, 80, 361, 21)
	  $Unlock = GUICtrlCreateButton("Unlock", 128, 112, 113, 25)
	  GUISetState(@SW_SHOW)
   #EndRegion ### END Koda GUI section ###

   While 1
   $nMsg = GUIGetMsg()
   Switch $nMsg
		 Case $GUI_EVENT_CLOSE
			Exit

	     Case $Unlock
			If GUICtrlRead($hardid_p) <> "" Then
			   $cypt_Key = _Crypt_DeriveKey(StringToBinary($key_global), $CALG_RC4)
			   $decrypted = _Crypt_DecryptData(GUICtrlRead($hardid_p), $cypt_Key, $CALG_USERKEY)
			   If BinaryToString($decrypted) == $hardid Then
				  ;ConsoleWrite("TRUE"&@CRLF)
				  GUISetState(@SW_HIDE)
				  _saveconfig($hardid_p,"serialkey")
				  pop()
			   Else
			      error97()
				  ;Exit 0
			   EndIf
			Else
			   error98()
			EndIf
   EndSwitch
WEnd
EndFunc

func checklic_day()
   $hardid   = _WinAPI_UniqueHardwareID(BitOR($UHID_MB, $UHID_CPU))
   $hardid = StringTrimLeft($hardid, 1)
   $hardid = StringTrimRight($hardid, 1)

   #Region ### START Koda GUI section ### Form=
	  $Pop1 = GUICreate("License check - DONT PANIC", 379, 110, 400, 300)
	  $hardid_s = GUICtrlCreateInput($hardid, 8, 8, 361, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY,$SS_CENTER))
	  $Label1 = GUICtrlCreateLabel("This is your ID,copy it and contact with author to keep using bot", 8, 32, 356, 17, $SS_CENTER)
	  $Label2 = GUICtrlCreateLabel("To na gorze to Twoje ID, skopiuj je i wyślj na qiku00@gmail.com", 8, 56, 364, 17, $SS_CENTER)
	  ;$hardid_p = GUICtrlCreateInput(_loadconfig("serialkey"), 8, 80, 361, 21)
	  $Unlock = GUICtrlCreateButton("Unlock", 128, 80, 113, 25)
	  GUISetState(@SW_SHOW)
   #EndRegion ### END Koda GUI section ###

   While 1
   $nMsg = GUIGetMsg()
   Switch $nMsg
		 Case $GUI_EVENT_CLOSE
			Exit

	   Case $Unlock
			If getlicence($hardid) >= 1 Then
			   GUISetState(@SW_HIDE)
			   pop()
			Else
			   error96()
			EndIf
   EndSwitch
WEnd
EndFunc



