<!--#include file="AspCms_ApplyFun.asp" -->
<%
getContent
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE></TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK href="../../images/style.css" type=text/css rel=stylesheet>
</HEAD>
<BODY>
<FORM name="form" action="?action=edit" method="post" >
<DIV class=formzone>
<DIV class=namezone>查看应聘信息</DIV>
<DIV class=tablezone>
<DIV class=noticediv id=notice></DIV>
<TABLE cellSpacing=0 cellPadding=2 width="100%" align=center border=0>
<TBODY>
<TR>						
<TD align=middle width=100 height=30>应聘职位</TD>
<TD><INPUT class="input" style="WIDTH: 200px" maxLength="200" name="Jobs" value="<%=Jobs%>"/> <FONT color=#ff0000>*</FONT> </TD>
</TR>
<TR>
    <TD align=middle width=100 height=30>姓名</TD>    
    <TD><input name="Linkman" class="input"  type="text" style="width:150px;" value="<%=Linkman%>" /></TD>
</TR>
<TR>
    <TD align=middle width=100 height=30>年龄</TD>    
    <TD><input name="Age" class="input"  type="text" style="width:60px;" value="<%=Age%>" /></TD>
</TR>
<TR>
    <TD align=middle width=100 height=30>性别</TD>    
    <TD><input type="radio"  value="1" name="Gender" <% if Gender=1 then echo "checked" end if%>/>男
            <input type="radio" value="0" name="Gender" <% if Gender=0 then echo "checked" end if%>/>女</TD>
</TR>
<TR>
    <TD align=middle width=100 height=30>婚姻状况</TD>    
    <TD><input name="Marriage" class="input"  type="text" style="width:160px;" value="<%=Marriage%>" /></TD>
</TR>
<TR>
    <TD align=middle width=100 height=30>户 籍</TD>    
    <TD><input name="Education" class="input"  type="text" style="width:160px;" value="<%=Education%>" /></TD>
</TR>
<TR>
    <TD align=middle width=100 height=30>最高学历</TD>
    <TD><input class="input" name="RegResidence" type="text" value="<%=RegResidence%>" /></TD>
</TR>
<TR>
    <TD align=middle width=100 height=30>教育经历</TD>
    <TD><textarea class="textarea" name="EduResume" cols="40" rows="6" style="width:500px"><%=EduResume%></textarea></TD>
</TR>
<TR>
    <TD align=middle width=100 height=30>工作经历</TD>
    <TD><textarea class="textarea" name="JobResume" cols="40" rows="6" style="width:500px"><%=JobResume%></textarea></TD>
</TR>

<TR>
    <TD align=middle width=100 height=30>联系电话</TD>
    <TD><input class="input" name="phone" type="text" value="<%=phone%>" /></TD>
</TR>
<TR>
    <TD align=middle width=100 height=30>手机</TD>
    <TD><input class="input" name="Mobile" type="text" value="<%=Mobile%>" /></TD>
</TR>
<TR>
    <TD align=middle width=100 height=30>邮箱</TD>
    <TD><input class="input" name="Email" type="text" value="<%=Email%>" /></TD>
</TR>
<TR>
    <TD align=middle width=100 height=30>QQ</TD>
    <TD><input class="input" name="QQ" type="text" value="<%=QQ%>" /></TD>
</TR>
<TR>
    <TD align=middle width=100 height=30>地址</TD>
    <TD><input class="input" name="Address" type="text" style="width:300px" value="<%=Address%>" /></TD>
</TR>
<TR>
    <TD align=middle width=100 height=30>邮政编码</TD>
    <TD> <input class="input" name="PostCode" type="text" value="<%=PostCode%>" /></TD>
</TR>

<TR>
    <TD align=middle width=100 height=30>查看状态</TD>
    <TD><input class="input" type="checkbox"  value="1" name="ApplyStatus" <% if ApplyStatus then echo"checked=""checked"""%>/></TD>
</TR>
  
</TBODY>
</TABLE>
</DIV>
<DIV class=adminsubmit>
<input type="hidden"  name="ApplyID" value="<%=ApplyID%>"/>
<INPUT class="button" type="submit" value="已阅" />
<INPUT class="button" type="button" value="返回" onClick="history.go(-1)"/> 
</DIV></DIV></FORM>

</BODY></HTML>    