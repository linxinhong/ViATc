Setkeydelay,-1 
SetControlDelay,-1
Detecthiddenwindows,on
Coordmode,Menu,Window
;=======================================================
Init()
Global VIATC_INI := GetPath_VIATC_INI()
Global TCEXE := GetPath_TCEXE()
Global TCINI := GetPath_TCINI()
Vim_HotkeyList .= " <> "
ReadConfigToRegHK()
;Msgbox % Substr(Vim_HotkeyList,RegExMatch(Vim_HotkeyList,"\s<>\s"))
Traytip,,ViATc 载入完毕,,17
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
#include Actions\QDir.ahk
