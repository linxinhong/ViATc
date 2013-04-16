<Tools>:
	CustomActions("<ShowIPAddr>","显示IP地址")
	CustomActions("<RunGVIM>","运行GVIM")
return
<ShowIPAddr>:
	Msgbox % A_IPAddress1 "`n" A_IPAddress2 "`n" A_IPAddress3 "`n" A_IPAddress4
return
<RunGVIM>:
	ExecSub("(e:\Program Files\Vim\vim73\gvim.exe)")
return
<ListHotkey>:
	Gui,Destroy
	Gui,Font,s9
	GUi,+Theme
	Gui,Add,ListView,Grid r20 w700 h400,作用域|热键|动作|描述
	Lv_ModifyCol(1,120)
	Lv_ModifyCol(2,150)
	Lv_ModifyCol(3,150)
	Lv_ModifyCol(4,300)
	idx := 1
	Loop,Parse,Vim_HotkeyList,%A_Tab%
	If A_LoopField
	{
		M := HK_Read(A_LoopField)
		Class := M.Class ? M.Class : "全局"
		LV_Add(idx,Class,M.Key,M.Action,Vim_Actions[M.Action])
		idx++
	}
	Gui,Show,h450
return
<MsgHKL>:
	;Msgbox 晓琪我爱你！by 欣宏
	;return
	Msgbox % Vim_HotkeyList
return
<MsgHKE>:
	Msgbox % Vim_HotkeyExist
return
<MsgClass>:
	For,i,k in Vim_Actions
		if Not RegExMatch(i,"^<.*>$") 
		m .=  i "|"
	Gui,Destroy
	Gui,Font,s9
	GUi,+Theme
	Gui,Add,DropDownList,choose1 gchangelist,%m%
	Gui,Add,ListView,Grid r20 w700 h400,动作|描述
	Lv_ModifyCol(1,200)
	idx := 1
	all := Vim_Actions["All"]
	Loop,Parse,all,%A_Space%
	If A_LoopField
	{
		LV_Add(idx,A_LoopField,Vim_Actions[A_LoopField])
		idx++
	}
	Gui,Show,h450
return
ChangeList:
	ChangeList()
Return
ChangeList()
{
	LV_Delete()
	GuiControlGet,k,,ComboBox1
	all := Vim_Actions[k]
	Loop,Parse,all,%A_Space%
	If A_LoopField
	{
		LV_Add(idx,A_LoopField,Vim_Actions[A_LoopField])
		idx++
	}
}
