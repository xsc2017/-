<!--#include file="../inc/AspCms_SettingClass.asp" -->
<%
dim ContentID,Page,SortAndID,qs
qs=split(request.QueryString,FileExt)(0)
SortAndID=split(qs,"_")
if isNul(qs) then  echoMsgAndGo "页面不存在",3 
ContentID=SortAndID(0)
if not isNul(ContentID) and isNum(ContentID) then ContentID=clng(ContentID) else echoMsgAndGo "页面不存在",3 end if
if ubound(SortAndID)=0 then page=1 else page=SortAndID(1) end if 
if not isNul(page) and isNum(page) then page=clng(page) else echoMsgAndGo "页面不存在",3 end if

dim content : content=makeContent(ContentID, Page, false)
if isnul(content) then 
	echoMsgAndGo "页面不存在",3 
else
	echo content
end If

If DebugMode Then echo timer - AppSpan
%>