#include <Includes/mouse.au3>
#include <un.au3>

HotKeySet("{END}", "drag_hotkey")
While 1
        Sleep(20)
WEnd

Func drag_hotkey()
	  local $mxy = MouseGetPos()
		 MouseDown("left")
		 MouseMove(1765, 245,1)
		 MouseUp("left")
		 Send("{enter}")
		 MouseMove($mxy[0],$mxy[1],1)
EndFunc