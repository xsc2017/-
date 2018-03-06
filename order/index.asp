<!--#include file="../inc/AspCms_SettingClass.asp" -->
<%
'echo "进入cart"
'echo getForm("proid","both")
'Session.Abandon()
dim action:action=getForm("act","both")
dim proid:proid=getForm("id","both")
 session.timeout=400

'Set Session("Cart") = Nothing
'Set Session("Cart.Price") = Nothing
if action="select"  then
echo escape(CartList)
elseif action="top"  then
echo CartList

elseif action="add" or action="buy" then
Add2Session
else 
Cart_Load
end if

'加入购物车
Sub Add2Session
Dim dicCount,dicPrice,pids,counts,price,color,height,pid,dcount,ok,i
pids = split(unescape(filterPara(getForm("proid","post"))),",")
counts = split(filterPara(getForm("count","post")),",")
price = split(filterPara(getForm("price","post")),",")

ok=0
If IsEmpty(Session("Cart")) or action="buy" Then
	Set dicCount = Server.CreateObject("Scripting.Dictionary")
	Set dicPrice = Server.CreateObject("Scripting.Dictionary")
Else
	Set dicCount = Session("Cart")
	Set dicPrice = Session("Cart.Price")
End If
for i=0 to ubound(pids)

	pid=pids(i)
	dcount=counts(i)
		if dicCount.Exists(pid) then
			dicCount(pid) = Cint(dcount) + Cint(dicCount(pid))
			dicPrice(pid) = price
		else
			dicCount.add pid,dcount
			dicPrice.add pid,price
		end if
next
Set Session("Cart") = dicCount
Set Session("Cart.Price") = dicPrice
End Sub
'所有保存
Sub All2Cart
Dim dicCount,dicPrice,pid,count,price,i,keysPrice,keysCount
'pid = getForm("proid","post")
'count = getForm("count","post")
'price = getForm("price","post")
if pid="" then exit sub
If IsEmpty(Session("Cart")) Then
	Set dicCount = Server.CreateObject("Scripting.Dictionary")
	Set dicPrice = Server.CreateObject("Scripting.Dictionary")
Else
	Set dicCount = Session("Cart")
	Set dicPrice = Session("Cart.Price")
End If
keysPrice = dicPrice.keys
keysCount = dicCount.keys
for i=0 to dicCount.Count-1
	if dicCount.Exists(keysCount(i)) then
		echo getForm("count"&keysCount(i),"post")
		dicCount(keysCount(i)) = getForm("count"&keysCount(i),"post")
		echo getForm("proprice"&keysPrice(i),"post")
		dicPrice(keysPrice(i)) = getForm("proprice"&keysPrice(i),"post")
	else
		dicCount.add keysCount(i),getForm("count"&keysCount(i),"post")
		dicPrice.add keysPrice(i),getForm("proprice"&keysPrice(i),"post")
	end if
next

Set Session("Cart") = dicCount
Set Session("Cart.Price") = dicPrice
End Sub




'从购物车删除
Sub DeleteFromSession(proid)
Dim dicCount,dicPrice
	If Not IsEmpty(Session("Cart")) Then
		Set dicCount = Session("Cart")
		Set dicPrice = Session("Cart.Price")
		If dicCount.exists(proid) Then dic.remove(proid)
		If dicPrice.exists(proid) Then dic.remove(proid)
	End If	
	Set Session("Cart") = dicCount
	Set Session("Cart.Price") = dicPrice
	Response.Redirect Request.ServerVariables("HTTP_REFERER")
End Sub



'显示购物车
Function CartList
Dim dic,md
Dim rs,sql
Dim result,total,tcount,pcount


result="<div class='layout screen' id='active-cart'>"&vbcrlf&_
"<div class='mod mod-cart'>"&vbcrlf&_
"<div class='content'>"&vbcrlf&_
"<table cellspacing='0' cellpadding='0'> "&vbcrlf&_
"<colgroup>"&vbcrlf&_
"<col class='col-detail'>"&vbcrlf&_
"<col class='col-price-desc'>"&vbcrlf&_
"<col class='col-amount'>"&vbcrlf&_
"<col class='col-promo'> "&vbcrlf&_
"<col class='col-price-total'> "&vbcrlf&_
"<col class='col-panel'> "&vbcrlf&_
"</colgroup><tbody>"&vbcrlf

tcount = 0
pcount=0

If Not IsEmpty(Session("Cart")) Then
	Set dic = Session("Cart")
	For Each md In dic

		dim proid : proid=md
		sql = "select P_Price,IndexImage,title,contentid from {prefix}Content where contentid=" & proid
		Set rs = GetRS(sql)
if rs.eof or rs.bof then
result = result &"<tr class='cart'><td class='td-detail'>"
result = result &"ERROE"
result = result &"</td><td>"
result = result &"该产品已被删除或未通过审核"
result = result &"</td></tr> "&vbcrlf
else
		dim img
		if rs("IndexImage") = "" then
		img="../Images/nopic.gif"
		else
		img=rs("IndexImage")
		end if
		
result = result & "<tr class='cart'><td class='td-detail'><dl class='cell-thumbnail'>"&vbcrlf&_
"<dt><a class='a-img' href='../content/?"&rs("contentid")&".html' target='_blank' ><img src='"&img&"' /></a> </dt> "&vbcrlf
result = result & "<dd class='offer-title'> <a href='../content/?"&rs("contentid")&".html' target='_blank' >"&rs("title")&"</a> </dd>"&vbcrlf&_
"<dd class='offer-sku'> <span class='sku-item '> 自定义参数：</span> <span class='sku-item sku-item-last'> </span> </dd></dl></td> "&vbcrlf
result = result &"<td><div class='price-desc'> <span>  <em id='price"&md&"'>"&rs("P_Price")&"</em> </span><input type='hidden' name='price"&md&"' value='"&rs("P_Price")&"'> </div></td>"&vbcrlf&_
"<td class='td-amount'><div class='fd-locate'> "&vbcrlf&_
"<div class='amount unit-finecontrol'> <a class='minus' href='#' data='count"&md&"' md='"&md&"'>-</a>"&vbcrlf&_
"<input class='input' type='text' id='count"&md&"' name='count"&md&"' onkeyup=""this.value=this.value.replace(/\D/g,'');changePrice(this,'"&md&"')"" onafterpaste=""this.value=this.value.replace(/\D/g,'')"" onblur=""if(value==''){value='1';changePrice(this,'"&md&"')}"" autocomplete='off' value='"&dic(md)&"' /> "&vbcrlf&_
"<a class='plus' href='#' data='count"&md&"' md='"&md&"'>+</a> </div></div></td> "&vbcrlf&_
"<td><div class='promo'> <span class='promo-badge'>--</span> </div></td>"&vbcrlf&_
"<td><div class='price-total'> <em class='value' id='curtotal"&md&"'> "&dic(md) * rs("P_Price")&" </em> </div></td> "&vbcrlf&_
"<td class='td-panel'><div class='panel'> <a title='删除' class='delete' href='javascript:void(0)' onclick='deleteItem("""&md&""",this)'>删除</a> </div></td></tr> "&vbcrlf

total = total + (dic(md) * rs("P_Price"))
tcount = tcount + dic(md)
pcount = pcount + 1
rs.close:set rs = nothing

end if
	Next


End If

result="<form name='frmCart' action='?action=all2cart'>"&vbcrlf& _
"<div class='layout screen'>"&vbcrlf& _
"<div class='mod mod-status'>"&vbcrlf&_
"<div class='content fd-locate'>"&vbcrlf&_
"<p class='fd-left'>购物车状态(<em>"&pcount&"</em>/100)</p>"&vbcrlf&_
"<div class='fd-right panel'><a class='continue' href='../list/?2_1.html' target='_blank'>继续购买</a></div>"&vbcrlf&_
"</div></div></div>"&vbcrlf&_
"<div class='layout screen'>"&vbcrlf&_
"<div class='mod mod-thead'>"&vbcrlf&_
"<div class='content'>"&vbcrlf&_
"<ul class='list'>"&vbcrlf&_
"<li class='col-name'>货品</li>"&vbcrlf&_
"<li class='col-price-desc'>单价(元)</li>"&vbcrlf&_
"<li class='col-amount'>数量</li>"&vbcrlf&_
"<li class='col-promo'>优惠</li>"&vbcrlf&_
"<li class='col-price-total'>金额(元)</li>"&vbcrlf&_
"</ul></div></div></div>"&vbcrlf&_
result

result=result&"</tbody></table></div>"&vbcrlf&_
"<div class='footer'><div class='container'>"&vbcrlf&_
"<span class='total-amount' >数量总计：<em id='allcount'>"&tcount&"</em>件</span> <span class='total-price'>货品金额总计(不包含运费)：<em id='alltotal'>"&total&"</em>元</span>"&vbcrlf&_
"<a class='button-submit button button-important button-large' href='checkout.asp' >确认下单</a></div>"&vbcrlf&_
"</div></div>"&vbcrlf
if action="select" then
	CartList = "购物车共"&pcount&"种货品,数量总计：<em id='allcount'>"&tcount&"</em>件,<span>合计：<b>"&total&"</b>元</span>"
elseif action="top" then	
	CartList="document.write("""&pcount&""");"
else
	CartList = result
end if
End Function


Function GetRS(sql)

On Error Resume Next
Set GetRS = conn.exec(sql,"r1")
If Err Then
	'echo sql
	'die err.description
	die "错误，表结构不是最新版本"
End If
End Function


Sub TestA
	Dim dic,md
	Set dic = Session("Cart")

	for each md in dic
		echo md & dic(md) & "<hr>"  
	next

	die "结束"	
End Sub

Sub Cart_Load	
	'dim id, sortID,SortAndID
	'SortAndID=split(replaceStr(request.QueryString,FileExt,""),"_")
	'if isNul(replaceStr(request.QueryString,FileExt,"")) then  echoMsgAndGo "页面不存在",3 
	'Session("Cart_QS") = Request.QueryString
	'SortID = SortAndID(0)
	'if not isNul(SortID) and isNum(SortID) then SortID=clng(SortID) else echoMsgAndGo "页面不存在",3 end if
	'id=SortAndID(1)
	'if not isNul(id) and isNum(id) then id=clng(id) else echoMsgAndGo "页面不存在",3 end if
	
	'if isnul(id) or not isnum(id) then alertMsgAndGo "请选择产品！","-1" 
	'if isnul(sortID) or not isnum(sortID) then alertMsgAndGo "请选择产品！","-1" 
	
	dim templateobj,channelTemplatePath : set templateobj = new TemplateClass	
	dim typeIds,rsObj,rsObjtid,Tid,rsObjSmalltype,rsObjBigtype
	Dim templatePath,tempStr
	templatePath=sitePath&"/"&"templates/"&setting.defaultTemplate&"/"&setting.htmlFilePath&"/productcart.html"
	if not CheckTemplateFile(templatePath) then echo "productcart.html"&err_16
	
	'set rsobj=conn.exec("select * from {prefix}Sort where SortID="&sortID, "exe")							
	'if rsObj.eof then 
	'echoMsgAndGo "页面不存在",3		
	'end if
	with templateObj 
		.content=loadFile(templatePath)	
		.parseHtml()
		'templateObj.content=replace(templateObj.content,"{aspcms:sortname}",rsObj("SortName"))
		'templateObj.content=replace(templateObj.content,"{aspcms:parentsortid}",rsObj("parentid"))		
		'templateObj.content=replace(templateObj.content,"{aspcms:sortid}",sortID)	
		'templateObj.content=replace(templateObj.content,"{aspcms:topsortid}",rsObj("topsortid"))
		templateObj.content=replace(templateObj.content,"{aspcms:topsortid}",-1)
		'if isnul(rsObj("PageKeywords")) then 
			templateObj.content=replace(templateObj.content,"{aspcms:sortkeyword}",setting.siteKeyWords)	
		'else
		'	templateObj.content=replace(templateObj.content,"{aspcms:sortkeyword}",rsObj("PageKeywords"))	
		'end if
		'if isnul(rsObj("PageDesc")) then
			templateObj.content=replace(templateObj.content,"{aspcms:sortdesc}",setting.sitedesc)
		'else
		'	templateObj.content=replace(templateObj.content,"{aspcms:sortdesc}",rsObj("PageDesc"))
		'end if
		'if isnul(rsObj("PageTitle")) then 
		'	templateObj.content=replace(templateObj.content,"{aspcms:sorttitle}",rsObj("SortName"))	
		'else
		'	templateObj.content=replace(templateObj.content,"{aspcms:sorttitle}",rsObj("PageTitle"))
		'end if
		'templateObj.parsePosition(sortID)
		
	'dim selectproduct	
	'set rsObj=conn.Exec("select title from {prefix}Content where ContentID="&id,"r1")
	'selectproduct=rsObj(0)
	
	'rsObj.close()		
		.content=replaceStr(.content,"{aspcms:cartlist}",CartList)
		.parseCommon() 
		echo .content 
	end with
	set templateobj =nothing : terminateAllObjects
End Sub

%>
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         