<!--#include file="AspCms_LanguageFun.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE></TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK href="../../images/style.css" type=text/css rel=stylesheet>
</HEAD>
<BODY>
<FORM name="form" action="?action=add" method="post" >
<DIV class=formzone>
<DIV class=namezone>添加其它语言</DIV>
<DIV class=tablezone>
<DIV class=noticediv id=notice></DIV>
<TABLE cellSpacing=0 cellPadding=2 width="100%" align=center border=0>
  <TBODY>
  <TR>						
    <TD align=middle width=100 height=30>语言名称</TD>
    <TD><INPUT class="input" style="WIDTH: 150px" maxLength="200" name="LanguageName"/> <FONT color=#ff0000>*</FONT> 如：英文</TD>
  </TR>
  <TR>
    <TD align=middle width=100 height=30>别名</TD>
    <TD> <INPUT class="input" style="WIDTH: 150px" maxLength="200" name="Alias"/> <FONT color=#ff0000>*</FONT>如：en
</TD>
</TR>
  <TR>
    <TD align=middle width=100 height=30>网站目录</TD>
    <TD><INPUT class="input" style="WIDTH: 150px" maxLength="200" value="/" name="LanguagePath"/> <FONT color=#ff0000>*</FONT></TD></TR>
  <TR>
    <TD align=middle width=100 height=30>模板目录</TD>
    <TD><input class="input" style="WIDTH: 150px" size="200" name="defaultTemplate"/> <FONT color=#ff0000>*</FONT>如：en2016 
    </TD></TR>
  <TR>
    <TD align=middle width=100 height=30>排序</TD>
    <TD><input class="input" size="11"  value="9" name="LanguageOrder"/> </TD></TR>
  <TR>
    <TD align=middle height=30>是否为默认语言</TD>
    <TD> <INPUT class="checkbox" type="checkbox" name="IsDefault" value="1"/>  
    </TD>
    </TR>
  <TR>
    <TD align=middle height=30>是否启用</TD>
    <TD> <INPUT class="checkbox" type="checkbox" checked="checked" name="LanguageStatus" value="1"/>  
    </TD>
    </TR>
  <TR>
    <TD align=middle height=30>html模板路径</TD>
    <TD><INPUT class="input" style="WIDTH: 150px" maxLength="200" value="html" name="htmlFilePath"/> <FONT color=#ff0000>*</FONT>修改可防模板下载
    </TD>
    </TR>
    
    </TBODY></TABLE>
</DIV>
<DIV class=adminsubmit>
<INPUT class="button" type="submit" value="添加" />
<INPUT class="button" type="button" value="返回" onClick="history.go(-1)"/> 
</DIV></DIV></FORM>

</BODY></HTML>