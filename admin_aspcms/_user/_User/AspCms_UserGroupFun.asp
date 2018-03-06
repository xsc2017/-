<!--#include file="../../inc/AspCms_SettingClass.asp" -->
<%
dim page,sortid,keyword,order

checkLogin()

SortID =getForm("sort","get")	
keyword=getForm("keyword","post")
if isnul(keyword) then keyword=getForm("keyword","get")
page=getForm("page","get")
order=getForm("order","get")


dim action : action=getForm("action","get")
Select case action		
	case "addg" : addUserGroup
	case "editg" : editUserGroup
	case "delg" : delUserGroup
	case "ong" : onOff "on", "UserGroup", "GroupID", "GroupStatus", "and IsAdmin=0", getPageName()
	case "offg" : onOff "off", "UserGroup", "GroupID", "GroupStatus", "and IsAdmin=0", getPageName()
	
	case "add" : addUser
	case "edit" : editUser
	case "del" : delUser
	case "on" : onOff "on", "User", "UserID", "UserStatus", "", getPageName()
	case "off" : onOff "off", "User", "UserID", "UserStatus", "", getPageName()
	
End Select


dim GroupID, IsAdmin, GroupName, GroupDesc, GroupStatus, GroupMark, GroupMenu, GroupSort, GroupOrder
dim UserID, LanguageID, SceneID, LoginName, Password, PswQuestion, PswAnswer, UserStatus, RegTime, RegIP, LastLoginIP, LastLoginTime, LoginCount, TrueName, Gender, Birthday, Country, Province, City, Address, PostCode, Phone, Mobile, Email, QQ, MSN, Permissions, UserDesc
dim sql, msg

Sub getUserGroup
	dim id : id=getForm("id","get")
	if not isnul(ID) then		
		sql ="select * from {prefix}UserGroup where IsAdmin=0 and GroupID="&id
		dim rs : set rs = conn.exec(sql,"r1")
		if rs.eof then 
			alertMsgAndGo "没有这条记录","-1"
		else
			GroupID=rs("GroupID")
			IsAdmin=rs("IsAdmin")
			GroupName=rs("GroupName")
			GroupDesc=rs("GroupDesc")
			GroupStatus=rs("GroupStatus")
			GroupMark=rs("GroupMark")
			GroupMenu=rs("GroupMenu")
			GroupSort=rs("GroupSort")
			GroupOrder=rs("GroupOrder")
		end if
		rs.close : set rs=nothing
	else		
		alertMsgAndGo "没有这条记录","-1"
	end if
End Sub

Sub addUserGroup	
	IsAdmin=0
	GroupName=getForm("GroupName","post")
	GroupDesc=getForm("GroupDesc","post")
	GroupStatus=getCheck(getForm("GroupStatus","post"))
	GroupMark=getForm("GroupMark","post")
	GroupMenu=getForm("GroupMenu","post")
	GroupSort=""
	GroupOrder=getForm("GroupOrder","post")
	
	if isNul(GroupName) then alertMsgAndGo"请填写组名称","-1"
	if not isNum(GroupMark) then alertMsgAndGo"请正确填写权限值","-1"
	if not isNum(GroupOrder) then alertMsgAndGo"请正确填写排序数字","-1"
		
	sql="insert into {prefix}UserGroup( IsAdmin, GroupName, GroupDesc, GroupStatus, GroupMark, GroupMenu, GroupSort, GroupOrder) values("&IsAdmin&", '"&GroupName&"', '"&GroupDesc&"', "&GroupStatus&", "&GroupMark&", '"&GroupMenu&"', '"&GroupSort&"', "&GroupOrder&")"
	msg="添加会员组成功"
	conn.exec sql,"exe"	
	alertMsgAndGo msg,"AspCms_UserGroupList.asp"
End Sub

Sub editUserGroup
	GroupID=getForm("GroupID","post")
	IsAdmin=0
	GroupName=getForm("GroupName","post")
	GroupDesc=getForm("GroupDesc","post")
	GroupStatus=getCheck(getForm("GroupStatus","post"))
	GroupMark=getForm("GroupMark","post")
	GroupMenu=getForm("GroupMenu","post")
	GroupSort=""
	GroupOrder=getForm("GroupOrder","post")
	
	if not isNum(GroupID) then alertMsgAndGo "组ID不正确！","-1"	
	if isNul(GroupName) then alertMsgAndGo"请填写组名称","-1"
	if not isNum(GroupMark) then alertMsgAndGo"请正确填写权限值","-1"
	if not isNum(GroupOrder) then alertMsgAndGo"请正确填写排序数字","-1"
	
	sql="update {prefix}UserGroup set GroupName='"&GroupName&"', GroupDesc='"&GroupDesc&"', GroupMenu='"&GroupMenu&"', GroupOrder="&GroupOrder&", GroupMark="&GroupMark&", GroupStatus="&GroupStatus&" where GroupID="&GroupID
	msg="修改会员组成功"
	conn.exec sql,"exe"	
	alertMsgAndGo msg,"AspCms_UserGroupList.asp"
End Sub

Sub onUserGroup

End Sub

Sub offUserGroup

End Sub

Sub delUserGroup	
	dim id	:	id=getForm("id","both")
	if isnul(id) then alertMsgAndGo "请选择要操作的内容","-1"
	dim ids,i
	ids=split(id,",")
	for i=0 to ubound(ids)
		if ids(i)>=4 then conn.exec "delete from {prefix}UserGroup where IsAdmin=0 and GroupID="&ids(i),"exe"
	next
	alertMsgAndGo "删除成功",getPageName()		
End Sub



Sub userGroupList
	sql="select * from {prefix}UserGroup where IsAdmin=0 order by GroupOrder ,GroupID"
	dim rs
	set rs=conn.exec(sql,"r1")
	if rs.eof then 
		echo "<TR class=list>"&vbcrlf& _
			"<TD colspan=""8"" align=""center"">没有记录</TD>"&vbcrlf& _
			"</TR>"&vbcrlf
	else
		do while not rs.eof 
			echo "<tr bgcolor=""#ffffff"" onMouseOver=""this.bgColor='#CDE6FF'"" onMouseOut=""this.bgColor='#FFFFFF'"">"&vbcrlf& _
			"<TD align=middle width=29 height=26><INPUT type=checkbox value="""&rs("GroupID")&""" name=""id""></TD>"&vbcrlf& _
			"<TD width=38 height=26>"&rs("GroupID")&"</TD>"&vbcrlf& _
			"<TD>"&rs("GroupName")&"</TD>"&vbcrlf& _
			"<TD width=371>"&rs("GroupDesc")&"</TD>"&vbcrlf& _
			"<TD width=88>"&getStr(rs("GroupStatus"),"<a href=""?action=offg&id="&rs("GroupID")&""" title=""启用""><IMG src=""../../images/toolbar_ok.gif""></a>","<a href=""?action=ong&id="&rs("GroupID")&""" title=""禁用"" ><IMG src=""../../images/toolbar_no.gif""></a>")&"</TD>"&vbcrlf& _
			"<TD width=73>"&rs("GroupMark")&"</TD>"&vbcrlf& _
			"<TD width=50>"&rs("GroupOrder")&"</TD>"&vbcrlf& _
			"<TD width=82><a href=""AspCms_UserGroupedit.asp?id="&rs("GroupID")&""">修改</a> <a href=""?action=delg&id="&rs("GroupID")&""" onClick=""return confirm('确定要删除吗')"">删除</a></TD>"&vbcrlf& _
			"</TR>"&vbcrlf
			rs.moveNext
		loop
	end if	
	rs.close : set rs=nothing
End Sub

Sub getUser
	dim id : id=getForm("id","get")
	if not isnul(ID) then		
		sql ="select * from {prefix}User where UserID="&id
		dim rs : set rs = conn.exec(sql,"r1")
		if rs.eof then 
			alertMsgAndGo "没有这条记录","-1"
		else
			UserID=rs("UserID")
			GroupID=rs("GroupID")
			LoginName=rs("LoginName")
			UserStatus=rs("UserStatus")
			TrueName=rs("TrueName")
			 Gender=rs("Gender")
			 Birthday=rs("Birthday")
			 Address=rs("Address")
			 PostCode=rs("PostCode")
			 Phone=rs("Phone")
			 Mobile=rs("Mobile")
			 Email=rs("Email")
			 QQ=rs("QQ")
			 MSN=rs("MSN")
		end if
		rs.close : set rs=nothing
	else		
		alertMsgAndGo "没有这条记录","-1"
	end if
End Sub


Sub addUser	
	GroupID=getForm("GroupID","post")
	LoginName=getForm("LoginName","post")
	Password=getForm("Password","post")
	UserStatus=getCheck(getForm("UserStatus","post"))
	UserDesc=getForm("UserDesc","post")
	RegTime=formatDate(now(),4)
	RegIP=getIP()
	LoginCount=0
	TrueName=getForm("TrueName","post")
 Gender=getForm("Gender","post")
 Birthday=getForm("Birthday","post")
 Address=getForm("Address","post")
 PostCode=getForm("PostCode","post")
 Phone=getForm("Phone","post")
 Mobile=getForm("Mobile","post")
 Email=getForm("Email","post")
 QQ=getForm("QQ","post")
 MSN=getForm("MSN","post")
	
	if isNul(LoginName) then alertMsgAndGo"请填写用户名称","-1"
	if isNul(Password) then alertMsgAndGo"请填写用户密码","-1"
	if conn.Exec("select count(*) from {prefix}User where LoginName='"&LoginName&"'","r1")(0) >0 then alertMsgAndGo "该用户名已存在","-1"
	
	sql="insert into {prefix}User( GroupID, LoginName, [Password], UserStatus, RegTime, RegIP, LoginCount,TrueName, Gender, Birthday, Address, PostCode, Phone, Mobile, Email, QQ, MSN) values("&GroupID&", '"&LoginName&"', '"&md5(Password,16)&"', "&UserStatus&", '"&RegTime&"', '"&RegIP&"', "&LoginCount&",'"&TrueName&"',"&Gender&",'"&Birthday&"','"&Address&"','"&PostCode&"','"&Phone&"','"&Mobile&"','"&Email&"','"&QQ&"','"&MSN&"')"
	msg="添加用户成功"
	
	conn.exec sql,"exe"	
	alertMsgAndGo msg,"AspCms_UserList.asp"
End Sub

Sub editUser
	UserID=getForm("UserID","post")
	GroupID=getForm("GroupID","post")
	LoginName=getForm("LoginName","post")
	Password=getForm("Password","post")
	UserStatus=getForm("UserStatus","post")
	'die UserStatus
	UserDesc=getForm("UserDesc","post")
	if UserStatus="on" then 
	UserStatus=1 
	else 
	UserStatus=0
	end if
	TrueName=getForm("TrueName","post")
	 Gender=getForm("Gender","post")
	 Birthday=getForm("Birthday","post")
	 Address=getForm("Address","post")
	 PostCode=getForm("PostCode","post")
	 Phone=getForm("Phone","post")
	 Mobile=getForm("Mobile","post")
	 Email=getForm("Email","post")
	 QQ=getForm("QQ","post")
	 MSN=getForm("MSN","post")	
	
	if not isNum(GroupID) then alertMsgAndGo "组ID不正确！","-1"	
	Dim passStr
	if isNul(Password) then 
		passStr=""
	else
		passStr=" , [Password]='"&md5(Password, 16)&"'"
	end if
	
	sql="update {prefix}User set GroupID="&GroupID&passStr&",UserStatus="&UserStatus&",TrueName='"&TrueName&"', Gender="&Gender&", Birthday='"&Birthday&"', Address='"&Address&"', PostCode='"&PostCode&"', Phone='"&Phone&"', Mobile='"&Mobile&"', Email='"&Email&"', QQ='"&QQ&"', MSN='"&MSN&"' where LoginName='"&LoginName&"'"
	'die sql
	msg="修改成功"
	conn.exec sql,"exe"	
	alertMsgAndGo msg,"AspCms_UserList.asp"
End Sub

Sub delUser	
	dim id	:	id=getForm("id","both")
	if isnul(id) then alertMsgAndGo "请选择要操作的内容","-1"
	dim ids,i
	ids=split(id,",")
	for i=0 to ubound(ids)
		if ids(i)>1 then conn.exec "delete from {prefix}User where UserID="&ids(i),"exe"
	next	
	alertMsgAndGo "删除成功",getPageName()
End Sub

Sub UserList
	dim datalistObj,rsArray
	dim m,i,orderStr,whereStr,sqlStr,rsObj,allPage,allRecordset,numPerPage,searchStr
	numPerPage=10
	orderStr= " order by UserID desc"
	if isNul(page) then page=1 else page=clng(page)
	if page=0 then page=1
	whereStr=" where 1=1 "
	if not isNul(SortID) then  whereStr=whereStr
	if not isNul(keyword) then 
		whereStr = whereStr&" and LoginName like '%"&keyword&"%'"
	end if
	sqlStr = "select UserID,LoginName,Gender,Email,QQ,LastLoginTime,UserStatus,{prefix}User.GroupID,GroupName,Mobile,Address,PostCode,RegTime,LastLoginIP,Birthday from {prefix}User, {prefix}UserGroup "&whereStr&" and {prefix}User.GroupID={prefix}UserGroup.GroupID and {prefix}UserGroup.IsAdmin=0 "&orderStr
	'die sqlStr
	set rsObj = conn.Exec(sqlStr,"r1")
	rsObj.pagesize = numPerPage
	allRecordset = rsObj.recordcount : allPage= rsObj.pagecount
	if page>allPage then page=allPage
	if allRecordset=0 then
		if not isNul(keyword) then
		    echo "<tr bgcolor=""#FFFFFF"" align=""center""><td colspan='9'>关键字 <font color=red>"""&keyword&"""</font> 没有记录</td></tr>" 
		else
		    echo "<tr bgcolor=""#FFFFFF"" align=""center""><td colspan='9'>还没有记录!</td></tr>"
		end if
	else  
		rsObj.absolutepage = page
		for i = 1 to numPerPage	
			echo "<tr bgcolor=""#ffffff"" onMouseOver=""this.bgColor='#CDE6FF'"" onMouseOut=""this.bgColor='#FFFFFF'"">"&vbcrlf& _
					"<TD align=middle height=26><INPUT type=checkbox value="""&rsObj("UserID")&""" name=""id""></TD>"&vbcrlf& _
					"<TD>"&rsObj("UserID")&"</TD>"&vbcrlf& _
					"<TD>"&rsObj("LoginName")&"</TD>"&vbcrlf& _
					"<TD>"&rsObj("GroupName")&"</TD>"&vbcrlf& _
					"<TD>"&rsObj("LastLoginTime")&"</TD>"&vbcrlf& _
					"<TD>"&rsObj("LastLoginIP")&"</TD>"&vbcrlf& _
					"<TD>"&getStr(rsObj("UserStatus"),"<a href=""?action=off&id="&rsObj("UserID")&""" title=""启用""><IMG src=""../../images/toolbar_ok.gif""></a>","<a href=""?action=on&id="&rsObj("UserID")&""" title=""禁用"" ><IMG src=""../../images/toolbar_no.gif""></a>")&"</TD>"&vbcrlf& _
					"<TD><a href=""AspCms_UserEdit.asp?id="&rsObj("UserID")&""">修改</a> <a href=""?action=del&id="&rsObj("UserID")&""" onClick=""return confirm('确定要删除吗')"">删除</a></TD>"&vbcrlf& _
			  "</tr>"&vbcrlf
			rsObj.movenext
			if rsObj.eof then exit for
		next

		echo"<tr bgcolor=""#FFFFFF"" class=""pagenavi"">"&vbcrlf& _
			"<td colspan=""8"" height=""28"" style=""padding-left:20px;"">"&vbcrlf& _				
			"页数："&page&"/"&allPage&"  每页"&numPerPage &" 总记录数"&allRecordset&"条 <a href=""?page=1&order="&order&"&sort="&sortID&"&keyword="&keyword&""">首页</a> <a href=""?page="&(page-1)&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">上一页</a> "&vbcrlf
		dim pageNumber
		pageNumber=makePageNumber_(page, 10, allPage, "userlist",sortID,order,keyword)
		echo pageNumber
		echo"<a href=""?page="&(page+1)&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">下一页</a> <a href=""?page="&allPage&"&order="&order&"&sort="&sortID&"&keyword="&keyword&""">尾页</a>"&vbcrlf& _		
		"</td>"&vbcrlf& _
		"</tr>"&vbcrlf
	end if
	rsObj.close : set rsObj = nothing	
End Sub
%>