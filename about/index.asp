<!--#include file="../inc/AspCms_SettingClass.asp" -->
<%
dim SortID,Page,SortAndID,qs

qs=split(request.QueryString,FileExt)(0)
SortAndID=split(qs,"_")
if isNul(qs) then  echoMsgAndGo "页面不存在",3 
SortID = SortAndID(0)
if not isNul(SortID) and isNum(SortID) then SortID=clng(SortID) else echoMsgAndGo "页面不存在",3 end if
if ubound(SortAndID)=0 then page=1 else page=SortAndID(1) end if 
if not isNul(page) and isNum(page) then page=clng(page) else echoMsgAndGo "页面不存在",3 end if
echo makeAbout(SortID, Page, false)
If DebugMode Then echo timer - AppSpan
%>