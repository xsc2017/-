<!--#include file="AspCms_templateFun.asp" -->
<%
Function createTextFile(Byval content,Byval fileDir,Byval code)
	dim fileobj,fileCode : fileDir=replace(fileDir, "\", "/")
	if isNul(code) then fileCode="utf-8" else fileCode=code
	call createfolder(fileDir,"filedir")
	on error resume next
	With objStream
		.Charset=fileCode:
		.Type=2:
		.Mode=3:
		.Open:
		.Position=0
		.WriteText content:
		.SaveToFile Server.MapPath(fileDir), 2
		.Close
	End With
	if Err Then  err.clear :createTextFile=false : errid=err.number:errdes=err.description:Err.Clear : echoErr err_09,errid,errdes else createTextFile=true
End Function

Function createStreamFile(Byval stream,Byval fileDir)
	dim errid,errdes
	fileDir=replace(fileDir, "\", "/")
	call createfolder(fileDir,"filedir")
	on error resume next
	With objStream
		.Type =1
		.Mode=3  
		.Open
		.write stream
		.SaveToFile server.mappath(fileDir),2
		.close
	End With
	if Err Then  error.clear:createStreamFile=false else createStreamFile=true
End Function

'页面模式跳转
Function checkMode()
	dim host,path,query,reExp,isWap
	host = "http://"&request.ServerVariables("HTTP_HOST")
	path = replaceStr(request.ServerVariables("PATH_INFO"),"/index.asp","")
	query = request.ServerVariables("QUERY_STRING")
	isWap = checkWap()
	Set reExp = New RegExp
	reExp.IgnoreCase = True
	reExp.Global = True
	reExp.pattern=".*(\/wap).*"
	If isWap and switchWapStatus Then 
		pagemode="wap"  '手机终端并且开启状态,设置模式
		if not reExp.test(path) then 	'如果非手机地址，则跳转
			Response.Redirect host&"/wap/"&path&"?"&query
			Response.End()
		end if
	End If
	If not isWap and switchWapDebug=1 and reExp.test(path) then pagemode="wap"  '手机版调试模式
	If not isWap and switchWapDebug<>1 and reExp.test(path) Then '只要是电脑访问手机路径，一律转PC地址
		path = replace(path,"/wap","")
		Response.Redirect host&"/"&path&"?"&query
		Response.End()
	End If
	Set reExp = nothing
End Function

'检测是否为移动终端
Function checkWap()
	 dim flag:flag = false
	 dim MoblieUrl,reExp,MbStr
	 Set reExp = New RegExp
	 MbStr="Android|iPhone|Windows Phone|webOS|BlackBerry|iPod"
	 reExp.pattern=".*("&MbStr&").*"
	 reExp.IgnoreCase = True
	 reExp.Global = True
	 If reExp.test(Request.ServerVariables("HTTP_USER_AGENT")) Then
	   flag = true
	 End If
	 checkWap = flag
	 Set reExp = nothing
End Function

Function createFolder1(Byval dir,Byval dirType)
	dim subPathArray,lenSubPathArray, pathDeep, i
	on error resume next
	dir=replace(dir, "\", "/")
	dir=replace(server.mappath(dir), server.mappath("/"), "")
	subPathArray=split(dir, "\")
	pathDeep=pathDeep&server.mappath("/")
	select case dirType
		case "filedir"
			 lenSubPathArray=ubound(subPathArray) - 1
		case "folderdir"
			lenSubPathArray=ubound(subPathArray)
	end select
	for i=0 to  lenSubPathArray
		pathDeep=pathDeep&"\"&subPathArray(i)
		if not objFso.FolderExists(pathDeep) then objFso.CreateFolder pathDeep
	next
	if Err Then  createFolder=false : errid=err.number:errdes=err.description:Err.Clear : echoErr err_10,errid,errdes else createFolder=true
End Function

Function createFolder(Byval dir,Byval dirType)
dim subPathArray,lenSubPathArray, pathDeep, i
on error resume next
dir=replace(dir, "\", "/")
    if trim(sitePath) = "" then pathDeep = "/" else pathDeep = sitePath
    pathDeep = server.MapPath(pathDeep)
dir=replace(server.mappath(dir), pathDeep, "")
subPathArray=split(dir, "\")
select case dirType
case "filedir"
 lenSubPathArray=ubound(subPathArray) - 1
case "folderdir"
lenSubPathArray=ubound(subPathArray)
end select
for i=0 to  lenSubPathArray
        if trim(subPathArray(i)) <> "" then
    pathDeep=pathDeep&"\"&subPathArray(i)
    if not objFso.FolderExists(pathDeep) then objFso.CreateFolder pathDeep
        end if
next
if Err Then  createFolder=false : errid=err.number:errdes=err.description:Err.Clear : echoErr err_10,errid,errdes else createFolder=true
End Function


Function isExistFile(Byval fileDir)
	on error resume next
	If (objFso.FileExists(server.MapPath(fileDir))) Then  isExistFile=True  Else  isExistFile=False
	if err then err.clear:isExistFile=False
End Function

Function isExistFolder(Byval folderDir)
	on error resume next
	If objFso.FolderExists(server.MapPath(folderDir)) Then  isExistFolder=True Else isExistFolder=False
	if err then err.clear:isExistFolder=False
End Function

Function delFolder(Byval folderDir)
	on error resume next
	If isExistFolder(folderDir)=True Then  
		objFso.DeleteFolder(server.mappath(folderDir)) 
		if Err Then  delFolder=false : errid=err.number : errdes=err.description:Err.Clear : echoErr err_11,errid,errdes else delFolder=true
	else
		delFolder=false : die(err_13)
	end if
End Function 

Function delFile(Byval fileDir)
	on error resume next
	If isExistFile(fileDir)=True Then objFso.DeleteFile(server.mappath(fileDir))
	if  Err Then  delFile=false : errid=err.number : errdes=err.description:Err.Clear : echoErr err_12,errid,errdes else delFile=true
End Function 

Function initAllObjects()
	dim errid,errdes
	on error resume next
	if not isobject(objFso) then set objFso=server.createobject(FSO_OBJ_NAME)
	If Err Then errid=err.number:errdes=err.description:Err.Clear:echoErr err_05,errid,errdes
	if not isobject(objStream) then Set objStream=Server.CreateObject(STREAM_OBJ_NAME)
	If Err Then errid=err.number:errdes=err.description:Err.Clear:echoErr err_04,errid,errdes
End Function

Function terminateAllObjects()
	on error resume next
	if conn.isConnect then conn.close
	if isobject(conn) then : set conn=nothing
	if isobject(objFso) then set objFso=nothing
	if isobject(objStream) then set objStream=nothing
	if isObject(gXmlHttpObj) then SET gXmlHttpObj=Nothing
End Function

Function moveFolder(oldFolder,newFolder)
	dim voldFolder,vnewFolder
	voldFolder=oldFolder
	vnewFolder=newFolder
	on error resume next
	if voldFolder <> vnewFolder then
		voldFolder=server.mappath(oldFolder)
		vnewFolder=server.mappath(newFolder)
		if not objFso.FolderExists(vnewFolder) then createFolder newFolder,"folderdir" 
		if  objFso.FolderExists(voldFolder)  then  objFso.CopyFolder voldFolder,vnewFolder : objFso.DeleteFolder(voldFolder)
		if Err Then  moveFolder=false : errid=err.number : errdes=err.description:Err.Clear : echoErr err_14,errid,errdes else moveFolder=true
	end if
End Function

Function moveFile(ByVal src,ByVal target,Byval operType)
	dim srcPath,targetPath
	srcPath=Server.MapPath(src) 
	targetPath=Server.MapPath(target)
	if isExistFile(src) then
		objFso.Copyfile srcPath,targetPath
		if operType="del" then  delFile src 
		moveFile=true
	else
		moveFile=false
	end if
End Function

Function getFolderList(Byval cDir)
	dim filePath,objFolder,objSubFolder,objSubFolders,i
	i=0
	redim  folderList(0)
	filePath=server.mapPath(cDir)
	set objFolder=objFso.GetFolder(filePath)
	set objSubFolders=objFolder.Subfolders
	for each objSubFolder in objSubFolders
		ReDim Preserve folderList(i)
		With objSubFolder
			folderList(i)=.name&",文件夹,"&.size/1000&"KB,"&.DateLastModified&","&cDir&"/"&.name
		End With
		i=i + 1 
	next 
	set objFolder=nothing
	set objSubFolders=nothing
	getFolderList=folderList
End Function

Function getFileList(Byval cDir)
	dim filePath,objFolder,objFile,objFiles,i,fileList
	i=0
	redim  fileList(0)
	filePath=server.mapPath(cDir)
	set objFolder=objFso.GetFolder(filePath)
	set objFiles=objFolder.Files
	for each objFile in objFiles
		ReDim Preserve fileList(i)
		With objFile
			fileList(i)=.name&","&Mid(.name, InStrRev(.name, ".") + 1)&","&.size/1000&"KB,"&.DateLastModified&","&cDir&"/"&.name
		End With
		i=i + 1 
	next 
	set objFiles=nothing
	set objFolder=nothing
	getFileList=fileList
End Function

'读取文件内容
Function loadFile(ByVal filePath)
    dim errid,errdes,filename
    On Error Resume Next
    With objStream
        .Type=2
        .Mode=3
        .Open
		if isExistStr(lcase(filePath),"templates") then
		.Charset=Charset      '只要模板目录，根据设置格式来载入
		else
		.Charset="utf-8"
		end if
		'echo Server.MapPath(filePath)&"<br>"
        .LoadFromFile Server.MapPath(filePath)
		filename = mid(filePath,instrrev(filePath,"/")+1)
		If Err Then  errid=err.number:errdes=err.description:Err.Clear:echoErr err_06,errid,"加载文件 "&filename&" 失败"
		'die "A"
        .Position=0
        loadFile=.ReadText
        .Close
    End With
End Function

'****************************************************
'触发定时发布
Sub Rposting 
	conn.exec "update {prefix}Content  set TimeStatus=0 where TimeStatus=1 and Timeing <= #" & formatDate(now(),4)	&"#","exe"
End Sub
'*******************************************

'弹出对话框
'str 提示信息
'url 跳转地址
Sub alertMsgAndGo(str,url)
	dim urlstr 
	if url<>"" then urlstr="location.href='"&url&"';"
	if url="-1" then urlstr="history.go(-1);"
	if not isNul(str) then str ="alert('"&str&"');"
	echo("<script>"&str&urlstr&"</script>")
	response.End()
End Sub
Sub alertMsgAndGoParent(str,url)
	dim urlstr 
	if url<>"" then urlstr="top.location.href='"&url&"';"
	if url="-1" then urlstr="history.go(-1);"
	if not isNul(str) then str ="alert('"&str&"');"
	echo("<script>"&str&urlstr&"</script>")
	response.End()
End Sub
'输出信息
'
'
Sub echoMsgAndGo(str,timenum)
	echo str&",稍后将自动返回<script language=""javascript"">setTimeout(""goLastPage()"","&timenum*1000&");function goLastPage(){history.go(-1);}</script>&nbsp;&nbsp;<a href='"&sitePath&"/' target='_self'>进入网站"&str_01&"</a>"&" Powered By "&setting.siteTitle
	response.End()	
End Sub

'选择跳转
'str 提示信息
'url1 
'url2 
Sub selectMsg(str,url1,url2)
	echo("<script>if(confirm('"&str&"')){location.href='"&url1&"'}else{location.href='"&url2&"'}</script>") 
End Sub


'输出
Sub echo(str)
	response.write(str)
	response.Flush()
End Sub

'输出后停止，调试用
Sub die(str)
	if not isNul(str) then
		echo str
	end if	 
	response.End()
End Sub

'读cookies
Function rCookie(cookieName)
	rCookie=request.cookies(cookieName)
End Function

'写cookies
Sub wCookie(cookieName,cookieValue)
	response.cookies(cookieName)=cookieValue
End Sub

'写cookies写义过期时间
Sub wCookieInTime(cookieName,cookieValue,dateType,dateNum)
	Response.Cookies(cookieName).Expires=DateAdd(dateType,dateNum,now())
	response.cookies(cookieName)=cookieValue
End Sub

'是否为空
Function isNul(str)
	if isnull(str) or str=""  then isNul=true else isNul=false
End Function

'是否为数字
Function isNum(str)
	if not isNul(str) then  isNum=isnumeric(str) else isNum=false
End Function

'是否为URL
Function isUrl(str)
	isUrl=false
	if not isNul(str) and left(str,7)="http://" then isUrl=true 
End Function

'iif 条件判断
Function iif(a,b,c)
	if a then
		iif=b
	else
		iif=c
	end if
End Function


'获取扩展名
Function getFileFormat(str)
	dim ext : str=trim(""&str) : ext=""
	if str<>"" then
		if instr(" "&str,"?")>0 then:str=mid(str,1,instr(str,"?")-1):end if
		if instrRev(str,".")>0 then:ext=mid(str,instrRev(str,".")):end if
	end if
	getFileFormat=ext
End Function

'全角转换成半角
Function convertString(Str)
	Dim strChar,intAsc,strTmp,i
	For i = 1 To Len(Str)
      strChar = Mid(Str, i, 1)
      intAsc = Asc(strChar)
      If (intAsc>=-23648 And intAsc<=-23553) Then 
         strTmp = strTmp & Chr(intAsc+23680)
      Else
         strTmp = strTmp & strChar 
      End if    
    Next
	ConvertString=strTmp
End Function

Sub echoErr(byval str,byval id, byval des)        

        dim errstr,cssstr
		cssstr="<meta http-equiv=""Content-Type"" content=""text/html; charset="&Charset&""" />"
        cssstr=cssstr&"<style>body{text-align:center}#msg{background-color:white;border:1px solid #0073B0;margin:0 auto;width:400px;text-align:left}.msgtitle{padding:3px 3px;color:white;font-weight:700;line-height:28px;height30px;font-size:12px;border-bottom:1px solid #0073B0; text-indent:3px; background-color:#0073B0}#msgbody{font-size:12px;padding:20px 8px 30px;line-height:25px}#msgbottom{text-align:center;height:20px;line-height:20px;font-size:12px;background-color:#0073B0;color:#FFFFFF}</style>"
		if id="-2147467259" then 
			des=des&"<br />可能原因：数据库所在目录写入权限不足！"
		end if
        errstr=cssstr&"<div id='msg'><div class='msgtitle'>提示：【"&str&"】</div><div id='msgbody'>错误号："&id&"<br>错误描述："&des&"<br /><a href=""javascript:history.go(-1);"">返回上一页</a>&nbsp;<a href="""& sitePath &"/"">返回首页</a></div><div id='msgbottom'>Powered by "&aspcmsVersion&"</div></div>"
        cssstr=""
        die(errstr)
End Sub

Sub echoInstallErr(byval str,byval id, byval des)
        dim errstr,cssstr,reason
		cssstr="<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" />"
        cssstr=cssstr&"<style>body{text-align:center}#msg{background-color:white;border:1px solid #0073B0;margin:0 auto;width:400px;text-align:left}.msgtitle{padding:3px 3px;color:white;font-weight:700;line-height:28px;height30px;font-size:12px;border-bottom:1px solid #0073B0; text-indent:3px; background-color:#0073B0}#msgbody{font-size:12px;padding:20px 8px 30px;line-height:25px}#msgbottom{text-align:center;height:20px;line-height:20px;font-size:12px;background-color:#0073B0;color:#FFFFFF}</style>"
        if id="-2147467259" and des="未指定的错误" then
			reason = "可能原因：系统盘下windows/temp目录权限不足！"
		elseif id="-2147467259" then
			reason = "可能原因：数据库所在目录权限不足！"
		elseif id="3706" then
			reason="可能原因：你的IIS网站应用程序池未开启32位应用程序支持"
		else
			reason=""
		end if
		errstr=cssstr&"<div id='msg'><div class='msgtitle'>提示：【数据库连接失败】</div><div id='msgbody'>错误号："&id&"<br>错误描述："&des&"<br />"&reason&"</div><div id='msgbottom'>Powered by "&aspcmsVersion&"</div></div>"
        cssstr=""
        die(errstr)
End Sub


'获取参数值
Function getForm(element,ftype)
	Select case ftype
		case "get"
			getForm=trim(request.QueryString(element))
		case "post"
			getForm=trim(request.Form(element))
		case "both"
			if isNul(request.QueryString(element)) then getForm=trim(request.Form(element)) else getForm=trim(request.QueryString(element))
	End Select	
	getForm=replace(getForm,CHR(34),"&quot;")
	getForm=replace(getForm,CHR(39),"&apos;")
End Function

'是否为已安装对象
Function isInstallObj(objname)
	dim isInstall,obj
	On Error Resume Next
	set obj=server.CreateObject(objname)
	if Err then 
		isInstallObj=false : err.clear 
	else 
		isInstallObj=true:set obj=nothing
	end if
End Function

Sub setStartTime()
	startTime=timer()
End Sub

Sub echoRunTime()
	endTime=timer()      
	echo pageRunStr(0)&FormatNumber((endTime-startTime),4,-1)&pageRunStr(1)&conn.queryCount&pageRunStr(2)
End Sub

Function replaceStr(Byval str,Byval finStr,Byval repStr)
	on error resume next
	if isNull(repStr) then repStr=""
	replaceStr=replace(str,finStr,repStr)
	if err then replaceStr="" : err.clear
End Function

Function replaceStrReg(Byval str,Byval finStr,Byval repStr)
	on error resume next
	dim regEx
	Set regEx = New RegExp
	regEx.Pattern = finStr
	regEx.IgnoreCase = True  
	regEx.Global = True
	replaceStrReg = regEx.Replace(str, repStr)
	Set regEx = Nothing
	if err then replaceStr="" : err.clear
End Function

Function getArrayElementID(Byval parray,Byval itemid,Byval compareValue)
	dim i 
	for  i=0 to ubound(parray,2)
		if trim(parray(itemid,i))=trim(compareValue) then
			getArrayElementID=i
			Exit Function
		end if
	next
End Function

Function trimOuter(Byval str)
	dim vstr : vstr=str
	if left(vstr,1)=chr(32) then vstr=right(vstr,len(vstr)-1) 
	if right(vstr,1)=chr(32) then  vstr=left(vstr,len(vstr)-1)
	trimOuter=vstr
End Function

Function trimOuterStr(Byval str,Byval flag)
	dim vstr,m : vstr=str : m=len(flag)
	if left(vstr,m)=flag then vstr=right(vstr,len(vstr)-m) 
	if right(vstr,m)=flag then  vstr=left(vstr,len(vstr)-m)
	trimOuterStr=vstr
End Function

Function getPageSize(Byval str,Byval ptype)
	dim regObj,matchChannel,matchesChannel,sizeValue
	set regObj=New RegExp
	regObj.Pattern="\{aspcms:"&ptype&"list[\s\S]*size=([\d]+)[\s\S]*\}"	
	set matchesChannel=regObj.Execute(str)
	for each matchChannel in matchesChannel
		sizeValue=matchChannel.SubMatches(0) : if isNul(sizeValue) then sizeValue=10
		set regObj=nothing
		set matchesChannel=nothing
		getPageSize=sizeValue
		Exit Function
	next
End Function

Function dropHtml(Byval strHTML) 
	if isnul(strHTML) then
		dropHtml=""
		exit Function
	end if
	Dim objRegExp, Match, Matches 
	Set objRegExp = New Regexp 
	objRegExp.IgnoreCase = True 
	objRegExp.Global = True 
	'取闭合的<> 
	objRegExp.Pattern = "<.+?>" 
	'进行匹配 
	Set Matches = objRegExp.Execute(strHTML) 
	' 遍历匹配集合，并替换掉匹配的项目 
	For Each Match in Matches 
	strHtml=Replace(strHTML,Match.Value,"") 
	Next 
	dropHtml=strHTML 
	Set objRegExp = Nothing 
End Function

Function filterStr(Byval str,Byval filtertype)
	if isNul(str) then  filterStr="" : Exit Function
	dim regObj, outstr,rulestr : set regObj=New Regexp
	regObj.IgnoreCase=true : regObj.Global=true
	Select case filtertype
		case "html"	
			rulestr="(<[a-zA-Z].*?>)|(<[\/][a-zA-Z].*?>)"
		case "jsiframe"
			rulestr="(<(script|iframe).*?>)|(<[\/](script|iframe).*?>)"
	end Select
	regObj.Pattern=rulestr
	outstr=regObj.Replace(str, "")
	set regObj=Nothing : filterStr=outstr
End Function

Function getAgent()
	getAgent=request.ServerVariables("HTTP_USER_AGENT")
End Function

Function getRefer()
	getRefer=request.ServerVariables("HTTP_REFERER")
End Function

Function getServername()
	getServername=request.ServerVariables("server_name")
End Function

Function isOutSubmit()
	dim server1, server2
	server1=getRefer
	server2=getServername
	if Mid(server1, 8, len(server2)) <> server2 then
		isOutSubmit=true
	else
		isOutSubmit=false
	end if
End Function

Function getIp()
	dim forwardFor
	getIp=request.servervariables("Http_X_Forwarded_For")
	if getIp="" then getIp=request.servervariables("Remote_Addr") 	
	getIp=filterPara(replace(getIp, chr(39), ""))
	
End Function


Function urlDecode(ByVal sUrl)
	Dim i,c,ts,b,lc,t,n:ts="":b=false:lc=""
	for i=1 to len(sUrl)
		c=mid(sUrl,i,1)
		if c="+" then
			ts=ts & " "
		elseif c="%" then
			t=mid(sUrl,i+1,2):n=cint("&H" & t)
			if b then
				b=false:ts=ts & chr(cint("&H" & lc & t))
			else
				if abs(n)<=127 then
					ts=ts & chr(n)
				else
					b=true:lc=t
				end if
			end if
			i=i+2
		else
			ts=ts & c
		end if
	next
	urldecode=ts
End Function

Function urlEncode(ByVal sUrl)
	if InStr(" "&sUrl,"?")>0 then
		dim ts,i,l,s:ts=Split(Mid(sUrl,InStr(sUrl,"?")+1),"&"):l=UBound(ts)
		for i=0 to l
			if InStr(" "&ts(i),"=")>0 then
				s=Split(ts(i),"=")
				if s(1)<>"" then
					if InStr(" "&s(1),"%") then:s(1)=urldecode(s(1)):end if
					s(1)=Server.urlencode(s(1)):ts(i)=Join(s,"=")
				end if
			end if
		next
		urlencode=Mid(sUrl,1,InStr(sUrl,"?"))&Join(ts,"&")
	else
		urlencode=sUrl
	end if
End Function

dim gXmlHttpVer
Function getXmlHttpVer()
	dim i,xmlHttpVersions,xmlHttpVersion
	getXmlHttpVer=false
	xmlHttpVersions=Array("Microsoft.XMLHTTP", "MSXML2.XMLHTTP", "MSXML2.XMLHTTP.3.0","MSXML2.XMLHTTP.4.0","MSXML2.XMLHTTP.5.0")
	for i=0 to ubound(xmlHttpVersions)
		xmlHttpVersion=xmlHttpVersions(i)
		if isInstallObj(xmlHttpVersion) then getXmlHttpVer=xmlHttpVersion:gXmlHttpVer=xmlHttpVersion: Exit Function
	next
End Function

Function tryXmlHttp()
	dim i,ah:ah=array("MSXML2.ServerXMLHTTP.5.0","MSXML2.ServerXMLHTTP","MSXML2.ServerXMLHTTP.2.0","MSXML2.ServerXMLHTTP.3.0","MSXML2.ServerXMLHTTP.4.0","MSXML2.ServerXMLHTTP.6.0","Microsoft.XMLHTTP", "MSXML2.XMLHTTP", "MSXML2.XMLHTTP.3.0","MSXML2.XMLHTTP.4.0","MSXML2.XMLHTTP.5.0")
	On Error Resume Next
	for i=0 to UBound(ah)
		SET tryXmlHttp=Server.CreateObject(ah(i))
		if err.number=0 then:gXmlHttpVer=ah(i):tryXmlHttp.setTimeouts 2000,20000,20000,180000:err.clear:Exit Function:else:err.clear:end if
	next
End Function

dim gXmlHttpObj
Function getRemoteContent(Byval url,Byval returnType)
	if not isObject(gXmlHttpObj) then:set gXmlHttpObj=tryXmlHttp():end if
	url=urlencode(url):gXmlHttpObj.open "GET",url,False
	On error resume next
	gXmlHttpObj.send()
	if err.number = -2147012894 then
		dim des
		select case gXmlHttpObj.readyState
			Case 1:des="解析域名或连接远程服务器"
			Case 2:des="发送请求"
			Case 3:des="接收数据"
			Case else:des="未知阶段"
		end select
		die gXmlHttpVer&"组件<br />在请求 “"&url&"”时<br />发生" + des + " 超时错误,请重试.如果问题还没解决，请联系你的服务商"
	else
		select case returnType
			case "text"
				getRemoteContent=gXmlHttpObj.responseText
			case "body"
				getRemoteContent=gXmlHttpObj.responseBody
		end select
	end if
End Function


Function bytesToStr(Byval responseBody,Byval strCharSet)
	with objStream
		.Type=1
		.Mode =3
		.Open
		.Write responseBody
		.Position=0
		.Type=2
		.Charset=strCharSet
		bytesToStr=objstream.ReadText
		objstream.Close
	End With
End Function

Function computeStrLen(Byval str)
	dim strlen,charCount,i,an
	str=trim(str)   
	charCount=len(str)   
	strlen=0   
	for i=1 to charCount
		an=asc(mid(str,i,1))
		if an < 0 or an >255 then   
			strlen=strlen + 2
		else   
			strlen=strlen + 1
		end if
	next
	computeStrLen=strlen
End Function

Function getStrByLen(Byval str, Byval strlen)
	dim vStrlen,charCount,i,an
	str=trim(str)
	if isNul(str) then Exit Function   
	charCount=len(str)  
	vStrlen=0   
	for i=1 to charCount
		an=asc(mid(str,i,1))
		if an < 0 or an >255 then
			vStrlen=vStrlen + 2
		else   
			vStrlen=vStrlen + 1
		end if
		if vStrlen >= strlen then getStrByLen=left(str,i):Exit Function
	next
	getStrByLen=str
End Function

Function encodeHtml(Byval str)
	IF len(str)=0 OR Trim(str)="" then exit function
		str=replace(str,"<","&lt;")
		str=replace(str,">","&gt;")
		str=replace(str,CHR(34),"&quot;")
		str=replace(str,CHR(39),"&apos;")
		encodeHtml=str
End Function

Function decodeHtml(Byval str)
	IF len(str)=0 OR Trim(str)="" or isNull(str) then exit function
		str=replace(str,"&lt;","<")
		str=replace(str,"&gt;",">")
		str=replace(str,"&quot;",CHR(34))
		str=replace(str,"&apos;",CHR(39))
		str=replace(str,"&#160;"," ")
		decodeHtml=str
End Function


Function decode(str)
if isnul(str) then exit function
	dim strdecode
	strdecode=replace(str,"<br>",chr(13)&chr(10))
	decode=replace(strdecode,"&nbsp;",chr(32))
End Function

Function encode(str)
	dim strdecode
	strdecode=replace(replace(str,chr(10),""),chr(13),"<br>")
	encode=replace(strdecode,chr(32),"&nbsp;")
End Function

Function filterDirty(content)
	dim dirtyStrArray,i 
	
	dirtyStrArray=split(unescape(dirtyStr),"<br>")
	for i=0 to ubound(dirtyStrArray)
		content=replace(content,dirtyStrArray(i),"***",1,-1,1)
	next
	filterDirty=content
End Function

Function timeToStr(Byval t)
	t=Replace(Replace(Replace(Replace(t,"-",""),":","")," ",""),"/","") : timeToStr=t
End Function

'分页中部
Function makePageNumber(Byval currentPage,Byval pageListLen,Byval totalPages,Byval linkType,Byval sortid, Byval showType)		
	dim beforePages,pagenumber,page
	dim beginPage,endPage,strPageNumber
	if pageListLen mod 2 = 0 then beforePages = pagelistLen / 2 else beforePages = clng(pagelistLen / 2) - 1
	if  currentPage < 1  then currentPage = 1 else if currentPage > totalPages then currentPage = totalPages
	if pageListLen > totalPages then pageListLen=totalPages
	if currentPage - beforePages < 1 then
		beginPage = 1 : endPage = pageListLen
	elseif currentPage - beforePages + pageListLen > totalPages  then
		beginPage = totalPages - pageListLen + 1 : endPage = totalPages
	else 
		beginPage = currentPage - beforePages : endPage = currentPage - beforePages + pageListLen - 1
	end if	
'	die currentPage
	for pagenumber = beginPage  to  endPage
		if pagenumber=1 then page = "" else page = pagenumber
		if pagenumber=currentPage then
			if linkType="commentlist" then
				strPageNumber=strPageNumber&"<span href=""javascript:pager("&sortid&","&pagenumber&")"">"&pagenumber&"</span>"
			else				
				strPageNumber=strPageNumber&"<span><font color=red>"&pagenumber&"</font></span>"
			end if			
		else
			if showType="tags" then
				strPageNumber=strPageNumber&"<a href=""?page="&pagenumber&""">"&pagenumber&"</a>"			
			elseif showType="taglist" then			
				dim tag
				tag=filterPara(getForm("tag","get"))
				strPageNumber=strPageNumber&"<a href=""?page="&pagenumber&"&tag="&tag&""">"&pagenumber&"</a>"	
				
			elseif linkType="list" then		
				if runMode=1 then					
					if pagenumber>1 then 
						
						strPageNumber=strPageNumber&"<a href="""&replace(showType, "{page}", pagenumber)&""">"&pagenumber&"</a>" 
					else 
						strPageNumber=strPageNumber&"<a href="""&replace(showType, "{page}", pagenumber)&""">"&pagenumber&"</a>"
					end if
				else
					if pagenumber>1 then 
						strPageNumber=strPageNumber&"<a href=""?"&sortid&"_"&pagenumber&FileExt&""">"&pagenumber&"</a>" 
					else 
						strPageNumber=strPageNumber&"<a href=""?"&sortid&"_1"&FileExt&""">"&pagenumber&"</a>"
					end if
				end if
			elseif linkType="userbuylist" then		
						strPageNumber=strPageNumber&"<a href=""?page="& pagenumber&""">"&pagenumber&"</a>" 
			elseif linkType="about" then
				if runMode=1 then 
					if pagenumber>1 then 
						strPageNumber=strPageNumber&"<a href="""&showType&"_"&pagenumber&FileExt&""">"&pagenumber&"</a>"
					else
						strPageNumber=strPageNumber&"<a href="""&showType&""&FileExt&""">"&pagenumber&"</a>"					
					end if				
				else
					if pagenumber>1 then 
						strPageNumber=strPageNumber&"<a href=""?"&sortid&"_"&pagenumber&FileExt&""">"&pagenumber&"</a>"
					else
						strPageNumber=strPageNumber&"<a href=""?"&sortid&""&FileExt&""">"&pagenumber&"</a>"					
					end if
				end if
			elseif linkType="gbooklist" then
				strPageNumber=strPageNumber&"<a href=""?"&sortid&"_"&pagenumber&FileExt&""">"&pagenumber&"</a>"	
			elseif linkType="searchlist" then
			
				dim searchtype,keys
				searchtype=filterPara(getForm("searchtype","get"))
				keys=filterPara(getForm("keys","get"))
				strPageNumber=strPageNumber&"<a href=""?page="&pagenumber&"&keys="&keys&"&searchtype="&searchtype&""">"&pagenumber&"</a>"
			elseif linkType="commentlist" then
				strPageNumber=strPageNumber&"<a href=""javascript:pager("&sortid&","&pagenumber&")"">"&pagenumber&"</a>"			
			else
				if sortid="" then
					strPageNumber=strPageNumber&"<a href=""?"&linkType&"_"&pagenumber&FileExt&""">"&pagenumber&"</a>"
				else
					if pagenumber>1 then 
						strPageNumber=strPageNumber&"<a href="""&sortid&"_"&linkType&"_"&pagenumber&FileExt&""">"&pagenumber&"</a>"
					else
						strPageNumber=strPageNumber&"<a href="""&sortid&"_"&linkType&FileExt&""">"&pagenumber&"</a>"					
					end if
				end if
			end if
		end if	
	next
	makePageNumber=strPageNumber
End Function

'分页中部 后台使用
Function makePageNumber_(Byval currentPage,Byval pageListLen,Byval totalPages,Byval linkType,Byval sortid, Byval order, Byval keyword)
	dim beforePages,pagenumber,page
	dim beginPage,endPage,strPageNumber
	if pageListLen mod 2 = 0 then beforePages = pagelistLen / 2 else beforePages = clng(pagelistLen / 2) - 1
	if  currentPage < 1  then currentPage = 1 else if currentPage > totalPages then currentPage = totalPages
	if pageListLen > totalPages then pageListLen=totalPages
	if currentPage - beforePages < 1 then
		beginPage = 1 : endPage = pageListLen
	elseif currentPage - beforePages + pageListLen > totalPages  then
		beginPage = totalPages - pageListLen + 1 : endPage = totalPages
	else 
		beginPage = currentPage - beforePages : endPage = currentPage - beforePages + pageListLen - 1
	end if	
'	die currentPage
	for pagenumber = beginPage  to  endPage
		if pagenumber=1 then page = "" else page = pagenumber
		if pagenumber=currentPage then
			strPageNumber=strPageNumber&"<span>"&pagenumber&"</span>"
		else
			if linkType="newslist" then
				'if runMode="0" then
					strPageNumber=strPageNumber&"<a href='?sortType="&sortType&"&sortid="&sortid&"&keyword="&keyword&"&page="&pagenumber&"&psize="&psize&"&order="&order&"&ordsc="&ordsc&"'>"&pagenumber&"</a>"
				'elseif runMode="1" then
				'	if pagenumber>1 then strPageNumber=strPageNumber&"<a href='"&sortid&"_"&pagenumber&FileExt&"'>"&pagenumber&"</a>&nbsp;" : else strPageNumber=strPageNumber&"<a href='"&sortid&FileExt&"'>"&pagenumber&"</a>&nbsp;"
				'end if
			elseif linkType="guestlist" then
				strPageNumber=strPageNumber&"<a href='?page="&pagenumber&"'>"&pagenumber&"</a>"						
			else
				if sortid="" then
					strPageNumber=strPageNumber&"<a href='?Sort="&linkType&"&Page="&pagenumber&"'>"&pagenumber&"</a>"
				else
					strPageNumber=strPageNumber&"<a href='?Sort="&linkType&"&ID="&sortid&"&Page="&pagenumber&"'>"&pagenumber&"</a>"
				end if
			end if
		end if	
	next
	makePageNumber_=strPageNumber
End Function

'分页两侧
Function pageNumberLinkInfo(Byval currentPage,Byval pageListLen,Byval totalPages,Byval linkType,Byval sortid, Byval showType)
	dim pageNumber,pagesStr,i,pageNumberInfo,firstPageLink,lastPagelink,nextPagelink,finalPageLink,p,jumppagelink,currentpagestr
			
	pageNumber=makePageNumber(currentPage,pageListLen,totalPages,linkType,sortid,showType)		
	dim searchtype,keys,tag
	searchtype=filterPara(getForm("searchtype","get"))
	keys=filterPara(getForm("keys","get"))
	tag=filterPara(getForm("tag","get"))
	if currentPage=1 then  
		firstPageLink="<span class='nolink'>"&str_01&"</span>" : lastPagelink="<span class='nolink'>"&str_03&"</span>"
	else
		if linkType="gbooklist" then
			firstPageLink="<a href='?"&sortid&"_1"&FileExt&"'>"&str_01&"</a>" : lastPagelink="<a href='?"&sortid&"_"&currentPage-1&FileExt&"'>"&str_03&"</a>"
		elseif linkType="userbuylist" then
			firstPageLink="<a href='?page=1'>"&str_01&"</a>" : lastPagelink="<a href='?page="&currentPage-1&"'>"&str_03&"</a>"
		elseif linkType="searchlist" then
			firstPageLink="<a href='?page=1&keys="&keys&"&searchtype="&searchtype&"'>"&str_01&"</a>" : lastPagelink="<a href='?page="&currentPage-1&"&keys="&keys&"&searchtype="&searchtype&"'>"&str_03&"</a>"
		elseif showType="tags" then
			firstPageLink="<a href='?page=1'>"&str_01&"</a>" : lastPagelink="<a href='?page="&currentPage-1&"'>"&str_03&"</a>"
		elseif showType="taglist" then
			firstPageLink="<a href='?page=1&tag="&tag&"'>"&str_01&"</a>" : lastPagelink="<a href='?page="&currentPage-1&"&tag="&tag&"'>"&str_03&"</a>"
		else
			if runMode=0 then
				firstPageLink="<a href='?"&sortid&"_1"&FileExt&"'>"&str_01&"</a>" : if currentPage>2 then lastPagelink="<a href='?"&sortid&"_"&currentPage-1&FileExt&"'>"&str_03&"</a>" : else lastPagelink="<a href='?"&sortid&"_1"&FileExt&"'>"&str_03&"</a>"
			else
				firstPageLink="<a href='"&replace(showType, "{page}", 1)&"'>"&str_01&"</a>" : if currentPage>2 then lastPagelink="<a href='"&replace(showType, "{page}", currentPage-1)&"'>"&str_03&"</a>" : else lastPagelink="<a href='"&replace(showType, "{page}", 1)&"'>"&str_03&"</a>"
			end if			
		end if
	end if 
	if linkType<>"gbooklist" and linkType<>"userbuylist" and linkType<>"searchlist" and showType<>"tags" and showType<>"taglist" then
		jumppagelink=str_17&" <SELECT NAME=""select"" ONCHANGE=""var jmpURL=this.options[this.selectedIndex].value ; if(jmpURL!='') {window.location=jmpURL;} else {this.selectedIndex=0 ;}"" >"
		
		for p=1 to totalPages
			currentpagestr=""
			if currentPage=p then currentpagestr=" selected=selected"
			if runMode=0 then
				jumppagelink=jumppagelink&"<option value=?"&sortid&"_"&p&FileExt&"  "&currentpagestr&">"&p&"</option>"
				
			else
				jumppagelink=jumppagelink&"<option value="&replace(showType, "{page}", p)&" "&currentpagestr&">"&p&"</option>"
				
			end if	
		next
			jumppagelink=jumppagelink&"</SELECT>"
	
	end if
	if currentPage=totalPages then 
		nextPagelink="<span class='nolink'>"&str_04&"</span>" : finalPageLink="<span class='nolink'>"&str_02&"</span>"
	else
		if linkType="gbooklist" then
			nextPagelink="<a href='?"&sortid&"_"&currentPage+1&FileExt&"'>"&str_04&"</a>" : finalPageLink="<a href='?"&sortid&"_"&totalPages&FileExt&"'>"&str_02&"</a>"
		elseif linkType="searchlist" then
			nextPagelink="<a href='?page="&currentPage+1&"&keys="&keys&"&searchtype="&searchtype&"'>"&str_04&"</a>" : finalPageLink="<a href='?page="&totalPages&"&keys="&keys&"&searchtype="&searchtype&"'>"&str_02&"</a>"
		elseif linkType="userbuylist" then
			nextPagelink="<a href='?page="&currentPage+1&"'>"&str_04&"</a>" : finalPageLink="<a href='?page="&totalPages&"'>"&str_02&"</a>"
		elseif showType="tags" then
			nextPagelink="<a href='?page="&currentPage+1&"'>"&str_04&"</a>" : finalPageLink="<a href='?page="&totalPages&"'>"&str_02&"</a>"
		elseif showType="taglist" then
			nextPagelink="<a href='?page="&currentPage+1&"&tag="&tag&"'>"&str_04&"</a>" : finalPageLink="<a href='?page="&totalPages&"&tag="&tag&"'>"&str_02&"</a>"
		else		
			if runMode=0 then
				nextPagelink="<a href='?"&sortid&"_"&currentPage+1&FileExt&"'>"&str_04&"</a>" : finalPageLink="<a href='?"&sortid&"_"&totalPages&FileExt&"'>"&str_02&"</a>"
			else
				nextPagelink="<a href='"&replace(showType, "{page}", currentPage+1)&"'>"&str_04&"</a>" : finalPageLink="<a href='"&replace(showType, "{page}", totalPages)&"'>"&str_02&"</a>"
			end if
		end if	
	end if 
	
	pageNumberInfo="<span> "&str_06&""&totalPages&" "&str_07&" "&str_05&":"&currentPage&"/"&totalPages&" "&str_07&"</span>"&firstPageLink&lastPagelink&pageNumber&""&nextPagelink&""&finalPagelink&" "&jumppagelink
	pageNumberLinkInfo=pageNumberInfo
End Function


'在str中是否存在findstr
Function isExistStr(str,findstr)
	if isNul(str) or isNul(findstr) then isExistStr=false:Exit Function
	if instr(str,findstr)>0 then isExistStr=true else isExistStr=false
End Function

Function getSubStrByFromAndEnd(str,startStr,endStr,operType)
	dim location1,location2
	select case operType
		case "start"
			location1=instr(str,startStr)+len(startStr):location2=len(str)+1
		case "end"
			location1=1:location2=instr(location1,str,endStr)
		case else
			location1=instr(str,startStr)+len(startStr):location2=instr(location1,str,endStr)
	end select
	getSubStrByFromAndEnd=mid(str,location1,location2-location1) 
End Function

'转换时间
Function formatDate(Byval t,Byval ftype)	
	dim y, m, d, h, mi, s
	formatDate=""
	If IsDate(t)=False Then Exit Function
	y=cstr(year(t))
	m=cstr(month(t))
	If len(m)=1 Then m="0" & m
	d=cstr(day(t))
	If len(d)=1 Then d="0" & d
	h = cstr(hour(t))
	If len(h)=1 Then h="0" & h
	mi = cstr(minute(t))
	If len(mi)=1 Then mi="0" & mi
	s = cstr(second(t))
	If len(s)=1 Then s="0" & s

	select case ftype
		case "1"
			' yyyy-mm-dd
			formatDate=y & "-" & m & "-" & d
		case "2"		
			' yy-mm-dd
			formatDate=right(y,2) & "-" & m & "-" & d
		case "3"		
			' mm-dd
			formatDate=m & "-" & d
		case "4"
			' yyyy-mm-dd hh:mm:ss
			formatDate=y & "-" & m & "-" & d & " " & h & ":" & mi & ":" & s
		case "5"
			' hh:mm:ss
			formatDate=h & ":" & mi & ":" & s
		case "6"
			' yyyy年mm月dd日
			formatDate=y & "年" & m & "月" & d & "日"
		case "7"
			' yyyymmdd
			formatDate=y & m & d
		case "8"
			'yyyymmddhhmmss
			formatDate=y & m & d & h & mi & s
		case else
			ftype = replace(ftype, "yy", y) '年
			ftype = replace(ftype, "y", right(y,2)) '年
			ftype = replace(ftype, "mi", mi) '分
			ftype = replace(ftype, "h", h) '小时
			ftype = replace(ftype, "s", s) '秒
			ftype = replace(ftype, "m", m) '月
			ftype = replace(ftype, "d", d) '日
			formatDate = ftype
	end select

End Function


'过滤参数
Function filterPara(byVal Para)
    filterPara=preventSqlin(Checkxss(Para))
End Function

Function preventSqlin(content)

	dim sqlStr,sqlArray,i,speStr
	sqlStr="<|>|%|%27|%16|'|''|;|*|and|exec|dbcc|alter|drop|insert|select|update|delete|count|master|truncate|char|declare|where|set|declare|mid|chr|union|from|{prefix}|top|user|/|\"

	if isNul(content) then Exit Function
	sqlArray=split(sqlStr,"|")
	for i=lbound(sqlArray) to ubound(sqlArray)
		if instr(lcase(content),sqlArray(i))<>0 then
				select case sqlArray(i)
					case "<":speStr="&lt;"
					case ">":speStr="&gt;"
					case "'","""":speStr="&quot;"
					'case ";":speStr="；"
					case else:speStr=""
				end select
				content=replace(content,sqlArray(i),speStr)		
		end if
	next
	dim num
	num=0
	for i=lbound(sqlArray) to ubound(sqlArray)
		if instr(lcase(content),sqlArray(i))<>0 then
			num=1
		end if
	next
	if num=1 then 
	
		content=preventSqlin(content)
	end if
	preventSqlin=content
End Function

'过滤xss注入
Function checkxss(byVal ChkStr)
    dim Str,re
    Str = ChkStr
    if IsNull(Str) then  Checkxss = "" : Exit Function
    Str = Replace(Str, "&", "&amp;") : Str = Replace(Str, "'", "&acute;") : Str = Replace(Str, """", "&quot;") : Str = Replace(Str, "<", "&lt;") : Str = Replace(Str, ">", "&gt;") : Str = Replace(Str, "/", "&#47;") : Str = Replace(Str, "*", "&#42;")
    Set re = New RegExp
    re.IgnoreCase = True : re.Global = True
    re.Pattern = "(w)(here)" : Str = re.Replace(Str, "$1h&#101;re")
	re.Pattern = "(s)(elect)" : Str = re.Replace(Str, "$1el&#101;ct")
	re.Pattern = "(i)(nsert)" : Str = re.Replace(Str, "$1ns&#101;rt")
	re.Pattern = "(c)(reate)" : Str = re.Replace(Str, "$1r&#101;ate")
	re.Pattern = "(d)(rop)" : Str = re.Replace(Str, "$1ro&#112;")
	re.Pattern = "(a)(lter)" : Str = re.Replace(Str, "$1lt&#101;r")
	re.Pattern = "(d)(elete)" : Str = re.Replace(Str, "$1el&#101;te")
	re.Pattern = "(u)(pdate)" : Str = re.Replace(Str, "$1p&#100;ate")
	re.Pattern = "(\s)(or)" : Str = re.Replace(Str, "$1o&#114;")
	re.Pattern = "(java)(script)" : Str = re.Replace(Str, "$1scri&#112;t")
	re.Pattern = "(j)(script)" : Str = re.Replace(Str, "$1scri&#112;t")
	re.Pattern = "(vb)(script)" : Str = re.Replace(Str, "$1scri&#112;t")
	If Instr(Str, "expression") > 0 Then Str = Replace(Str, "expression", "e&#173;xpression", 1, -1, 0)
    Set re = Nothing
    Checkxss = Str
End Function

'获取SortID分类的顶级分类ID
Function getTopId(byval SortID)
    dim sqlStr,rsObj,ChildArray,i
	sqlStr= "select SortID,SortPath from {prefix}Sort where ParentID=0"

	set rsObj = conn.Exec(sqlStr,"r1")
	do while not rsObj.eof
	    ChildArray=split(rsObj(1),",")
		for i=0 to ubound (ChildArray)
		    if cint(ChildArray(i))=cint(SortID) then GetTopId=rsObj(0) : exit for : exit do
		next
	rsObj.movenext
	loop
	rsObj.close
	set rsObj = nothing
End Function




'前台类别
Function makeqtType(topId,separateStr,classname)
	dim sqlStr,rsObj,selectedStr,qtstr,qtspan
	sqlStr= "select SortID,SortName,SortStyle from {prefix}Sort where SortStatus and ParentID="&topId&" order by SortID asc"
	set rsObj = conn.Exec(sqlStr,"r1")
	do while not rsObj.eof
	  
			if runMode="0" then
				qtstr = qtstr + "<div class='"&classname&"'>"&qtspan&"<a href='"&sitePath&"/productlist/?"&rsObj("SortID")&"_1.html'>"&rsObj("SortName")&"</a></div>"
			elseif runMode="1" then
				qtstr = qtstr + "<div class='"&classname&"'>"&qtspan&"<a href='"&sitePath&"/productlist/"&rsObj("SortID")&".html'>"&rsObj("SortName")&"</a></div>"
			end if
		qtspan=qtspan&separateStr
		makeqtType rsObj("SortID"),separateStr,classname
		rsObj.movenext
	loop
	if not isNul(qtspan) then qtspan = left(qtspan,len(qtspan)-len(separateStr))
	rsObj.close
	set rsObj = nothing
	makeqtType=qtstr
End Function

'所有类别
Sub makeTypeOption(topId,separateStr,compareValue,sortid)
	dim sqlStr,rsObj,selectedStr
	sqlStr= "select ID,SortName from {prefix}Sort where ParentID="&topId&" and IsOut=0 order by ID asc"
	set rsObj = conn.Exec(sqlStr,"r1")
	do while not rsObj.eof
	    if rsObj("ID")=compareValue then selectedStr=" selected" else selectedStr=""
		print "<option value='"&rsObj("ID")&"' "&selectedStr&">"&span&"&nbsp;|—"&rsObj("SortName")&"</option>"
		span=span&separateStr
		makeTypeOption rsObj("ID"),separateStr,compareValue,sortid
		rsObj.movenext
	loop
	if not isNul(span) then span = left(span,len(span)-len(separateStr))
	rsObj.close
	set rsObj = nothing
End Sub

'判断一个类别是否有子类
Function hasChild(TableName,ClassID)
	Dim HasChild_SQL	:	HasChild_SQL="SELECT COUNT(*) FROM ["&TableName&"] WHERE [ParentID]="&ClassID
	Dim HasChild_Rs		:	Set HasChild_Rs=conn.Exec(HasChild_SQL,"r1")
	Dim Has
	IF HasChild_Rs(0)>0 Then
		Has=True
	Else
		Has=False
	End IF
	HasChild_Rs.Close	:	Set HasChild_Rs=Nothing
	HasChild=Has
End Function

'获取某个类别表的某个类别的最小子类列表
Function getSmallestChild(TableName,ClassID)
	Dim Str
	IF HasChild(TableName,ClassID) Then
		Str=GetSmallestChild_Sub(TableName,ClassID,"")
	Else
		Str=ClassID&","
	End IF
	GetSmallestChild=Left(Str,Len(Str)-1)
End Function

'获取某个类别表的某个类别的最小子类列表,GetSmallestChild函数调用的递归函数
Function getSmallestChild_Sub(TableName,ClassID,TmpStr)
	IF HasChild(TableName,ClassID) Then
		Dim GetSmallestChild_Sub_SQL	:	GetSmallestChild_Sub_SQL="SELECT [SortID] FROM ["&TableName&"] WHERE [ParentID]="&ClassID
		Dim GetSmallestChild_Sub_Rs		:	Set GetSmallestChild_Sub_Rs=conn.Exec(GetSmallestChild_Sub_SQL,"r1")
		While Not (GetSmallestChild_Sub_Rs.Eof Or GetSmallestChild_Sub_Rs.Bof)
			Dim TmpClassID	:	TmpClassID=GetSmallestChild_Sub_Rs(0)
			IF HasChild(TableName,TmpClassID) Then
				TmpStr=GetSmallestChild_Sub(TableName,TmpClassID,TmpStr)
			Else
				TmpStr=TmpStr&TmpClassID&","
			End IF
			GetSmallestChild_Sub_Rs.MoveNext
		Wend
	Else
		TmpStr=TmpStr&ClassID&","
	End IF
	GetSmallestChild_Sub=TmpStr
End Function

'获取当前类下所有子类 allsub 1带父级，0所有最小类
Function getSubSort(sortID, allsub)
	getSubSort=getSubSorts(sortID, allsub)
getSubSort=left(getSubSort,len(getSubSort)-1)
End Function

Function getSubSorts(sortID, allsub)
	dim rs, sql
	sql="select (select count(*) from {prefix}Sort where ParentID in ("&sortID&")), * from {prefix}Sort where ParentID in("&sortID&")"
	set rs=conn.exec(sql, "exe")
	'echo sql &"<br>"
	if rs.eof then 
		getSubSorts=sortID&","
	else
		if allsub=1 then getSubSorts=sortID&","
		do while not rs.eof 
			getSubSorts=getSubSorts&getSubSorts(rs("sortID"), allsub)
			rs.movenext
		loop
	end if
End Function

	
'获取checkbox的值,选中为1，选为0
function getCheck(cValue)
	if isnul(cValue) then 
		getCheck=0
	elseif cValue="1" then
		getCheck=1	
	end if	
end function

'将null替换成空
Function repnull(str)
'echo str 
'echo "<br>"
	repnull=str
	if isnul(str) then repnull=""
End Function

Function getStr(Stat,str1,str2)
	if Stat=1 then
		getStr=str1
	else
		getStr=str2
	end if
End Function

'获取当前页面名称
Function getPageName()
	Dim fileName,arrName,postion
	fileName=Request.ServerVariables("script_name")
	postion=InstrRev(fileName,"/")+1
	fileName=Mid(fileName,postion)
	If InStr(fileName,"?")>0 Then
		arrName=fileName
		arrName=Split(arrName,"?")
		filename=arrName(0)
	End If
	getPageName=filename
End Function


Function CheckAdmin(filename)
	if isnul(Session("adminName")) then 
		alertMsgAndGoParent"您还没有登陆",sitePath&"/"&adminPath&"/login.asp"
	else
		dim Permissions,padmin
		padmin = Session("GroupSort")
		Permissions=Session("groupMenu")
		if padmin<>"all" and isnul(Permissions) then
			alertMsgAndGoParent"您没有访问权限","-1"

		elseif padmin="all" then 
			exit function
		else			
			dim rsObj,i
			set rsObj=conn.exec("select MenuID from {prefix}Menu where MenuLink like '%"&filename&"%'","r1")
			'die "select MenuID from {prefix}Menu where MenuLink like '%"&filename&"%'"
			
			if not rsObj.eof then 
				Permissions=split(Permissions,",")

				for i=0 to ubound(Permissions)
					if cstr(trim(Permissions(i)))=cstr(trim(rsObj(0))) then exit function				
				next
			end if
			alertMsgAndGoParent"您的访问权限不够","-1"
		end if
	end if
	if not isnum(Session("adminrand")) then alertMsgAndGoParent"您没有访问权限","-1" end if
	sql = "select count(*) from {prefix}User where LoginName = '"& Session("adminName") &"' and adminrand='"&Session("adminrand")&"'"
	Dim rscoo : Set rscoo=Conn.Exec(sql,"r1")
	if rscoo(0)<>1 then
		Session("adminName")=""
		Session("adminId")=""
		Session("groupMenu")=""
		Session("SceneMenu")=""
		alertMsgAndGo"请不要尝试COOKIES欺骗","-1"
	end if
End Function

Function checkLogin()
	if isnul(Session("adminName")) or Session("adminName")="" then 
		alertMsgAndGoParent"您还没有登陆",sitePath&"/"&adminPath&"/login.asp"
	else
		dim Permissions
		Permissions=Session("groupMenu")
		'die Permissions
		if Permissions<>"all" and isnul(Permissions) then
			alertMsgAndGo"1您没有访问权限","-1"
		end if
	end if
	dim sql
	if not isnum(Session("adminrand")) then alertMsgAndGo"2您没有访问权限","-1" end if
	sql = "select count(*) from {prefix}User where LoginName = '"& Session("adminName") &"' and adminrand='"&Session("adminrand")&"'"
	Dim rscoo : Set rscoo=Conn.Exec(sql,"r1")
	if rscoo(0)<>1 then
			Session("adminName")=""
			Session("adminId")=""
			Session("groupMenu")=""
			Session("SceneMenu")=""
		    alertMsgAndGo"3您没有访问权限","-1"
	end if
End Function

'从内容里面提取图片
Function getImgFromText(strng) 
	Dim regEx, Match, Matches '建立变量。 
	Set regEx = New RegExp '建立正则表达式。	
	regEx.Pattern = "(<)(.[^<]*)(src=)('|"&CHR(34)&"| )?(.[^'|\s|"&CHR(34)&"]*)(\.)(jpg|gif|png|bmp|jpeg)('|"&CHR(34)&"|\s|>)(.[^>]*)(>)" '设置模式。 	
	regEx.IgnoreCase = true '设置是否区分字符大小写。 
	regEx.Global = True '设置全局可用性。 
	Set Matches = regEx.Execute(strng) '执行搜索。 
	For Each Match in Matches '遍历匹配集合。 
	values=values&Match.Value&"{|LDIV|}" 
	Next 
	RegExpExecute = values 
End Function 

Function getDataCount(sqlStr)
	getDataCount=conn.Exec(sqlStr,"exe")(0)
End Function


Function loadSelect(selName,tableName,fieldText,fieldValue,selected, ParentID,strOrder,topText)
	echo "<select name="""& selName &""" id="""& selName &""">" & vbcr & "<option value=""0"">"&topText&"</option>"& vbcr 
	makeOption tableName,fieldText,fieldValue,selected,strOrder,ParentID
	echo "</select>" & vbcr
End Function

Function makeOption(tableName,fieldText,fieldValue,selected,strOrder,ParentID)
	Dim rs ,sel
	sel=""
		set rs =conn.Exec ("select ["&fieldValue&"],["&fieldText&"],ParentID,SortLevel,(select count(*) from {prefix}Sort where ParentID=t.SortID) as c from "&tableName&" as t where  LanguageID="&session("languageID")&" and ParentID="&ParentID&" "&strOrder,"r1")
	
	Do While Not rs.Eof	
		IF CSTR(selected)=CSTR(rs(0)) Then sel = "selected=""selected""" else sel="" end if
		dim rscount:rscount=0		
		echo "<option value="""& rs(0) &""" "&sel&">"&getLevel_(rs(3))&rs(1) &"</option>" & vbcr
		if rs(4)>0 then 
			makeOption = makeOption & makeOption(tableName,fieldText,fieldValue,selected,strOrder,rs(0))
		end if
		rs.MoveNext
	Loop
	rs.Close	:	Set rs=Nothing
End Function

function getLevel(num)
	if not isnum(num) then  exit Function
	dim i
	getLevel=""
	for i=2 to num
		getLevel=getLevel&"<img src=""../../images/01.gif""/>"
	next
	if num<>"1" then getLevel=getLevel&"<img src=""../../images/02.gif""/>"	
end function

function getLevel_(num)
	if not isnum(num) then  exit Function
	dim i
	getLevel_=""
	for i=2 to num
		getLevel_=getLevel_&"┃"
	next
	if num<>"1" then getLevel_=getLevel_&"┝"	
end function



Function getTodayVisits
	getTodayVisits=conn.Exec("select sum(Visits) from {prefix}Visits where year(AddTime)="&Year(date)&" and month(AddTime)="&month(date)&" and day(AddTime)="&day(date),"r1")(0)
	if isnul(getTodayVisits) then getTodayVisits=0
End Function

Function getYesterdayVisits
	getYesterdayVisits=conn.Exec("select sum(Visits) from {prefix}Visits where year(AddTime)="&Year(DateAdd("d",-1,date))&" and month(AddTime)="&month(DateAdd("d",-1,date))&" and day(AddTime)="&day(DateAdd("d",-1,date)),"r1")(0)
	if isnul(getYesterdayVisits) then getYesterdayVisits=0
End Function

Function getMonthVisits
	getMonthVisits=conn.Exec("select sum(Visits) from {prefix}Visits where year(AddTime)="&Year(date)&" and month(AddTime)="&month(date),"r1")(0)	
	if isnul(getMonthVisits) then getMonthVisits=0
End Function

Function getAllVisits
	getAllVisits=conn.Exec("select sum(Visits) from {prefix}Visits","r1")(0)
	if isnul(getAllVisits) then getAllVisits=0
End Function


Function getExtend(fileName)
   GetExtend = Mid(fileName,Instr(fileName,".")+1,Len(fileName)-Instr(fileName,"."))
End Function

Function getTemplateFile(Byval sortID,Byval str,Byval sStyle)
	getTemplateFile=conn.exec("select SortTemplate from {prefix}Sort where SortID="&SortID ,"r1")(0)
	if isnul(getTemplateFile) then 
		if str="" then 
			getTemplateFile="about.html"
		else
			if sStyle=1 then		
				getTemplateFile=str&".html"
			elseif sStyle=2 then
				getTemplateFile=str&"list.html"			
			end if
		end if
	end if
End Function

Function checkTemplateFile(Byval fileName)
	CheckTemplateFile=false
	if isExistFile(fileName)then CheckTemplateFile=true
End Function

Function ipHide(ipstr)
	dim t,ipx,ipfb
	if not isnull(ipstr) then
		t = 0
		ipx=""
		ipfb = split(ipstr, ".",4)
		for t = 0 to 2
			ipx = ipx&ipfb(t)&"."
		next
		ipHide = ipx&"*"
	end if
end Function



Function userGroupSelect(selName, selOption, usertype)
	dim selStr
	if isnul(selOption) then selOption=0
	selStr= "<select name="""&selName&""" id="""&selName&""">" & vbcr
	Dim rs ,sel
		sel=""
		set rs =Conn.Exec ("select [GroupID],[GroupName] from {prefix}UserGroup where IsAdmin="&usertype&" order by GroupOrder", "r1")
		Do While Not rs.Eof	
			IF CSTR(selOption)=CSTR(rs(0)) Then sel = "selected=""selected""" else sel="" end if
			selStr=selStr& "<option value="""& rs(0) &""" "&sel&">"&rs(1) &"</option>" & vbcr
			rs.MoveNext
		Loop
		rs.Close	:	Set rs=Nothing
	selStr=selStr& "</select>" & vbcr
	userGroupSelect=selStr
end Function

Function viewNoRight(GroupID, Exclusive)
    Dim rs, sql, GroupMark
    Set rs =Conn.Exec("select GroupMark from {prefix}UserGroup where GroupID="&GroupID,"r1")
    if not  rs.eof then
		GroupMark = rs("GroupMark")
	else
		GroupMark=0
	end if
    rs.Close
    Set rs = Nothing
    viewNoRight = True
    If session("GroupMark") = "" Then session("GroupMark") = 0
    select case Exclusive
        case ">="
            If Not session("GroupMark") >= GroupMark Then
                viewNoRight = False
            End If
        case "="
            If Not session("GroupMark") = GroupMark Then
                viewNoRight = False
            End If
    end select
End Function


'actiontype (del, on, off)
Sub onOff(actionType, tabName, idField, upField, whereStr, url)
	dim id	:	id=getForm("id","both")
	if isnul(id) then alertMsgAndGo "请选择要操作的内容","-1"

	if actionType="on" then
		conn.exec "update {prefix}"&tabName&" set "&upField&"=1 where "&idField&" in("&id&") "&whereStr,"exe"
	else
		dim ids,i
		ids=split(id,",")
		if tabName="UserGroup" then		
			for i=0 to ubound(ids)
				if ids(i)>4 then  conn.exec "update {prefix}"&tabName&" set "&upField&"=0 where "&idField&"="&ids(i)&" "&whereStr,"exe"
			next
		elseif tabName="User" then 
			for i=0 to ubound(ids)
				if ids(i)>1 then conn.exec "update {prefix}"&tabName&" set "&upField&"=0 where "&idField&"="&ids(i)&" "&whereStr,"exe"
			next
		else
			conn.exec "update {prefix}"&tabName&" set "&upField&"=0 where "&idField&" in("&id&") "&whereStr,"exe"
		end if
	end if
	response.Redirect url
End Sub


'单篇2,文章0,产品3,下载4,招聘6,相册1,链接5
'单篇1,文章2,产品3,下载4,招聘5,相册6,链接7
'"单篇,文章,产品,下载,招聘,相册,链接"
Function makeSortTypeSelect(selName, selOption, events)
	dim selStr, types, i, sel
	types=split(sortTypes, ",")	
	if isnul(selOption) then selOption=0
	selStr= "<select name="""&selName&""" id="""&selName&""" "&events&">" & vbcr
	for i=0 to ubound(types)				
		if cstr(trim(selOption))=cstr(trim(i+1)) Then sel = "selected=""selected""" else sel="" end if
		selStr=selStr& "<option value="""& i+1 &""" "&sel&">"&types(i)&"</option>" & vbcr
	next
	selStr=selStr& "</select>" & vbcr
	makeSortTypeSelect=selStr
End Function

Function groupMenuChecked(menus_, mid_)	
	dim i, menus
	groupMenuChecked=""
	if menus_="all" then 
		groupMenuChecked="checked=""checked"""
	elseif not isnul(menus_) then	
		menus=split(menus_, ",")
		for i=0 to ubound(menus)

			if  cstr(trim(menus(i)))=cstr(trim(mid_)) then groupMenuChecked="checked=""checked""" : exit for
		next 
	end if
End Function

'sendMail"13322712@qq.com","QQ","aaaa","bb"
'收件人邮箱，发件人姓名，标题，内容
Function sendMail(email,sendname,zhuti,mailbody)
	Server.ScriptTimeOut=5000
	If Not isInstallObj("JMail.Message") Then exit function
	dim jmail : set jmail=Server.CreateObject("JMail.Message")   
	If  jmail is nothing then exit function
	set jmail= server.CreateObject ("Jmail.message")  '调用Jmail组件
	jmail.Silent = true
	jmail.CharSet = "utf-8"
	JMail.ContentType = "text/html"
	'调用变量内容
	'=================================
	'发件人邮箱
	jmail.From = smtp_usermail
	'发件人姓名
	jmail.FromName = sendname  
	'收件人邮箱
	jmail.ReplyTo = email
	'邮件标题
	jmail.Subject = zhuti   
	'收件人邮箱
	jmail.AddRecipient email
	'邮件内容
	jmail.Body = mailbody
	'用户名	
	jmail.MailServerUserName = smtp_user
	'密码
	jmail.MailServerPassWord = smtp_password
	 '发送邮件	
	sendMail=jmail.Send(smtp_server)
	jmail.close : set jmail = nothing
End Function

'图片水印
'waterMarkImg(saveImgPath,waterMarkLocation)
Function waterMarkImg(saveImgPath,location)
dim Logobox,ImageWidth,ImageHeight,ImageMode
dim sAllowMarkExt:sAllowMarkExt = ".jpg,.png,.gif,.jpeg,.bmp"
'Left(saveImgPath,inStrRev(saveImgPath,".")-1)
If InStr(sAllowMarkExt, Mid(saveImgPath, InStrRev(saveImgPath, "."), Len(saveImgPath))) = 0 Then Exit Function
'die instr(mid(saveImgPath,sAllowMarkExt)
	If Not isInstallObj("Persits.Jpeg") Then exit function
	dim jpegObj : set jpegObj = Server.CreateObject("Persits.Jpeg")	
	dim strWidth,strHeight : strWidth=len(waterMarkFont)*13 : strHeight=3 	
	jpegObj.Open Server.MapPath(saveImgPath)
	If  jpegObj is nothing then exit function	
	if jpegObj.width <200 and jpegObj.height<200 then exit function
	'为图片加入文字水印功能
	if waterType = 0 then
	jpegObj.Canvas.Font.Color = &H000000 ' 颜色,这里是设置成:黑 
	jpegObj.Canvas.Font.Family = "方正隶变简体"  ' 设置字体 
	jpegObj.Canvas.Font.Bold = False '是否设置成粗体 
	jpegObj.Canvas.Font.Size = 26 '字体大小 
	jpegObj.Canvas.Font.Quality = 4 ' 文字清晰度
	jpegObj.Canvas.Font.ShadowColor = &H000000 '阴影色彩 
	jpegObj.Canvas.Font.ShadowYOffset = 1 
	jpegObj.Canvas.Font.ShadowXOffset = 1 
	jpegObj.Canvas.Brush.Solid = True 
	jpegObj.Canvas.Font.Quality = 4 ' '输出质量
	
	select case location
		case "1" : jpegObj.Canvas.Print 5 , strHeight, waterMarkFont
		case "2" : jpegObj.Canvas.Print (jpegObj.width-strWidth) / 2, strHeight, waterMarkFont
		case "3" : jpegObj.Canvas.Print jpegObj.width-strWidth-5, strHeight, waterMarkFont
		case "4" : jpegObj.Canvas.Print 5 , (jpegObj.height-strHeight)/2, waterMarkFont
		case "5" : jpegObj.Canvas.Print (jpegObj.width-strWidth) / 2, (jpegObj.height-strHeight)/2, waterMarkFont
		case "6" : jpegObj.Canvas.Print jpegObj.width-strWidth-5, (jpegObj.height-strHeight)/2, waterMarkFont
		case "7" : jpegObj.Canvas.Print 5 , jpegObj.height-40, waterMarkFont
		case "8" : jpegObj.Canvas.Print (jpegObj.width-strWidth) / 2, jpegObj.height-40, waterMarkFont
		case else : jpegObj.Canvas.Print jpegObj.width-strWidth-5, jpegObj.height-40, waterMarkFont
	end select
	jpegObj.Save Server.MapPath(saveImgPath)    ' 保存文件
	else
	'为图片加入图片水印功能
	Set Logobox = Server.CreateObject("Persits.Jpeg")	
 	Logobox.Open Server.MapPath(waterMarkPic)
	 
	ImageWidth= Logobox.Width 
	ImageHeight= Logobox.Height
	Logobox.Width=markPicWidth
	Logobox.Height=markPicHeight
	 If jpegObj.OriginalWidth<Cint(ImageWidth) or jpegObj.Originalheight<Cint(ImageHeight) Then
	   Set jpegObj = Nothing
	    Exit Function
	 Else
	 ImageMode = "jpg"
 	IF ImageMode<>"" and FileExt<>"gif" Then 
	 jpegObj.Canvas.Pen.Width  = 1   
	 jpegObj.Canvas.Brush.Solid = False  
	 'jpegObj.DrawImage jpegObj.width-100, jpegObj.height-52, Logobox, 0.5  
	
	select case location
		case "1" : jpegObj.DrawImage 5 , 5, Logobox, markPicAlpha
		case "2" : jpegObj.DrawImage (jpegObj.width-markPicWidth) / 2, 5, Logobox, markPicAlpha
		case "3" : jpegObj.DrawImage jpegObj.width-markPicWidth-5, 5, Logobox, markPicAlpha
		case "4" : jpegObj.DrawImage 5 , (jpegObj.height-markPicHeight)/2, Logobox, markPicAlpha
		case "5" : jpegObj.DrawImage (jpegObj.width-markPicWidth) / 2, (jpegObj.height-markPicHeight)/2, Logobox, markPicAlpha
		case "6" : jpegObj.DrawImage jpegObj.width-markPicWidth-5, (jpegObj.height-markPicHeight)/2, Logobox, markPicAlpha
		case "7" : jpegObj.DrawImage 5 , jpegObj.height-markPicHeight-5, Logobox, markPicAlpha
		case "8" : jpegObj.DrawImage (jpegObj.width-markPicWidth) / 2, jpegObj.height-markPicHeight-5, Logobox, markPicAlpha
		case else : jpegObj.DrawImage jpegObj.width-markPicWidth-5, jpegObj.height-markPicHeight-5, Logobox, markPicAlpha
	end select
	
	 jpegObj.Canvas.Bar 0, 0, jpegObj.Width, jpegObj.Height  
	 jpegObj.Save Server.MapPath(saveImgPath)  
		End If
		
		jpegObj.Sharpen 1, 120
		jpegObj.Save Server.MapPath(saveImgPath)  
	   End If
   	Set Logobox=Nothing
	
	end if
	set jpegObj=Nothing
End Function


'获得目录
Function getAdminDir
	dim scriptname  
	dim page,systempath
	scriptname=request.servervariables("script_name")  
	page=replace(scriptname,"\","/") 
	page=lcase(right(page,len(page)-instrrev(page,"/"))) 
	systempath=left(scriptname,len(scriptname)-len(page)-1) 
	getAdminDir=right(systempath,len(systempath)-instrrev(systempath,"/"))  
End Function

'通过TAG内容获取到ID
Function getTagID(tag)
	dim sql,rs,tags,tagIDs
	tags=split(tag, ",")
	for each tag in tags
		if not isnul(tag) then 	
			sql="select TagID from {prefix}Tag where TagName='"&tag&"'"			
			set rs=conn.exec(sql,"r1")
			if not rs.eof then 
				getTagID=getTagID&"{"&rs(0)&"}"
			end if
		end if
	next	
	rs.close : set rs=nothing	
End Function



rem 通过内容中的ID获取TAG内容
Function getTags(tagID)
	dim sql,rs
	if isnul(tagID) then exit function
	sql="select * from {prefix}Tag where TagID in("&replace(replace(replace(tagID,"}{",","),"{",""),"}","")&")"
	set rs=conn.exec(sql,"r1")
	do while not rs.Eof
		getTags=getTags&rs("TagName")&","
		rs.movenext
	loop
	rs.close : set rs=nothing
	'getTags=left(getTags,len(getTags)-1)
	if not isnul(getTags) then getTags=left(getTags,len(getTags)-1)
End Function

rem 为TAG加链接
Function tagsLink(tags)
	dim sql,rs,link,tag
	link=sitePath&setting.languagePath&"taglist.asp?tag="
	tags=split(tags, ",")
	for each tag in tags
		if not isnul(tag) then 			
			tagsLink=tagsLink&"<a href="""&link&tag&""">"&tag&"</a>,"
		end if
	next	
	if not isnul(tagsLink) then tagsLink=left(tagsLink,len(tagsLink)-1)
End Function

'对listcontent的解析
Function LeftH(str,l)
         dim labelt,labels
         dim ishtml
         ishtml=false
         dim res
         dim c,c2
         dim n
         n=0
         dim maxlen
         maxlen=len(str)
         dim i
         i=0
         dim b,e
         do while n<l and i<maxlen
                 i=i+1
                 c=mid(str,i,1)
                 if c="<" then
                         c2=mid(str,i+1,1)
                         ishtml=true
                         b=i
                 end if
                 res=res+c
                 if ishtml=false then
                         n=n+1
                 else
                         if c=">" then
                                 if ishtml=true and c2<>"/" then
                                         labels=mid(str,b+1,i-b)
                                         e=InStr(labels," ")
                                         if e>0 then
                                                 labels="</"+left(labels,e-1)+">"
                                         else
                                                 labels="</"+labels
                                         end if
                                         labelt=labels+labelt
                                 end if
                                 ishtml=false
                         end if
                 end if
         loop
         leftH=res+labelt
 end function

' ============================================
' 判断是否安全字符串,在注册登录等特殊字段中使用
' ============================================
Function IsSafeStr(str)
 Dim s_BadStr, n, i
 s_BadStr = "'&<>?%,;:()`~!@#$^*{}[]|+-=┩" & Chr(34) & Chr(9) & Chr(32)
 n = Len(s_BadStr)
 IsSafeStr = True
 For i = 1 To n
  If Instr(str, Mid(s_BadStr, i, 1)) > 0 Then
   IsSafeStr = False
   Exit Function
  End If
 Next
End Function
'正则电话号码
Function CheckTelPhone(TelPhone)
	dim re,re2,CheckResult
	Set re = new RegExp
	Set re2 = new RegExp
	re.Pattern = "^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$" '电话格式1
	re2.Pattern = "^(([0\+]\d{2,3}-)?(0\d{2,3}))?(\d{7,8})(-(\d{3,}))?$" '电话格式2
	'进行匹配测试
	If re.Test(TelPhone) or re2.Test(TelPhone) Then
		CheckResult=true
	Else
		CheckResult=false
	End If
	CheckTelPhone=CheckResult
end function

'正则手机号码
Function CheckMobile(Mobile)
	dim re,CheckResult
	Set re = new RegExp
	re.Pattern = "^(((13[0-9]{1})|145|150|151|152|153|155|156|157|158|159|170|176|177|178|180|181|182|183|184|185|186|187|188|189)+\d{8})$"
	'进行匹配测试
	If re.Test(Mobile) Then
		CheckResult=true
	Else
		CheckResult=false
	End If
	CheckMobile=CheckResult
end function

'正则检测邮箱
Function CheckEmail(Email)
dim CheckResult,re
Set re = new RegExp '创建RegExp实例
re.Pattern = "^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
'Email = "crack8@qq.com"
'进行匹配测试,并写出是否匹配成功
If re.Test(Email) Then
''Response.write("匹配成功!")
CheckResult=true
Else
CheckResult=false
''Response.write("匹配成功!")
End If
CheckEmail=CheckResult
end function

'正则检测QQ号码
Function CheckQQnum(QQnum)
dim CheckResult,re
Set re = new RegExp
re.Pattern = "^\d{5,10}$"
If re.Test(QQnum) Then
CheckResult=true
Else
CheckResult=false
End If
CheckQQnum=CheckResult
end function

'正则网名数字大小写字母(6-10)
Function CheckCdoe(NetName)
dim re,CheckResult
Set re = new RegExp
re.Pattern = "^[0-9]{6,8}$"
'进行匹配测试
If re.Test(NetName) Then
CheckResult=true
Else
CheckResult=false
End If
CheckCdoe=CheckResult
end function
function cutStr(str)
if right(str,1)="\" then 
str=left(str,len(str)-1)
end if
str=Replace(str,"\","/") 
cutStr =str
end function

function getWebSite
dim len1
dim wwwroot:wwwroot=cutStr(server.MapPath("/"))
dim webroot:webroot=cutStr(server.MapPath("../"))
if len(webroot)-len(wwwroot)<0 then
len1=0
else
len1=len(webroot)-len(wwwroot)
end if
dim siteroot:siteroot=Right(webroot,len1)
getWebSite=siteroot
end function


'关键词替换链接
function replacekey(Tcontent)
	if Tcontent="" then exit function
	dim sql,rs
	sql="select KeyWordsText,KeyWordsUrl from {prefix}KeyWords where KeyWordsStatus=1 order by KeyWordsID desc"
	set rs=conn.exec(sql,"r1")
	if not rs.eof then
		do while not rs.eof
			Tcontent= replace(Tcontent,trim(rs("KeyWordsText")),"<a href="""&trim(rs("KeyWordsUrl"))&""" target=""_blank""><strong>"&trim(rs("KeyWordsText"))&"</strong></a>",1,1)
			rs.movenext
		loop
	end if
	replacekey=Tcontent
End Function

Function getReUrl
		dim rs
			set rs=conn.exec("select * from {prefix}Language where IsDefault=1","r1")
			if not rs.eof then
			getReUrl=rs("siteUrl")
			end if
end function

Function getReTitle
		dim rs
			set rs=conn.exec("select * from {prefix}Language where IsDefault=1","r1")
			if not rs.eof then
			getReTitle=rs("siteTitle")
			end if
end function

Function getIIS
	getIIS=mid(request.ServerVariables("SERVER_SOFTWARE"),15)
end Function

%>