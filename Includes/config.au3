Func _saveconfig($input,$name)
   IniWrite("config.ini","Config",$name,GUICtrlRead($input))
EndFunc

Func _loadconfig($name)
   Return IniRead("config.ini", "Config", $name, "")
EndFunc