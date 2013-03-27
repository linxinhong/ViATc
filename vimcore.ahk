; vimcore 0.0.1
; 2013-03-01
; by Array ( linxinhong.sky@gmail.com )

#UseHook on
; Global Var {{{1
; 全局变量，请勿修改
Init()
{
	GoSub,<Init>
	GoSub,<LoadPlugin>
}
<Init>:
	Global ViATcKey := []
	Global Actions := []
	Global HotkeyTemp := ""
	Global HotkeyCount := 0
	Global ViMode := True
	Global NeedReload := False
	GroupAdd,ViGroup,ahk_class TTOTAL_CMD
return
End()
{
	EmptyMem()
}
;===============================================
; 若要自定义模式切换，不使用Esc，请修改这里！
; 错误处理及提示
<Error>:
return
; 留空处理
<None>:
return
; Core Function {{{1
; 核心函数
<SingleHotkey>:
	SingleHotkey()
return
SingleHotkey()
{
	WinGet,MenuID,ID,AHK_CLASS #32768
	If MenuID
	{
		Send,%A_ThisHotkey%
		Return
	}
	If HotkeyTemp 
		GoSub,<GroupKey>
	Else
	{
		WinGetClass, Class, A
		IfWinActive,ahk_group ViGroup
		{
			If CheckCapsLock()
				iMatch := "\tH" . KeyToMatch(GetThisHotkey()) . "\s"
			HotkeyTemp := "H" . GetThisHotkey() . " " . Class 
		}
		Else
		{
			If CheckCapsLock()
				iMatch := "\tS" . KeyToMatch(GetThisHotkey()) . "\s"
			HotkeyTemp := "S" . GetThisHotkey() . " " . Class
		}
		If CheckCapsLock()
		{
			If RegExMatch(ViATcKey["AllKeys"],iMatch)
				ExecSub(ViATcKey[HotkeyTemp])
			Else
			{
				HotkeyTemp :=
				GoSub,<GroupKeyStart>
				return
			}
		}
		Else
			ExecSub(ViATcKey[HotkeyTemp])
		HotkeyTemp :=
	}
}
<GroupKeyStart>:
	GroupKeyStart()
return
GroupKeyStart()
{
	WinGet,MenuID,ID,AHK_CLASS #32768
	If MenuID
	{
		Send,%A_ThisHotkey%
		Return
	}
	If HotkeyTemp
		GoSub,<GroupKey>
	Else
	{
		IfWinActive,ahk_group ViGroup
		{
			If CheckCapsLock()
				iMatch := "\tH" . KeyToMatch(GetThisHotkey()) . "\s"
			HotkeyTemp := "H" . GetThisHotkey() 
		}
		Else
		{
			If CheckCapsLock()
				iMatch := "\tS" . KeyToMatch(GetThisHotkey()) . "\s"
			HotkeyTemp := "S" . GetThisHotkey()
		}
		If CheckCapsLock()
		{
			If RegExMatch(ViATcKey["Allkeys"],iMatch)
			{
				HotkeyTemp :=
				GoSub,<SingleHotkey>
			}
		}
		;Tooltip,% Help(SubStr(HotkeyTemp,2))
	}
}
<GroupKey>:
	GroupKey()
return
GroupKey()
{
	HotkeyTemp .= GetThisHotkey()
	WinGetClass, Class, A
	gMatch := "\t" . KeyToMatch(HotkeyTemp) . "\s" . KeyToMatch(Class) . "\t"
	cMatch := "\t" . KeyToMatch(HotkeyTemp) . "[^\t]"
	AllKeys := ViATcKey["AllKeys"]
	If RegExMatch(AllKeys,gMatch)
	{
		HotkeyTemp .= " " . Class
		ExecSub(ViATcKey[HotkeyTemp])
		HotkeyTemp :=
	}
	Else
	{
		If Not RegExMatch(ViATcKey["AllKeys"],cMatch)
			HotkeyTemp :=
	}
}
; RegisterHotkey() {{{2
; 注册热键
RegisterHotkey(Scope="H",Key="",Action="<SingleHotkey>",ViCLASS="TTOTAL_CMD")
{
	; 如果需要Reload，先不映射
	If NeedReload 
		Return
	; 判断各个参数是否有意义
	If IsLabel(Action)
	{
		If RegExMatch(Scope,"^S$")
		{
			Hotkey,IfWinActive ;,AHK_CLASS TTOTAL_CMD
			KeyList := ResolveHotkey(key)
			SetHotkey(KeyList[1],Action)
			return
		}
		If RegExMatch(Scope,"^H$")
			Hotkey,IfWinActive,ahk_class %ViCLASS%
		For,i,GetKey In ResolveHotkey(Key)
		{
			If i = 1
			{
				Key1 := GetKey
				SetHotkey(GetKey,"<SingleHotKey>",ViClass)
			}
			If i > 1
			{
				If Not IsHotKey(GetKey,ViClass)
					SetHotkey(GetKey,"<SingleHotkey>",ViClass)
			}
			; 将原先第一个热键注册为<GroupKeyStart>
			If i = 2
				SetHotkey(Key1,"<GroupKeyStart>",ViClass)
			KeyList .= GetKey
		}
	}
	Else
		Msgbox % Key " map to Label " Action "Error !"
	; Save to ViATcKey
	NeedleRegEx := "\t" . Scope . KeyToMatch(KeyList) . "\s" . ViCLASS . "\t"
	If Not RegExMatch(ViATcKey["AllKeys"],NeedleRegEx)
		ViATcKey["AllKeys"] .= A_Tab . Scope . KeyList . A_Space . ViCLASS . A_Tab
	Key := Scope . KeyList . A_Space . ViCLASS
	ViATcKey[Key] := Action
	GroupAdd,ViGroup,ahk_class %ViCLASS%
	return
}
IsHotkey(Key,class)
{
	item := key . class 
	kMatch := "\s" . KeyToMatch(item) . "\s"
	Return RegExMatch(ViATcKey["Exist"],kMatch)
}
; SetHotkey(sKey,sAction) {{{2
; 设置热键功能,只是方便，不然写太多Hotkey也累啊！
SetHotkey(sKey,sAction,Class="")
{
	; 如果需要Reload，先不映射
	If NeedReload 
		Return
	If Class
		Hotkey,IfWinActive,ahk_class %Class%
	If Not IsHotKey(sKey,class)
		ViATcKey["Exist"] .= " " . sKey . class . " "
	Hotkey,%sKey%,%sAction%,On,UseErrorLevel
	If ErrorLevel
	{
		Msgbox % "Key " sKey " map to " sAction "Error !"
		return
	}
}
; ExecSub(Label) {{{2
; 执行标签
ExecSub(Label)
{
	If ( Not Label ) 
	{
		HotkeyCount := 0
		Return
	}
	If RegExMatch(Label,"<\d>")
	{
		HotkeyCount := HotkeyCount * 10 + Substr(Label,2,1)
		If HotkeyCount > 99
			HotkeyCount := 99
		Return
	}
	If Not IsLabel(Label)
		Msgbox % Label " Error !"
	If IsLabel(Label) 
	{
		If HotkeyCount
			LoopCount := HotkeyCount
		Else
			LoopCount := 1
		Loop % LoopCount
		{
			If LoopCount
				GoSub % Label
			Else
				Break
			LoopCount := HotkeyCount
		}
	}
	HotkeyCount := 0
	EmptyMem()
}
<LoadPlugin>:
	LoadPlugin()
return
; LoadPlugin() {{{2
; 加载脚本，并修改VIATC
LoadPlugin()
{
	IfExist %A_Workingdir%\Actions
	{
		Loop,%A_Workingdir%\Actions\*.ahk
		{
			Label := "<" RegExReplace(A_LoopFileName,"\.ahk") ">"
			If IsLabel(Label)
			{
				GoSub,%Label%
				Continue
			}
			Else
			{
				NeedReload := true
				FileAppend, #include Actions\%A_LoopFileName%`n , %A_ScriptName%
			}
		}	
		If NeedReload
			msgbox,4,Plugin,新动作添加完毕，请重启！
		IfMsgbox yes
			Reload
	}
}
; CustomActions(Action,Info="") {{{2
; 添加自定义Actions的帮助信息
CustomActions(Action,Info="")
{
	aMatch := KeyToMatch(Action)
	If Not RegExMatch(Actions["All"],aMatch)
	{
		Actions["All"] .= Action 
		Actions[action] := Info
	}
}
; HotkeyControl(Control) {{{2
; 启用或者禁用热键 
HotkeyControl(control)
{
	If ViMode = %control%
		return
	Else
		ViMode := !ViMode
	AllKeys := ViATcKey["AllKeys"]
	Loop,Parse,AllKeys,%A_Tab%
	{
		If A_LoopField
		{
			Scope := Substr(A_LoopField,1,1)
			Pos := 1 
			GetClass := SubStr(A_LoopField,InStr(A_LoopField," ",false,0))
			KeyList := HotkeyFilter(A_LoopField)
			For,i,Key in KeyList
			{
				If RegExMatch(Scope,"H")
				;	Hotkey,IfWinActive, ahk_class %GetClass%
				;   奇怪的是，用上面那个语法，会出错，而用下面的则不会。没找着原因!
					Hotkey,IfWinActive,% "ahk_class" GetClass
				Else
					Hotkey,IfWinActive
				If Control
				{
					Hotkey,%Key%,on ,,UseErrorLevel
					;If ErrorLevel
					;	Msgbox % Key
				}	
				Else
				{
					Hotkey,%Key%,off ,,UseErrorLevel
					;If ErrorLevel
					;	Msgbox % Key
				}	
			}
		}
	}
	Return !control
}
; ResolveHotkey(SrcKey) {{{2
; 解析为多个单键
ResolveHotkey(SrcKey)
{
	DstKey := []  , rKeyTemp := []
	rIndex := 1 , rKey := "" , rchar := ""
	switch := False
	Loop,Parse,SrcKey
	{
		If RegExMatch(A_LoopField,"<") And (Not switch)
		{
			switch := True
			Continue
		}
		If Not RegExMatch(A_LoopField,"<") And (Not switch)
		{
			rchar := A_LoopField
			If Asc(A_LoopField) >= 65 And Asc(A_LoopField) <= 90
			{
				rKeyTemp[rIndex] := "shift"
				rIndex++
				rKeyTemp[rIndex] := Chr(Asc(rchar)+32)
			}	
			Else
				rKeyTemp[rIndex] := rchar
			rKey := ""
			rIndex++
			Continue
		}
		If RegExMatch(A_LoopField,">") And switch
		{
			switch := False
			If RegExMatch(rkey,"i)(l|r)?(ctrl|shift|win|alt|Escape|f\d\d?)") 
			{
				rKeyTemp[rIndex] := rKey
				rKey := ""
				rIndex++
				Continue
			}
			Else
			{
				Msgbox % "<" rKey "> ERROR !`rPlease Check " SrcKey " !"
				GoSub,BreakResolve
			}
		}
		rKey .= A_LoopField
	}
	;Msgbox % rkey
	; 保存rKeyTemp到DstKey数列中
	rIndex := 1
	For,i,rKey in rKeyTemp
	{
		If RegExMatch(rkey,"i)(l|r)?(ctrl|shift|win|alt)") 
			List .= rKey " & " 
		Else
		{
			List .= rKey
			DstKey[rIndex] := List
			rIndex++
			List := 
		}
	}
	return DstKey
	BreakResolve:
	return
}
; UnResolveHotkey(Key) {{{2
; 反解析热键
UnResolveHotkey(Key)
{
	Loop
	{
		If RegExMatch(Key,"shift\s&\s.",m)
		{
			Match := Chr(Asc(Substr(m,0))-32)
			Key := RegExReplace(Key,KeyToMatch(m),Match)
		}
		Else
			Break
	}
	Loop
	{
		If RegExMatch(key,"i)(l|r)?(ctrl|alt|win)\s&\s",m)
		{
			Match := "<" . RegExReplace(m,"\s&\s",">")
			Key := RegExReplace(Key,KeyToMatch(m),Match)
		}
		Else
			Break
	}
	return Key
}
; HotkeyFilter(Src,Location) {{{2
; 热键过滤器，用于将组合热键过滤成多个单一热键
; Location 控制要输出的单键位置
; 默认为0，即过滤所有热键
HotkeyFilter(SrcKey,Location=0)
{
	Match := []
	Src := Substr(SrcKey,2,StrLen(Src)-StrLen(SubStr(A_LoopField,InStr(A_LoopField," ",false,0))))
	Pos := 1
	KeyIndex := 1
	Loop,Parse,Src
	{
		If strlen(Src) < Pos
			Break
		If RegExMatch(Src,"(((l|r)?(shift|alt|ctrl|win)\s&\s.)|f\d\d?|Escape)",m,Pos) = Pos
		{
			Match[KeyIndex] := m
			KeyIndex++
			Pos += Strlen(m)
		}
		Else
		{
			Match[KeyIndex] := SubStr(Src,Pos,1)
			KeyIndex++
			Pos++
		}
	}
	If Location 
		Return Match[Location]
	Else
		Return Match
}
; KeyToMatch(Key) {{{2
; 当需要进行热键判断时，需要先将热键转换为
; RegExMatch和RegExReplace函数可识别的字符串
KeyToMatch(Key)
{
	Key := RegExReplace(Key,"\+|\?|\.|\*|\{|\}|\(|\)|\||\^|\$|\[|\]|\\","\$0")
	Return RegExReplace(Key,"\s","\s")
	
}
; GetThisHotkey() {{{2
; 获得当前热键，区分大小写
GetThisHotkey()
{
	If CheckCapsLock()
	{
		If RegExMatch(A_ThisHotkey,"^[a-z]$")
			ThisHotkey := "shift & " . A_ThisHotkey
		Else If RegExMatch(A_ThisHotkey,"i)^(l|r)?shift\s&\s[a-z]$") 
			ThisHotkey := Substr(A_ThisHotkey,0)
		Else
			ThisHotkey := A_ThisHotkey
	}
	Else
		ThisHotkey := A_ThisHotkey
	Return ThisHotkey
}
CheckCapsLock()
{
	GetKeyState,Var,CapsLock,T
	If Var = D
		Return true
	Else
		Return False
}


; EmptyMem() {{{2
; 减少内存使用
EmptyMem(PID="AHK Rocks")
{
    pid:=(pid="AHK Rocks") ? DllCall("GetCurrentProcessId") : pid
    h:=DllCall("OpenProcess", "UInt", 0x001F0FFF, "Int", 0, "Int", pid)
    DllCall("SetProcessWorkingSetSize", "UInt", h, "Int", -1, "Int", -1)
    DllCall("CloseHandle", "Int", h)
}
