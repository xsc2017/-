<!--#include file="../../inc/AspCms_SettingClass.asp" -->
<%
CheckAdmin("AspCms_Comments.asp")

'定义类别ID，搜索关键词，页数，排序
dim action : action=getForm("action","get")
dim SortID,keyword,page,order,pic,ID

SortID =getForm("sort","get")	
keyword=getForm("keyword","post")
if isnul(keyword) then keyword=getForm("keyword","get")
page=getForm("page","get")
order=getForm("order","get")
pic=getForm("pic","get")
ID=getForm("id","get")


select case action 
	case "edit" : editComment	
	case "del" : delComment	
	
	case "enable" :Enable
	case "notenabled" :NotEnabled	
end select
Dim CommentsID,CommentTitle,Contact,ContactWay,Content,Reply,AddTime,ReplyTime,CommentStatus,AuditStatus


Sub delComment	
	Dim id	:	id=getForm("id","both")
	if isnul(id) then alertMsgAndGo "请选择要删除的内容","-1"
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	pic=getForm("pic","get")
	Conn.Exec "delete from {prefix}Comments where CommentsID in("&id&")","exe"
	alertMsgAndGo "删除成功","?page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword
End Sub

Sub CommentList	
	dim datalistObj,rsArray
	dim m,i,orderStr,whereStr,sqlStr,rsObj,allPage,allRecordset,numPerPage,searchStr
	numPerPage=10
	orderStr= " order by CommentStatus desc,a.AddTime desc"
	if isNul(page) then page=1 else page=clng(page)
	if page=0 then page=1
	whereStr=" where a.ContentID=b.ContentID and c.SortID=b.SortID"
	if not isNul(SortID) then  whereStr=whereStr
	if not isNul(keyword) then 
		whereStr = whereStr&" and (Commentator like '%"&keyword&"%' or CommentContent like '%"&keyword&"%')"
	end if
	sqlStr = "select CommentsID,Commentator,CommentContent,a.AddTime,CommentStatus,a.ContentID,b.SortID,SortType,SortFolder,ContentFolder,ContentFileName,b.PageFileName,b.GroupID,c.GroupID,b.ContentID,b.AddTime from {prefix}Comments as a,{prefix}Content as b,{prefix}Sort as c "&whereStr&orderStr
	
	
	dim templateobj,templatePath : set templateobj = new TemplateClass
	set rsObj = conn.Exec(sqlStr,"r1")
	rsObj.pagesize = numPerPage
	allRecordset = rsObj.recordcount : allPage= rsObj.pagecount
	if page>allPage then page=allPage
	if allRecordset=0 then
		if not isNul(keyword) then
		    echo "<tr bgcolor=""#FFFFFF"" align=""center""><td colspan='8'>关键字 <font color=red>"""&keyword&"""</font> 没有记录</td></tr>" 
		else
		    echo "<tr bgcolor=""#FFFFFF"" align=""center""><td colspan='8'>还没有记录!</td></tr>"
		end if
	else 
		rsObj.absolutepage = page
		for i = 1 to numPerPage		
			 echo "<tr bgcolor=""#ffffff"" align=""center"" onMouseOver=""this.bgColor='#CDE6FF'"" onMouseOut=""this.bgColor='#FFFFFF'"">"&vbcrlf& _
		 	"<td height=""28""><input type=""checkbox"" name=""id"" value="""&rsObj(0)&""" class=""checkbox"" /><input type=""hidden"" name=""SpecIDs"" value="""&rsObj(0)&""" /></td>"&vbcrlf& _
				"<td  height=""28"">"&rsObj(0)&"</td>"&vbcrlf& _
				"<td>"&rsObj(1)&"</td>"&vbcrlf& _
				"<td align=""left"" style=""padding:2px;line-height:1.5em;"">"&replace(rsObj(2),"<br>","")&"</td>"&vbcrlf& _
				"<td>"&rsObj(3)&"</td>"&vbcrlf& _
				"<td>"&getStr(rsObj(4),"<a href=""?action=notenabled&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C1""><IMG src=""../../images/toolbar_ok.gif""></a>","<a href=""?action=enable&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C4""><IMG src=""../../images/toolbar_no.gif""></a>")&"</td>"&vbcrlf& _
				"<td><a target=""_blank"" href="""&templateobj.getContentLink(rsObj("SortID"),rsObj("b.ContentID"),rsObj("SortFolder"),rsObj("b.GroupID"),rsObj("ContentFolder"),rsObj("ContentFileName"),rsObj("b.AddTime"),rsobj("PageFileName"),rsObj("c.GroupID"))&""" class=""txt_C1"">查看</a> | <a href=""?action=del&id="&rsObj(0)&"&page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""" class=""txt_C1"" onClick=""return confirm('确定要删除吗')"">删除</a></td>"&vbcrlf& _
				
			  "</tr>"&vbcrlf
			rsObj.movenext
			if rsObj.eof then exit for
		next
		echo"<tr bgcolor=""#FFFFFF"" class=""pagenavi"">"&vbcrlf& _
			"<td colspan=""8"" height=""28"" style=""padding-left:20px;"">"&vbcrlf& _	
			"页数："&page&"/"&allPage&"  每页"&numPerPage &" 总记录数"&allRecordset&"条 <a href=""?page=1&order="&order&"&sort="&sortID&"&keyword="&keyword&""">首页</a> <a href=""?page="&(page-1)&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">上一页</a> "&vbcrlf
		dim pageNumber
		pageNumber=makePageNumber_(page, 10, allPage, "guestlist","","","")
		echo pageNumber
		echo"<a href=""?page="&(page+1)&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">下一页</a> <a href=""?page="&allPage&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">尾页</a>"&vbcrlf& _
			"</td>"&vbcrlf& _			
		"</tr>"&vbcrlf
	end if
	rsObj.close : set rsObj = nothing		
	set templateobj =nothing : terminateAllObjects
End Sub

Sub NotEnabled	
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	Dim id				:	id=getForm("ID","get")
	Conn.Exec"update {prefix}Comments set CommentStatus=0 Where CommentsID="&id,"exe"
	response.Redirect getPageName()&"?page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword	
End Sub

Sub Enable
	SortID =getForm("sort","get")
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")

	Dim id				:	id=getForm("ID","get")
	Conn.Exec"update {prefix}Comments set CommentStatus=1 Where CommentsID="&id,"exe"
	response.Redirect getPageName()&"?page="&page&"&order="&order&"&sort="&sortID&"&keyword="&keyword
End Sub

%>