<!--#include file="../inc/AspCms_SettingClass.asp" -->
<%
dim action : action=getForm("action","get")
if action="add" then addGbook

dim FaqID,FaqTitle,Contact,ContactWay,Content,Reply,AddTime,ReplyTime,FaqStatus,AuditStatus,tab,sql
Sub addGbook
	'if session("faq") then alertMsgAndGo "请不要重复提交","-1"
	txt=encodeHtml(filterPara(getForm("txt","post")))
	addtime=formatDate(now(),4)
	if messageReminded then 
		dim n,mails:mails=split(messageAlertsEmail,",")
		for n=0 to ubound(mails)
			sendMail mails(n),setting.sitetitle,setting.siteTitle&setting.siteUrl&"--留言信息提醒邮件！","您的网站<a href=""http://"&setting.siteUrl&""">"&setting.siteTitle&"</a>有新的微博分享！<br>"&"<br>内容："&txt&"<br>联系人："&Contact&"<br>时间："&AddTime	
		next
	end if
	if SwitchCommentsStatus=0 then
		alertMsgAndGo "留言成功！",getRefer	
	else	
		alertMsgAndGo "留言成功，请等待审核中！",getRefer	
	end if
End Sub

%>