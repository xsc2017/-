<!--#include file="../inc/AspCms_SettingClass.asp" -->
<%

dim action : action=getForm("action","get")

checkadmin("_system/AspCms_ComplanySetting.asp")

Select case action	
	case "savec" : saveComplanySetting
	case "saves" : saveSiteSetting
	case "saveb" : SavePayMent
End Select


dim LanguageID, SiteTitle, AdditionTitle, SiteLogoUrl, SiteUrl, CompanyName, CompanyAddress, CompanyPostCode, CompanyContact, CompanyPhone, CompanyMobile, CompanyFax, CompanyEmail, CompanyICP, StatisticalCode, CopyRight, SiteKeywords, SiteDesc
dim rs, sql,SiteicoUrl



Sub SavePayMent
	dim configStr,configPath
	configPath="../../config/AspCms_PayMentConfig.asp"	
	
	configStr=loadFile(configPath)	
	
	configStr = AddParas("seller_email","(\S*?)",configStr,true)
	configStr = AddParas("subject","(\S*?)",configStr,true)
	configStr = AddParas("partner","(\S*?)",configStr,true)
	configStr = AddParas("key","(\S*?)",configStr,true)
	configStr = AddParas("notify_url","(\S*?)",configStr,true)
	configStr = AddParas("return_url","(\S*?)",configStr,true)
	configStr = AddParas("Payment_Online","(\S*?)",configStr,true)
	configStr = AddParas("Payment_Bank","(\S*?)",configStr,true)
	configStr = AddParas("Payment_PostOffice","(\S*?)",configStr,true)
	
	createTextFile configStr,configPath,"utf-8"
	
	alertMsgAndGo "修改成功",getPageName()
	
End Sub


Sub saveSiteSetting
	dim cRunMode,cSwitchWapStatus:cRunMode=runMode:cSwitchWapStatus=switchWapStatus
	if runMode=1 and getForm("runMode","post")<>1 and not htmlOnRoot then
		if isExistFile(sitePath&"/"&"index.html") then delFile sitePath&"/"&"index.html"	'删除PC首页	
		if isExistFile(sitePath&"/wap/"&"index.html") then delFile sitePath&"/wap/"&"index.html"	'删除手机首页	
		if not isnul(htmlDir) and isExistFolder(sitePath&"/"&htmlDir) then delFolder(sitePath&"/"&htmlDir)'删除PC页
		if not isnul(htmlDir) and isExistFolder(sitePath&"/wap/"&htmlDir) then delFolder(sitePath&"/wap/"&htmlDir) '删除手机页
	end if
	
	if runMode=1 and getForm("switchWapStatus","post")<>1 and not htmlOnRoot then
		if isExistFile(sitePath&"/wap/"&"index.html") then delFile sitePath&"/wap/"&"index.html"	'删除手机首页	
		if not isnul(htmlDir) and isExistFolder(sitePath&"/wap/"&htmlDir) then delFolder(sitePath&"/wap/"&htmlDir) '删除手机页
	end if
	
	dim cnzz:cnzz=getForm("CNZZUSER","post")
		dim cnzzlink,sql
	if not isnul(cnzz) then
		dim cnzzarr:cnzzarr=split(cnzz,"@")
		if ubound(cnzzarr)>0 then
			cnzzlink="http://wss.cnzz.com/user/companion/aspcms_login.php?site_id="&cnzzarr(0)&"&password="&cnzzarr(1)&""
			sql="update aspcms_menu set menulink='"&cnzzlink&"' where MenuKey='cnzz'"
			'die(sql)
			conn.exec sql,"exe"
		end if
	else
		cnzzlink=sitePath&"_expand/_statistics/AspCms_CNZZ.asp"
		sql="update aspcms_menu set menulink='"&cnzzlink&"' where MenuKey='cnzz'"
		'die(sql)
		conn.exec sql,"exe"
	end if
	dim configStr,configPath
	configPath="../../config/AspCms_Config.asp"	
	
	configStr=loadFile(configPath)
	
	
	
	configStr = AddParas("runMode","(\d?)",configStr,false)
	configStr = AddParas("adminPath","(\S*?)",configStr,false)
	configStr = AddParas("Charset","(\S*?)",configStr,false)
	configStr = AddParas("siteMode","(\d?)",configStr,false)
	configStr = AddParas("siteHelp","(\S*?)",configStr,false)
	configStr = AddParas("admincode","(\d?)",configStr,false)
	
	configStr = AddParas("SwitchNavEn","(\d?)",configStr,false)
	configStr = AddParas("switchFaq","(\d?)",configStr,false)	
	configStr = AddParas("switchFaqStatus","(\d?)",configStr,false)	
	configStr = AddParas("switchComments","(\d?)",configStr,false)	
	configStr = AddParas("switchCommentsStatus","(\d?)",configStr,false)	
	configStr = AddParas("switchCommentsStatus","(\d?)",configStr,false)	
	
	configStr = AddParas("switchWapStatus","(\d?)",configStr,false)	
	configStr = AddParas("wapDomain","(\S*?)",configStr,false)
	
	configStr = AddParas("switchSortDefend","(\d?)",configStr,false)	
	configStr = AddParas("switchWapDebug","(\d?)",configStr,false)
	
	configStr = AddParas("htmlOnRoot","(\d?)",configStr,false)		
	
	configStr = AddParas("Share","(\d?)",configStr,false)
	configStr = AddParas("dirtyStrToggle","(\d?)",configStr,false)
	configStr = AddParas("dirtyStr","(\S*?)",configStr,true)	
	
	
	configStr = AddParas("waterMark","(\d?)",configStr,false)
	configStr = AddParas("waterType","(\d?)",configStr,false)
	configStr = AddParas("waterMarkFont","(\S*?)",configStr,false)
	configStr = AddParas("waterMarkPic","(\S*?)",configStr,false)
	configStr = AddParas("markPicWidth","(\S*?)",configStr,false)
	configStr = AddParas("markPicHeight","(\S*?)",configStr,false)
	configStr = AddParas("markPicAlpha","(\S*?)",configStr,false)	
	configStr = AddParas("waterMarkLocation","(\S*?)",configStr,false)	
	
	configStr = AddParas("smtp_usermail","(\S*?)",configStr,false)	
	configStr = AddParas("smtp_user","(\S*?)",configStr,false)	
	configStr = AddParas("smtp_password","(\S*?)",configStr,false)	
	configStr = AddParas("smtp_server","(\S*?)",configStr,false)
	
	configStr = AddParas("CNZZUSER","(\S*?)",configStr,false)	
	configStr = AddParas("CNZZPASS","(\S*?)",configStr,false)
	
	
	configStr = AddParas("messageAlertsEmail","(\S*?)",configStr,false)
	configStr = AddParas("messageReminded","(\d?)",configStr,false)
	configStr = AddParas("orderReminded","(\d?)",configStr,false)
	configStr = AddParas("commentReminded","(\d?)",configStr,false)
	configStr = AddParas("applyReminded","(\d?)",configStr,false)
	
	
	
	configStr = AddParas("GoogleAPIKey","(\S*?)",configStr,false)
	configStr = AddParas("GoogleMapLat","(\S*?)",configStr,false)
	configStr = AddParas("GoogleMapLng","(\S*?)",configStr,false)
	
	
	 
	'die configStr
	
	'die configPath
	createTextFile configStr,configPath,"utf-8"
	
	if cint(getForm("runMode","post"))=1 then  '静态开启状态
		if cRunMode=0 and cint(getForm("switchWapStatus","post"))=1 or (cSwitchWapStatus=0 and cint(getForm("switchWapStatus","post"))=1) then '静态关到开并且手机开，或者手机关到开
			alertMsgAndGo "修改成功,下面将重新生成全站静态页！","../_seo/AspCms_MakeHtml.asp?actType=html&action=auto" 
		elseif (cSwitchWapStatus=1 and cint(getForm("switchWapStatus","post"))<>1) or cRunMode=0  then'手机开变关或静态关到开
			alertMsgAndGo "修改成功,下面将重新生成全站PC静态页！","../_seo/AspCms_MakeHtml.asp?actType=html&action=all" 
		else
			alertMsgAndGo "修改成功",getPageName()
		end if
	else
		alertMsgAndGo "修改成功",getPageName()
	end if
End Sub
'2011年7月8日 by amysimple
'带追加功能
'p 参数 t 替换类型 c 替换字符串 e 需要进行编码
Function AddParas(p,t,c,e)
	dim endTag,isString,val
	isString = ( t = "(\S*?)" )	
	val = getForm(p,"post")
	endTag = "%" & ">"
	dim templateobj
	set templateobj=new TemplateClass
	if instr(c,"Const "&p&"") = 0 then	
		c = replace(c,endTag,"")
		c = c & vbCrLf & vbCrLf
		if isString then
			c = c & "Const "&p&"="""&val&""""
		else
			if val = "" then val = 0
			c = c & "Const "&p&"="&val&""
		end if
		c = c & vbCrLf & vbCrLf & endTag
	else	
		if isString then
			if e then
				c=templateobj.regExpReplace(c,"Const "&p&"="""&t&"""","Const "&p&"="""&encode(val)&"""")
			else	
				c=templateobj.regExpReplace(c,"Const "&p&"="""&t&"""","Const "&p&"="""&val&"""")
			end if	
		else
			if val = "" then val = 0	
			c=templateobj.regExpReplace(c,"Const "&p&"="&t,"Const "&p&"="&val)
		end if
	end if
	set templateobj = nothing
	AddParas = c
End Function
'2011年7月8日 by amysimple
'由于程序顶端设置了Option Explicit，输出的变量需要特殊处理
Sub SafeEcho(s)
On Error Resume Next

Dim code:code = "Response.Write(decode(" & s & "))"
Execute code
'SafeVar = s
End Sub


Sub getComplanySetting
	dim ID : ID=session("languageID")
	if not isnul(ID) and isnum(ID) then		
		sql ="select * from {prefix}Language where LanguageID="&id
		dim rs : set rs=conn.exec(sql,"r1")
		if rs.eof then 
			alertMsgAndGo "没有这条记录","-1"
		else
			LanguageID=rs("LanguageID")
			SiteTitle=rs("siteTitle")
			AdditionTitle=rs("additionTitle")
			SiteLogoUrl=rs("siteLogoUrl")
			SiteUrl=rs("siteUrl")
			CompanyName=rs("companyName")
			CompanyAddress=rs("companyAddress")
			CompanyPostCode=rs("companyPostCode")
			CompanyContact=rs("companyContact")
			CompanyPhone=rs("companyPhone")
			CompanyMobile=rs("companyMobile")
			CompanyFax=rs("companyFax")
			CompanyEmail=rs("companyEmail")
			CompanyICP=rs("companyICP")
			StatisticalCode=rs("statisticalCode")
			CopyRight=rs("copyRight")
			SiteKeywords=rs("siteKeywords")
			SiteDesc=rs("siteDesc")
		end if
		rs.close : set rs=nothing
	else		
		alertMsgAndGo "没有这条记录","-1"
	end if 
End Sub

Sub saveComplanySetting
	LanguageID=getForm("LanguageID","post")
	SiteTitle=getForm("siteTitle","post")
	AdditionTitle=getForm("additionTitle","post")
	SiteLogoUrl=getForm("siteLogoUrl","post")
	SiteUrl=getForm("siteUrl","post")
	CompanyName=getForm("companyName","post")
	CompanyAddress=getForm("companyAddress","post")
	CompanyPostCode=getForm("companyPostCode","post")
	CompanyContact=getForm("companyContact","post")
	CompanyPhone=getForm("companyPhone","post")
	CompanyMobile=getForm("companyMobile","post")
	CompanyFax=getForm("companyFax","post")
	CompanyEmail=getForm("companyEmail","post")
	CompanyICP=getForm("companyICP","post")
	StatisticalCode=getForm("statisticalCode","post")
	CopyRight=getForm("copyRight","post")
	SiteKeywords=getForm("siteKeywords","post")
	SiteDesc=getForm("siteDesc","post")

	conn.exec"update {prefix}Language set SiteTitle='"&SiteTitle&"', AdditionTitle='"&AdditionTitle&"', SiteLogoUrl='"&SiteLogoUrl&"', SiteUrl='"&SiteUrl&"', CompanyName='"&CompanyName&"', CompanyAddress='"&CompanyAddress&"', CompanyPostCode='"&CompanyPostCode&"', CompanyContact='"&CompanyContact&"', CompanyPhone='"&CompanyPhone&"', CompanyMobile='"&CompanyMobile&"', CompanyFax='"&CompanyFax&"',CompanyEmail ='"&CompanyEmail&"', CompanyICP='"&CompanyICP&"', StatisticalCode='"&StatisticalCode&"', CopyRight='"&CopyRight&"', SiteKeywords='"&SiteKeywords&"', SiteDesc='"&SiteDesc&"' where LanguageID="&LanguageID, "exe"
	alertMsgAndGo "保存成功！",getPageName()
End Sub
%>