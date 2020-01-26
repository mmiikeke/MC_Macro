#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         mmiikeke

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
; Script Start - Add your code below here

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <StringConstants.au3>
#include <MsgBoxConstants.au3>
#include <SendMessage.au3>

#pragma compile(Icon, 'dragon.ico')

AutoitSetOption("GuiOnEventMode", 1)
Global $fInterrupt = -1
Global $fInterrupt2 = 0
Global $MouseSpeed = 2
Global $targethWnd
Global $winTitle = "Minecraft"
Global $GUI1
Global $GUI2 = 9999
Global $callbackhWnd
Global $callbackInt
Global $ProcessWindowOK
Global $ProcessWindowCancel

#Region ### START GUI section ###

Func gui()
	#Region ### START Koda GUI section ### Form=D:\Mike\github\my_space\Autoit\minecraftScript\MinecraftScript.kxf
	$GUI1 = GUICreate("MC Macro", 400, 257, 339, 215)
	Global $mTools = GUICtrlCreateMenu("&Tools")
	Global $mSetWindowTitle = GUICtrlCreateMenuItem("Set Window Title", $mTools)
	Global $mSetting = GUICtrlCreateMenu("&Setting")
	Global $mProcessWindow = GUICtrlCreateMenuItem("Process Window", $mSetting)
	Global $mAbout = GUICtrlCreateMenu("&About")
	Global $mInformation = GUICtrlCreateMenuItem("Information", $mAbout)
	Global $GMain = GUICtrlCreateGroup("options", 11, 8, 377, 169)
	GUICtrlSetFont(-1, 10, 800, 0, "UD Digi Kyokasho NK-B")
	Global $AutoClickerR = GUICtrlCreateRadio("Auto Clicker", 27, 48, 113, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetFont(-1, 10, 800, 0, "System")
	Global $AutoClickerC = GUICtrlCreateCombo("", 147, 44, 113, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	GUICtrlSetFont(-1, 10, 800, 0, "System")
	Global $AutoClickerI = GUICtrlCreateInput("1200", 275, 44, 57, 24, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	GUICtrlSetFont(-1, 10, 800, 0, "System")
	Global $Label1 = GUICtrlCreateLabel("ms", 339, 47, 24, 20)
	GUICtrlSetFont(-1, 10, 800, 0, "System")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	Global $StartButton = GUICtrlCreateButton("Start", 70, 192, 91, 33)
	GUICtrlSetFont(-1, 12, 800, 0, "UD Digi Kyokasho NK-B")
	Global $StopButton = GUICtrlCreateButton("Stop", 237, 192, 91, 33)
	GUICtrlSetFont(-1, 12, 800, 0, "UD Digi Kyokasho NK-B")
	Global $PauseButton = GUICtrlCreateButton("Pause", 70, 192, 91, 33)
	GUICtrlSetFont(-1, 12, 800, 0, "UD Digi Kyokasho NK-B")
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetState(-1, $GUI_HIDE)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###

	GUISetOnEvent($GUI_EVENT_CLOSE, "On_Close")
	GUICtrlSetOnEvent($StartButton, "Start")
	GUICtrlSetOnEvent($mSetWindowTitle, "SetWindowTitle")
	GUICtrlSetOnEvent($mProcessWindow, "ProcessWindow")
	GUICtrlSetOnEvent($mInformation, "Information")
	GUIRegisterMsg($WM_COMMAND, "Interrupt")

	GUICtrlSetData($AutoClickerC, "L mouse|R mouse|L shift", "L mouse")
EndFunc

Func guiSetWindowTitle()
	#Region ### START Koda GUI section ### Form=D:\Mike\github\my_space\Autoit\minecraftScript\SetWindowTitle.kxf
	$GUI2 = GUICreate("Set Window Title", 270, 127, 516, 360)
	Global $SetWindowTitleFrom = GUICtrlCreateInput("", 99, 16, 137, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
	$Label1 = GUICtrlCreateLabel("From", 43, 16, 37, 20)
	GUICtrlSetFont(-1, 10, 800, 0, "System")
	$Label2 = GUICtrlCreateLabel("To", 43, 57, 20, 20)
	GUICtrlSetFont(-1, 10, 800, 0, "System")
	Global $SetWindowTitleTo = GUICtrlCreateInput("", 99, 57, 137, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
	$SetWindowTitleOK = GUICtrlCreateButton("Ok", 50, 96, 75, 25)
	GUICtrlSetFont(-1, 10, 800, 0, "UD Digi Kyokasho NK-B")
	$SetWindowTitleCancel = GUICtrlCreateButton("Cancel", 152, 95, 75, 25)
	GUICtrlSetFont(-1, 10, 800, 0, "UD Digi Kyokasho NK-B")
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###

	GUISetOnEvent($GUI_EVENT_CLOSE, "On_Close")
	GUICtrlSetOnEvent($SetWindowTitleOK, "SetWindowTitleOK")
	GUICtrlSetOnEvent($SetWindowTitleCancel, "SetWindowTitleCancel")
	GUIRegisterMsg($WM_COMMAND, "Interrupt")
EndFunc

Func guiProcessWindow()
	#Region ### START Koda GUI section ### Form=d:\mike\github\my_space\autoit\minecraftscript\background\processwindow.kxf
	$GUI2 = GUICreate("Process Window", 270, 127, 425, 294)
	$Label1 = GUICtrlCreateLabel("Please select the window", 50, 16, 168, 20, $SS_CENTER)
	GUICtrlSetFont(-1, 10, 800, 0, "System")
	$ProcessWindowOK = GUICtrlCreateButton("Ok", 50, 96, 75, 25)
	GUICtrlSetFont(-1, 10, 800, 0, "UD Digi Kyokasho NK-B")
	$ProcessWindowCancel = GUICtrlCreateButton("Cancel", 152, 95, 75, 25)
	GUICtrlSetFont(-1, 10, 800, 0, "UD Digi Kyokasho NK-B")
	Global $ProcessWindowL = GUICtrlCreateLabel("None", 43, 55, 182, 20, $SS_CENTER)
	GUICtrlSetFont(-1, 10, 800, 0, "System")
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###

	GUISetOnEvent($GUI_EVENT_CLOSE, "On_Close")
	GUIRegisterMsg($WM_COMMAND, "Interrupt")
EndFunc

Func guiInformation()
	#Region ### START Koda GUI section ### Form=d:\mike\github\mc_macro\information.kxf
	$GUI2 = GUICreate("Information", 270, 175, 302, 218)
	$GroupBox1 = GUICtrlCreateGroup("", 8, 8, 257, 121)
	$Image1 = GUICtrlCreatePic("dragon.jpg", 16, 24, 97, 97)
	$Label1 = GUICtrlCreateLabel("Product Name  MC macro", 124, 32, 126, 17)
	$Label2 = GUICtrlCreateLabel("Version  v1.0", 124, 62, 66, 17)
	$Label3 = GUICtrlCreateLabel("Author  mmiikeke", 124, 92, 85, 17)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$InformationClose = GUICtrlCreateButton("&OK", 97, 144, 75, 25, 0)
	GUICtrlSetFont(-1, 10, 800, 0, "UD Digi Kyokasho NK-B")
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###

	GUISetOnEvent($GUI_EVENT_CLOSE, "On_Close")
	GUICtrlSetOnEvent($InformationClose, "On_Close")
	GUIRegisterMsg($WM_COMMAND, "Interrupt")
EndFunc

#EndRegion ### End GUI section ###

gui()
Initialize()
main()

Func main()

	While 1
		Sleep(250)
	WEnd
EndFunc

Func Initialize()

EndFunc

#Region ### START Menu Function section ###
Func Information()
	guiInformation()
	GUISwitch($GUI1)
	GUISetState(@SW_DISABLE)
EndFunc

Func SetWindowTitle()
	guiSetWindowTitle()
	GUISwitch($GUI1)
	GUISetState(@SW_DISABLE)
EndFunc

Func ProcessWindow()
	guiProcessWindow()
	GUISwitch($GUI1)
	GUISetState(@SW_DISABLE)
	Local $newHandle = 9999

	$fInterrupt2 = 0
	$callbackInt = 0

	While $fInterrupt2 = 0
		$newHandle = WinGetHandle("[active]")

		If ((Not ($newHandle = $GUI1)) And (Not ($newHandle = $GUI2)) And (Not (StringCompare(WinGetTitle("[active]"), "") = 0))) Then
			$callbackInt = 1
			$callbackhWnd = $newHandle
			GUICtrlSetData($ProcessWindowL, WinGetTitle($callbackhWnd))
			Sleep(100)
		EndIf
	WEnd

	ProcessWindowCallback()
EndFunc

Func SetWindowTitleOK()

	Local $hWndt = WinGetHandle(GUICtrlRead($SetWindowTitleFrom))

	If @error Then
		MsgBox($MB_ICONERROR, "Oh no! we have a problem!", "An error occurred when trying to retrieve the window handle.")
	ElseIf StringCompare(GUICtrlRead($SetWindowTitleTo), "") = 0 Then
		MsgBox($MB_ICONINFORMATION, "Notification", "Please input new title.")
	Else
		WinSetTitle($hWndt, "", GUICtrlRead($SetWindowTitleTo))
		GUIDelete($GUI2)
		GUISwitch($GUI1)
		GUISetState(@SW_ENABLE)
		WinActivate($GUI1)
	EndIf

EndFunc

Func SetWindowTitleCancel()
	GUIDelete($GUI2)
	GUISwitch($GUI1)
	GUISetState(@SW_ENABLE)
	WinActivate($GUI1)
EndFunc

Func SubWindowOK()
	$fInterrupt2 = 1
EndFunc

Func SubWindowCancel()
	$fInterrupt2 = 2
EndFunc

Func ProcessWindowCallback()
	If $fInterrupt2 = 1 And $callbackInt = 1 Then
		$targethWnd = $callbackhWnd
	EndIf

	SubWindowClose()
EndFunc

Func SubWindowClose()
	GUIDelete($GUI2)
	GUISwitch($GUI1)
	GUISetState(@SW_ENABLE)
	WinActivate($GUI1)
EndFunc

#EndRegion ### END Menu Function section ###

Func Start()

	If $fInterrupt = -1 Then

		$targethWnd = WinGetHandle($winTitle)

		If @error Then
			MsgBox($MB_ICONINFORMATION, "Notification", "Please go to Setting -> Process Window and select the window to run.")
		Else
			$fInterrupt = 1
		EndIf

	EndIf

	If $fInterrupt = 1 Then

		GUICtrlSetState($StartButton, $GUI_DISABLE)
		GUICtrlSetState($StartButton, $GUI_HIDE)
		GUICtrlSetState($PauseButton, $GUI_ENABLE)
		GUICtrlSetState($PauseButton, $GUI_SHOW)
		GUICtrlSetData($PauseButton, "Pause")
		GUICtrlSetState($AutoClickerR, $GUI_DISABLE)
		GUICtrlSetState($AutoClickerC, $GUI_DISABLE)
		GUICtrlSetState($AutoClickerI, $GUI_DISABLE)
		GUICtrlSetState($Label1, $GUI_DISABLE)
		$fInterrupt = 0

		If GUICtrlRead($AutoClickerR) = 1 Then
			AutoClicker()
		EndIf

		GUICtrlSetState($PauseButton, $GUI_DISABLE)
		GUICtrlSetState($PauseButton, $GUI_HIDE)
		GUICtrlSetState($StartButton, $GUI_ENABLE)
		GUICtrlSetState($StartButton, $GUI_SHOW)
		GUICtrlSetState($AutoClickerR, $GUI_ENABLE)
		GUICtrlSetState($AutoClickerC, $GUI_ENABLE)
		GUICtrlSetState($AutoClickerI, $GUI_ENABLE)
		GUICtrlSetState($Label1, $GUI_ENABLE)
		$fInterrupt = 1
	EndIf

	Return
EndFunc

Func AutoClicker()

	Local $counter = 0
	Local $buttonD
	Local $buttonU

	If StringCompare(GUICtrlRead($AutoClickerC), "L mouse") = 0 Then
		$buttonD = $WM_LBUTTONDOWN
		$buttonU = $WM_LBUTTONUP

		while $fInterrupt = 0
			ToolTip("LClick " & $counter & "times", 0, 0)

			_SendMessage($targethWnd, $buttonD)
			Sleep(10)
			_SendMessage($targethWnd, $buttonU)
			Sleep(GUICtrlRead($AutoClickerI))

			WaitForInterrupt()
			$counter = $counter + 1
		WEnd
	ElseIf StringCompare(GUICtrlRead($AutoClickerC), "R mouse") = 0 Then
		$buttonD = $WM_RBUTTONDOWN
		$buttonU = $WM_RBUTTONUP

		while $fInterrupt = 0
			ToolTip("RClick " & $counter & "times", 0, 0)

			_SendMessage($targethWnd, $buttonD)
			Sleep(10)
			_SendMessage($targethWnd, $buttonU)
			Sleep(GUICtrlRead($AutoClickerI))

			WaitForInterrupt()
			$counter = $counter + 1
		WEnd
	ElseIf StringCompare(GUICtrlRead($AutoClickerC), "L shift") = 0 Then
		while $fInterrupt = 0
			ToolTip("Shift " & $counter & "times", 0, 0)

			ControlSend($targethWnd, "", "", "{LSHIFT down}")
			Sleep(Floor(GUICtrlRead($AutoClickerI)/2))
			ControlSend($targethWnd, "", "", "{LSHIFT up}")
			Sleep(Floor(GUICtrlRead($AutoClickerI)/2))

			WaitForInterrupt()
			$counter = $counter + 1
		WEnd
	EndIf
EndFunc

Func Pause()
	$fInterrupt = 2 - $fInterrupt

	If $fInterrupt = 0 Then
		GUICtrlSetData($PauseButton, "Pause")
	ElseIf $fInterrupt = 2 Then
		GUICtrlSetData($PauseButton, "Continue")
	EndIf

	Return
EndFunc

Func Stop()
	If $fInterrupt = 0 Or $fInterrupt = 2 Then
		$fInterrupt = 1
	EndIf
EndFunc

Func _exit()
   Exit
EndFunc

Func WaitForInterrupt()
	While $fInterrupt = 2
		ToolTip("Pause()", 0, 0)
		Sleep(2000)
	WEnd
	Return
EndFunc

Func Resize()
	WinMove("Name", "", 0, 0, 442, 808)
	Return
EndFunc

 Func Interrupt($hWnd, $Msg, $wParam, $lParam)
     If BitAND($wParam, 0x0000FFFF) =  $StopButton Then
		 Stop()
	 ElseIf BitAND($wParam, 0x0000FFFF) =  $PauseButton Then
		 Pause()
	 ElseIf BitAND($wParam, 0x0000FFFF) =  $ProcessWindowOK Then
		 SubWindowOK()
	 ElseIf BitAND($wParam, 0x0000FFFF) =  $ProcessWindowCancel Then
		 SubWindowCancel()
	 EndIf

     Return $GUI_RUNDEFMSG
 EndFunc

 Func On_Close()
	Switch @GUI_WinHandle ; See which GUI sent the CLOSE message
		Case $GUI1
			Exit
		Case $GUI2
			SubWindowClose()
	EndSwitch
EndFunc   ;==>On_Close