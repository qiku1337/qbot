func help1()
    MsgBox($MB_OK,"Info","Update v4 - funkcje myszkowe dzialaja w tle." & @CRLF & _
	"Przyciski XY - po przycisnieciu bot czeka na klikniecie lewym przyciskiem myszy w miejsce itemu." & @CRLF & _
	"Antiafk - funkcja dziala w tle - znany bug, czasem nie dziala klawisz CTRL - postać potrafi chodzic (najczesciej win7)" & @CRLF & _
    "Antiafk2 - funkcja nie działa tle." & @CRLF & _
	"Fishing - lowi do skonczenia capa" & @CRLF & _
	"Reconnect - laczy ponownie jesli postac zostala wylogowana przez x minut" & @CRLF & @LF & _
	"Poradnik ustawiania runemakera:" & @CRLF & _
	"Standardowo: mana na rune, hotkey, zaznaczyć Runemaker. Food xy - najlepiej miec 1 wolna reke do ktorej bedziemy lowic rybe i z niej jesc." & _
    "dodatkowo zeby postac wylogowywala - Player on screen logout, reconnect - zaleca sie po 5 minutach lub wiecej. Antiafk, do tego ustawic" & _
	"xy fishing na wode, xy wedki, fishing z zasiegiem 2-3. Nalowic rybek do skonczenia capa. Bot bedzie zjadal z reki rybe, jak zje to zlowi kolejna." & @CRLF & @LF & _
	"Klawisz PauseBreak wylacza bota w razie naglych przyadkow")
EndFunc

func help2()
   MsgBox($MB_OK,"Info","Po wcisnieciu przyciskow bot czeka na lewy przycisk myszy. Hotkeye pod klawiszami PgDn, Insert działaja na zasadzie 'strzelania', uzywane np. do wedki, run. Hotkey pod klawiszem END, sluzy do szybkiego podnoszenia itemow z gleby. Zasada uzywania: Po ustawieniu miejsca runy/wedki/miejsca do ktorego ma byc przeniesiony item, nakierowac kursor myszy oraz wcisnac hotkey. Przytrzymanie hotkeya grozi zawieszeniem bota")
EndFunc

func error99()
    MsgBox($MB_OK,"Error","Set XY!!!")
EndFunc

