#include <ImageSearch.au3>

global $y = 0, $x = 0

Func checkForImage()
	Local $search = _ImageSearch('100.bmp', 0, $x, $y, 0)
		If $search = 1 Then
	;MouseMove($x+15, $y+15, 1)
	MouseClick("right", $x+15, $y+15,1, 1)
EndIf
EndFunc

while 1
sleep(200)
checkForImage()
WEnd