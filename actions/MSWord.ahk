; 所有程序通用
<MSWord>:
	CustomActions("<Wordleft>","向左移动[Count]次")
	CustomActions("<WordRight>","向右移动[Count]次")
	CustomActions("<WordUp>","向上移动[Count]次")
	CustomActions("<WordDown>","向下移动[Count]次")
return
<WordAdd>:
	oWord := ComObjCreate("Word.Application")
	oWord.Documents.Add
	oWord.Selection.TypeText("Line1`n")
	oWord.Selection.TypeText("Line2`n")
	oWord.Selection.TypeText("Line3`n")
	oWord.Visible := True
return
<WordLeft>:
	oWord.Selection.Previous(1,1).Select
return
<WordRight>:
	oWord.Selection.Next(1,1).Select
return
<WordUp>:
	oWord.Selection.MoveUp(5,1)
return
<WordDown>:
	oWord.Selection.MoveDown(5,1)
return
