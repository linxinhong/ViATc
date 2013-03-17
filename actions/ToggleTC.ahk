; <ToggleTC> {{{2
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
