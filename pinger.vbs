Sub FindBadServers()

	Set objServerRead=objFSO.OpenTextFile("network.csv",1)
	Set objServerWrite=objFSO.CreateTextFile("temp.csv",8)
	'skipping header
	objServerRead.Readline
	
	Do Until objServerRead.AtEndOfStream
		line=Split(objServerRead.Readline,",")
		server = line(0)
		successes = CInt(line(1))
		runs = CInt(line(2))
		lastSuccessfulRun = line(3)
		
		set objPing = GetObject("winmgmts:").Get("Win32_PingStatus.Address='"&server&"'")
		if objPing.StatusCode = 0 then
			successes = successes + 1
			lastSuccessfulRun = Now
		end if
		
		objServerWrite.writeline server +","+ CStr(successes) +","+ CStr(runs+1) +","+ CStr(lastSuccessfulRun)
		
	Loop
	
	objServerRead.Close
	objServerWrite.Close
	
End Sub


Sub FileOverwrite()

	if objFSO.fileExists("network.csv") then
		objFSO.DeleteFile("network.csv")
	end if
	
	Set tempfile = objFSO.OpenTextFile("temp.csv",1)
	Set newfile = objFSO.CreateTextFile("network.csv",8)
	newfile.writeline "IP"+","+"Successes"+","+"Attempts"+","+"Last Success"
	
	Do Until tempfile.AtEndOfStream
		newfile.writeline tempfile.Readline
	Loop
	
	newfile.Close
	tempfile.Close
	
	objFSO.DeleteFile("temp.csv")
	
End Sub	


Function timedBox(DelayTime)

	Set box = Wscript.CreateObject("WScript.Shell")
	DelayTime = DelayTime
	
	timedBox = box.Popup("Runthrough complete. Halt?",DelayTime,"pinger",4)

End Function

'Main
Set objFSO=CreateObject("Scripting.FileSystemObject")

usage = msgbox ("Do you wish to set an end date?", vbYesNo, "pinger")

if usage = 7 then
	DelayTime = 300
	isExit = 7
	Do while isExit <> 6
		FindBadServers()
		FileOverwrite()
		isExit = timedBox(DelayTime)
	loop
elseif usage = 6 then
	enddate = InputBox("Enter the end date in the format MM/DD/YY:","pinger")
	tday = Now
	Do while tday < enddate
		FindBadServers()
		FileOverwrite()
		tday = Now
	loop
end if