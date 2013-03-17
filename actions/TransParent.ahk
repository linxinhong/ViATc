; <TransParent> {{{2
<TransParent>:
		TransParent()
Return
TransParent()
{
	WinGet,TranspVar,Transparent,ahk_class TTOTAL_CMD
	If TranspVar <> 255
	{
		WinSet,Transparent,255,ahk_class TTOTAL_CMD
	}
	Else
	{
		TranspVar:= 220
		WinSet,Transparent,%TranspVar%,ahk_class TTOTAL_CMD
	}
}
