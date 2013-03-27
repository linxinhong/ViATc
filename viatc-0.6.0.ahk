Setkeydelay,-1 
SetControlDelay,-1
Detecthiddenwindows,on
Coordmode,Menu,Window
Init()
;=======================================================
TCPath := "e:\Program Files\totalcmd\TOTALCMD.EXE"
If RegExMatch(TcPath,"i)totalcmd64\.exe$")
{
	Global TCListBox := "LCLListBox"
	Global TCEdit := "Edit2"
	GLobal TCPanel1 := "Window1"
	Global TCPanel2 := "Window11"
}
Else
{
	Global TCListBox := "TMyListBox"
	Global TCEdit := "Edit1"
	Global TCPanel1 := "TPanel1"
	Global TCPanel2 := "TMyPanel8"
}
;=======================================================
; RegisterHotkey {{{1
RegisterHotkey("H","0","<0>")
RegisterHotkey("H","1","<1>")
RegisterHotkey("H","2","<2>")
RegisterHotkey("H","3","<3>")
RegisterHotkey("H","4","<4>")
RegisterHotkey("H","5","<5>")
RegisterHotkey("H","6","<6>")
RegisterHotkey("H","7","<7>")
RegisterHotkey("H","8","<8>")
RegisterHotkey("H","9","<9>")
RegisterHotkey("H","<lctrl>j<alt>k<lwin>aAV","<CreateNewFile>")
RegisterHotkey("H","<f1>","<ListViATc>")
RegisterHotkey("H","<f2>","<ListActions>")
RegisterHotkey("H","k","<up>")
RegisterHotkey("H","K","<upSelect>")
RegisterHotkey("H","j","<down>")
RegisterHotkey("H","J","<downSelect>")
RegisterHotkey("H","h","<left>")
RegisterHotkey("H","H","<GotoPreviousDir>")
RegisterHotkey("H","l","<right>")
RegisterHotkey("H","L","<GotoNextDir>")
RegisterHotkey("H","I","<CreateNewFile>")
RegisterHotkey("H","i","<insert_TC>")
RegisterHotkey("H","d","<DirectoryHotlist>")
RegisterHotkey("H","D","<OpenDesktop>")
RegisterHotkey("H","e","<ContextMenu>")
RegisterHotkey("H","E","<ExeCuteDOS>")
;RegisterHotkey("H","f","<LabelControl>")
RegisterHotkey("H","N","<DirectoryHistory>")
RegisterHotkey("H","n","<azHistory>")
RegisterHotkey("H","m","<Mark>")
RegisterHotkey("H","M","<Half>")
RegisterHotkey("H","'","<ListMark>")
RegisterHotkey("H","u","<GoToParent>")
RegisterHotkey("H","o","<LeftOpenDrives>")
RegisterHotkey("H","O","<RightOpenDrives>")
RegisterHotkey("H","q","<SrcQuickView>")
RegisterHotkey("H","r","<RenameOnly>")
RegisterHotkey("H","R","<MultiRenameFiles>")
RegisterHotkey("H","x","<Delete>")
RegisterHotkey("H","X","<ForceDelete>")
RegisterHotkey("H","w","<List>")
RegisterHotkey("H","y","<CopyNamesToClip>")
RegisterHotkey("H","Y","<CopyFullNamesToClip>")
RegisterHotkey("H","P","<PackFiles>")
RegisterHotkey("H","p","<UnpackFiles>")
RegisterHotkey("H","t","<OpenNewTab>")
RegisterHotkey("H","T","<OpenNewTabBg>")
RegisterHotkey("H","/","<ShowQuickSearch>")
RegisterHotkey("H","?","<SearchFor>")
RegisterHotkey("H","[","<SelectCurrentName>")
RegisterHotkey("H","{","<UnselectCurrentName>")
RegisterHotkey("H","]","<SelectCurrentExtension>")
RegisterHotkey("H","}","<UnSelectCurrentExtension>")
RegisterHotkey("H","\","<ExchangeSelection>")
RegisterHotkey("H","|","<ClearAll>")
RegisterHotkey("H","-","<SwitchSeparateTree>")
RegisterHotkey("H","=","<MatchSrc>")
RegisterHotkey("H","G","<LastLine>")
RegisterHotkey("H","ga","<CloseAllTabs>")
RegisterHotkey("H","gg","<GoToLine>")
RegisterHotkey("H","gn","<SwitchToNextTab>")
RegisterHotkey("H","gp","<SwitchToPreviousTab>")
RegisterHotkey("H","gc","<CloseCurrentTab>")
RegisterHotkey("H","gb","<OpenDirInNewTabOther>")
RegisterHotkey("H","ge","<Exchange>")
RegisterHotkey("H","gw","<ExchangeWithTabs>")
RegisterHotkey("H","g1","<SrcActivateTab1>")
RegisterHotkey("H","g2","<SrcActivateTab2>")
RegisterHotkey("H","g3","<SrcActivateTab3>")
RegisterHotkey("H","g4","<SrcActivateTab4>")
RegisterHotkey("H","g5","<SrcActivateTab5>")
RegisterHotkey("H","g6","<SrcActivateTab6>")
RegisterHotkey("H","g7","<SrcActivateTab7>")
RegisterHotkey("H","g8","<SrcActivateTab8>")
RegisterHotkey("H","g9","<SrcActivateTab9>")
RegisterHotkey("H","g0","<GoLastTab>")
RegisterHotkey("H","sn","<SrcByName>")
RegisterHotkey("H","se","<SrcByExt>")
RegisterHotkey("H","ss","<SrcBySize>")
RegisterHotkey("H","sd","<SrcByDateTime>")
RegisterHotkey("H","sr","<SrcNegOrder>")
RegisterHotkey("H","s1","<SrcSortByCol1>")
RegisterHotkey("H","s2","<SrcSortByCol2>")
RegisterHotkey("H","s3","<SrcSortByCol3>")
RegisterHotkey("H","s4","<SrcSortByCol4>")
RegisterHotkey("H","s5","<SrcSortByCol5>")
RegisterHotkey("H","s6","<SrcSortByCol6>")
RegisterHotkey("H","s7","<SrcSortByCol7>")
RegisterHotkey("H","s8","<SrcSortByCol8>")
RegisterHotkey("H","s9","<SrcSortByCol9>")
RegisterHotkey("H","s0","<SrcUnsorted>")
RegisterHotkey("H","v","<SrcCustomViewMenu>")
RegisterHotkey("H","Vb","<VisButtonbar>")
RegisterHotkey("H","Vd","<VisDriveButtons>")
RegisterHotkey("H","Vo","<VisTwoDriveButtons>")
RegisterHotkey("H","Vr","<VisDriveCombo>")
RegisterHotkey("H","Vc","<VisDriveCombo>")
RegisterHotkey("H","Vt","<VisTabHeader>")
RegisterHotkey("H","Vs","<VisStatusbar>")
RegisterHotkey("H","Vn","<VisCmdLine>")
RegisterHotkey("H","Vf","<VisKeyButtons>")
RegisterHotkey("H","Vw","<VisDirTabs>")
RegisterHotkey("H","Ve","<CommandBrowser>")
RegisterHotkey("H","Z","<Reload>")
RegisterHotkey("H","zz","<50Percent>")
RegisterHotkey("H","zi","<WinMaxLeft>")
RegisterHotkey("H","zo","<WinMaxRight>")
RegisterHotkey("H","zt","<AlwayOnTop>")
RegisterHotkey("H","zn","<Minimize>")
RegisterHotkey("H","zm","<Maximize>")
RegisterHotkey("H","zr","<Restore>")
RegisterHotkey("H","zv","<VerticalPanels>")
RegisterHotkey("H","zs","<TransParent>")
RegisterHotkey("S","<lwin>e","<ToggleTC>")
;RegisterHotkey("H","zf","<TCFullScreen>")
;RegisterHotkey("H","zl","<TCLite>")
;RegisterHotkey("H","zq","<QuitTC>")
;RegisterHotkey("H","za","<ReloadTC>")
; ==========================================
; MSWord ===================================
; ==========================================
RegisterHotkey("H","a","<WordAdd>","OpusApp")
RegisterHotkey("H","j","<WordDown>","OpusApp")
RegisterHotkey("H","k","<WordUp>","OpusApp")
RegisterHotkey("H","h","<WordLeft>","OpusApp")
RegisterHotkey("H","l","<WordRight>","OpusApp")
RegisterHotkey("H","i","<Insert_TC>","OpusApp")
RegisterHotkey("H","zt","<AlwayOnTop>","OpusApp")
RegisterHotkey("H","zs","<TransParent>","OpusApp")
RegisterHotkey("H","0","<0>","OpusApp")
RegisterHotkey("H","1","<1>","OpusApp")
RegisterHotkey("H","2","<2>","OpusApp")
RegisterHotkey("H","3","<3>","OpusApp")
RegisterHotkey("H","4","<4>","OpusApp")
RegisterHotkey("H","5","<5>","OpusApp")
RegisterHotkey("H","6","<6>","OpusApp")
RegisterHotkey("H","7","<7>","OpusApp")
RegisterHotkey("H","8","<8>","OpusApp")
RegisterHotkey("H","9","<9>","OpusApp")
; ==========================================
;Esc必须要以下列形式映射热键
;保证Esc的功能不被hotkeycontrol影响
;如果不这样映射，则退回正常模式将会失效
; ==========================================
SetHotkey("Escape","<Esc_TC>","TTOTAL_CMD")
SetHotkey("Escape","<Esc_TC>","OpusApp")
End()
;HotkeyControl(False)
return
;===================================================
#include vimcore.ahk
#include Actions\Debug.ahk
#include Actions\General.ahk
#include Actions\TCCOMMAND.ahk
#include Actions\TConly.ahk
#include Actions\MSWord.ahk
