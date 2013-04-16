Setkeydelay,-1 
SetControlDelay,-1
Detecthiddenwindows,on
Coordmode,Menu,Window
;=======================================================
Init()
Global VIATC_INI := GetPath_VIATC_INI()
Global TCEXE := GetPath_TCEXE()
Global TCINI := GetPath_TCINI()
RegisterHotkey("J","<Down>","TQUICKSEARCH")
RegisterHotkey("K","<Up>","TQUICKSEARCH")
RegisterHotkey("0","<0>","TTOTAL_CMD")
RegisterHotkey("1","<1>","TTOTAL_CMD")
RegisterHotkey("2","<2>","TTOTAL_CMD")
RegisterHotkey("3","<3>","TTOTAL_CMD")
RegisterHotkey("4","<4>","TTOTAL_CMD")
RegisterHotkey("5","<5>","TTOTAL_CMD")
RegisterHotkey("6","<6>","TTOTAL_CMD")
RegisterHotkey("7","<7>","TTOTAL_CMD")
RegisterHotkey("8","<8>","TTOTAL_CMD")
RegisterHotkey("9","<9>","TTOTAL_CMD")
RegisterHotkey("k","<up>","TTOTAL_CMD")
RegisterHotkey("K","<upSelect>","TTOTAL_CMD")
RegisterHotkey("j","<down>","TTOTAL_CMD")
RegisterHotkey("J","<downSelect>","TTOTAL_CMD")
RegisterHotkey("h","<left>","TTOTAL_CMD")
RegisterHotkey("H","<cm_GotoPreviousDir>","TTOTAL_CMD")
RegisterHotkey("l","<right>","TTOTAL_CMD")
RegisterHotkey("L","<cm_GotoNextDir>","TTOTAL_CMD")
RegisterHotkey("I","<CreateNewFile>","TTOTAL_CMD")
RegisterHotkey("i","<Insert_Mode_TC>","TTOTAL_CMD")
RegisterHotkey("d","<cm_DirectoryHotlist>","TTOTAL_CMD")
RegisterHotkey("D","<cm_OpenDesktop>","TTOTAL_CMD")
RegisterHotkey("e","<cm_ContextMenu>","TTOTAL_CMD")
RegisterHotkey("E","<cm_ExeCuteDOS>","TTOTAL_CMD")
RegisterHotkey("N","<cm_DirectoryHistory>","TTOTAL_CMD")
RegisterHotkey("n","<azHistory>","TTOTAL_CMD")
RegisterHotkey("m","<Mark>","TTOTAL_CMD")
RegisterHotkey("M","<Half>","TTOTAL_CMD")
RegisterHotkey("'","<ListMark>","TTOTAL_CMD")
RegisterHotkey("u","<GoToParentEx>","TTOTAL_CMD")
RegisterHotkey("U","<cm_GoToRoot>","TTOTAL_CMD")
RegisterHotkey("o","<cm_LeftOpenDrives>","TTOTAL_CMD")
RegisterHotkey("O","<cm_RightOpenDrives>","TTOTAL_CMD")
RegisterHotkey("q","<cm_SrcQuickView>","TTOTAL_CMD")
RegisterHotkey("r","<cm_RenameOnly>","TTOTAL_CMD")
RegisterHotkey("R","<cm_MultiRenameFiles>","TTOTAL_CMD")
RegisterHotkey("x","<cm_Delete>","TTOTAL_CMD")
RegisterHotkey("X","<ForceDelete>","TTOTAL_CMD")
RegisterHotkey("w","<cm_List>","TTOTAL_CMD")
RegisterHotkey("y","<cm_CopyNamesToClip>","TTOTAL_CMD")
RegisterHotkey("Y","<cm_CopyFullNamesToClip>","TTOTAL_CMD")
RegisterHotkey("P","<cm_PackFiles>","TTOTAL_CMD")
RegisterHotkey("p","<cm_UnpackFiles>","TTOTAL_CMD")
RegisterHotkey("t","<cm_OpenNewTab>","TTOTAL_CMD")
RegisterHotkey("T","<cm_OpenNewTabBg>","TTOTAL_CMD")
RegisterHotkey("/","<cm_ShowQuickSearch>","TTOTAL_CMD")
RegisterHotkey("?","<cm_SearchFor>","TTOTAL_CMD")
RegisterHotkey("[","<cm_SelectCurrentName>","TTOTAL_CMD")
RegisterHotkey("{","<cm_UnselectCurrentName>","TTOTAL_CMD")
RegisterHotkey("]","<cm_SelectCurrentExtension>","TTOTAL_CMD")
RegisterHotkey("}","<cm_UnSelectCurrentExtension>","TTOTAL_CMD")
RegisterHotkey("\","<cm_ExchangeSelection>","TTOTAL_CMD")
RegisterHotkey("|","<cm_ClearAll>","TTOTAL_CMD")
RegisterHotkey("-","<cm_SwitchSeparateTree>","TTOTAL_CMD")
RegisterHotkey("=","<cm_MatchSrc>","TTOTAL_CMD")
RegisterHotkey(":","<cm_FocusCmdLine>","TTOTAL_CMD")
RegisterHotkey("G","<LastLine>","TTOTAL_CMD")
RegisterHotkey("ga","<cm_CloseAllTabs>","TTOTAL_CMD")
RegisterHotkey("gg","<GoToLine>","TTOTAL_CMD")
RegisterHotkey("gn","<cm_SwitchToNextTab>","TTOTAL_CMD")
RegisterHotkey("gp","<cm_SwitchToPreviousTab>","TTOTAL_CMD")
RegisterHotkey("gc","<cm_CloseCurrentTab>","TTOTAL_CMD")
RegisterHotkey("gb","<cm_OpenDirInNewTabOther>","TTOTAL_CMD")
RegisterHotkey("ge","<cm_Exchange>","TTOTAL_CMD")
RegisterHotkey("gw","<cm_ExchangeWithTabs>","TTOTAL_CMD")
RegisterHotkey("g1","<cm_SrcActivateTab1>","TTOTAL_CMD")
RegisterHotkey("g2","<cm_SrcActivateTab2>","TTOTAL_CMD")
RegisterHotkey("g3","<cm_SrcActivateTab3>","TTOTAL_CMD")
RegisterHotkey("g4","<cm_SrcActivateTab4>","TTOTAL_CMD")
RegisterHotkey("g5","<cm_SrcActivateTab5>","TTOTAL_CMD")
RegisterHotkey("g6","<cm_SrcActivateTab6>","TTOTAL_CMD")
RegisterHotkey("g7","<cm_SrcActivateTab7>","TTOTAL_CMD")
RegisterHotkey("g8","<cm_SrcActivateTab8>","TTOTAL_CMD")
RegisterHotkey("g9","<cm_SrcActivateTab9>","TTOTAL_CMD")
RegisterHotkey("g0","<GoLastTab>","TTOTAL_CMD")
RegisterHotkey("sn","<cm_SrcByName>","TTOTAL_CMD")
RegisterHotkey("se","<cm_SrcByExt>","TTOTAL_CMD")
RegisterHotkey("ss","<cm_SrcBySize>","TTOTAL_CMD")
RegisterHotkey("sd","<cm_SrcByDateTime>","TTOTAL_CMD")
RegisterHotkey("sr","<cm_SrcNegOrder>","TTOTAL_CMD")
RegisterHotkey("s1","<cm_SrcSortByCol1>","TTOTAL_CMD")
RegisterHotkey("s2","<cm_SrcSortByCol2>","TTOTAL_CMD")
RegisterHotkey("s3","<cm_SrcSortByCol3>","TTOTAL_CMD")
RegisterHotkey("s4","<cm_SrcSortByCol4>","TTOTAL_CMD")
RegisterHotkey("s5","<cm_SrcSortByCol5>","TTOTAL_CMD")
RegisterHotkey("s6","<cm_SrcSortByCol6>","TTOTAL_CMD")
RegisterHotkey("s7","<cm_SrcSortByCol7>","TTOTAL_CMD")
RegisterHotkey("s8","<cm_SrcSortByCol8>","TTOTAL_CMD")
RegisterHotkey("s9","<cm_SrcSortByCol9>","TTOTAL_CMD")
RegisterHotkey("s0","<cm_SrcUnsorted>","TTOTAL_CMD")
RegisterHotkey("v","<cm_SrcCustomViewMenu>","TTOTAL_CMD")
RegisterHotkey("Vb","<cm_VisButtonbar>","TTOTAL_CMD")
RegisterHotkey("Vd","<cm_VisDriveButtons>","TTOTAL_CMD")
RegisterHotkey("Vo","<cm_VisTwoDriveButtons>","TTOTAL_CMD")
RegisterHotkey("Vr","<cm_VisDriveCombo>","TTOTAL_CMD")
RegisterHotkey("Vc","<cm_VisDriveCombo>","TTOTAL_CMD")
RegisterHotkey("Vt","<cm_VisTabHeader>","TTOTAL_CMD")
RegisterHotkey("Vs","<cm_VisStatusbar>","TTOTAL_CMD")
RegisterHotkey("Vn","<cm_VisCmdLine>","TTOTAL_CMD")
RegisterHotkey("Vf","<cm_VisKeyButtons>","TTOTAL_CMD")
RegisterHotkey("Vw","<cm_VisDirTabs>","TTOTAL_CMD")
RegisterHotkey("Ve","<cm_CommandBrowser>","TTOTAL_CMD")
RegisterHotkey("zz","<cm_50Percent>","TTOTAL_CMD")
RegisterHotkey("zi","<WinMaxLeft>","TTOTAL_CMD")
RegisterHotkey("zo","<WinMaxRight>","TTOTAL_CMD")
RegisterHotkey("zt","<AlwayOnTop>","TTOTAL_CMD")
RegisterHotkey("zn","<cm_Minimize>","TTOTAL_CMD")
RegisterHotkey("zm","<cm_Maximize>","TTOTAL_CMD")
RegisterHotkey("zr","<cm_Restore>","TTOTAL_CMD")
RegisterHotkey("zv","<cm_VerticalPanels>","TTOTAL_CMD")
RegisterHotkey("zv","<cm_VerticalPanels>","TTOTAL_CMD")
RegisterHotkey("zs","<TransParent>","TTOTAL_CMD")
RegisterHotkey(".","<Repeat>","TTOTAL_CMD")
RegisterHotkey("<lwin>e","<ToggleTC>")
SetHotkey("esc","<Normal_Mode_TC>","TTOTAL_CMD")
ReadConfigToRegHK()
Traytip, ,ViATc 载入完毕,,17
Sleep,1800
Traytip
;RegisterHotkey("zf","<TCFullScreen>","TTOTAL_CMD")
;RegisterHotkey("zl","<TCLite>","TTOTAL_CMD")
;RegisterHotkey("zq","<QuitTC>","TTOTAL_CMD")
;RegisterHotkey("za","<ReloadTC>","TTOTAL_CMD")
; ==========================================
;Esc必须要以下列形式映射热键
;保证Esc的功能不被hotkeycontrol影响
;如果不这样映射，则退回正常模式将会失效
; ==========================================
return
;===================================================
; 读取配置并注册热键
ReadConfigToRegHK()
{
	Config_section := VIATC_IniRead()
	Loop,Parse,Config_section,`n
	{
		; Global为全局域，注册全局热键
		If RegExMatch(A_LoopField,"i)^Global$")
		{
			; Global时，Class为空
			CLASS :=
			; 获取Global的热键列表
			KeyList := VIATC_IniRead("Global")
			Loop,Parse,KeyList,`n
			{
				;获取INI中的热键部分
				Key := RegExReplace(A_LoopField,"=[<\(\{\[].*[\]\}\)>]$")
				;获取热键对应的Action
				Action := SubStr(A_LoopField,Strlen(Key)+2,Strlen(A_LoopField))
				;注册热键
				If RegExMatch(Key,"^\$.*")
				{
					Key := SubStr(Key,2)
					If RegExMatch(Key,"^[^\$].*")
					{
						Key := ResolveHotkey(Key)
						SetHotkey(Key.1,Action,CLASS)
						Continue
					}
				}
				RegisterHotkey(Key,Action,CLASS)
			}
		}
		; 所有以AHKC开头的域，用来注册对应CLASS的热键
		If RegExMatch(A_LoopField,"^AHKC_")
		{
			;获取类
			AHKC := A_LoopField ;获取AHKC_XXXXX 类，此时的LoopField为外部循环
			;从AHKC中获取CLASS类
			CLASS := SubStr(AHKC,6,Strlen(AHKC))
			;获取AHKC对应的热键列表
			KeyList := VIATC_IniRead(AHKC)
			Loop,Parse,KeyList,`n
			{
				;获取INI中的热键部分
				Key := RegExReplace(A_LoopField,"=[\[<\(\{].*[\]\}\)>]$")
				;获取热键对应的Action
				Action := SubStr(A_LoopField,Strlen(Key)+2,Strlen(A_LoopField))
				;注册热键
				If RegExMatch(Key,"^\$.*")
				{
					Key := SubStr(Key,2)
					If RegExMatch(Key,"^[^\$].*")
					{
						Key := ResolveHotkey(Key)
						SetHotkey(Key.1,Action,CLASS)
						Continue
					}
				}
				RegisterHotkey(Key,Action,CLASS)
			}
		}
	}
}
<GetClassByView>:
	GetClassByView()
return
GetClassByView()
{
	Gui, Add, ListView, x2 y0 w400 h500, Title|Class
	for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
	{
		name := Process.name
		Process,Exist,%name%
		ID := ErrorLevel
		WinGetClass,Class,AHK_PID %ID%
		If Class
		{
			WinGetTitle,Title,AHK_PID %ID%
   		 	LV_Add("", Title,class)
		}
	}
	Gui, Show,, Process List
}
<GetClassByMouse>:
	GetClassByMouse()
return
GetClassByMouse()
{
	MouseGetPos, , , id
	WinGetClass, class, ahk_id %id%
	ToolTip,AHKC_%class%
	Sleep,2000
	Tooltip
}	
; 读取ini文件，如果读取的项是VIATC的选项，则在读取不到的时候创建
VIATC_IniRead(section="",key="")
{
	IniRead,Value,%VIATC_INI%,%section%,%key%
	If RegExMatch(Value,"ERROR")
	{
		Value := Options(key)
		If Not RegExMatch(Value,"^ERROR$")
		{
			IniWrite,%Value%,%VIATC_INI%,%section%,%key%
		}
		Else
			Value := ""
	}
	Return Value
}
; 添加INI
VIATC_IniWrite(section,key,value)
{
	IniWrite,%Value%,%VIATC_INI%,%section%,%key%
	Return ErrorLevel
}
; 删除INI
VIATC_IniDelete(section,key)
{
	IniDelete,%VIATC_INI%,%section%,%key%
	Return ErrorLevel
}
; 返回选项及其默认值到数组中,非选项返回ERROR
Options(opt)
{
	If RegExMatch(opt,"^TrayIcon$")
		Return True
	If RegExMatch(opt,"^VimMode$")
		Return True
	If RegExMatch(opt,"^TransParent$")
		Return False
	If RegExMatch(opt,"^Startup$")
		Return False
	If RegExMatch(opt,"^GroupWarn$")
		Return True
	If RegExMatch(opt,"^MaxCount$")
		Return 99
	If RegExMatch(opt,"^Toggle$")
		Return "<lwin>e"
	If RegExMatch(opt,"^TranspVar$")
		Return 220
	If RegExMatch(opt,"^SearchEng$")
		Return "http://www.baidu.com/s?wd={%1}"
	Return "ERROR"
}
; 获取VIATC的配置文件路径
GetPath_VIATC_INI()
{
	NeedRegWrite := False
	Loop ;这里的Loop无用，只是用来当某个条件成立时，停止查找用的
	{
	;在当前目录查找
		gPath := A_ScriptDir "\viatc.ini"
		If FileExist(gPath)
			Break
	;在VIATC注册表里查找
		RegRead,gPath,HKEY_CURRENT_USER,Software\ViATc,ViATcIni
			If FileExist(gPath) 
				Break
			Else
				NeedRegWrite := True
	;在TC目录里查找
		TCEXE := GetPath_TCEXE()
		Splitpath,TCEXE,,TCDir
		gPath := TCDir "\viatc.ini"
		If FileExist(gPath)
			break
	;使用GUI查找
		FileSelectFile,gPath,3,,查找TC配置文件(wincmd.ini),*.ini
		If ErrorLevel
		{
			Msgbox 查找ViATc.ini文件失败
			return
		}
	;保存到VIATC注册表里
		break
	}
	If FileExist(gPath)
	{
		If NeedRegWrite
			Regwrite,REG_SZ,HKEY_CURRENT_USER,Software\VIATC,ViATcINI,%gPath%
		return gPath
	}
}
; 获取wincmd.ini配置文件路径
GetPath_TCINI()
{
	NeedRegWrite := False
	Loop ;这里的Loop无用，只是用来当某个条件成立时，停止查找用的
	{
	;查找VIATC的注册表值
		RegRead,gPath,HKEY_CURRENT_USER,Software\ViATc,IniFileName
		If FileExist(gPath) 
			Break
		Else
			NeedRegWrite := True
	;在当前目录查找
		gPath := A_ScriptDir "\wincmd.ini"
		If FileExist(gPath)
			Break
		TCEXE := GetPath_TCEXE()
		Splitpath,TCEXE,,TCDir
		gPath := TCDir "\wincmd.ini"
		If FileExist(gPath)
			break
	;使用GUI查找
		FileSelectFile,gPath,3,,查找TC配置文件(wincmd.ini),*.ini
		If ErrorLevel
		{
			Msgbox 查找TC配置文件失败
			return
		}
		break
	}
	;保存到VIATC注册表值里
	If FileExist(gPath)
	{
		If NeedRegWrite
			Regwrite,REG_SZ,HKEY_CURRENT_USER,Software\VIATC,IniFileName,%gPath%
		return gPath
	}
}
; 获取Totalcmd.exe文件路径
GetPath_TCEXE()
{
	NeedRegWrite := False ;是否需要写注册表
	Loop ;这里的Loop无用，只是用来当某个条件成立时，停止查找用的
	{
		;查找VIATC的注册表值
		RegRead,gPath,HKEY_CURRENT_USER,Software\ViATc,InstallDir
		If FileExist(gPath) 
			Break
		Else
			NeedRegWrite := True
		;使用进程进行查找
		Process,Exist,TOTALCMD.exe
		PID := ErrorLevel
		WinGet,gPath,ProcessPath,AHK_PID %PID%
		If gPath
			Break
		;在当前目录查找
		gPath := A_ScriptDir "\totalcmd.exe"
		If FileExist(gPath)
			Break
		gPath := A_ScriptDir "\totalcmd64.exe"
		If FileExist(gPath)
			Break
		;使用GUI查找
		FileSelectFile,gPath,3,,查找TOTALCMD.exe或者TOTALCMD64.exe,*.exe
		If ErrorLevel
		{
			Msgbox 查找Totalcmd.exe失败
			return
		}
		Break
	}
	If FileExist(gPath)
	{
		If NeedRegWrite
			Regwrite,REG_SZ,HKEY_CURRENT_USER,Software\VIATC,InstallDir,%gPath%
		Return gPath
	}
	;保存到VIATC注册表值里
}
EmptyMem()
{
	return
}
;===================================================
#include vimcore.0.2.1.ahk
;#include Actions\Debug.ahk
#include Actions\General.ahk
#include Actions\TCCOMMAND.ahk
#include Actions\TConly.ahk
#include Actions\MSWord.ahk
#include Actions\temp.ahk
#include Actions\Tools.ahk
#include Actions\TCCOMMAND+.ahk
