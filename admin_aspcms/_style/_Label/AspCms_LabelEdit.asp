<!--#include file="AspCms_LabelFun.asp" -->
<%getLabel%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE></TITLE>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK href="../../images/style.css" type=text/css rel=stylesheet>
<script type="text/javascript" CharSet = "utf-8" src="../../ueditor/ueditor.config.js"></script>
<script type="text/javascript" CharSet = "utf-8" src="../../ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" CharSet = "utf-8" src="../../ueditor/lang/zh-cn/zh-cn.js"></script>
</HEAD>
<BODY>
<FORM name="form" action="?action=edit" method="post" >
<DIV class=formzone>
<DIV class=namezone>编辑自定义标签</DIV>
<DIV class=tablezone>
<DIV class=noticediv id=notice></DIV>
<TABLE cellSpacing=0 cellPadding=2 width="100%" align=center border=0>
  <TBODY>
  <TR>						
    <TD align=middle width=100 height=30>标签名称</TD>
    <TD><INPUT class="input" style="WIDTH: 200px" maxLength="200" name="LabelName" value="<%=LabelName%>"/> <FONT color=#ff0000>*</FONT> </TD>
  </TR>
  <TR>
    <TD align=middle width=100 height=30>描述</TD>
    <TD><input class="input" maxlength="100" style="WIDTH: 360px" name="LabelDesc" value="<%=LabelDesc%>"/> </TD></TR>
  <TR >
    <TD align="middle" height="30">
       	内容<BR><BR></TD>
    <TD>
<div style="width:80%"><textarea name="Content" class="Content" id="Content" style="width:365px;"><%=decodeHtml(Content)%></textarea> </div>
    </TD>
  </TR>
    <tr>
    <TD align=middle height=30 valign="top">上传图片</td>
      <td colspan="3"><iframe name="image" frameborder="0" width='100%' height="40" scrolling="no" src="../../editor/upload.asp?sortType=10&stype=file&Tobj=Content" allowTransparency="true"></iframe></td>
    </tr>
  <TR>
  
    </TBODY></TABLE>
</DIV>
<DIV class=adminsubmit>
<INPUT type="hidden" name="LabelID" value="<%=LabelID%>"/>
<INPUT class="button" type="submit" value="修改" />
<INPUT class="button" type="button" value="返回" onClick="history.go(-1)"/> 
<INPUT onClick="location.href='<%=getPageName()&"?id="&LabelID%>'" type="button" value="刷新" class="button" /> 
</DIV></DIV></FORM>

</BODY></HTML>