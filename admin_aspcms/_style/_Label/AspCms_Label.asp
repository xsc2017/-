<!--#include file="AspCms_LabelFun.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE></TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK href="../../images/style.css" type=text/css rel=stylesheet>
</HEAD>
<SCRIPT>
function SelAll(theForm){
		for ( i = 0 ; i < theForm.elements.length ; i ++ )
		{
			if ( theForm.elements[i].type == "checkbox" && theForm.elements[i].name != "SELALL" )
			{
				theForm.elements[i].checked = ! theForm.elements[i].checked ;
			}
		}
}
</SCRIPT>
<BODY>
<DIV class=searchzone>
<TABLE height=30 cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD height=30>&nbsp;</TD>
    <TD align=right colSpan=2><INPUT onClick="location.href='AspCms_LabelAdd.asp'" type="button" value="添加自定义标签" class="button" > <INPUT onClick="location.href='<%=getPageName()%>'" type="button" value="刷新" class="button" /> 
</TD></TR></TBODY></TABLE></DIV>
<FORM name="" action="" method="post">
<DIV class=listzone>
<TABLE cellSpacing=0 cellPadding=3 width="100%" align=center border=0>
  <TBODY>
  <TR class=list>
    <TD width=47 align="center" class=biaoti>选择</TD>
    <TD width=46 align="center" class=biaoti>编号</TD> 	 	
    <TD width="227" height=28 align="center" class=biaoti><span class="searchzone">标签名称</span></TD>
    <TD width="227" height=28 align="center" class=biaoti><span class="searchzone">调用代码</span></TD>
    <TD width=97 align="center" class=biaoti><span class="searchzone">描述</span></TD>
    <TD width=185 align="center" class=biaoti><span class="searchzone">操作</span></TD>
    </TR>
	<%LabelList%>
    </TBODY></TABLE>
</DIV>

<DIV class=piliang><div class="left" style="float:left;"><INPUT onClick="SelAll(this.form)" type="checkbox" value="1" name="SELALL"> 全选&nbsp;
<INPUT class="button" type="submit" value="删除" onClick="if(confirm('确定要删除吗')){form.action='?action=del';}else{return false};"/> </div>
<div style="clear:both; height:0px; line-height:0px;"></div>
</DIV>
</FORM>
</BODY></HTML>
