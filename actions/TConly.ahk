<TConly>:
	Global Mark := []
	Global NewFile := []
	CustomActions("<Esc_TC>","返回正常模式")
	CustomActions("<Insert_TC>","进入插入模式")
	CustomActions("<ToggleTC>","打开/激活TC")
	CustomActions("<azHistory>","a-z历史导航")
	CustomActions("<DownSelect>","向下选择")
	CustomActions("<UpSelect>","向上选择")
	CustomActions("<WinMaxLeft>","最大化左侧窗口")
	CustomActions("<WinMaxRight>","最大化右侧窗口")
	CustomActions("<GoLastTab>","切换到最后一个标签")
	CustomActions("<CopyNameOnly>","只复制文件名，不含扩展名")
	CustomActions("<GotoLine>","移动到[count]行，默认第一行")
	CustomActions("<LastLine>","移动到[count]行，默认最后一行")
	CustomActions("<Half>","移动到窗口中间行")
	CustomActions("<CreateNewFile>","新建文件")
	ReadNewFile()
return
; <Esc_TC> {{{1
<Esc_TC>:
	Send,{Esc}
	HotkeyControl(true)	
	EmptyMem()
return
; <insert_TC> {{{1
<insert_TC>:
	HotkeyControl(False)	
return
; <ToggleTC> {{{1
<ToggleTC>:
	IfWinExist,AHK_CLASS TTOTAL_CMD	
		WinActivate,AHK_CLASS TTOTAL_CMD
	Else
		Run,%TCPath%
	Loop,4
	{
		IfWinNotActive,AHK_CLASS TTOTAL_CMD
			WinActivate,AHK_CLASS TTOTAL_CMD
		Else
			Break
		Sleep,500
	}
	EmptyMem()
return
; <azHistory> {{{1
<azHistory>:
		azhistory()
Return
azhistory()
{
	GoSub,<DirectoryHistory>
	Sleep, 100
	if WinExist("ahk_class #32768")
	{
	SendMessage,0x01E1 ;Get Menu Hwnd
    hmenu := ErrorLevel
    if hmenu!=0
    {
		If Not RegExMatch(GetMenuString(Hmenu,1),".*[\\|/]$")
			Return
		Menu,sh,add
		Menu,sh,deleteall
		a :=
        itemCount := DllCall("GetMenuItemCount", "Uint", hMenu, "Uint")
		Loop %itemCount%
	 	{
			a := chr(A_Index+64) . ">>" .  GetMenuString(Hmenu,A_Index-1)
			Menu,SH,add,%a%,azSelect
		}
		Send {Esc}
		ControlGetFocus,TLB,ahk_class TTOTAL_CMD
		ControlGetPos,xn,yn,,,%TLB%,ahk_class TTOTAL_CMD
		Menu,SH,show,%xn%,%yn%
		Return
    }
	}	
}
GetMenuString(hMenu, nPos)
{
      VarSetCapacity(lpString, 256) 
      length := DllCall("GetMenuString"
         , "UInt", hMenu
         , "UInt", nPos
         , "Str", lpString
         , "Int", 255
         , "UInt", 0x0400)
   	  return lpString
}
azSelect:
	azSelect()
Return
azSelect()
{
	nPos := A_ThisMenuItem
	nPos := Asc(Substr(nPos,1,1)) - 64
	Winactivate,ahk_class TTOTAL_CMD
	Postmessage,1075,572,0,,ahk_class TTOTAL_CMD
	Sleep,100
	if WinExist("ahk_class #32768")
	{
		Loop %nPos%
			SendInput {Down}
		Send {enter}
	}
}
; <DownSelect> {{{1
<DownSelect>:
	Send +{Down}
return
; <upSelect> {{{1
<upSelect>:
	Send +{Up}
return
; <WinMaxLeft> {{{1
<WinMaxLeft>:
	WinMaxLR(true)
Return
; <WinMaxRight> {{{1
<WinMaxRight>:
	WinMaxLR(false)
Return
WinMaxLR(lr)
{
	If lr
	{
		ControlGetPos,x,y,w,h,%TCPanel2%,ahk_class TTOTAL_CMD
		ControlGetPos,tm1x,tm1y,tm1W,tm1H,%TCPanel1%,ahk_class TTOTAL_CMD
		If (tm1w < tm1h) ; 判断纵向还是横向 Ture为竖 false为横
		{
			ControlMove,%TCPanel1%,x+w,,,,ahk_class TTOTAL_CMD
		}
		else
			ControlMove,%TCPanel1%,0,y+h,,,ahk_class TTOTAL_CMD
		ControlClick, %TCPanel1%,ahk_class TTOTAL_CMD 
		WinActivate ahk_class TTOTAL_CMD
	}
	Else
	{
		ControlMove,%TCPanel1%,0,0,,,ahk_class TTOTAL_CMD
		ControlClick,%TCPanel1%,ahk_class TTOTAL_CMD
		WinActivate ahk_class TTOTAL_CMD
	}
}
; <GoLastTab> {{{1
<GoLastTab>:
	GoSub,<SrcActivateTab1>
	GoSub,<SwitchToPreviousTab>
return
; <CopyNameOnly> {{{1
<CopyNameOnly>:
		CopyNameOnly()
Return
CopyNameOnly()
{
	clipboard :=
	GoSub,<CopyNamesToClip>
	ClipWait
	If Not RegExMatch(clipboard,"^\..*")
		clipboard := RegExReplace(RegExReplace(clipboard,"\\$"),"\.[^\.]*$")
}
; <ForceDelete>  {{{1
; 强制删除
<ForceDelete>:
	Send +{Delete}
return
; <GotoLine> {{{1
; 转到[count]行,缺省第一行
<GotoLine>:
	If HotkeyCount
		GotoLine(HotkeyCount)
	Else
		GotoLine(1)
return
; <LastLine> {{{1
; 转到[count]行, 最后一行
<LastLine>:
	If HotkeyCount
		GotoLine(HotkeyCount)
	Else
		GotoLine(0)
return
GotoLine(Index)
{
	HotkeyCount := 0
	ControlGetFocus,Ctrl,AHK_CLASS TTOTAL_CMD
	If Index
	{
		Index--
		ControlGet,text,List,,%ctrl%,AHK_CLASS TTOTAL_CMD
		Stringsplit,T,Text,`n
		Last := T0 - 1
		If Index > %Last%
			Index := Last
		Postmessage,0x19E,%Index%,1,%Ctrl%,AHK_CLASS TTOTAL_CMD
	}
	Else
	{
		ControlGet,text,List,,%ctrl%,AHK_CLASS TTOTAL_CMD
		Stringsplit,T,Text,`n
		Last := T0 - 1
		PostMessage, 0x19E,  %Last% , 1 , %CTRL%, AHK_CLASS TTOTAL_CMD
	}
}
; <Half>  {{{1
; 移动到窗口中间
<Half>:
		Half()
Return
Half()
{
	winget,tid,id,ahk_class TTOTAL_CMD
	controlgetfocus,ctrl,ahk_id %tid%
	controlget,cid,hwnd,,%ctrl%,ahk_id %tid%
	controlgetpos,x1,y1,w1,h1,THeaderClick2,ahk_id %tid%
	controlgetpos,x,y,w,h,%ctrl%,ahk_id %tid%
	SendMessage,0x01A1,1,0,,ahk_id %cid%
	Hight := ErrorLevel
	SendMessage,0x018E,0,0,,ahk_id %cid%
	Top := ErrorLevel
	HalfLine := Ceil( ((h-h1)/Hight)/2 ) + Top
	PostMessage, 0x19E, %HalfLine%, 1, , AHK_id %cid%
}
; <Mark> {{{1
; 标记功能
<Mark>:
	Mark()
Return
Mark()
{
	HotkeyControl(False)	
	GoSub,<FocusCmdLine>
	ControlGet,EditId,Hwnd,,AHK_CLASS TTOTAL_CMD
	ControlSetText,%TCEdit%,m,AHK_CLASS TTOTAL_CMD
	Postmessage,0xB1,2,2,%TCEdit%,AHK_CLASS TTOTAL_CMD
	SetTimer,<MarkTimer>,100
}
<MarkTimer>:
	MarkTimer()
Return
MarkTimer()
{
	ControlGetFocus,ThisControl,AHK_CLASS TTOTAL_CMD
	ControlGetText,OutVar,%TCEdit%,AHK_CLASS TTOTAL_CMD
	Match_TCEdit := "i)^" . TCEdit . "$"
	If Not RegExMatch(ThisControl,Match_TCEdit) OR Not RegExMatch(Outvar,"i)^m.?")
	{
		HotkeyControl(true)	
		Settimer,<MarkTimer>,Off
		Return
	}
	If RegExMatch(OutVar,"i)^m.$")
	{
		HotkeyControl(true)	
		SetTimer,<MarkTimer>,off
		ControlSetText,%TCEdit%,,AHK_CLASS TTOTAL_CMD
		ControlSend,%TCEdit%,{Esc},AHK_CLASS TTOTAL_CMD
		ClipSaved := ClipboardAll
		Clipboard :=
		Postmessage 1075, 2029, 0, , ahk_class TTOTAL_CMD
		ClipWait
		Path := Clipboard
		Clipboard := ClipSaved
		If StrLen(Path) > 80
		{
			SplitPath,Path,,PathDir
			Path1 := SubStr(Path,1,15)
			Path2 := SubStr(Path,RegExMatch(Path,"\\[^\\]*$")-Strlen(Path))
			Path := Path1 . "..." . SubStr(Path2,1,65) "..."
		}
		M := SubStr(OutVar,2,1)
		mPath := "&" . m . ">>" . Path
		If RegExMatch(Mark["ms"],m)
		{
			DelM := Mark[m]
			Menu,MarkMenu,Delete,%DelM%
			Menu,MarkMenu,Add,%mPath%,<AddMark>
			Mark["ms"] := Mark["ms"] . m
			Mark[m] := mPath
		}
		Else
		{
			Menu,MarkMenu,Add,%mPath%,<AddMark>
			Mark["ms"] := Mark["ms"] . m
			Mark[m] := mPath
		}
	}
}
<AddMark>:
	AddMark()
Return
AddMark()
{
	ThisMenuItem := SubStr(A_ThisMenuItem,5,StrLen(A_ThisMenuItem))
	If RegExMatch(ThisMenuItem,"i)\\\\桌面$")
	{
		Postmessage 1075, 2121, 0, , ahk_class TTOTAL_CMD
		Return
	}
	If RegExMatch(ThisMenuItem,"i)\\\\计算机$")
	{
		Postmessage 1075, 2122, 0, , ahk_class TTOTAL_CMD
		Return
	}
	If RegExMatch(ThisMenuItem,"i)\\\\所有控制面板项$")
	{
		Postmessage 1075, 2123, 0, , ahk_class TTOTAL_CMD
		Return
	}
	If RegExMatch(ThisMenuItem,"i)\\\\Fonts$")
	{
		Postmessage 1075, 2124, 0, , ahk_class TTOTAL_CMD
		Return
	}
	If RegExMatch(ThisMenuItem,"i)\\\\网络$")
	{
		Postmessage 1075, 2125, 0, , ahk_class TTOTAL_CMD
		Return
	}
	If RegExMatch(ThisMenuItem,"i)\\\\打印机$")
	{
		Postmessage 1075, 2126, 0, , ahk_class TTOTAL_CMD
		Return
	}
	If RegExMatch(ThisMenuItem,"i)\\\\回收站$")
	{
		Postmessage 1075, 2127, 0, , ahk_class TTOTAL_CMD
		Return
	}
	ControlSetText, %TCEdit%, cd %ThisMenuItem%, ahk_class TTOTAL_CMD
	ControlSend, %TCEdit%, {Enter}, ahk_class TTOTAL_CMD
	Return
}
; <ListMark> {{{1
; 显示标记
<ListMark>:
	ListMark()
Return
ListMark()
{
	If Not Mark["ms"]
		Return
	ControlGetFocus,TLB,ahk_class TTOTAL_CMD
	ControlGetPos,xn,yn,,,%TLB%,ahk_class TTOTAL_CMD
	Menu,MarkMenu,Show,%xn%,%yn%
}
; <CreateNewFile> {{{1
; 新建文件
<CreateNewFile>:
	CreateNewFile()
return
CreateNewFile()
{
	Loop % NewFile[0]
	{
		RegExMatch(NewFile[A_Index],".*\)",File,1)
		Menu,CreateNewFile,Add,%File%,NewFile
	}
	Menu,CreateNewFile,Show
		;Msgbox % NewFile[A_Index]
}
NewFile:
	Msgbox % A_ThisMenuItemPos
return
ReadNewFile()
{
	NewFile[0] := 0
	SetBatchLines -1
	Path := "e:\Program Files\totalcmd\ShellNew\"
	Loop,HKEY_CLASSES_ROOT ,,1,0
	{
		If RegExMatch(A_LoopRegName,"^\..*")
		{
			Reg := A_LoopRegName
			Loop,HKEY_CLASSES_ROOT,%Reg%,1,1
			{
				If RegExMatch(A_LoopRegName,"i)shellnew")
				{
					NewReg := A_LoopRegSubKey "\shellnew"
					If RegGetNewFilePath(NewReg)
					{
						NewFile[0]++
						Index := NewFile[0]
						NewFile[Index] := RegGetFileDescribe(Reg) . "(" . Reg . ")[" . RegGetNewFilePath(NewReg) . "]"
					}
				}
			}
		}
	}
}
RegGetNewFilePath(reg)
{
	RegRead,GetRegPath,HKEY_CLASSES_ROOT,%Reg%,FileName
	IF Not ErrorLevel
		Return GetRegPath
	RegRead,GetRegPath,HKEY_CLASSES_ROOT,%Reg%,NullFile
	IF Not ErrorLevel
		Return "NullFile"
}
RegGetFileType(reg)
{
	RegRead,FileType,HKEY_CLASSES_ROOT,%Reg%
	If Not ErrorLevel
		Return % FileType
}
RegGetFileDescribe(reg)
{
	FileType := RegGetFileType(reg)
	RegRead,FileDesc,HKEY_CLASSES_ROOT,%FileType%
	If Not ErrorLevel
		Return % FileDesc
}
