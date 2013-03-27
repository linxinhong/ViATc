; 所有程序通用
<General>:
	CustomActions("<1>","计数前缀1")
	CustomActions("<2>","计数前缀2")
	CustomActions("<3>","计数前缀3")
	CustomActions("<4>","计数前缀4")
	CustomActions("<5>","计数前缀5")
	CustomActions("<6>","计数前缀6")
	CustomActions("<7>","计数前缀7")
	CustomActions("<8>","计数前缀8")
	CustomActions("<9>","计数前缀9")
	CustomActions("<0>","计数前缀0")
	CustomActions("<left>","向左移动[Count]次")
	CustomActions("<Right>","向右移动[Count]次")
	CustomActions("<Down>","向下移动[Count]次")
	CustomActions("<Up>","向上移动[Count]次")
	CustomActions("<AlwayOnTop>","设置窗口顶置")
	CustomActions("<TransParent>","设置窗口透明")
return
<1>:
return
<2>:
return
<3>:
return
<4>:
return
<5>:
return
<6>:
return
<7>:
return
<8>:
return
<9>:
return
<0>:
return
<Left>:
	Send,{left}
return
<Right>:
	Send,{Right}
return
<Down>:
	Send,{Down}
return
<Up>:
	Send,{Up}
return
; <AlwayOnTop> {{{1
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
; <TransParent> {{{1
<TransParent>:
		TransParent()
Return
TransParent()
{
	win :=  WinExist(A)
	WinGet,TranspVar,Transparent,ahk_id %win%
	If Not TranspVar ;第一次一般会获取到空值
	{
		WinSet,Transparent,220,ahk_id %win%
		return
	}
	If TranspVar <> 255 
	{
		WinSet,Transparent,255,ahk_id %win%
	}
	Else
	{
		TranspVar:= 220
		WinSet,Transparent,%TranspVar%,ahk_id %win%
	}
}

