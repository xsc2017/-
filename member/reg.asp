<!--#include file="../inc/AspCms_SettingClass.asp" -->
<%
dim action : action=getform("action","get")
if action = "reg" then
	addUser()
elseif action = "editpass" then
	editUser()
else
	echoContent()
end if

Sub editPass
	dim LoginName,userPass,reuserPass
	LoginName=trim(session("loginName"))	
	userPass=getForm("userPass","post")	
	reuserPass=getForm("reuserPass","post")		
	
	if userPass<>reuserPass then alertMsgAndGo "两次输入密码不相同","-1" 		
	'die  "update {prefix}User set [Password]='"&md5(userPass,16)&"' where LoginName='"&LoginName&"'"
	conn.Exec "update {prefix}User set [Password]='"&md5(userPass,16)&"' where LoginName='"&LoginName&"'","exe"	
	alertMsgAndGo "密码修改成功","editPass.asp"
End Sub

Sub editUser
	dim LoginName,userPass,reuserPass,Email,Mobile,Address,PostCode,Gender,QQ,TrueName,Phone
	LoginName=trim(session("loginName"))	
	userPass=getForm("userPass","post")	
	reuserPass=getForm("reuserPass","post")		
	
	Email=filterPara(getForm("Email","post"))
	Mobile=filterPara(getForm("Mobile","post"))
	Address=filterPara(getForm("Address","post"))
	PostCode=filterPara(getForm("PostCode","post"))
	Gender=filterPara(getForm("Gender","post"))
	QQ=filterPara(getForm("QQ","post"))
	TrueName=filterPara(getForm("TrueName","post"))
	Phone=filterPara(getForm("Phone","post"))

	
	if userPass<>reuserPass then alertMsgAndGo "两次输入密码不相同","-1" 	
	
	dim passStr
	if not isnul(userPass) then passStr="[Password]='"&md5(userPass,16)&"',"	

	'Gender="1,groupid=1"
	'alertMsgAndGo Gender,""
	if not isnum(Gender) then gender = 1
	'alertMsgAndGo Gender,""
	dim sqlsql
	sqlsql = "update {prefix}User set "&passStr&" Email='"&Email&"',QQ='"&QQ&"',Mobile='"&Mobile&"',Address='"&Address&"',PostCode='"&PostCode&"',Gender="&Gender&",Phone='"&Phone&"',TrueName='"&TrueName&"' where LoginName='"&LoginName&"'"
	Conn.Exec sqlsql,"exe"	
	'response.Write(sqlsql)
	alertMsgAndGo "修改成功","editPass.asp"	
End Sub

Sub echoContent()
	dim templateobj,templatePath : set templateobj = new TemplateClass	
	templatePath=sitePath&"/"&"templates/"&setting.defaultTemplate&"/"&setting.htmlFilePath&"/reg.html"	
	'die templatePath
	if not CheckTemplateFile(templatePath) then echo "reg.html"&err_16
	
	
	with templateObj 
		.content=loadFile(templatePath) 
		.parseHtml()		
		.parseCommon
		echo .content 
	end with	
	set templateobj =nothing : terminateAllObjects
End Sub



Sub addUser
	'dim UserID,GroupID,LanguageID,SceneID,LoginName,Password,PswQuestion,PswAnswer,UserStatus,RegTime,RegIP,LastLoginIP,LastLoginTime,LoginCount,TrueName,Gender,Birthday,Country,Province,City,Address,PostCode,Phone,Mobile,Email,QQ,MSN,Permissions,AdminDesc

	Dim LoginName,Password,verifyPass,Email,Mobile,Address,PostCode,Gender,QQ,UserStatus,RegTime,RegIP,LastLoginIP,LastLoginTime,Birthday,Exp1,Exp2,Exp3,GroupID,TrueName,Phone
	if getForm("code","post")<>Session("Code") then alertMsgAndGo "验证码不正确","-1"

	LoginName=filterPara(getForm("LoginName","post"))
	Password=filterPara(getForm("userPass","post"))
	verifyPass=filterPara(getForm("verifyPass","post"))
	Email=filterPara(getForm("Email","post"))
	Mobile=filterPara(getForm("Mobile","post"))
	Address=filterPara(getForm("Address","post"))
	PostCode=filterPara(getForm("PostCode","post"))
	Gender=1
	Gender=filterPara(getForm("Gender","post"))
	QQ=filterPara(getForm("QQ","post"))
	Phone=filterPara(getForm("Phone","post"))
	TrueName=filterPara(getForm("TrueName","post"))
	
	UserStatus=1
	RegTime=formatDate(now(),4)
	RegIP=getip()
	GroupID=3

	
	if isnul(LoginName) then alertMsgAndGo "用户名不能为空","-1"
	if Conn.Exec("select count(*) from {prefix}User where LoginName='"&LoginName&"'","r1")(0) >0 then alertMsgAndGo "该用户名已被注册","-1"
	
	if isnul(Password) then alertMsgAndGo "密码不能为空","-1"
	if isnul(verifyPass) then alertMsgAndGo "确认密码不能为空","-1"
	if Password<>verifyPass then alertMsgAndGo "两次输入密码不相同","-1"
	if len(LoginName)>15 then alertMsgAndGo "用户名不能大于15个字符","-1"
	if not IsSafeStr(LoginName) then alertMsgAndGo "您的用户名里包含了不安全字段，请重新输入","-1"
	if not IsSafeStr(TrueName) then alertMsgAndGo "您的真是姓名里包含了不安全字段，请重新输入","-1"
	if len(TrueName)>5 then alertMsgAndGo "真实姓名不能大于5个字符，如真实姓名超过5个字符的用户，请联系网站管理员！","-1"
	if not isnul(Mobile) then
		if not CheckMobile(Mobile) then alertMsgAndGo "您输入的手机号码格式不正确，请重新输入","-1"
	end if
	if not isNum(Gender) then
	  alertMsgAndGo "您选择的性别不正确，请重新选择","-1"
	end if
	if not isnul(Phone) then
		if not CheckTelPhone(Phone) then alertMsgAndGo "您输入的电话号码格式不正确，请重新输入","-1"
	end if
	if not isnul(Email) then
		if not CheckEmail(Email) then alertMsgAndGo "您输入的邮箱格式不正确，请重新输入","-1"
	end if
	if not isnul(QQ) then
		if not CheckQQnum(QQ) then alertMsgAndGo "您输入的QQ格式不正确，请重新输入","-1"
	end if
	if not isnul(Address) then
		if not IsSafeStr(Address) then alertMsgAndGo "您输入的地址里面含有不安全字段，请检查并且重新输入","-1"
	end if
	if not isnul(PostCode) then
		if not CheckCdoe(PostCode) then alertMsgAndGo "您输入的邮政编码格式不正确，请重新输入","-1"
	end if
	Password=md5(Password,16)
	Conn.Exec"insert into {prefix}User(LoginName,[Password],Email,Mobile,Address,PostCode,Gender,QQ,UserStatus,RegIP,RegTime,GroupID,TrueName,Phone) values('"&LoginName&"','"&Password&"','"&Email&"','"&Mobile&"','"&Address&"','"&PostCode&"','"&Gender&"','"&QQ&"',"&UserStatus&",'"&RegIP&"','"&RegTime&"',"&GroupID&",'"&TrueName&"','"&Phone&"')","exe"
	alertMsgAndGo "注册成功！",sitePath&setting.languagepath&"member/login.asp"
End Sub
%>
