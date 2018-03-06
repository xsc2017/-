<!--#include file="../../../inc/AspCms_MainClass.asp" -->
<%
CheckAdmin("AspCms_artUrl.asp")

dim action : action=getForm("action", "get")
dim LinkText,LinkStatus,LinkURL,ID

Select case action
	case "del" : delLinks
	case "add" : addLinks
	case "edit" : editLinks
	case "on" : onOff "on", "KeyWords", "KeyWordsID", "KeyWordsStatus", "", getPageName()
	case "off" : onOff "off", "KeyWords", "KeyWordsID", "KeyWordsStatus", "", getPageName()	
End Select

Sub getContent
	ID = getForm("id","get")
	Dim rsObj 	: Set rsObj=Conn.Exec("select KeyWordsText,KeyWordsUrl,EditTime,KeyWordsStatus from {prefix}KeyWords where KeyWordsID="&ID,"r1")
	if isnul(ID) then alertMsgAndGo "ID不能为空","-1"
	LinkText=rsObj("KeyWordsText")
	LinkURL=rsObj("KeyWordsUrl")
	LinkStatus=rsObj("KeyWordsStatus")
	rsObj.close	:	Set rsObj = nothing
End Sub

Sub editLinks
	ID=getForm("LinkID","post")
	LinkText=getForm("LinkText","post")	
	LinkStatus=getCheck(getForm("LinkStatus","post"))
	LinkURL=getForm("LinkURL","post")	
	
	if isnul(LinkText) then alertMsgAndGo "网站名称不能为空","-1"
	if isnul(LinkURL) then alertMsgAndGo "链接地址不能为空","-1"		
	if not isurl(LinkURL) then alertMsgAndGo "链接地址不正确","-1"	
	if isnul(LinkStatus) then LinkStatus=0
	
	conn.Exec "update {prefix}KeyWords set KeyWordsText='"&LinkText&"',KeyWordsUrl='"&LinkURL&"',KeyWordsStatus="&LinkStatus&" where KeyWordsID="&ID,"exe"
	
	alertMsgAndGo "修改成功","AspCms_artUrl.asp"
End Sub

Sub addLinks 	
	LinkText=getForm("LinkText","post")
	LinkStatus=getCheck(getForm("LinkStatus","post"))
	LinkURL=getForm("LinkUrl","post")	

	if isnul(LinkText) then alertMsgAndGo "网站名称不能为空","-1"
	if isnul(LinkURL) then alertMsgAndGo "链接地址不能为空","-1"		
	if not isurl(LinkURL) then alertMsgAndGo "链接地址不正确","-1"
	conn.Exec "insert into {prefix}KeyWords(KeyWordsText,KeyWordsUrl,EditTime,KeyWordsStatus) values('"&LinkText&"','"&LinkUrl&"','"&formatDate(now(),4)&"','"&LinkStatus&"')","exe"		
	alertMsgAndGo "添加成功","AspCms_artUrl.asp"
End Sub	

Sub KeyList
	Dim rsObj,sql
	sql="select KeyWordsID,KeyWordsText,KeyWordsUrl,KeyWordsStatus from {prefix}KeyWords"
	Set rsObj=Conn.Exec(sql,"r1")
	If rsObj.Eof Then 
		echo"<tr bgcolor=""#FFFFFF"" align=""center"">"&vbcrlf& _
			"<td colspan=""6"">没有数据</td>"&vbcrlf& _
		  "</tr>"&vbcrlf
	Else
		Do while not rsObj.Eof 
		 echo"<tr class=list>"&vbcrlf& _
			"<TD height=26><INPUT type=checkbox value="""&rsObj("KeyWordsID")&""" name=""id""></TD>"&vbcrlf& _
			"<td>"&rsObj("KeyWordsID")&"</td>"&vbcrlf& _
			"<td>"&rsObj("KeyWordsText")&"</td>"&vbcrlf& _
			"<td>"&rsObj("KeyWordsUrl")&"</td>"&vbcrlf& _
			"<TD>"&getStr(rsObj("KeyWordsStatus"),"<a href=""?action=off&id="&rsObj("KeyWordsID")&""" title=""启用""><IMG src=""../../images/toolbar_ok.gif""></a>","<a href=""?action=on&id="&rsObj("KeyWordsID")&""" title=""禁用"" ><IMG src=""../../images/toolbar_no.gif""></a>")&"</TD>"&vbcrlf& _
			"<td><a href=""AspCms_artUrlEdit.asp?id="&rsObj("KeyWordsID")&""" class=""txt_C1"">修改</a> | <a href=""?action=del&id="&rsObj("KeyWordsID")&""" class=""txt_C1"" onClick=""return confirm('确定要删除吗')"">删除</a></td>"&vbcrlf& _
		  "</tr>"&vbcrlf
		  rsObj.MoveNext
		Loop
	End If
	rsObj.close	:	Set rsObj = nothing
End Sub

Sub delLinks 
	id=getForm("id","both")
	if isnul(id) then alertMsgAndGo "请选择要删除的内容","-1"

	conn.Exec "Delete * from {prefix}KeyWords where KeyWordsID in("&id&")" ,"exe"
	alertMsgAndGo "删除成功","AspCms_artUrl.asp"	
End Sub 

%>