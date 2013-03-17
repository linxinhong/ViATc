; <AlwayOnTop> {{{2
<AlwayOnTop>:
		AlwayOnTop()
Return
AlwayOnTop()
{
	win :=  WinExist(A)
	WinGet,ExStyle,ExStyle,ahk_id %win%
	If (ExStyle & 0x8)
   		WinSet,AlwaysOnTop,off,ahk_id %win%
	else
   		WinSet,AlwaysOnTop,on,ahk_id %win%
}
