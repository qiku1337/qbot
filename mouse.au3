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
;===============================================================================
;opt("MouseCoordMode", 0)


Func _MouseClickPlus($handle, $Button = "left", $X = "", $Y = "", $Clicks = 1)
  Local $MK_LBUTTON    =  0x0001
  Local $WM_LBUTTONDOWN   =  0x0201
  Local $WM_LBUTTONUP    =  0x0202

  Local $MK_RBUTTON    =  0x0002
  Local $WM_RBUTTONDOWN   =  0x0204
  Local $WM_RBUTTONUP    =  0x0205

  Local $WM_MOUSEMOVE    =  0x0200

  Local $i              = 0
  ;Local $dll = DllOpen("user32.dll")

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
     $MouseCoord = MouseGetPos()
     $X = $MouseCoord[0]
     $Y = $MouseCoord[1]
  EndIf
  For $i = 1 to $Clicks
	 local $mxy = MouseGetPos()
	 _MouseTrap($X,$Y)
     DllCall($dll, "int", "SendMessage", "hwnd",$handle, "int", $WM_MOUSEMOVE, "int", 0, "long", _MakeLong($X, $Y-25))


     DllCall($dll, "int", "SendMessage", "hwnd", $handle, "int", $ButtonDown, "int", $Button, "long", _MakeLong($X, $Y-25))
     DllCall($dll, "int", "SendMessage", "hwnd", $handle,  "int", $ButtonUp, "int", $Button, "long", _MakeLong($X, $Y-25))
	  _MouseTrap()
	   MouseMove($mxy[0],$mxy[1],1)
  Next
EndFunc

Func _MouseDragPlus($handle, $Button = "left", $X = "", $Y = "", $X2 = "", $Y2 = "")
  Local $MK_LBUTTON    =  0x0001
  Local $WM_LBUTTONDOWN   =  0x0201
  Local $WM_LBUTTONUP    =  0x0202

  Local $MK_RBUTTON    =  0x0002
  Local $WM_RBUTTONDOWN   =  0x0204
  Local $WM_RBUTTONUP    =  0x0205

  Local $WM_MOUSEMOVE    =  0x0200

  Local $i              = 0
  ;Local $dll = DllOpen("user32.dll")

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
     $MouseCoord = MouseGetPos()
     $X = $MouseCoord[0]
     $Y = $MouseCoord[1]
  EndIf
     DllCall($dll, "int", "SendMessage", "hwnd",$handle, "int", $WM_MOUSEMOVE, "int", 0, "long", _MakeLong($X-5, $Y-25))
     DllCall($dll, "int", "SendMessage", "hwnd", $handle, "int", $ButtonDown, "int", $Button, "long", _MakeLong($X-5, $Y-25))

	 DllCall($dll, "int", "SendMessage", "hwnd",$handle, "int", $WM_MOUSEMOVE, "int", 0, "long", _MakeLong($X2-5, $Y2-25))
     DllCall($dll, "int", "SendMessage", "hwnd", $handle,  "int", $ButtonUp, "int", $Button, "long", _MakeLong($X2-5, $Y2-25))
EndFunc

Func _MakeLong($LoWord,$HiWord)
  Return BitOR($HiWord * 0x10000, BitAND($LoWord, 0xFFFF))
EndFunc


;----testing the function
;sleep(5000)
;_MouseClickPlus("Unbenannt - Editor", "left",1468,571,1)