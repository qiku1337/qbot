Func pop()
   #Region ### START Koda GUI section ### Form=C:\Users\Qiku\Desktop\autoit gui\Forms\Pop.kxf
   $Pop = GUICreate("Select client", 148, 181, 1486, 46)
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
			$pid = ProcessExists($clientname)
			$memory = _MemoryOpen($pid)
			$name = $NameLab
	        GUISetState(@SW_HIDE)
			botgui()
		Else

		   MsgBox(NULL,"Error", "Cos sie zjebalo")

	    EndIf
	EndSwitch
 WEnd
 EndFunc