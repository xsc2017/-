<!--#include file="../../inc/AspCms_SettingClass.asp" -->
<%
CheckAdmin("AspCms_Statistics.asp")
dim action : action=getForm("action","get")

if action="clear" then clearStatistics

Sub clearStatistics
	conn.Exec"delete from {prefix}Visits","exe"	
	response.Redirect("?")
End Sub
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE></TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK href="../../images/style.css" type=text/css rel=stylesheet>
</HEAD>
<BODY>
<FORM name="form" action="?action=clear" method="post" >
<DIV class=formzone>
<DIV class=namezone>访问统计</DIV>
<DIV class=tablezone>
<DIV class=noticediv id=notice></DIV>
<TABLE cellSpacing=0 cellPadding=2 width="100%" align=center border=0>
  <TBODY>
  <TR>						
    <TD align=middle width=100 height=30>今日访问量</TD>
    <TD><INPUT class="input" style="WIDTH: 100px" maxLength="200" value="<%=getTodayVisits%>"/> 标签：{visits:today}</TD>
  </TR>
  <TR>						
    <TD align=middle width=100 height=30>昨日访问量</TD>
    <TD><INPUT class="input" style="WIDTH: 100px" maxLength="200" value="<%=getYesterdayVisits%>"/> 标签：{visits:yesterday}</TD>
  </TR>
  <TR>						
    <TD align=middle width=100 height=30>本月访问量</TD>
    <TD><INPUT class="input" style="WIDTH: 100px" maxLength="200" value="<%=getMonthVisits%>"/> 标签：{visits:month}</TD>
  </TR>
  <TR>						
    <TD align=middle width=100 height=30>总访问量</TD>
    <TD><INPUT class="input" style="WIDTH: 100px" maxLength="200" value="<%=getAllVisits%>"/> 标签：{visits:all}</TD>
  </TR>

  
    </TBODY></TABLE>
</DIV>
<DIV class=adminsubmit>

<input type="submit" class="button" value="全部清零"  onClick="return confirm('确定要清零吗')" class="btn"/>
<INPUT onClick="location.href='<%=getPageName()%>'" type="button" value="刷新" class="button" /> 
</DIV></DIV></FORM>

</BODY></HTML>


