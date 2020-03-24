#include <MsgBoxConstants.au3>
#include <IE.au3>
#include <INet.au3>
#include <WinAPIFiles.au3>
#RequireAdmin
#NoTrayIcon


;global vars have to be above all code - Global vars are frowned upon in general, but for this example they do what is needed
Global $serverVersionFile = "https://gitlab.com/Qiku/bocid-o/-/raw/master/version.txt";create a txt file in your webhosting account and only include your software version in it, for example: 2.0.0.0
Global $UpdatePathIs = @ScriptDir & "\update.exe"; This is the local path where you want your update to be downloaded into.
Global $serverUpdateExe = "https://gitlab.com/Qiku/bocid-o/-/raw/master/qbot.exe"; This is the path to the update.exe file on your server.
Global $ToBeReplacedPathIs = @ScriptDir & "\qbot.exe"; This is the path to your original program that you want to update.
Global $doDownload
Global $updateFailed
Global $retryornot


Func GetCurrentSoftwareVersion()
    ; Retrieve the file version of the target/original executable. | Retrieve the version number contained in your version.txt file.
    Global $localEXEversion = FileGetVersion($ToBeReplacedPathIs)
    Global $remoteEXEversion = _INetGetSource($serverVersionFile)
	ConsoleWrite($localEXEversion&@LF&$remoteEXEversion&@CRLF)

EndFunc   ;==>GetCurrentSoftwareVersion

Func doVersionCheck()
;check if local version is lower than server version - if server version higher than local version then push update
If $localEXEversion < $remoteEXEversion Then
    MsgBox(0,"Update needed","Server version higher - lets update it")

    Global $doDownload = InetGet($serverUpdateExe, $UpdatePathIs, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND); This goes and downloads our update.exe file (forces a fresh download)
    ;The 'do' statment below forces the script to wait until the download has completed to continue.
    Do
        Sleep(250)
    Until InetGetInfo($doDownload, $INET_DOWNLOADCOMPLETE)
    MsgBox(0,"Download","Download complete!")
    DownloadDeleteRename()

Else
    MsgBox(0,"Info","Server version lower than current local verison - no action needed"); we do "lower" so that when you are working on updates locally and testing, your script doesn't force you to update.
EndIf

EndFunc;doVersionCheck

Func DownloadDeleteRename()

    FileDelete($ToBeReplacedPathIs); this will delete the original exe file
    FileMove($UpdatePathIs,$ToBeReplacedPathIs,1); this will rename your update.exe to whatver your original exe file name was so that you have replaced the original exe with the updated exe

    ; lets check to make sure our update was successful - We do this by checking the local and remote file versions again... If the update was successful, then the local exe file and the remote version.txt file will be the same number.

    GetCurrentSoftwareVersion()

    MsgBox(0,"Version","Old: "&$localEXEversion&@LF & "New: "&$remoteEXEversion)

    If $localEXEversion = $remoteEXEversion Then
        ;all is good - the update was successful
        Global $updateFailed = false; this means the update did not fail
        ConsoleWrite($updateFailed)
    Else
        $retryornot = MsgBox(16 + 5,"Update error detected","Likely cause: Firewall/Antivirus prevented the download. ")
        ;this tells us what button the user clicked on msgbox... cancel = 2, and retry = 4
        Global $updateFailed = true; this means the update failed
        ConsoleWrite($updateFailed)

        EndIf

        ; with the if statement below we are telling the software to simply close if the user rejected our update instead of retrying.
        If $retryornot = 4 Then
            GetCurrentSoftwareVersion()
            doVersionCheck()
        Else
            ;close application
            ;Exit (remove this text and uncomment 'exit' to make the program actually close)



    EndIf

    EndFunc;DownloadDeleteRename