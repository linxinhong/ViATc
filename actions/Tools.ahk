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
; <ListHotkey>: {{{2
<ListHotkey>:
	;Gui_Help()
;return
;Gui_Help()
{
	Gui,Destroy
	Gui,Font, s10
	Gui,Add,ListBox,w90 h400 x10 y10 t2 gGui_ChangeTab, 全局配置|热键|宏|插件|帮助
	Gui,Add,Button,x10 y420 w90 h25 center,配置文件(&E)
	Gui,Add,Button,x340 y420 w70 h25 center,应用(&A)
	Gui,Add,Button,x420 y420 w70 h25 center,确定(&O)
	Gui,Add,Button,x500 y420 w70 h25 center,取消(&C)
	Gui,Add,Tab2,  x110 y-25  w480 h460 buttons AltSubmit ,全局配置|热键|宏|插件|帮助
	Gui,Tab,1
	Gui,Add,CheckBox
	Gui,Tab,2
	Gui,Add,ListView,Grid r20 x110 y10 w480 h320 vListview_HKL,作用域|热键|动作|描述
	Gui,Add,Text,x110 y345 w60,作用域&V:
	Gui,Add,Edit,x170 y343 w120 h20
	Gui,Add,Button,x300 y343 w30 h20 g<GetClassByMouse>,&+
	Gui,Add,Text,x110 y375 w60,热键&H:
	Gui,Add,Edit,x170 y373 w160 h20 g<chkHK>
	Gui,Tab,3
	Gui,Add,edit
	Gui,Tab,4
	Gui,Add,DropDownList,choose1 gGui_ChangeList x110 y10 vDD_PLS ,
	Gui_DropDown()
	Gui,Add,ListView,Grid r20 x110 y40 w480 h364 vListview_PLS,动作|描述
	Gui,Tab,5
	Gui,Add,listview
	Gui_HKList()
	Gui_PLSList()
	Gui,Show,w600 h460,ViATc设置
	OnMessage(0x03,"t")
	Settimer,Gui_Edit_HK,50
}
return
Gui_Edit_HK:
	Gui_Edit_HK()
return
Gui_Edit_HK()
{
	GuiControlGet,f,Focus
	If f = Edit2
		chkHK()
	Else
		Tooltip,,,,2
}
t(x,y)
{
	tooltip
		Tooltip,,,,2
	Settimer,t,on
	v := false
}
t:
	settimer,t,off
	v := true
	sleep,200
	GuiControlGet,f,Focus
	If f = Edit2 and v
		chkhk()
return
;==========================
; Gui_DropDown() {{{2
Gui_DropDown()
{
	For,i,k in Vim_Actions
	if Not RegExMatch(i,"^[\(\{\[<].*[>\)\}\]]$") 
		m .=  i "|"
	GuiControl,,ComboBox1,%m%
	GuiControl,Choose,ComboBox1,1
}
; Gui_PLSList() {{{2
Gui_PLSList()
{
	Gui,ListView,ListView_PLS
	Lv_ModifyCol(1,200)
	idx := 1
	all := Vim_Actions["All"]
	Loop,Parse,all,%A_Space%
	If A_LoopField
	{
		LV_Add(idx,A_LoopField,Vim_Actions[A_LoopField])
		idx++
	}
}
;==========================
; Gui_HKList() {{{2
Gui_HKList()
{
	Gui,ListView,ListView_HKL
	Lv_ModifyCol(1,100)
	Lv_ModifyCol(2,100)
	Lv_ModifyCol(3,120)
	Lv_ModifyCol(4,180)
	idx := 1
	Loop,Parse,Vim_HotkeyList,%A_Tab%
	{
		If RegExMatch(A_LoopField,"(\d+\|[^\s]*){3}")
		{
			M := HK_Read(A_LoopField)
			Class := M.Class ? M.Class : "全局"
			LV_Add(idx,Class,M.Key,M.Action,Vim_Actions[M.Action])
			idx++
		}
	}
}
; Gui_ChangeTab() {{{2
Gui_ChangeTab:
	Gui_ChangeTab()
return
Gui_ChangeTab()
{
	GuiControlGet,tab,,ListBox1
	GuiControl,Choose,SysTabControl321,%Tab%
}
; Gui_ChangeList() {{{2
Gui_ChangeList:
	Gui_ChangeList()
Return
Gui_ChangeList()
{
	Gui,ListView,ListView_PLS
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
<GetClassByView>:
	GetClassByView()
return
GetClassByView()
{
	Gui, New
	Gui, Add, ListView, x2 y0 w400 h500, Title|Class
	for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
	{
		name := Process.name
		Process,Exist,%name%
		ID := ErrorLevel
		WinGetClass,Class,AHK_PID %ID%
		If Class
		{
			WinGetTitle,Title,AHK_PID %ID%
   		 	LV_Add("", Title,class)
		}
	}
	Gui, Show,, Process List
}
<GetClassByMouse>:
	GetClassByMouse()
return
GetClassByMouse()
{
	Settimer,<gcbm>,200
	Hotkey,IfWinActive
	Hotkey,RButton,<gcbmOK>,on
}
<gcbmOK>:
	gcbmOK()
return
gcbmOK()
{
	Settimer,<gcbm>,off
	Hotkey,RButton,<gcbmOK>,off
	Winactivate,AHK_CLASS AutoHotkeyGUI
}
<gcbm>:
	gcbm()
return
gcbm()
{
	MouseGetPos, , , id
	WinGetClass, class, ahk_id %id%
	GuiControl,,Edit1,%class%
}
<chkHK>:
	chkHK()
return
chkHK()
{
	GuiControlGet,hk,,Edit2
	GuiControlGet, p, Pos,Edit2
	n := 1
	For,i,k in ResolveHotkey(hk)
	{
		m .= "第" i "个热键>>"  k "`n"
		n++
	}
    PosX := px + 3
	PosY := py + 50
	Tooltip,%m%,%PosX%,%PosY%,2
}
;=========================================
<MsgHKL>:
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


/*
	Function: Anchor
		Defines how controls should be automatically positioned relative to the new dimensions of a window when resized.

	Parameters:
		cl - a control HWND, associated variable name or ClassNN to operate on
		a - (optional) one or more of the anchors: 'x', 'y', 'w' (width) and 'h' (height),
			optionally followed by a relative factor, e.g. "x h0.5"
		r - (optional) true to redraw controls, recommended for GroupBox and Button types

	Examples:
> "xy" ; bounds a control to the bottom-left edge of the window
> "w0.5" ; any change in the width of the window will resize the width of the control on a 2:1 ratio
> "h" ; similar to above but directrly proportional to height

	Remarks:
		To assume the current window size for the new bounds of a control (i.e. resetting) simply omit the second and third parameters.
		However if the control had been created with DllCall() and has its own parent window,
			the container AutoHotkey created GUI must be made default with the +LastFound option prior to the call.
		For a complete example see anchor-example.ahk.

	License:
		- Version 4.60a <http://www.autohotkey.net/~polyethene/#anchor>
		- Dedicated to the public domain (CC0 1.0) <http://creativecommons.org/publicdomain/zero/1.0/>
*/
Anchor(i, a = "", r = false) {
	static c, cs = 12, cx = 255, cl = 0, g, gs = 8, gl = 0, gpi, gw, gh, z = 0, k = 0xffff
	If z = 0
		VarSetCapacity(g, gs * 99, 0), VarSetCapacity(c, cs * cx, 0), z := true
	If (!WinExist("ahk_id" . i)) {
		GuiControlGet, t, Hwnd, %i%
		If ErrorLevel = 0
			i := t
		Else ControlGet, i, Hwnd, , %i%
	}
	VarSetCapacity(gi, 68, 0), DllCall("GetWindowInfo", "UInt", gp := DllCall("GetParent", "UInt", i), "UInt", &gi)
		, giw := NumGet(gi, 28, "Int") - NumGet(gi, 20, "Int"), gih := NumGet(gi, 32, "Int") - NumGet(gi, 24, "Int")
	If (gp != gpi) {
		gpi := gp
		Loop, %gl%
			If (NumGet(g, cb := gs * (A_Index - 1)) == gp) {
				gw := NumGet(g, cb + 4, "Short"), gh := NumGet(g, cb + 6, "Short"), gf := 1
				Break
			}
		If (!gf)
			NumPut(gp, g, gl), NumPut(gw := giw, g, gl + 4, "Short"), NumPut(gh := gih, g, gl + 6, "Short"), gl += gs
	}
	ControlGetPos, dx, dy, dw, dh, , ahk_id %i%
	Loop, %cl%
		If (NumGet(c, cb := cs * (A_Index - 1)) == i) {
			If a =
			{
				cf = 1
				Break
			}
			giw -= gw, gih -= gh, as := 1, dx := NumGet(c, cb + 4, "Short"), dy := NumGet(c, cb + 6, "Short")
				, cw := dw, dw := NumGet(c, cb + 8, "Short"), ch := dh, dh := NumGet(c, cb + 10, "Short")
			Loop, Parse, a, xywh
				If A_Index > 1
					av := SubStr(a, as, 1), as += 1 + StrLen(A_LoopField)
						, d%av% += (InStr("yh", av) ? gih : giw) * (A_LoopField + 0 ? A_LoopField : 1)
			DllCall("SetWindowPos", "UInt", i, "Int", 0, "Int", dx, "Int", dy
				, "Int", InStr(a, "w") ? dw : cw, "Int", InStr(a, "h") ? dh : ch, "Int", 4)
			If r != 0
				DllCall("RedrawWindow", "UInt", i, "UInt", 0, "UInt", 0, "UInt", 0x0101) ; RDW_UPDATENOW | RDW_INVALIDATE
			Return
		}
	If cf != 1
		cb := cl, cl += cs
	bx := NumGet(gi, 48), by := NumGet(gi, 16, "Int") - NumGet(gi, 8, "Int") - gih - NumGet(gi, 52)
	If cf = 1
		dw -= giw - gw, dh -= gih - gh
	NumPut(i, c, cb), NumPut(dx - bx, c, cb + 4, "Short"), NumPut(dy - by, c, cb + 6, "Short")
		, NumPut(dw, c, cb + 8, "Short"), NumPut(dh, c, cb + 10, "Short")
	Return, true
}

