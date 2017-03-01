#include <MsgBoxConstants.au3>
global $NameExeIn, $List1, $hWnd, $foodx, $foody
Func pop()
   #Region ### START Koda GUI section ### Form=
   $Pop = GUICreate("Select client", 152, 257, 1486, 46)
   $NameLabExe = GUICtrlCreateLabel("Client Exe", 32, 56, 61, 17)
   $NameExeIn = GUICtrlCreateInput("Tibia.exe", 32, 80, 81, 21)
   $OkBut = GUICtrlCreateButton("OK", 16, 216, 113, 25)
   $bclientl = GUICtrlCreateButton("Click check clients id", 16, 8, 113, 41)
   $List1 = GUICtrlCreateList("", 16, 112, 113, 97)
   GUICtrlSetData(-1, "")
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
			$pid = ControlCommand($Pop, "", $List1, "GetCurrentSelection")
			$memory = _MemoryOpen($pid)
			$hWnd = _GetHwndFromPID($pid)

	        GUISetState(@SW_HIDE)
			botgui()
		Else

		   MsgBox(NULL,"Error", "Cos sie zjebalo")

	    EndIf
     Case $bclientl
		   GUICtrlSetData($List1, "")
		   checkid()
	EndSwitch
 WEnd
 EndFunc


Func checkid()
    $aProcessList = ProcessList(GUICtrlRead($NameExeIn))
    For $i = 1 To $aProcessList[0][0]
		GUICtrlSetData($List1, $aProcessList[$i][1])
	  Next
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

