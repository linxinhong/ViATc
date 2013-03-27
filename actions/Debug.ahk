; <ListViATc>
; <Reload>
; <ListViATc> {{{1
<Debug>:
return
; <Reload> {{{1
<ListViATc>:
	msgbox % ViATcKey["AllKeys"]
	Msgbox % ViATcKey["Exist"]
return
<ListHotkey>:
	Msgbox % ViATcKey["Exist"]
return
; <ListActions> {{{1
<ListActions>:
	;ListActions()
	Msgbox % Help("<lctrl>j")
return
ListActions()
{
	Info := ""
	Pos := 1
	Loop
	{
		If RegExMatch(Actions["All"],"<[^<>]*>",m,Pos)
			Info .= m . "  " . Actions[m] . "`n"
		Else
			Break
		Pos += Strlen(m)
	}
	FileAppend,%Info%,%A_WorkingDir%\help.txt
}
; <Reload> {{{1
<Help>:
	Help(string)
return
Help(string="")
{
	AllKeys := ViATcKey["AllKeys"]
	For,i,GetKey In ResolveHotkey(String)
	{
		Keys .= GetKey
	}
	WinGetClass,Class,A
	If Keys
		Match := "(H|S)" . KeyToMatch(Keys) . ".*" . Class
	Else
		Return
	DeleteMatch := "^.|" . KeyToMatch(Class)
	Loop,Parse,AllKeys,%A_Tab%
	{
		If RegExMatch(A_LoopField,Match)
			Helplist .= UnResolveHotKey(RegExReplace(A_LoopField,DeleteMatch))  ">>" Actions[ViATcKey[A_LoopField]] . "`n" 
	}
	return HelpList
	
}
<Reload>:
	Reload
return
