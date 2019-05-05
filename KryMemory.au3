#include-once
#include "Constants.au3"

; #INDEX# =======================================================================================================================
; Title .........: KryMemory
; AutoIt Version : 3.3.8.1
; Language ......: English
; Description ...: Functions for modifying and querying process memory.
; Author(s) .....: KryziK (John Fedorchak) <john.fedorchak@gmail.com>
; Dll(s) ........: Kernel32.dll
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _Process_Open($sProcessName, $iDesiredAccess = $PROCESS_ALL_ACCESS, $fInheritAccess = False)
; _Process_Close($ahHandle)
; _Process_ReadMemory($ahHandle, $ivAddress, $sType = "dword")
; _Process_ReadMemoryPointer($ahHandle, $ivAddress, $aiOffsets, $sType = "dword")
; _Process_WriteMemory($ahHandle, $ivAddress, $vData, $sType = "dword")
; _Process_WriteMemoryPointer($ahHandle, $ivAddress, $aiOffsets, $vData, $sType = "dword")
; _Process_GetBaseAddress($ahHandle)
; _Process_GetParent($ahHandle)
; _Process_GetModules($ahHandle)
;
; _Address_CalculateStatic($ahHandle, $sModuleName, $ivOffset)
; _Address_CalculatePointer($ahHandle, $ivAddress, $aiOffsets)
;
; _Module_GetBaseAddress($ahHandle, $sModuleName)
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
; CreateToolhelp32Snapshot
Global Const $TH32CS_SNAPPROCESS = 0x00000002
Global Const $TH32CS_SNAPMODULE = 0x00000008
Global Const $TH32CS_SNAPMODULE32 = 0x00000010
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name ..........: _Process_Open
; Description ...: Opens an existing local process object.
; Syntax ........: _Process_Open($sProcessName[, $iDesiredAccess = $PROCESS_ALL_ACCESS[, $fInheritAccess = False]])
; Parameters ....: $sProcessName        - A string value.
;                  $iDesiredAccess      - [optional] An integer value. Default is $PROCESS_ALL_ACCESS.
;											The access to the process object.
;											This access right is checked against the security descriptor for the process.
;											This parameter can be one or more of the process access rights.
;                  $fInheritAccess      - [optional] A boolean value. Default is False.
;											If this value is TRUE, processes created by this process will inherit the handle.
;											Otherwise, the processes do not inherit this handle.
; Return values .: $ahHandle			- An array of values, or FALSE if an error occurred.
;											$ahHandle[0] = Open handle to kernel32.dll.
;											$ahHandle[1] = Open handle to the specified process.
;											$ahHandle[2] = The identifier of the specified open process.
;				   @error -		0 = No error occurred.
;								1 = The specified process doesn't exist.
;								2 = A handle to kernel32.dll could not be opened.
;								3 = A handle to the specified process could not be opened.
;									@extended = @error of DllCall()
; Author ........: KryziK
; Modified ......: 1/12/2013
; Remarks .......:
; Related .......:
; Link ..........: http://msdn.microsoft.com/en-us/library/windows/desktop/ms684320.aspx
; Example .......: _Process_Open("KryziK.exe")
; ===============================================================================================================================
Func _Process_Open($sProcessName, $iDesiredAccess = $PROCESS_ALL_ACCESS, $fInheritAccess = False)
	Local $iPID = ProcessExists($sProcessName)

	If Not $iPID Then
		SetError(1, 0, False)
		;Return False
	EndIf

	Local $ahHandle[3] = [DllOpen("kernel32.dll"), 0, $iPID]

	If ($ahHandle[0] = -1) Then
		SetError(2, 0, False)
		;Return False
	EndIf

	Local $ahCall = DllCall($ahHandle[0], "handle", "OpenProcess", _
			"dword", $iDesiredAccess, _
			"bool", $fInheritAccess, _
			"dword", $iPID)

	If @error Then
		DllClose($ahHandle[0])
		SetError(3, @error, False)
		;Return False
	EndIf

	$ahHandle[1] = $ahCall[0]

	Return $ahHandle
EndFunc   ;==>_Process_Open

; #FUNCTION# ====================================================================================================================
; Name ..........: _Process_Close
; Description ...: Closes all handles associated with an array returned by _Process_Open.
; Syntax ........: _Process_Close($ahHandle)
; Parameters ....: $ahHandle            - An array of handles.
; Return values .: A boolean value. TRUE if CloseHandle succeeded in closing the open process handle, otherwise FALSE.
;				   @error -		0 = No error occurred.
;								1 = An invalid handle array was specified.
; Author ........: KryziK
; Modified ......: 1/12/2013
; Remarks .......:
; Related .......:
; Link ..........: http://msdn.microsoft.com/en-us/library/windows/desktop/ms724211.aspx
; Example .......: _Process_Close($ahHandle)
; ===============================================================================================================================
Func _Process_Close($ahHandle)
	If Not IsArray($ahHandle) Then
		SetError(1, 0, False)
		;Return False
	EndIf

	Local $ahCall = DllCall($ahHandle[0], "bool", "CloseHandle", _
			"handle", $ahHandle[1])

	DllClose($ahHandle[0])

	Return $ahCall[0]
EndFunc   ;==>_Process_Close

; #FUNCTION# ====================================================================================================================
; Name ..........: _Process_ReadMemory
; Description ...: Reads data from an area of memory in a specified process.
;				   The entire area to be read must be accessible or the operation fails.
; Syntax ........: _Process_ReadMemory($ahHandle, $ivAddress[, $sType = "dword"])
; Parameters ....: $ahHandle            - An array of handles.
;                  $ivAddress           - An integer value.
;											A pointer to the base address in the specified process from which to read.
;											Before any data transfer occurs, the system verifies that all data in the base address
;											and memory of the specified size is accessible for read access, and if it is not
;											accessible the function fails.
;                  $sType               - [optional] A string value. Default is "dword".
;											The data type of the value to read.
; Return values .: The value that was read from the specified address, or FALSE if an error occurred.
;				   @error -		0 = No error occurred.
;								1 = An invalid handle array was specified.
;								2 = The process' memory could not be read, or an inconsistent number of bytes were read.
; Author ........: KryziK
; Modified ......: 1/12/2013
; Remarks .......:
; Related .......:
; Link ..........: http://msdn.microsoft.com/en-us/library/windows/desktop/ms680553.aspx
; Example .......: _Process_ReadMemory($ahHandle, 0xDEADDEAD)
; ===============================================================================================================================
Func _Process_ReadMemory($ahHandle, $ivAddress, $sType = "dword")
	If Not IsArray($ahHandle) Then
		SetError(1, 0, False)
		;Return False
	EndIf

	Local $vReadData = DllStructCreate($sType)
	Local $vNumberOfBytesRead = DllStructCreate("ulong_ptr lpNumberOfBytesRead")

	Local $ahCall = DllCall($ahHandle[0], "bool", "ReadProcessMemory", _
			"handle", $ahHandle[1], _
			"dword_ptr", $ivAddress, _
			"ptr", DllStructGetPtr($vReadData), _
			"ulong_ptr", DllStructGetSize($vReadData), _
			"ptr", DllStructGetPtr($vNumberOfBytesRead))
	ConsoleWrite(DllStructGetData($vNumberOfBytesRead, "lpNumberOfBytesRead") & @CRLF & DllStructGetSize($vReadData) & @CRLF)
	If (Not $ahCall[0]) Or (DllStructGetData($vNumberOfBytesRead, "lpNumberOfBytesRead") <> DllStructGetSize($vReadData)) Then
		SetError(2, 0, False)
		;Return False
	EndIf

	Return DllStructGetData($vReadData, 1)
EndFunc   ;==>_Process_ReadMemory

; #FUNCTION# ====================================================================================================================
; Name ..........: _Process_ReadMemoryPointer
; Description ...: Reads data from an area of memory in a specified process, which is calculated based on the static address
;				   and array of offsets given.
; Syntax ........: _Process_ReadMemoryPointer($ahHandle, $ivAddress, $aiOffsets[, $sType = "dword"])
; Parameters ....: $ahHandle            - An array of handles.
;                  $ivAddress           - An integer value.
;											A pointer to the base address in the specified process from which to read.
;											Before any data transfer occurs, the system verifies that all data in the base address
;											and memory of the specified size is accessible for read access, and if it is not
;											accessible the function fails.
;                  $aiOffsets           - An array of integers.
;											Offsets to apply to the static address.
;                  $sType               - [optional] A string value. Default is "dword".
;											The data type of the value to read.
; Return values .: The value that was read from the specified address, or FALSE if an error occurred.
; Author ........: KryziK
; Modified ......: 1/12/2013
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Local $aiOffsets[2] = [0xDEAD, 0xDEAD]
;				   _Process_ReadMemoryPointer($ahHandle, 0xDEADDEAD, $aiOffsets)
; ===============================================================================================================================
Func _Process_ReadMemoryPointer($ahHandle, $ivAddress, $aiOffsets, $sType = "dword")
	Return _Process_ReadMemory($ahHandle, _Address_CalculatePointer($ahHandle, $ivAddress, $aiOffsets), $sType)
EndFunc   ;==>_Process_ReadMemoryPointer

; #FUNCTION# ====================================================================================================================
; Name ..........: _Process_WriteMemory
; Description ...: Writes data to an area of memory in a specified process.
;				   The entire area to be written to must be accessible or the operation fails.
; Syntax ........: _Process_WriteMemory($ahHandle, $ivAddress, $vData[, $sType = "dword"])
; Parameters ....: $ahHandle            - An array of handles.
;                  $ivAddress           - An integer value.
;											A pointer to the base address in the specified process to which data is written.
;											Before data transfer occurs, the system verifies that all data in the base address
;											and memory of the specified size is accessible for write access, and if it is not
;											accessible, the function fails.
;                  $vData               - A variant value.
;											The value to write to the address.
;                  $sType               - [optional] A string value. Default is "dword".
;											The data type of the value to write.
; Return values .: A boolean value. TRUE if the write succeeded, otherwise FALSE.
;				   @error -		0 = No error occurred.
;								1 = An invalid handle array was specified.
; Author ........: KryziK
; Modified ......: 1/12/2013
; Remarks .......:
; Related .......:
; Link ..........: http://msdn.microsoft.com/en-us/library/windows/desktop/ms681674.aspx
; Example .......: _Process_WriteMemory($ahHandle, 0xDEADDEAD, 0xDEAD)
; ===============================================================================================================================
Func _Process_WriteMemory($ahHandle, $ivAddress, $vData, $sType = "dword")
	If Not IsArray($ahHandle) Then
		SetError(1, 0, False)
		;Return False
	EndIf

	Local $vWriteData = DllStructCreate($sType)
	Local $vNumberOfBytesWritten = DllStructCreate("ulong_ptr lpNumberOfBytesWritten")

	DllStructSetData($vWriteData, 1, $vData)

	Local $ahCall = DllCall($ahHandle[0], "bool", "WriteProcessMemory", _
			"handle", $ahHandle[1], _
			"dword_ptr", $ivAddress, _
			"ptr", DllStructGetPtr($vWriteData), _
			"ulong_ptr", DllStructGetSize($vWriteData), _
			"ptr", DllStructGetPtr($vNumberOfBytesWritten))

	Return ($ahCall[0] And (DllStructGetData($vNumberOfBytesWritten, "lpNumberOfBytesWritten") = DllStructGetSize($vWriteData)))
EndFunc   ;==>_Process_WriteMemory

; #FUNCTION# ====================================================================================================================
; Name ..........: _Process_WriteMemoryPointer
; Description ...: Writes data to an area of memory in a specified process, which is calculated based on the static address
;				   and array of offsets given.
; Syntax ........: _Process_WriteMemoryPointer($ahHandle, $ivAddress, $aiOffsets, $vData[, $sType = "dword"])
; Parameters ....: $ahHandle            - An array of handles.
;                  $ivAddress           - An integer value.
;											A pointer to the base address in the specified process to which data is written.
;											Before data transfer occurs, the system verifies that all data in the base address
;											and memory of the specified size is accessible for write access, and if it is not
;											accessible, the function fails.
;                  $aiOffsets           - An array of integers.
;											Offsets to apply to the static address.
;                  $vData               - A variant value.
;											The value to write to the address.
;                  $sType               - [optional] A string value. Default is "dword".
;											The data type of the value to write.
; Return values .: A boolean value. TRUE if the write succeeded, otherwise FALSE.
; Author ........: KryziK
; Modified ......: 1/12/2013
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Local $aiOffsets[2] = [0xDEAD, 0xDEAD]
;				   _Process_WriteMemoryPointer($ahHandle, 0xDEADDEAD, $aiOffsets, 0xDEAD)
; ===============================================================================================================================
Func _Process_WriteMemoryPointer($ahHandle, $ivAddress, $aiOffsets, $vData, $sType = "dword")
	Return _Process_WriteMemory($ahHandle, _Address_CalculatePointer($ahHandle, $ivAddress, $aiOffsets), $vData, $sType)
EndFunc   ;==>_Process_WriteMemoryPointer

; #FUNCTION# ====================================================================================================================
; Name ..........: _Process_GetBaseAddress
; Description ...: Gets the base address of the process associated with an array returned by _Process_Open.
; Syntax ........: _Process_GetBaseAddress($ahHandle)
; Parameters ....: $ahHandle            - An array of handles.
; Return values .: An integer value. The base address of the open process, or FALSE if an error occurred.
;				   @error -		0 = No error occurred.
;								1 = An invalid handle array was specified.
;								2 = An error occurred while obtaining the first module of the process.
; Author ........: KryziK
; Modified ......: 1/12/2013
; Remarks .......:
; Related .......:
; Link ..........: http://msdn.microsoft.com/en-us/library/windows/desktop/ms682489.aspx
;				   http://msdn.microsoft.com/en-us/library/windows/desktop/ms684218.aspx
; Example .......: _Process_GetBaseAddress($ahHandle)
; ===============================================================================================================================
Func _Process_GetBaseAddress($ahHandle)
	If Not IsArray($ahHandle) Then
		SetError(1, 0, False)
		Return False
	EndIf

	Local $ahSnapshot = DllCall($ahHandle[0], "handle", "CreateToolhelp32Snapshot", _
			"dword", BitOR($TH32CS_SNAPMODULE, $TH32CS_SNAPMODULE32), _
			"dword", $ahHandle[2])

	Local $vModuleEntry32 = DllStructCreate("dword dwSize;" & _
			"dword th32ModuleID;" & _
			"dword th32ProcessID;" & _
			"dword GlblcntUsage;" & _
			"dword ProccntUsage;" & _
			"ptr modBaseAddr;" & _
			"dword modBaseSize;" & _
			"handle hModule;" & _
			"char szModule[256];" & _
			"char szExePath[260]")

	DllStructSetData($vModuleEntry32, "dwSize", DllStructGetSize($vModuleEntry32))

	Local $ahCall = DllCall($ahHandle[0], "bool", "Module32First", _
			"handle", $ahSnapshot[0], _
			"ptr", DllStructGetPtr($vModuleEntry32))

	If Not $ahCall[0] Then
		DllCall($ahHandle[0], "bool", "CloseHandle", _
				"handle", $ahSnapshot[0])
		SetError(2, 0, False)
		;Return False
	EndIf

	DllCall($ahHandle[0], "bool", "CloseHandle", _
			"handle", $ahSnapshot[0])

	Return DllStructGetData($vModuleEntry32, "modBaseAddr")
EndFunc   ;==>_Process_GetBaseAddress

; #FUNCTION# ====================================================================================================================
; Name ..........: _Process_GetParent
; Description ...: Gets the parent of the process associated with an array returned by _Process_Open.
; Syntax ........: _Process_GetParent($ahHandle)
; Parameters ....: $ahHandle            - An array of handles.
; Return values .: An integer value. The process ID of the parent, or FALSE if an error occurred or no parent exists.
;				   @error -		0 = No error occurred.
;								1 = An invalid handle array was specified.
;								2 = An error occurred while obtaining the first process.
; Author ........: KryziK
; Modified ......: 1/12/2013
; Remarks .......:
; Related .......:
; Link ..........: http://msdn.microsoft.com/en-us/library/windows/desktop/ms682489.aspx
;				   http://msdn.microsoft.com/en-us/library/windows/desktop/ms684834.aspx
;				   http://msdn.microsoft.com/en-us/library/windows/desktop/ms684836.aspx
; Example .......: _Process_GetParent($ahHandle)
; ===============================================================================================================================
Func _Process_GetParent($ahHandle)
	If Not IsArray($ahHandle) Then
		SetError(1, 0, False)
		;Return False
	EndIf

	Local $ahSnapshot = DllCall($ahHandle[0], "handle", "CreateToolhelp32Snapshot", _
			"dword", $TH32CS_SNAPPROCESS, _
			"dword", $ahHandle[2])

	Local $vProcessEntry32 = DllStructCreate("dword dwSize;" & _
			"dword dwSize;" & _
			"dword cntUsage;" & _
			"dword th32ProcessID;" & _
			"ulong_ptr th32DefaultHeapID;" & _
			"dword th32ModuleID;" & _
			"dword cntThreads;" & _
			"dword th32ParentProcessID;" & _
			"long pcPriClassBase;" & _
			"dword dwFlags;" & _
			"char szExeFile[260]")

	DllStructSetData($vProcessEntry32, "dwSize", DllStructGetSize($vProcessEntry32))

	Local $ahCall = DllCall($ahHandle[0], "bool", "Process32First", _
			"handle", $ahSnapshot[0], _
			"ptr", DllStructGetPtr($vProcessEntry32))

	If Not $ahCall[0] Then
		DllCall($ahHandle[0], "bool", "CloseHandle", _
				"handle", $ahSnapshot[0])
		SetError(2, 0, False)
		;Return False
	EndIf

	Do
		If DllStructGetData($vProcessEntry32, "th32ProcessID") = $ahHandle[2] Then
			DllCall($ahHandle[0], "bool", "CloseHandle", _
					"handle", $ahSnapshot[0])

			Return DllStructGetData($vProcessEntry32, "th32ParentProcessID")
		EndIf

		$ahCall = DllCall($ahHandle[0], "bool", "Process32Next", _
				"handle", $ahSnapshot[0], _
				"ptr", DllStructGetPtr($vProcessEntry32))
	Until Not $ahCall[0]

	DllCall($ahHandle[0], "bool", "CloseHandle", _
			"handle", $ahSnapshot[0])

	Return False
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _Process_GetModules
; Description ...: Returns the names of the modules loaded into the process associated with an array returned by _Process_Open.
; Syntax ........: _Process_GetModules($ahHandle)
; Parameters ....: $ahHandle            - An array of handles.
; Return values .: An array of strings. An array of the names of the modules loaded into the opened process.
; Author ........: KryziK
; Modified ......: 1/12/2013
; Remarks .......: x64: Currently includes the main executable twice in the list because of the snapshot creation flags.
;				   @error -		0 = No error occurred.
;								1 = An invalid handle array was specified.
;								2 = An error occurred while obtaining the first module of the process.
; Related .......:
; Link ..........: http://msdn.microsoft.com/en-us/library/windows/desktop/ms682489.aspx
;				   http://msdn.microsoft.com/en-us/library/windows/desktop/ms684218.aspx
;				   http://msdn.microsoft.com/en-us/library/windows/desktop/ms684221.aspx
;				   http://msdn.microsoft.com/en-us/library/windows/desktop/ms724211.aspx
; Example .......: _Process_GetModules($ahHandle)
; ===============================================================================================================================
Func _Process_GetModules($ahHandle)
	If Not IsArray($ahHandle) Then
		SetError(1, 0, False)
		;Return False
	EndIf

	Local $ahSnapshot = DllCall($ahHandle[0], "handle", "CreateToolhelp32Snapshot", _
			"dword", BitOR($TH32CS_SNAPMODULE, $TH32CS_SNAPMODULE32), _
			"dword", $ahHandle[2])

	Local $vModuleEntry32 = DllStructCreate("dword dwSize;" & _
			"dword th32ModuleID;" & _
			"dword th32ProcessID;" & _
			"dword GlblcntUsage;" & _
			"dword ProccntUsage;" & _
			"ptr modBaseAddr;" & _
			"dword modBaseSize;" & _
			"handle hModule;" & _
			"char szModule[256];" & _
			"char szExePath[260]")

	DllStructSetData($vModuleEntry32, "dwSize", DllStructGetSize($vModuleEntry32))

	Local $ahCall = DllCall($ahHandle[0], "bool", "Module32First", _
			"handle", $ahSnapshot[0], _
			"ptr", DllStructGetPtr($vModuleEntry32))

	If Not $ahCall[0] Then
		DllCall($ahHandle[0], "bool", "CloseHandle", _
				"handle", $ahSnapshot[0])
		SetError(2, 0, False)
		;Return False
	EndIf

	Local $asModules[1]
	Local $iModuleCount = 1

	Do
		If UBound($asModules) < $iModuleCount Then
			ReDim $asModules[UBound($asModules) + 1]
		EndIf

		$asModules[$iModuleCount - 1] = DllStructGetData($vModuleEntry32, "szModule")
		$iModuleCount += 1

		$ahCall = DllCall($ahHandle[0], "bool", "Module32Next", _
				"handle", $ahSnapshot[0], _
				"ptr", DllStructGetPtr($vModuleEntry32))
	Until Not $ahCall[0]

	DllCall($ahHandle[0], "bool", "CloseHandle", _
			"handle", $ahSnapshot[0])

	Return $asModules
EndFunc   ;==>_Process_GetModules

; #FUNCTION# ====================================================================================================================
; Name ..........: _Address_CalculateStatic
; Description ...: Gets an address by applying a single offset to a module's base address.
; Syntax ........: _Address_CalculateStatic($ahHandle, $sModuleName, $ivOffset)
; Parameters ....: $ahHandle            - An array of handles.
;                  $sModuleName         - A string value.
;											The name of the module.
;                  $ivOffset            - An integer value.
;											The offset to add to the module's base address.
; Return values .: An integer value. The final address, after the offset has been added to the module's base address.
; Author ........: KryziK
; Modified ......: 1/12/2013
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: _Address_CalculateStatic($ahHandle, "KryziK.exe", 0xDEAD)
;				   _Address_CalculateStatic($ahHandle, "KryziK.dll", 0xDEAD)
; ===============================================================================================================================
Func _Address_CalculateStatic($ahHandle, $sModuleName, $ivOffset)
	Return _Module_GetBaseAddress($ahHandle, $sModuleName) + $ivOffset
EndFunc   ;==>_Address_CalculateStatic

; #FUNCTION# ====================================================================================================================
; Name ..........: _Address_CalculatePointer
; Description ...: Gets an address by applying an array of offsets to a static address. After each offset is applied,
;				   the address is read from to obtain the next address until all offsets are exhausted.
; Syntax ........: _Address_CalculatePointer($ahHandle, $ivAddress, $aiOffsets)
; Parameters ....: $ahHandle            - An array of handles.
;                  $ivAddress           - An integer value.
;											A static address used as the starting point of the calculation.
;                  $aiOffsets           - An array of integers.
;											Offsets to apply to the static address.
; Return values .: An integer value. The final address, after all offsets have been applied.
; Author ........: KryziK
; Modified ......: 1/12/2013
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Local $aiOffsets[2] = [0xDEAD, 0xDEAD]
;				   _Address_CalculatePointer($ahHandle, 0xDEADDEAD, $aiOffsets)
; ===============================================================================================================================
Func _Address_CalculatePointer($ahHandle, $ivAddress, $aiOffsets)
	Local $vFinalAddress = DllStructCreate("dword_ptr")

	DllStructSetData($vFinalAddress, 1, $ivAddress)

	For $iOffset In $aiOffsets
		DllStructSetData($vFinalAddress, 1, _Process_ReadMemory($ahHandle, DllStructGetData($vFinalAddress, 1)) + $iOffset)
	Next

	Return DllStructGetData($vFinalAddress, 1)
EndFunc   ;==>_Address_CalculatePointer

; #FUNCTION# ====================================================================================================================
; Name ..........: _Module_GetBaseAddress
; Description ...: Gets the base address of a module in the process associated with an array returned by _Process_Open.
; Syntax ........: _Module_GetBaseAddress($ahHandle, $sModuleName)
; Parameters ....: $ahHandle            - An array of handles.
;                  $sModuleName         - A string value.
;											The name of the module.
; Return values .: An integer value. The base address of the module in the open process.
;				   @error -		0 = No error occurred.
;								1 = An invalid handle array was specified.
;								2 = An error occurred while obtaining the first module of the process.
; Author ........: KryziK
; Modified ......: 1/12/2013
; Remarks .......:
; Related .......:
; Link ..........: http://msdn.microsoft.com/en-us/library/windows/desktop/ms682489.aspx
;				   http://msdn.microsoft.com/en-us/library/windows/desktop/ms684218.aspx
;				   http://msdn.microsoft.com/en-us/library/windows/desktop/ms684221.aspx
;				   http://msdn.microsoft.com/en-us/library/windows/desktop/ms724211.aspx
; Example .......: _Module_GetBaseAddress($ahHandle, "KryziK.dll")
; ===============================================================================================================================
Func _Module_GetBaseAddress($ahHandle, $sModuleName)
	If Not IsArray($ahHandle) Then
		SetError(1, 0, False)
		;Return False
	EndIf

	Local $ahSnapshot = DllCall($ahHandle[0], "handle", "CreateToolhelp32Snapshot", _
			"dword", BitOR($TH32CS_SNAPMODULE, $TH32CS_SNAPMODULE32), _
			"dword", $ahHandle[2])

	Local $vModuleEntry32 = DllStructCreate("dword dwSize;" & _
			"dword th32ModuleID;" & _
			"dword th32ProcessID;" & _
			"dword GlblcntUsage;" & _
			"dword ProccntUsage;" & _
			"ptr modBaseAddr;" & _
			"dword modBaseSize;" & _
			"handle hModule;" & _
			"char szModule[256];" & _
			"char szExePath[260]")

	DllStructSetData($vModuleEntry32, "dwSize", DllStructGetSize($vModuleEntry32))

	Local $ahCall = DllCall($ahHandle[0], "bool", "Module32First", _
			"handle", $ahSnapshot[0], _
			"ptr", DllStructGetPtr($vModuleEntry32))

	If Not $ahCall[0] Then
		DllCall($ahHandle[0], "bool", "CloseHandle", _
				"handle", $ahSnapshot[0])
		SetError(2, 0, False)
		;Return False
	EndIf

	Do
		If DllStructGetData($vModuleEntry32, "szModule") = $sModuleName Then
			DllCall($ahHandle[0], "bool", "CloseHandle", _
					"handle", $ahSnapshot[0])

			Return DllStructGetData($vModuleEntry32, "modBaseAddr")
		EndIf

		$ahCall = DllCall($ahHandle[0], "bool", "Module32Next", _
				"handle", $ahSnapshot[0], _
				"ptr", DllStructGetPtr($vModuleEntry32))
	Until Not $ahCall[0]

	DllCall($ahHandle[0], "bool", "CloseHandle", _
			"handle", $ahSnapshot[0])

	Return False
EndFunc   ;==>_Module_GetBaseAddress