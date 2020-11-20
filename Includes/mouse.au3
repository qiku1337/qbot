;===============================================================================

;
; Function Name:  _MouseClickPlus()
; Version added:  0.1
; Description:  Sends a click to window, not entirely accurate, but works
;                minimized.
; Parameter(s):   $Window    =  Title of the window to send click to
;                $Button     =  "left" or "right" mouse button
;                $X       =  X coordinate
;                $Y       =  Y coordinate
;                $Clicks     =  Number of clicks to send
; Remarks:      You MUST be in "MouseCoordMode" 0 to use this without bugs.
; Author(s):      Insolence <insolence_9@yahoo.com>
;
;==============================================================================

Func _MouseClickPlus($handle, $Button = "left", $X = "", $Y = "", $Clicks = 1)
  opt("MouseCoordMode", 1)
  Local $MK_LBUTTON    =  0x0001
  Local $WM_LBUTTONDOWN   =  0x0201
  Local $WM_LBUTTONUP    =  0x0202

  Local $MK_RBUTTON    =  0x0002
  Local $WM_RBUTTONDOWN   =  0x0204
  Local $WM_RBUTTONUP    =  0x0205

  Local $WM_MOUSEMOVE    =  0x0200

  Local $i              = 0
  Local $user32 = DllOpen("user32.dll")

  Select
  Case $Button = "left"
     $Button     =  $MK_LBUTTON
     $ButtonDown =  $WM_LBUTTONDOWN
     $ButtonUp   =  $WM_LBUTTONUP
  Case $Button = "right"
     $Button     =  $MK_RBUTTON
     $ButtonDown =  $WM_RBUTTONDOWN
     $ButtonUp   =  $WM_RBUTTONUP
  EndSelect

  If $X = "" OR $Y = "" Then
	  ;ConsoleWrite("NULLE")
  EndIf
  For $i = 1 to $Clicks
	 local $mxy = MouseGetPos()
	 _MouseTrap($mxy[0],$mxy[1])
     DllCall($user32, "int", "SendMessage", "hwnd",$handle, "int", $WM_MOUSEMOVE, "int", 0, "long", _MakeLong($X-5, $Y-30))
	 Sleep(1)
	 DllCall($user32, "int", "SendMessage", "hwnd",$handle, "int", $WM_MOUSEMOVE, "int", 0, "long", _MakeLong($X-5, $Y-30))
	 Sleep(1)
     DllCall($user32, "int", "SendMessage", "hwnd", $handle, "int", $ButtonDown, "int", $Button, "long", _MakeLong($X-5, $Y-30))
     DllCall($user32, "int", "SendMessage", "hwnd", $handle,  "int", $ButtonUp, "int", $Button, "long", _MakeLong($X-5, $Y-30))
     _MouseTrap()
      ;MouseMove($mxy[0],$mxy[1],1)
   Next
   DllClose($user32)
EndFunc

Func _MouseClickPlusW($handle, $Button = "left", $X = "", $Y = "", $Clicks = 1)
  opt("MouseCoordMode", 1)
  Local $MK_LBUTTON    =  0x0001
  Local $WM_LBUTTONDOWN   =  0x0201
  Local $WM_LBUTTONUP    =  0x0202

  Local $MK_RBUTTON    =  0x0002
  Local $WM_RBUTTONDOWN   =  0x0204
  Local $WM_RBUTTONUP    =  0x0205

  Local $WM_MOUSEMOVE    =  0x0200

  Local $i              = 0
  Local $user32 = DllOpen("user32.dll")

  Select
  Case $Button = "left"
     $Button     =  $MK_LBUTTON
     $ButtonDown =  $WM_LBUTTONDOWN
     $ButtonUp   =  $WM_LBUTTONUP
  Case $Button = "right"
     $Button     =  $MK_RBUTTON
     $ButtonDown =  $WM_RBUTTONDOWN
     $ButtonUp   =  $WM_RBUTTONUP
  EndSelect

  If $X = "" OR $Y = "" Then
	  ;ConsoleWrite("NULLE")
  EndIf
  For $i = 1 to $Clicks
     DllCall($user32, "int", "SendMessage", "hwnd",$handle, "int", $WM_MOUSEMOVE, "int", 0, "long", _MakeLong($X-5, $Y-30))
	 Sleep(1)
	 DllCall($user32, "int", "SendMessage", "hwnd",$handle, "int", $WM_MOUSEMOVE, "int", 0, "long", _MakeLong($X-5, $Y-30))
	 Sleep(1)
     DllCall($user32, "int", "SendMessage", "hwnd", $handle, "int", $ButtonDown, "int", $Button, "long", _MakeLong($X-5, $Y-30))
     DllCall($user32, "int", "SendMessage", "hwnd", $handle,  "int", $ButtonUp, "int", $Button, "long", _MakeLong($X-5, $Y-30))
   Next
   DllClose($user32)
EndFunc

Func _MouseDragPlus($handle, $Button = "left", $X = "", $Y = "", $X2 = "", $Y2 = "")
  opt("MouseCoordMode", 1)
  Local $MK_LBUTTON    =  0x0001
  Local $WM_LBUTTONDOWN   =  0x0201
  Local $WM_LBUTTONUP    =  0x0202

  Local $MK_RBUTTON    =  0x0002
  Local $WM_RBUTTONDOWN   =  0x0204
  Local $WM_RBUTTONUP    =  0x0205

  Local $WM_MOUSEMOVE    =  0x0200

  Local $i              = 0
  Local $user32 = DllOpen("user32.dll")

  Select
  Case $Button = "left"
     $Button     =  $MK_LBUTTON
     $ButtonDown =  $WM_LBUTTONDOWN
     $ButtonUp   =  $WM_LBUTTONUP
  Case $Button = "right"
     $Button     =  $MK_RBUTTON
     $ButtonDown =  $WM_RBUTTONDOWN
     $ButtonUp   =  $WM_RBUTTONUP
  EndSelect

  If $X = "" OR $Y = "" Then
     ;ConsoleWrite("NULLE")
  EndIf
    local $mxy = MouseGetPos()
	 _MouseTrap($mxy[0],$mxy[1])
     DllCall($user32, "int", "SendMessage", "hwnd",$handle, "int", $WM_MOUSEMOVE, "int", 0, "long", _MakeLong($X-5, $Y-25))
     DllCall($user32, "int", "SendMessage", "hwnd", $handle, "int", $ButtonDown, "int", $Button, "long", _MakeLong($X-5, $Y-25))

	 DllCall($user32, "int", "SendMessage", "hwnd",$handle, "int", $WM_MOUSEMOVE, "int", 0, "long", _MakeLong($X2-5, $Y2-25))
     DllCall($user32, "int", "SendMessage", "hwnd", $handle,  "int", $ButtonUp, "int", $Button, "long", _MakeLong($X2-5, $Y2-25))
	 DllClose($user32)
	_MouseTrap()
EndFunc

Func _MouseDragPlusW($handle, $Button = "left", $X = "", $Y = "", $X2 = "", $Y2 = "")
  opt("MouseCoordMode", 1)
  Local $MK_LBUTTON    =  0x0001
  Local $WM_LBUTTONDOWN   =  0x0201
  Local $WM_LBUTTONUP    =  0x0202

  Local $MK_RBUTTON    =  0x0002
  Local $WM_RBUTTONDOWN   =  0x0204
  Local $WM_RBUTTONUP    =  0x0205

  Local $WM_MOUSEMOVE    =  0x0200

  Local $i              = 0
  Local $user32 = DllOpen("user32.dll")

  Select
  Case $Button = "left"
     $Button     =  $MK_LBUTTON
     $ButtonDown =  $WM_LBUTTONDOWN
     $ButtonUp   =  $WM_LBUTTONUP
  Case $Button = "right"
     $Button     =  $MK_RBUTTON
     $ButtonDown =  $WM_RBUTTONDOWN
     $ButtonUp   =  $WM_RBUTTONUP
  EndSelect

  If $X = "" OR $Y = "" Then
     ;ConsoleWrite("NULLE")
  EndIf
     DllCall($user32, "int", "SendMessage", "hwnd",$handle, "int", $WM_MOUSEMOVE, "int", 0, "long", _MakeLong($X-5, $Y-25))
     DllCall($user32, "int", "SendMessage", "hwnd", $handle, "int", $ButtonDown, "int", $Button, "long", _MakeLong($X-5, $Y-25))

	 DllCall($user32, "int", "SendMessage", "hwnd",$handle, "int", $WM_MOUSEMOVE, "int", 0, "long", _MakeLong($X2-5, $Y2-25))
     DllCall($user32, "int", "SendMessage", "hwnd", $handle,  "int", $ButtonUp, "int", $Button, "long", _MakeLong($X2-5, $Y2-25))
	 DllClose($user32)
EndFunc

Func _MakeLong($LoWord,$HiWord)
  Return BitOR($HiWord * 0x10000, BitAND($LoWord, 0xFFFF))
EndFunc

Func KeySend($handle, $inkey, $evt = "pressed", $kdown = 50)

Local $user32 = DllOpen("user32.dll")
If $user32 = -1 Then
	ConsoleWrite("KeySend: cannot open user32.dll")
	Exit
EndIf
If $inkey == "" Then
	Return null
	;$inkey = ""
EndIf

; handling for special keys
Switch StringUpper($inkey)
	Case "@"
		$skey = 0x40
		$lparam = 0x00100001
		DllCall($user32, "int", "PostMessage", "hwnd", $handle, "int", $WM_KEYDOWN, "int", 0x71, "long", $lparam)
		DllCall($user32, "int", "PostMessage", "hwnd", $handle, "int", $WM_CHAR, "int", $skey, "long", $lparam)
		Sleep(20)
		DllCall($user32, "int", "PostMessage", "hwnd", $handle, "int", $WM_KEYUP, "int", 0x71, "long", BitOR($lparam, 0xC0000000))
	Case "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12"
		$skey = 0x6f + Int(StringMid($inkey, 2))
		ContinueCase
	Case "NUM0", "NUM1", "NUM2", "NUM3", "NUM4", "NUM5", "NUM6", "NUM7", "NUM8", "NUM9"
		If StringUpper(StringLeft($inkey, 3)) = "NUM" Then
			$skey = 0x60 + Int(StringMid($inkey, 4))
		EndIf
		ContinueCase
	Case "RETURN", "SPACE", "TAB", "BACK", "END", "HOME", "SNAPSHOT", "INSERT", "DELETE", "LEFT", "RIGHT", "UP", "DOWN"
		Switch StringUpper($inkey)
			Case "RETURN"
				$skey = 0x0D
			Case "SPACE"
				$skey = 0x20
			Case "TAB"
				$skey = 0x09
			Case "BACK"
				$skey = 0x08
			Case "END"
				$skey = 0x23
			Case "HOME"
				$skey = 0x24
			Case "SNAPSHOT"
				$skey = 0x2c
			Case "INSERT"
				$skey = 0x2d
			Case "DELETE"
				$skey = 0x2e
			Case "LEFT"
				$skey = 0x25
			Case "RIGHT"
				$skey = 0x27
			Case "UP"
				$skey = 0x26
			Case "DOWN"
				$skey = 0x28
			Case " "
				ConsoleWrite("KUPA")

		EndSwitch
		$ret = DllCall($user32, "int", "MapVirtualKey", "int", $skey, "int", 0)
		$lparam = BitShift($ret[0], -16)
		$lparam = BitOR($lparam, 1)
		DllCall($user32, "int", "PostMessage", "hwnd", $handle, "int", $WM_KEYDOWN, "int", $skey, "long", $lparam)
		Sleep($kdown)
		DllCall($user32, "int", "PostMessage", "hwnd", $handle, "int", $WM_KEYUP, "int", $skey, "long", BitOR($lparam, 0xC0000000))
	Case Else ; default lower case key handling
		$key = DllCall($user32, "int", "VkKeyScan", "int", Asc(StringLower($inkey)))
		$skey = $key[0]
		$ret = DllCall($user32, "int", "MapVirtualKey", "int", $skey, "int", 0)
		$lparam = BitShift($ret[0], -16)
		$lparam = BitOR($lparam, 1)
		Select
			Case $evt = "pressed"
				DllCall($user32, "int", "PostMessage", "hwnd", $handle, "int", $WM_KEYDOWN, "int", $skey, "long", $lparam)
				Sleep($kdown)
				DllCall($user32, "int", "PostMessage", "hwnd", $handle, "int", $WM_KEYUP, "int", $skey, "long", BitOR($lparam, 0xC0000000))
			Case $evt = "down"
				DllCall($user32, "int", "PostMessage", "hwnd", $handle, "int", $WM_KEYDOWN, "int", $skey, "long", $lparam)
			Case $evt = "up"
				DllCall($user32, "int", "PostMessage", "hwnd", $handle, "int", $WM_KEYUP, "int", $skey, "long", BitOR($lparam, 0xC0000000))
		EndSelect
EndSwitch

DllClose($user32)
EndFunc   ;==>KeySend
;----testing the function
;sleep(5000)
;_MouseClickPlus("Unbenannt - Editor", "left",1468,571,1)