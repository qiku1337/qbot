global $NameExeIn, $List1, $List2, $hWnd
Func pop()

#Region ### START Koda GUI section ### Form=
	  $Pop = GUICreate("QBOT Select Client", 179, 367, 0, 60)
	  $NameLabExe = GUICtrlCreateLabel("Client .exe name", 40, 56, 93, 17, $SS_CENTER)
	  $NameExeIn = GUICtrlCreateInput("RealestaDX9.exe", 24, 80, 129, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
	  $OkBut = GUICtrlCreateButton("OK", 24, 300, 129, 25)
	  $bclientl = GUICtrlCreateButton("Click for check clients id", 24, 8, 129, 41, $BS_CENTER)
	  $butinfo1 = GUICtrlCreateButton("?", 155, 8, 20, 20, $BS_CENTER)
	  $List1 = GUICtrlCreateList("", 24, 112, 129, 184)
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
   $aProcessList = ProcessList(GUICtrlRead($NameExeIn))
   For $i = 1 To $aProcessList[0][0]
	  GUICtrlSetData($List1, $aProcessList[$i][1])
	  ;GUICtrlSetData($List1, WinGetTitle(_GetHwndFromPID($aProcessList[$i][1])))
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

