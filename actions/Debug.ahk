; <ListViATc>
; <Reload>
; <ListViATc> {{{1
<Debug>:
return
; <Reload> {{{1
<ListViATc>:
	msgbox % ViATcKey["AllKeys"]
return
; <ListActions> {{{1
<ListActions>:
	;msgbox % Actions["All"]
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
return
; <Reload> {{{1
<Reload>:
	Reload
return
