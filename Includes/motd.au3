func motd()
	MsgBox($MB_OK,"Messege of the day","MOTD: " & getmotd() & @CRLF & @CRLF & "Licence day left: "&$licenceday)
EndFunc