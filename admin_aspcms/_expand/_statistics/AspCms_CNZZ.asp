<!--#include file="../../inc/AspCms_SettingClass.asp" -->
<%
CheckAdmin("AspCms_CNZZ.asp")
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<LINK href="../images/style.css" type=text/css rel=stylesheet>
</head>
<%
	if isnul(CNZZUSER) then
	dim hostname:hostname=Request.ServerVariables("SERVER_NAME")
	dim zkey:zkey=md5(hostname&"Gk8MKsRs",32)
%>
<script type="text/javascript" src="../../../js/jquery.js"></script>
<div class="">
	<p>您还没有开通CNZZ接口<a href="http://wss.cnzz.com/user/companion/aspcms.php?domain=<%=hostname%>&key=<%=zkey%>" id="sendCnzz" target="_blank">点击申请</a></p>
    <div>
    <span style="color:#CD0000">将获取的值，复制到“<a href='../../_system/AspCms_SiteSetting.asp#cnzz'>网站参数设置</a>”里的CNZZ设置栏，进行提交即可</span>
    </div>
</div>
<%
else
dim cnzzarr:cnzzarr=split(CNZZUSER,"@")
%>
<IFRAME name="cnzz1" src="http://wss.cnzz.com/user/companion/aspcms_login.php?site_id=<%=cnzzarr(0)%>&password=<%=cnzzarr(1)%>" frameBorder=0 width="100%" height="600" noresize></IFRAME>
<%end if%>
</HTML>