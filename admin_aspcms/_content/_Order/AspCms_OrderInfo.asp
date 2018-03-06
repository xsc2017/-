<!--#include file="AspCms_OrderFun.asp" -->
<!doctype html public "-//w3c//dtd html 4.01 transitional//en" "http://www.w3c.org/tr/1999/rec-html401-19991224/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv=content-type content="text/html; charset=utf-8">
<title><%=setting.companyName%> 发货单</title>
<style type="text/css">
.oc{min-width:583px;border:#cccccc 1px solid;}
.oc_thead{background:url(/templates/cn/images/ocTHead.gif); height:26px; line-height:26px}
.oc_thead div{background:url(/templates/cn/images/bg.png) no-repeat left -43px;height:26px; width:120px; text-align:center; color:white; font-weight:bold;float:left}
.oc_content{ border:0px; margin:0px; padding:5px; }
.oc_content_b{border-bottom:#cccccc 1px solid;}
.oc_content_h{border-top:#cccccc 1px solid;}
fieldset p{ text-align:left; margin:0px; padding:3px;}
img{border:0px}


.bank{ list-style:none}
.banklogo{ border:0px;}
</style>
<style media=print type="text/css">   
.noprint{visibility:hidden}   
</style>   
<%
Dim m_orderno,sql,rs

m_orderno = getForm("OrderNo","both")

sql = "select {prefix}Order2.*,(select sum(count) from {prefix}OrderProduct where {prefix}OrderProduct.orderno={prefix}Order2.orderno) as pcount,(select sum(InstantPrice*[Count]) from {prefix}OrderProduct where {prefix}OrderProduct.orderno={prefix}Order2.orderno) as pprice from {prefix}Order2 where orderno = '"&m_orderno&"'"
Set rs = Conn.exec(sql,"r1")

if rs.eof or rs.bof then 
	die "未找到订单号" & m_orderno
end if

%>

<style>
*{margin:0;padding:0;
list-style:none;}
body{font-family:"微软雅黑","黑体";font-size:12pt;width:25cm;margin:10pt;}
h1{width:100%;display:block;text-align:center; margin:0;padding: 10pt 0 5pt 0;}
.dbl{border-bottom:3px double #000}
.clear{clear:both;}
.info{width:100%; display:block;line-height:25pt;}
.info li{display:block; float:left;}
.lh50{line-height:60px;height:60px;}
.m5{margin:5pt;}
.p0{width:100%}.p05{width:5%}
.p1{width:10%}.p15{width:15%}
.p2{width:20%}.p25{width:25%}
.p3{width:30%}.p35{width:35%}
.p4{width:40%}.p45{width:45%}
.p5{width:50%}.p55{width:55%}
.p6{width:60%}.p65{width:65%}
.p7{width:70%}.p75{width:75%}
.p8{width:80%}.p85{width:85%}
.p9{width:90%}.p95{width:95%}
div.info{border-top:2px solid #000;border-left:1px solid #333;}
.list{border-bottom:2px solid #000;padding-right:1px;}
.list li{border-right:1px solid #333;margin-right:-1px;}
.ct{text-align:center;}
textarea,input{border:none;width:90%;padding:5pt;}

</style>
</head>
<body>

<h1 class="dbl">发货单</h1>
<ul class="info m5">
    <li class="p5">收货人姓名(电话)：<b><%=rs("nicename")%>(<%=rs("mobile")%> <%=rs("phone")%>)</b></li>
    <li class="p25">下单日期：<b><%=rs("OrderTime")%></b></li>
    <li class="p25">订单号：<b><%=m_orderno%></b></li>
    <li class="p75">收货地址：<b><%=rs("province")%>-<%=rs("city")%>-<%=rs("area")%>-<%=rs("address")%></b></li>
    <li class="p25">买家ID：<b><%=rs("UserName")%></b></li>
	<div class="clear"></div>
</ul>
<div class="info">
<ul class="list ct">
    <li class="p05"><b>序列</b></li>
    <li class="p25"><b>图片</b></li>
    <li class="p45"><b>品名</b></li>
    <li class="p1"> <b>单价</b></li>
    <li class="p05"><b>数量</b></li>
    <li class="p1"> <b>合计</b></li>
	<div class="clear"></div>
</ul>
<%

Dim prs,i,allnum
i=1
allnum=0
sql = "select op.count,op.InstantPrice,op.productid,a.title,a.IndexImage from AspCms_OrderProduct as op, AspCms_content as a where contentid=op.productid and orderno='"&m_orderno&"'"
set prs = conn.exec(sql,"r1")
while not prs.eof
%>
<ul class="list lh50">
    <li class="p05 ct"><%=i%></li>
    <li class="p25 ct"><img src='<%=prs("IndexImage")%>' width='70' height='60' /></li>
    <li class="p45"><%=prs("title")%></li>
    <li class="p1 ct"><%=prs("InstantPrice")%></li>
    <li class="p05 ct"><%=prs("count")%></li>
    <li class="p1 ct"><%=prs("count")*prs("InstantPrice")%></li>
	<div class="clear"></div>
</ul>
<%  
allnum=allnum+prs("count")
i=i+1
prs.movenext
wend
prs.close
set prs = nothing
%>
<ul class="list lh50">
    <li class="p05 ct"><b>合计</b></li>
    <li class="p8">&nbsp;</li>
	<li class="p05 ct"><b><%=allnum%></b></li>
    <li class="p1 ct"><b><%=rs("pprice")%></b></li>
   
	<div class="clear"></div>
</ul>

<div class="clear"></div>

</div>
<ul class="info m5 dbl" style="padding-bottom:5px;">
    <li class="p1">买家留言：</li>
    <li class="p5">&nbsp;<b><%=rs("note")%></b></li>
	
    <li class="p4">电子邮箱：<%=rs("email")%></li>
	<div class="clear"></div>
   <li class="p1 ">备注：</li><li class="p5"><textarea class="input input-large input-address" name="address">点此输入备注信息</textarea></li>
       <!--li class="p4">支付方式：<%=rs("payment")%></li-->
   
   
	<div class="clear"></div>
	
</ul>

<ul class="info m5">
    <li class="p05"><b>制单</b></li>
	<li class="p2"><input value="<%=setting.companyName%>"/></li>
	<li class="p05"><b>电话</b></li>
	<li class="p2"><input value="<%=setting.companyPhone%>"/></li>
   	<li class="p05"><b>发货</b></li>
	<li class="p2"><input value="<%=formatDate(now(),4)%>"/></li>
    <li class="p05"><b>审核</b></li>
	<li class="p2"><input value=""/></li>
	<div class="clear"></div>
</ul>

<a class="noprint" href="Aspcms_OrderFun.asp?action=print&orderno=<%=m_orderno%>&s=1" target="p" onclick="window.print()">打印</a>


<iframe id="p" name="p" style="display:none;"></iframe>







</body>
</html><%rs.close:set rs = nothing%>