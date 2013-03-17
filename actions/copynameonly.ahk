; <CopyNameOnly> {{{2
<CopyNameOnly>:
		CopyNameOnly()
Return
CopyNameOnly()
{
	clipboard :=
	GoSub,<CopyNamesToClip>
	ClipWait
	If Not RegExMatch(clipboard,"^\..*")
		clipboard := RegExReplace(RegExReplace(clipboard,"\\$"),"\.[^\.]*$")
}
