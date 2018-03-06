<!--#include file="../../inc/AspCms_SettingClass.asp" -->
<%
dim action : action=getForm("action","get")
dim votetitle,votename,votenum,votetype
Select case action
	case "save" : savepaySetting
End Select



dim sql123
dim kvArr1

sql123 = "select * from {prefix}vote "
		kvArr1 = Conn.Exec(sql123,"arr")

if getDataCount("select Count(*) from {prefix}vote ") >0 then
votetitle = kvArr1(1,0)
votename = kvArr1(2,0)
votenum = kvArr1(3,0)
votetype = kvArr1(4,0)
end if




Sub savepaySetting	
	'dim templateobj,configStr,configPath
'	configPath="vote_config.asp"
'	set templateobj=new TemplateClass
'	configStr=loadFile(configPath)
'	
'	configStr=templateobj.regExpReplace(configStr,"Const votetitle=""(\S*?)""","Const votetitle="""&getForm("votetitle","post")&"""")	
'	configStr=templateobj.regExpReplace(configStr,"Const votename=""(\S*?)""","Const votename="""&getForm("votename","post")&"""")	
'	configStr=templateobj.regExpReplace(configStr,"Const votenum=""(\S*?)""","Const votenum="""&getForm("votenum","post")&"""")
'	configStr=templateobj.regExpReplace(configStr,"Const votetype=""(\S*?)""","Const votetype="""&getForm("votetype","post")&"""")
'	
'
'	createTextFile configStr,configPath,"utf-8"
'	set templateobj=nothing
	
	dim sqlstr
	votetitle=filterPara(getForm("votetitle","post"))
	votename=filterPara(getForm("votename","post"))
	votenum=filterPara(getForm("votenum","post"))
	votetype=filterPara(getForm("votetype","post"))
	
	conn.exec "delete from Aspcms_vote","exe"
	
	sqlstr = "insert into Aspcms_vote(votetitle,votename,votenum,votetype) values('"&votetitle&"','"&votename&"','"&votenum&"','"&votetype&"')"
	
	conn.exec sqlstr,"exe"
	
	
	alertMsgAndGo "设置成功",getPageName()
End Sub

%>