<!--#include file="AspCms_UpdateFun.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE>在线升级</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8"><LINK 
href="../../images/style.css" type=text/css rel=stylesheet>
<META content="MSHTML 6.00.3790.4807" name=GENERATOR>
<script language="javascript" type="text/javascript" src="../js/getdate/WdatePicker.js"></script>
<style type="text/css">
<!--
.STYLEnote {color: #FF0000}
-->
</style>
</head>
<body>
<FORM id= name= action="" method=post >
<DIV class=formzone>
<DIV class=namezone>在线升级</DIV>
<DIV class=tablezone>
<DIV class=noticediv id=notice></DIV>
<TABLE cellSpacing=0 cellPadding=2 width="100%" align=center border=0>
  <TBODY>
  <TR>						
    <TD align=center width=109 height=30>当前版本</TD>
    <TD width="778"><%=vnum%></TD>
  </TR>

  <TR>
    <TD align=center width=109 height=30>最新版本</TD>    
    <TD><%=newver%></TD>
 </tr>
   <TR>
    <TD height=30 colspan="2" align=left><span class="STYLEnote">*重要说明：</span>
    <ol>
     <li>在2.0.x版本中升级必须从低到高逐一升级</li>
    <li>每次升级最好先备份网站,确保万无一失</li>    
    <li>由于用户运行环境不同，权限不同等问题导致的系统不能正常更新，请到论坛去下载 <a href="http://www.asp4cms.com/aspcms-2441-1-1.html" target="_blank">完整包</a> 或者 <a href="http://www.asp4cms.com/aspcms-2441-1-1.html" target="_blank">补丁包</a></li>
    <li class="STYLEnote"><strong>在线更新功能目前并未完善，如果您当前版本正常稳定，建议不要使用在线升级功能，谢谢您的支持！</strong></li>
    </ol>
    </TD>
    </tr>
    </TBODY></TABLE>
<br>
<%=outmes%>
</DIV>
</DIV>
</FORM>
</body>
</html>
