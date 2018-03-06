<!--#include file="../inc/AspCms_SettingClass.asp" -->
<%
if  runMode="0"  then
	dim templateobj,templatePath : set templateobj = new TemplateClass	
	templatePath=sitePath&"/"&"templates/"&setting.defaultTemplate&"/"&setting.htmlFilePath&"/index.html"	
	
	if not CheckTemplateFile(templatePath) then echo "index.html"&err_16	
	with templateObj 
		.content=loadFile(templatePath) 
		.parseHtml()
		.indexpath
		.parseCommon
		echo .content 
	end with	
	set templateobj =nothing : terminateAllObjects
Else
	dim extName
	if setting.IsDefault=1 then
		extName=""
	else
		extName="_"&LanguageAlias
	end if
	On Error Resume Next
	Response.Redirect(sitePath&setting.languagepath&"index"&extName&FileExt) '兼容netBox
	'Server.Transfer(sitePath&setting.languagepath&"index"&extName&FileExt)
	If -2147467259 = Err.Number Then Response.Charset=Charset:Response.Write "缺少首页文件，请登录后台生成首页文件！"	
end if
If DebugMode Then echo timer - AppSpan 
%>