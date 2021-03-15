#include "EzMySql.au3"
#include <Array.au3>



func telemetry($id,$charname,$server)
   local $pass = "okiweskj"
   local $ip = "srv07.mikr.us"

   If Not _EzMySql_Startup() Then
	   ConsoleWrite("Error Starting MySql" & @CRLF)
   EndIf

   If Not _EzMySql_Open($ip, "bot", $pass, "", "20482") Then
	   ConsoleWrite("Error opening Database" & @CRLF)
   EndIf

   If Not _EzMySql_SelectDB("grafana") Then
	   ConsoleWrite("Error setting Database to use" & @CRLF)
   EndIf

   Local $sMySqlStatement = ""
   IF $charname == "" Then
	  $charname = "Disconnected"
   EndIf

		   $sMySqlStatement &= "INSERT INTO online (idhard,charname,server) VALUES (" & _
						   "'" & $id & "'," & _
						   "'" & $charname & "'," & _
						   "'" & $server & "');"

   If Not _EzMySql_Exec($sMySqlStatement) Then
	   ;MsgBox(0, "Error inserting data to Table", "Error: "& @error & @CR & "Error string: " & _EzMySql_ErrMsg())
	   ConsoleWrite("Error inserting data to Table" & @CRLF)
   EndIf

   _EzMySql_Close()
   _EzMySql_ShutDown()
EndFunc

Func getlicence($id)
   local $pass = "okiweskj"
   local $ip = "srv07.mikr.us"

   If Not _EzMySql_Startup() Then
	   ConsoleWrite("Error Starting MySql" & @CRLF)
	   error95()
	   Exit
   EndIf

   If Not _EzMySql_Open($ip, "bot", $pass, "", "20482") Then
	   ConsoleWrite("Error opening Database" & @CRLF)
	   error95()
	   Exit
   EndIf

   If Not _EzMySql_SelectDB("qbotto") Then
	   ConsoleWrite("Error setting Database to use" & @CRLF)
	   error95()
	   Exit
   EndIf

   $aOk = _EzMySql_GetTable2d("SELECT dayleft FROM license WHERE hwid = '"& $id & "';")

   If Not _EzMYSql_Query("SELECT dayleft FROM license WHERE hwid = '"& $id & "';") Then
		 ConsoleWrite("Query Error" & @CRLF)
		 MsgBox($MB_OK,"Error","Err select")
	   Exit
   EndIf

   $a1Row = _EzMySql_FetchData()

   If IsArray($a1Row) == 1 Then
	   Return $a1Row[0]
   EndIf
   Return 0

   _EzMySql_Close()
   _EzMySql_ShutDown()
EndFunc

Func getmotd()
   local $pass = "okiweskj"
   local $ip = "srv04.mikr.us"

   If Not _EzMySql_Startup() Then
	   ConsoleWrite("Error Starting MySql" & @CRLF)
	   error95()
	   Exit
   EndIf

   If Not _EzMySql_Open($ip, "bot", $pass, "", "20561") Then
	   ConsoleWrite("Error opening Database" & @CRLF)
	   error95()
	   Exit
   EndIf

   If Not _EzMySql_SelectDB("qbotto") Then
	   ConsoleWrite("Error setting Database to use" & @CRLF)
	   error95()
	   Exit
   EndIf

   $aOk = _EzMySql_GetTable2d("SELECT msg FROM motd ;")

   If Not _EzMYSql_Query("SELECT msg FROM motd ;") Then
		 ConsoleWrite("Query Error" & @CRLF)
		 MsgBox($MB_OK,"Error","Err select")
	   Exit
   EndIf

   $a1Row = _EzMySql_FetchData()

   If IsArray($a1Row) == 1 Then
	   Return $a1Row[0]
   EndIf
   Return 0

   _EzMySql_Close()
   _EzMySql_ShutDown()
EndFunc