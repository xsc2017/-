<!--#include file="../inc/AspCms_SettingClass.asp" -->
<%
'if session("userID")="" then
'alertMsgAndGo "您还未登陆，请登录！","../member/login.asp"
'end if
dim action,needCheck
action=getForm("act","both")
needCheck = false

Select Case LCase(action)	
	Case "buy"                                        '提交订单
		addOrder()
	Case "comfirm"							'2订单确认
		OrderComfirm()
	Case "complete"												'3成功下单
		OrderComplete()
	Case "echo"					'1填写信息
		echoContent()
	case "directbuy"	'0直接购买
		DirectBuy()
	case "print"                                              				'4打印订单
		OrderPrint()
	Case Else
		echoContent()     
End Select  


Sub OrderComplete		
	dim id, sortID,SortAndID
	dim qs
	'qs = Session("Cart_QS")
	'SortAndID=split(replaceStr(qs,FileExt,""),"_")
	
	'if isNul(replaceStr(qs,FileExt,"")) then  echoMsgAndGo "页面不存在1",3 
	'SortID = SortAndID(0)
	'if not isNul(SortID) and isNum(SortID) then SortID=clng(SortID) else echoMsgAndGo "页面不存在2",3 end if
	'id=SortAndID(1)
	'if not isNul(id) and isNum(id) then id=clng(id) else echoMsgAndGo "页面不存在3",3 end if
	
	'if isnul(id) or not isnum(id) then alertMsgAndGo "请选择产品1！","-1" 
	'if isnul(sortID) or not isnum(sortID) then alertMsgAndGo "请选择产品2！","-1" 
	
	dim templateobj,channelTemplatePath : set templateobj = new TemplateClass	
	dim typeIds,rsObj,rsObjtid,Tid,rsObjSmalltype,rsObjBigtype
	Dim templatePath,tempStr
	templatePath=sitePath&"/"&"templates/"&setting.defaultTemplate&"/"&setting.htmlFilePath&"/productcomfirm.html"
	if not CheckTemplateFile(templatePath) then echo "productcomfirm.html"&err_16
	
	'set rsObj=conn.exec("select * from {prefix}Sort where SortID="&sortID, "exe")							
	'if rsObj.eof then echoMsgAndGo "页面不存在4",3 : exit sub		
	with templateObj 
	
		.content=loadFile(templatePath)	
		.parseHtml()
		.indexpath()
	'templateObj.content=replace(templateObj.content,"{aspcms:sortname}",rsObj("SortName"))
	'templateObj.content=replace(templateObj.content,"{aspcms:parentsortid}",rsObj("parentid"))		
	'templateObj.content=replace(templateObj.content,"{aspcms:sortid}",sortID)	
	'templateObj.content=replace(templateObj.content,"{aspcms:topsortid}",rsObj("topsortid"))
			
			
	templateObj.content=replace(templateObj.content,"{aspcms:sortkeyword}",setting.siteKeyWords)	
	templateObj.content=replace(templateObj.content,"{aspcms:sortdesc}",setting.sitedesc)
	'templateObj.content=replace(templateObj.content,"{aspcms:sorttitle}",rsObj("SortName"))	
	
	'templateObj.parsePosition(sortID)			
	'rsObj.close()
			
dim hidden


'订单参数传递 {aspcms:order.$trigger$}
templateObj.content=replace(templateObj.content,"{aspcms:order.$trigger$}",hidden)

'订单号码：{aspcms:order.no} 
templateObj.content=replace(templateObj.content,"{aspcms:order.no}",Session("Print.Orderno"))
'订单日期：{aspcms:order.date} 
templateObj.content=replace(templateObj.content,"{aspcms:order.date}",Session("Print.OrderDate"))
'用 户 名：{aspcms:order.username} 
templateObj.content=replace(templateObj.content,"{aspcms:order.username}",Session("Print.OrderUserName"))
'订单状态：{aspcms:order.state} 
templateObj.content=replace(templateObj.content,"{aspcms:order.state}","未付款(成功下单)")
'订单总金额：{aspcms:order.total}元 
templateObj.content=replace(templateObj.content,"{aspcms:order.total}",Session("Print.OrderTotal"))
'商品总数量：{aspcms:order.count} 	
templateObj.content=replace(templateObj.content,"{aspcms:order.count}",Session("Print.OrderCount"))
'客户姓名：{aspcms:order.nicename}
templateObj.content=replace(templateObj.content,"{aspcms:order.nicename}",Session("Print.OrderNiceName"))
'联系电话：{aspcms:order.tel}
templateObj.content=replace(templateObj.content,"{aspcms:order.tel}",Session("Print.OrderTel"))
'手机号码：{aspcms:order.cellphone}
templateObj.content=replace(templateObj.content,"{aspcms:order.cellphone}",Session("Print.OrderCellphone"))
'邮政编码：{aspcms:order.zipcode}
templateObj.content=replace(templateObj.content,"{aspcms:order.zipcode}",Session("Print.OrderZipcode"))
'联系地址：{aspcms:order.address}


templateObj.content=replace(templateObj.content,"{aspcms:order.address}",Session("Print.OrderAddress"))
'电子邮箱：{aspcms:order.email}
templateObj.content=replace(templateObj.content,"{aspcms:order.email}",Session("Print.OrderEmail"))
'简单留言：{aspcms:order.note}
templateObj.content=replace(templateObj.content,"{aspcms:order.note}",Session("Print.OrderNote"))
'支付方式
templateObj.content=replace(templateObj.content,"{aspcms:order.payment}",Session("Print.OrderPayMent"))

select case Session("Print.OrderPayMent")
	case "在线支付"
	templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_Online)
	case "银行支付"
	templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_Bank)
	case "邮局付款"
	templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_PostOffice)
end select


'商品列表
templateObj.content=replace(templateObj.content,"{aspcms:selectproduct}",SelectProductList)
 

		.parseCommon() 		
		echo .content 
	end with
	
	set templateobj =nothing : terminateAllObjects
	
End Sub

'=======================================
'直接购买
'=======================================
Sub DirectBuy
Dim dicCount,dicPrice
Dim proid,count,proprice
Session.Contents.Remove("Cart")
Session.Contents.Remove("Cart.")
Session.Contents.Remove("Cart.Price")
End Sub


'=======================================
'订单信息填写
'=======================================
Sub echoContent()
	dim total
	
	dim templateobj,channelTemplatePath : set templateobj = new TemplateClass	
	dim typeIds,rsObj,rsObjtid,Tid,rsObjSmalltype,rsObjBigtype
	Dim templatePath,tempStr
	templatePath=sitePath&"/"&"templates/"&setting.defaultTemplate&"/"&setting.htmlFilePath&"/productcheckout.html"
	if not CheckTemplateFile(templatePath) then echo "productcheckout.html"&err_16
		Session.Contents.Remove("Print.Orderno")
	with templateObj 
		.content=loadFile(templatePath)	
		.parseHtml()
		.indexpath()
		templateObj.content=replace(templateObj.content,"{aspcms:topsortid}",0)
		templateObj.content=replace(templateObj.content,"{aspcms:sortid}",0)

			templateObj.content=replace(templateObj.content,"{aspcms:sortkeyword}",setting.siteKeyWords)	

			templateObj.content=replace(templateObj.content,"{aspcms:sortdesc}",setting.sitedesc)
	Dim m_username,gender
	if session("loginstatus")="" then  session("loginstatus")="0"

	if session("loginstatus")="1" then  
		set rsObj=conn.Exec("select * from {prefix}User where UserID="&trim(session("userID")),"r1")
		m_username = rsObj("loginname")
	else 
		gender=1
	end if
		
		.content=replaceStr(.content,"{aspcms:selectproduct}",SelectProductList)
		randomize 		
		.content=replaceStr(.content,"{aspcms:order.orderno}",Year(Now)&MOnth(Now)&Day(Now)&Int(10000000*   Rnd))
		.content=replaceStr(.content,"{aspcms:order.username}",m_username)
		.content=replaceStr(.content,"{aspcms:order.total}",session("total"))
		.parseCommon() 
		echo .content 
	end with
	set templateobj =nothing : terminateAllObjects
End Sub


'=======================================
'添加订单
'=======================================
Sub addOrder

if needCheck then
if getForm("code","post")<>Session("Code") then alertMsgAndGo "验证码不正确","-1"
end if


dim orderno, username,  m_state, payment, nicename, tel,cellphone, zipcode, address, email, note, m_to, invoice,addtime,province,city,area,pname,post,mobile,phone
dim sql
 
	orderno=filterPara(getForm("orderid","post"))	
	
	username=session("loginName") 'filterPara(getForm("username","post"))	
	m_state=0
	
	pname=filterPara(getForm("pname","post"))	
	province=filterPara(getForm("province","post"))	
	city=filterPara(getForm("city","post"))	
	area=filterPara(getForm("area","post"))
	address=filterPara(getForm("address","post"))	
	
	post=filterPara(getForm("post","post"))
	mobile=filterPara(getForm("mobile","post"))
	phone=filterPara(getForm("phone","post"))	
	'email=filterPara(getForm("email","post"))
	'm_to=filterPara(getForm("to","post"))	
	note=filterPara(getForm("note","post"))	
	'invoice=filterPara(getForm("invoice","post"))
	'payment=filterPara(getForm("payment","post"))
	 
	addtime = now
	if isnul(orderno) then alertMsgAndGo "订单号为空?请重新提交！","-1"	
		if username = "" then username = "游客"
	dim userid        : userid=session("userID")
if session("norefresh") <> orderno then
	if isnul(userid) then 	userid=0
		
	sql = "INSERT INTO {prefix}order2( orderno, username, ordertime, state,nicename, province,city,area,address,zipcode, mobile, phone, [note], userid,Invoice)VALUES('"&orderno&"', '"&username&"','"&formatDate(now(),4)&"', "&m_state&", '"&pname&"', '"&province&"', '"&city&"', '"&area&"', '"&address&"', '"&post&"', '"&mobile&"', '"&phone&"','"&note&"', "&userid&",0)"
	
	Conn.Exec sql,"exe"		
	session("norefresh") = orderno
	Session("Print.OrderNo")=orderno
	Session("Print.OrderNiceName")=pname
	Session("Print.OrderTel")=phone
	Session("Print.OrderCellphone")=mobile
	Session("Print.OrderZipcode")=post
	Session("Print.OrderAddress")=province&city&area&address
	Session("Print.OrderNote")=note
	
	
	dim dic,md,dicPrice,mds,rdic,rmd
	Set dic = Session("Cart")
	Set dicPrice=Session("Cart.Price")
	for each md in dic
		
		'dim prices:prices=0
		 'prices=dicPrice(md)
		 'die prices
		'if isnul(prices) then  prices=0 
		
		'sql = "insert into {prefix}OrderProduct (orderno,productid,[count],instantprice) values ('"&orderno&"',"&md&","&dic(md)&",(select P_Price from content where contentid="&dic(md)&"))"
		
		'sql = "insert into {prefix}OrderProduct (orderno,productid,[count],instantprice) select '"&orderno&"',"&md&","&dic(md)&", P_Price from {prefix}content where contentid="&md
		
        rmd=filterPara(md)
		rdic=filterPara(dic(md))
		
		sql = "insert into {prefix}OrderProduct (orderno,productid,[count],instantprice) select '"&orderno&"',"&rmd&","&rdic&", P_Price from {prefix}content where contentid="&rmd
		
		
		conn.exec sql,"exe"
		'echo sql & "<br>"
		'sql = "update {prefix}content set P_sales=cast(P_sales as int)+"&dic(md)&"where contentid="&md
		
		
		'conn.exec sql,"exe"
		
	next	
	
		if orderReminded then 
			dim n,mails:mails=split(messageAlertsEmail,",")
			for n=0 to ubound(mails)
				sendMail mails(n),setting.sitetitle,setting.siteTitle&setting.siteUrl&"--订单信息提醒邮件！","您的网站<a href=""http://"&setting.siteUrl&""">"&setting.siteTitle&"</a>有新的订单信息！<br>订单编号："&orderno&"<br>会员帐号："&username&"<br>联系人："&nicename&"<br>电话号码："&tel&"<br>手机号码："&cellphone&"<br>电子信箱："&Email&"<br>备注："&note&"<br>申请时间："&addtime
			next
		end if
'else
 'alertMsgAndGo "该订单已经提交，请勿重复提交！ ","-1"

end if
	
	'alertMsgAndGo "产品订购成功！","?act=complete"
	OrderComplete()
	'if Session("Cart_QS") <> "" then Session.Contents.Remove("Cart_QS")
	'Session.Contents.Remove("norefresh")
End Sub



'=======================================
'订单详细列表
'=======================================
Function SelectProductList
Dim dic,md
Dim rs,sql
Dim result,total,tcount,pcount


result="<div class='detail-content' > "&vbcrlf&_
"<table class='offer-list-table' cellSpacing='0' cellPadding='0' >"&vbcrlf&_
"<colgroup><col class='col-name' /><col class='col-price-unit' /><col class='col-amount' /><col class='col-promo' /><col class='col-price-total' /><col class='col-freight' /></colgroup>"&vbcrlf&_
"<thead><tr class='thead'><th>货品</th><th>单价（元）</th><th>数量</th><th>优惠（元）</th><th>金额（元）</th><th>运费（元）</th></tr></thead> "&vbcrlf&_
"<tbody > "

tcount = 0
pcount=0

If Not IsEmpty(Session("Cart")) Then
	Set dic = Session("Cart")
	For Each md In dic

		dim proid : proid=md
		sql = "select P_Price,IndexImage,title,contentid from {prefix}Content where contentid=" & proid
		Set rs = GetRS(sql)
		dim img
		if rs("IndexImage") = "" then
img="../Images/nopic.gif"
else
img=rs("IndexImage")
end if
		
result = result &"<tr class='item' ><td ><dl class='cell-thumbnail' ><dt><a title='"&rs("title")&"' class='a-img' href='#'><img width='64' height='64' alt='"&rs("title")&"' src='"&img&"' /></a> </dt>"&vbcrlf&_
"<dd class='offer-title'><a title='"&rs("title")&"' href='../content/?"&rs("contentid")&".html' target='_blank'>"&rs("title")&"</a> </dd>"&vbcrlf&_
"<dd class='offer-sku'><span class='sku-item '>自定义参数：  </span><span class='sku-item sku-item-last'> </span></dd></dl></td>"&vbcrlf&_
"<td ><div class='price-unit-ct'><span  class='price-unit'>"&rs("P_Price")&"</span></div></td>"&vbcrlf&_
"<td ><div class='amount'>"&dic(md)&"</div></td>"&vbcrlf&_
"<td ><div class='promo' >-- </div></td><td ><div class='price-total'>"&FormatNumber(dic(md) * rs("P_Price"),2,-1)&"</div></td>"
if pcount=0 then
result = result &"<td class='td-freight rowspan' rowSpan='{allnumpro}' ><div class='freight'  >包邮 </div></td></tr>"
end if

total = FormatNumber((total + (dic(md) * rs("P_Price"))),2,-1)
tcount = tcount + dic(md)
pcount = pcount + 1
rs.close:set rs = nothing
	Next
	
End If

result=replace(result,"{allnumpro}",pcount)
Session("Print.Ordertotal")=total

result=result&"</tbody></table></div> "&vbcrlf&_
"<div class='fd-clr shop detail-footer'>"&vbcrlf&_
"<div class='shop-info fd-left'>"&vbcrlf&_
"<dl><dt class='label'>给卖家留言：</dt><dd class='message'><div><textarea name='note' class='input' data-error='' >"&Session("Print.OrderNote")&"</textarea>"&vbcrlf&_
"<p class='word-count fd-hide'><span class='stress realtime'>0</span>/500</p></div></dd></dl></div> "&vbcrlf&_
"<div class='shop-price fd-right'>"&vbcrlf&_
"<input name='_fm.o._0.p' class='value-orderbundle' type='hidden' />"&vbcrlf&_
"<ul class='total-stat-list'> "&vbcrlf&_
"<li class='product-total'><span class='label'>货品总金额：</span> <em class='fd-bold product-total-value'>"&total&"</em>元</li> "&vbcrlf&_
"<li class='shop-promotion-info fd-hide'><span class='label'>活动优惠：</span> <em class='fd-bold shoppromo-value price-value'>0.00</em>元</li> "&vbcrlf&_
"<li class='freight-total'><span class='label'>运费共计：</span> <em class='fd-bold freight-value'>0.00</em>元</li> "&vbcrlf&_
"<li class='sep cope-total'><input name='_fm.o._0.to' class='value-copetotal' type='hidden' value='170.00' /> <span class='b-font label'>应付总额（含运费）：</span> <em class='stress cope-value'>"&total&"</em>元</li> "&vbcrlf&_
"<li class='img-vcode-ct'></li> "&vbcrlf
if not isnul(Session("Print.Orderno")) then
result=result&"<li class='zone-submit'> <a href='/order/alipay/alipayapi.asp'><img width=160 src='/images/alipay.png' /></a></li>"&vbcrlf&_
"</ul></div></div>"
else
result=result&"<li class='zone-submit'><a title='返回购物车' class='to-cart' id='back-to-purchase' href='/order/' data-needfocus='ddxx_backjhd_j' data-tracelog='ddxx_backjhd' >返回购物车</a> <a class='button button-important button-large order-submit-btn' href='javascript:void(0)'>提交订单</a></li>"&vbcrlf&_
"</ul></div></div>"
end if






'"</tbody></table></div>"&vbcrlf&_
'"<div class='footer'><div class='container'>"&vbcrlf&_
'"<span class='total-amount' >数量总计：<em id='allcount'>"&tcount&"</em>件</span> <span class='total-price'>货品金额总计(不包含运费)：<em id='alltotal'>"&total&"</em>元</span>"&vbcrlf&_
'"<a class='button-submit button button-important button-large' href='checkout.asp' >确认下单</a></div>"&vbcrlf&_
'"</div></div>"&vbcrlf

	SelectProductList = result
End Function
'=======================================
'添加订单
'=======================================
Function GetRS(sql)

On Error Resume Next
Set GetRS = conn.exec(sql,"r1")
If Err Then
	'echo sql
	'die err.description
	die "错误，表结构不是最新版本"
End If
End Function



'=======================================
'订单打印
'=======================================
Sub OrderPrint
if needCheck then
if getForm("code","post")<>Session("Code") then alertMsgAndGo "验证码不正确","-1"
end if
dim sql		
dim id, sortID,SortAndID
	dim qs
	'qs = Session("Cart_QS")
	'SortAndID=split(replaceStr(qs,FileExt,""),"_")
	
	'if isNul(replaceStr(qs,FileExt,"")) then  echoMsgAndGo "页面不存在",3 
	SortID = SortAndID(0)
	if not isNul(SortID) and isNum(SortID) then SortID=clng(SortID) else echoMsgAndGo "页面不存在",3 end if
	id=SortAndID(1)
	if not isNul(id) and isNum(id) then id=clng(id) else echoMsgAndGo "页面不存在",3 end if
	
	if isnul(id) or not isnum(id) then alertMsgAndGo "请选择产品！","-1" 
	if isnul(sortID) or not isnum(sortID) then alertMsgAndGo "请选择产品！","-1" 
	
	dim templateobj,channelTemplatePath : set templateobj = new TemplateClass	
	dim typeIds,rsObj,rsObjtid,Tid,rsObjSmalltype,rsObjBigtype
	Dim templatePath,tempStr
	templatePath=sitePath&"/"&"templates/"&setting.defaultTemplate&"/"&setting.htmlFilePath&"/productprint.html"
	if not CheckTemplateFile(templatePath) then echo "productprint.html"&err_16
	
	set rsObj=conn.exec("select * from {prefix}Sort where SortID="&sortID, "exe")							
	if rsObj.eof then echoMsgAndGo "页面不存在",3 : exit sub		
	with templateObj 
	
		.content=loadFile(templatePath)	
		.parseHtml()
		.indexpath()


'订单号码：{aspcms:order.no} 
templateObj.content=replace(templateObj.content,"{aspcms:order.no}",Session("Print.OrderNo"))
'订单日期：{aspcms:order.date} 
templateObj.content=replace(templateObj.content,"{aspcms:order.date}",Session("Print.OrderDate"))
'用 户 名：{aspcms:order.username} 
templateObj.content=replace(templateObj.content,"{aspcms:order.username}",Session("Print.OrderUserName"))
'订单状态：{aspcms:order.state} 
templateObj.content=replace(templateObj.content,"{aspcms:order.state}",Session("Print.OrderState"))
'订单总金额：{aspcms:order.total}元 
templateObj.content=replace(templateObj.content,"{aspcms:order.total}",Session("Print.OrderTotal"))
'商品总数量：{aspcms:order.count} 	
templateObj.content=replace(templateObj.content,"{aspcms:order.count}",Session("Print.OrderCount"))
'客户姓名：{aspcms:order.nicename}
templateObj.content=replace(templateObj.content,"{aspcms:order.nicename}",Session("Print.OrderNiceName"))
'联系电话：{aspcms:order.tel}
templateObj.content=replace(templateObj.content,"{aspcms:order.tel}",Session("Print.OrderTel"))
'手机号码：{aspcms:order.cellphone}
templateObj.content=replace(templateObj.content,"{aspcms:order.cellphone}",Session("Print.OrderCellphone"))
'邮政编码：{aspcms:order.zipcode}
templateObj.content=replace(templateObj.content,"{aspcms:order.zipcode}",Session("Print.OrderZipcode"))
'联系地址：{aspcms:order.address}
templateObj.content=replace(templateObj.content,"{aspcms:order.address}",Session("Print.OrderAddress"))
'电子邮箱：{aspcms:order.email}
templateObj.content=replace(templateObj.content,"{aspcms:order.email}",Session("Print.OrderEmail"))
'简单留言：{aspcms:order.note}
templateObj.content=replace(templateObj.content,"{aspcms:order.note}",Session("Print.OrderNote"))
'支付方式
templateObj.content=replace(templateObj.content,"{aspcms:order.payment}",Session("Print.OrderPayMent"))

select case Session("Print.OrderPayMent")
	case "在线支付"
	templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_Online)
	case "银行支付"
	templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_Bank)
	case "邮局付款"
	templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_PostOffice)
end select


'商品列表
templateObj.content=replace(templateObj.content,"{aspcms:selectproduct}",SelectProductList)
 

		.parseCommon() 		
		echo .content 
	end with
	
	set templateobj =nothing : terminateAllObjects
End Sub



'=======================================
'订单确认
'=======================================
Sub OrderComfirm()
	if needCheck then
	if getForm("code","post")<>Session("Code") then alertMsgAndGo "验证码不正确","-1"
	end if
	
	
	dim orderno, username,  m_state, payment, nicename, tel,cellphone, zipcode, address, email, note, m_to, invoice,addtime 
	dim sql

	orderno=filterPara(getForm("orderno","post"))
	username=filterPara(getForm("username","post"))	
	nicename=filterPara(getForm("nicename","post"))	
	m_state=0
	address=filterPara(getForm("address","post"))	
	zipcode=filterPara(getForm("zipcode","post"))
	cellphone=filterPara(getForm("cellphone","post"))
	tel=filterPara(getForm("tel","post"))	
	email=filterPara(getForm("email","post"))
	m_to=filterPara(getForm("to","post"))	
	note=filterPara(getForm("note","post"))	
	invoice=filterPara(getForm("invoice","post"))
	Payment=filterPara(getForm("Payment","post"))
	 
	addtime = now
	
	dim id, sortID,SortAndID
	dim qs
	qs = filterPara(Session("Cart_QS"))
	SortAndID=split(replaceStr(qs,FileExt,""),"_")
	
	if isNul(replaceStr(qs,FileExt,"")) then  echoMsgAndGo "页面不存在",3 
	SortID = SortAndID(0)
	if not isNul(SortID) and isNum(SortID) then SortID=clng(SortID) else echoMsgAndGo "页面不存在",3 end if
	id=SortAndID(1)
	if not isNul(id) and isNum(id) then id=clng(id) else echoMsgAndGo "页面不存在",3 end if
	
	if isnul(id) or not isnum(id) then alertMsgAndGo "请选择产品！","-1" 
	if isnul(sortID) or not isnum(sortID) then alertMsgAndGo "请选择产品！","-1" 
	
	dim templateobj,channelTemplatePath : set templateobj = new TemplateClass	
	dim typeIds,rsObj,rsObjtid,Tid,rsObjSmalltype,rsObjBigtype
	Dim templatePath,tempStr
	templatePath=sitePath&"/"&"templates/"&setting.defaultTemplate&"/"&setting.htmlFilePath&"/productcomfirm.html"
	if not CheckTemplateFile(templatePath) then echo "productcomfirm.html"&err_16
	
	set rsObj=conn.exec("select * from {prefix}Sort where SortID="&sortID, "exe")							
	if rsObj.eof then echoMsgAndGo "页面不存在",3 : exit sub		
	with templateObj 
	
		.content=loadFile(templatePath)	
		.parseHtml()
		.indexpath()
		templateObj.content=replace(templateObj.content,"{aspcms:sortname}",rsObj("SortName"))
		templateObj.content=replace(templateObj.content,"{aspcms:parentsortid}",rsObj("parentid"))		
		templateObj.content=replace(templateObj.content,"{aspcms:sortid}",sortID)	
		templateObj.content=replace(templateObj.content,"{aspcms:topsortid}",rsObj("topsortid"))
		
		if isnul(rsObj("PageKeywords")) then 
			templateObj.content=replace(templateObj.content,"{aspcms:sortkeyword}",setting.siteKeyWords)	
		else
			templateObj.content=replace(templateObj.content,"{aspcms:sortkeyword}",rsObj("PageKeywords"))	
		end if
		if isnul(rsObj("PageDesc")) then
			templateObj.content=replace(templateObj.content,"{aspcms:sortdesc}",setting.sitedesc)
		else
			templateObj.content=replace(templateObj.content,"{aspcms:sortdesc}",rsObj("PageDesc"))
		end if
		
		if isnul(rsObj("PageTitle")) then 
			templateObj.content=replace(templateObj.content,"{aspcms:sorttitle}",rsObj("SortName"))	
		else
			templateObj.content=replace(templateObj.content,"{aspcms:sorttitle}",rsObj("PageTitle"))
		end if
		
		templateObj.parsePosition(sortID)	
		
		Dim m_username,gender
		if isnul(session("loginstatus")) then  session"loginstatus",0
		if session("loginstatus")="1" then  
			set rsObj=conn.Exec("select * from {prefix}User where UserID="&trim(session("userID")),"r1")
			m_username = rsObj("loginname")
		else 
			gender=1
		end if
		rsObj.close()
		
		
		Dim dic,dicPrice,d,oTotal,oCount
		oTotal = 0:oCount = 0
		Set dic = Session("Cart")
		Set dicPrice = Session("Cart.Price")
		For Each d In dic
			dim prices
			if isnul(dicPrice(d)) then  prices=0 else prices=dicPrice(d)
			oTotal = oTotal + Eval(dic(d) * prices)
			oCount = oCount + dic(d)
		Next
		
		Set dic = nothing:Set dicPrice = nothing
		
		
		dim hidden
		hidden = "<form action='?act=buy' method='post' name='frmComfirm'>"
		hidden = hidden & "<input type='hidden' name='orderno' value='"&orderno&"' />"
		hidden = hidden & "<input type='hidden' name='username' value='"&username&"' />"
		hidden = hidden & "<input type='hidden' name='nicename' value='"&nicename&"' />"
		hidden = hidden & "<input type='hidden' name='address' value='"&address&"' />"
		hidden = hidden & "<input type='hidden' name='zipcode' value='"&zipcode&"' />"
		hidden = hidden & "<input type='hidden' name='cellphone' value='"&cellphone&"' />"
		hidden = hidden & "<input type='hidden' name='tel' value='"&tel&"' />"
		hidden = hidden & "<input type='hidden' name='email' value='"&email&"' />"
		hidden = hidden & "<input type='hidden' name='to' value='"&m_to&"' />"
		hidden = hidden & "<input type='hidden' name='note' value='"&note&"' />"
		hidden = hidden & "<input type='hidden' name='invoice' value='"&invoice&"' />"
		hidden = hidden & "<input type='hidden' name='Payment' value='"&Payment&"' />"
		'hidden = hidden & "<input type='hidden' name='state' value='0' />"
		hidden = hidden & "<p align='center'>"
		hidden = hidden & "<input type='submit' value='确认订单' name='btnSubmit'/></p></form>"
		
		'订单参数传递 {aspcms:order.$trigger$}
		templateObj.content=replace(templateObj.content,"{aspcms:order.$trigger$}",hidden)
		
		If m_username = "" then m_username = "游客"
		
		'订单号码：{aspcms:order.no} 
		templateObj.content=replace(templateObj.content,"{aspcms:order.no}",orderno)
		Session("Print.OrderNo") = orderno
		'订单日期：{aspcms:order.date} 
		templateObj.content=replace(templateObj.content,"{aspcms:order.date}",addtime)
		Session("Print.OrderDate") = addtime
		'用 户 名：{aspcms:order.username} 
		templateObj.content=replace(templateObj.content,"{aspcms:order.username}",m_username)
		Session("Print.OrderUserName") = m_username
		'订单状态：{aspcms:order.state} 
		templateObj.content=replace(templateObj.content,"{aspcms:order.state}","未处理")
		Session("Print.OrderState") = "未处理"
		'订单总金额：{aspcms:order.total}元 
		templateObj.content=replace(templateObj.content,"{aspcms:order.total}",oTotal)
		Session("Print.OrderTotal") = oTotal
		'商品总数量：{aspcms:order.count} 	
		templateObj.content=replace(templateObj.content,"{aspcms:order.count}",oCount)
		Session("Print.OrderCount") = oCount
		'客户姓名：{aspcms:order.nicename}
		templateObj.content=replace(templateObj.content,"{aspcms:order.nicename}",nicename)
		Session("Print.OrderNiceName") = nicename
		'联系电话：{aspcms:order.tel}
		templateObj.content=replace(templateObj.content,"{aspcms:order.tel}",tel)
		Session("Print.OrderTel") = tel
		'手机号码：{aspcms:order.cellphone}
		templateObj.content=replace(templateObj.content,"{aspcms:order.cellphone}",cellphone)
		Session("Print.OrderCellphone") = cellphone
		'邮政编码：{aspcms:order.zipcode}
		templateObj.content=replace(templateObj.content,"{aspcms:order.zipcode}",zipcode)
		Session("Print.OrderZipcode") = zipcode
		'联系地址：{aspcms:order.address}
		templateObj.content=replace(templateObj.content,"{aspcms:order.address}",address)
		Session("Print.OrderAddress") = address
		'电子邮箱：{aspcms:order.email}
		templateObj.content=replace(templateObj.content,"{aspcms:order.email}",email)
		Session("Print.OrderEmail") = email
		'简单留言：{aspcms:order.note}
		templateObj.content=replace(templateObj.content,"{aspcms:order.note}",note)
		Session("Print.OrderNote") = note
		'支付方式
		templateObj.content=replace(templateObj.content,"{aspcms:order.payment}",Payment)
		Session("Print.OrderPayMent") = Payment
		
		select case Payment
			case "在线支付"
			templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_Online)
			case "银行支付"
			templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_Bank)
			case "邮局付款"
			templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_PostOffice)
		end select
		
		
		'商品列表
		templateObj.content=replace(templateObj.content,"{aspcms:selectproduct}",SelectProductList)
		 
		
				.parseCommon() 		
				echo .content 
			end with
			
			set templateobj =nothing : terminateAllObjects	
End Sub
%>
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                      
                                                     
                                                     
                                                     