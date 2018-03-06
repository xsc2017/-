<!--#include file="AspCms_MainClass.asp" -->
<%
if siteMode=0 then die siteHelp
dim LanguageAlias : LanguageAlias=""
dim lg:lg=Trim(getForm("lg","get"))
if not isnul(lg) then
	dim lgObj:set lgObj=conn.exec("select * from {prefix}Language where Alias='"&lg&"'","exe")
	if not lgObj.eof then 
		 wCookie "LanguageAlias",lg
	else
		alertMsgAndGo "网站没有添加这个语言！",sitePath&"/"
	end if
	lgObj.close : set lgObj=nothing
end if
if rCookie("LanguageAlias")<>"" then LanguageAlias = rCookie("LanguageAlias")

'设置页面模式，首先检测域名绑定，否则使用二级路径跳转模式
dim domain:domain=Request.ServerVariables("SERVER_NAME")
dim pagemode: pagemode=""
If (domain=wapDomain) and switchWapStatus Then
	pagemode="wap"
elseif wapDomain<>"" and checkWap() and switchWapStatus Then
	Response.Redirect("http://"&wapDomain)
elseif switchWapStatus then
	checkMode()
end if

dim setting : set setting=new SettingClass
%>
<!--#include file="AspCms_Language.asp" -->