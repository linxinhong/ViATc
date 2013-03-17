; <WinMaxLeft> {{{2
<WinMax>:
return
<WinMaxLeft>:
	WinMaxLR(true)
Return
; <WinMaxRight> {{{2
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
