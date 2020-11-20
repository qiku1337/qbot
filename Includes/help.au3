func help1()
    MsgBox($MB_OK,"Info","Update v4 - funkcje myszkowe dzialaja w tle." & @CRLF & _
	"Przyciski XY - po przycisnieciu bot czeka na klikniecie lewym przyciskiem myszy w miejsce itemu." & @CRLF & _
	"Jesli uzywasz eatfood (po wczesniejszym ustawieniu xy), nie ma potrzeby uzywania antiafk)" & @CRLF & _
	"Antiafk - funkcja dziala w tle - znany bug, czasem nie dziala klawisz CTRL - postać potrafi chodzic (najczesciej win7)" & @CRLF & _
    "Antiafk2 - funkcja nie działa tle." & @CRLF & _
	"Fishing - lowi do skonczenia capa" & @CRLF & _
	"Safe log - wylogowuje gdy gracz sie pojawi na battle - battle musi byc otwarte, zaznaczyc jak nikogo nie bedzie na battle" & @CRLF & _
	"Reconnect - laczy ponownie jesli postac zostala wylogowana przez x minut" & @CRLF & _
	"Przycisk PL,UH sluza do ustawienia pozycji gracza oraz uha w bp dla funkcji healbot zaznaczenie uh"& @CRLF & @LF & _
	"Poradnik ustawiania runemakera:" & @CRLF & _
	"Ustawić ile many na rune, hotkey, zaznaczyć Runemaker. Food xy - najlepiej miec 1 wolna reke do ktorej bedziemy lowic rybe i z niej jesc." & _
    "dodatkowo zeby postac wylogowywala -Safe log, reconnect - zaleca sie po 5 minutach lub wiecej. Antiafk, do tego ustawic" & _
	"xy fishing na wode, xy wedki, fishing z zasiegiem 2-3. Nalowic rybek do skonczenia capa. Bot bedzie zjadal z reki rybe, jak zje to zlowi kolejna." & @CRLF & @LF & _
	"Klawisz PauseBreak wylacza bota w razie naglych przyadkow")
EndFunc

func help2()
   MsgBox($MB_OK,"Info","Aim - klika/przenosi w aktualne polozenie kursora z wczesniej zaznaczonego miejsca" & @CRLF & _
   "Przyciski XY - po przycisnieciu bot czeka na klikniecie lewym przyciskiem myszy w miejsce itemu." & @CRLF & _
   "Shoot - sluza do strzelania z run/wedki/manasa itp. w aktualne polozenie kursora" & @CRLF & _
   "Drag - sluzy do przenoszenia itema (np. golda do bp, ringa w ringslot itd.) w aktualne polozenie kursora" & @CRLF & _
   "Jest mozliwosc ustawienia pod kazdy klawisz na klawiaturze np. q,f1,end,enter itd, aby dokonac zmiany nalezy odznaczyc i zaznaczyc opcje hotkeys on")
EndFunc

func help3()
   MsgBox($MB_OK,"Info","Train - klika PPM w ustawione wczesniej miejsce potwora" & @CRLF & _
   "Trening na slime - nalezy znalezc takie miejsce zeby slime podchodzil ciagle w to samo miejsce a nastepnie zaznaczyc przyciskiem monster xy" & @CRLF & _
   "Podnoszenie spearow - z ustawionego miejsca Monsterxy (pod potworem) przenosi w miejsce ustawione Hand xy co x sekund")
EndFunc

Func help_kas()
	MsgBox($MB_OK,"Info","Pierwsza kolumna - delay w milisekundach, zalecana wartosc od 200 do 20000" & @CRLF & _
	"Druga kolumna - hp lub mana w zaleznosci od funkcji, dla leczenia gorna jest od hp, dolna od many - osobno dla soft oraz pwr" & @CRLF & _
	"Trzecia kolumna - hotkey od F1 do F12" & @CRLF & _
	"Czwarta kolumna - wlaczanie funkcji bota - zalecia sie wlaczanie z wypelnionymi polami" & @CRLF & _
	"Kontakt qiku00@gmail.com")
EndFunc

func error99()
    MsgBox($MB_OK,"Error","Ustaw miejsce itema (XY)!!!")
EndFunc

func error98()
    MsgBox($MB_OK,"Error","Miejsce nie moze byc puste"& @CRLF &"Place cannot be blank")
 EndFunc

func error97()
    MsgBox($MB_OK,"Error","Zly klucz!!!"& @CRLF &"Wrong key!!!")
EndFunc

func error96()
    MsgBox($MB_OK,"Error","Kup licencje!!!"& @CRLF &"Buy licence!!!")
EndFunc

func error95()
    MsgBox($MB_OK,"Error","Error while checking licence"& @CRLF &"Błąd sprawdzania licencji-kontaktuj sie z autorem")
EndFunc



