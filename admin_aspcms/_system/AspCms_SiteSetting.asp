<!--#include file="AspCms_SettingFun.asp" -->
<%CheckAdmin("AspCms_SiteSetting.asp")%>
<%getComplanySetting%>
<%
'在新变量第一次使用时，若不开启忽略则会报错
on error resume next
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<LINK href="../images/style.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.tinyTips.js"></script>
<script type="text/javascript">
		$(document).ready(function() {
			$('a.tTip').tinyTips('title');
			$('a.imgTip').tinyTips('title');
			$('img.tTip').tinyTips('title');
			$('h1.tagline').tinyTips('tinyTips are totally awesome!');
		});
		</script>
<link rel="stylesheet" type="text/css" media="screen" href="../css/tinyTips.css" />
<script type="text/javascript">
        function SetGoogleMapGode(t){
var s = "<";
s += "script src='http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=";
s += "{aspcms:googlemapkey}' type='text/javascript'>";
s += "</";
s += "script>";
s += "\n";
s += "<";
s += "script src='http://www.google.com/uds/api?file=uds.js&amp;v=1.0' type='text/javascript'>";
s += "</";
s += "script>";
s += "\n";
s += "<";
s += "script src='http://www.google.com/uds/solutions/localsearch/gmlocalsearch.js' type='text/javascript'>";
s += "</";
s += "script>";
s += "\n";
	document.getElementById(t).innerText = s;
	document.getElementById(t).style.display = "block";
		}
        </script>
        <script type="text/javascript">
        $(function(){
			$("input[name='waterType']").change(function(){
					var $type=$("input[name='waterType']:checked").val();
					if($type==0){
						$(".textWater").css("display","block");
						$(".picWater").css("display","none");
					}else{
						$(".textWater").css("display","none");
						$(".picWater").css("display","block");
					}
			});
			$("input[name='waterMark']").change(function(){
				if($(this).val()==0){
					$(".water").css("display","none");
				}else{
					$(".water").css("display","block");
				}
			});
			$("input[name='markPicAlpha']").focus(function(){
				$("#alpha").css("display","inline-block").css("color","#CD0000");
			});
			$("input[name='markPicAlpha']").blur(function(){
				$("#alpha").css("display","none").css("color","#FFFFFF");
			});
		});
        </script>
</HEAD>
<BODY>
<DIV class=formzone>
<FORM name="" action="?action=saves" method="post">
<DIV class=tablezone>

<TABLE cellSpacing=0 cellPadding=8 width="100%" align=center border=0>
<TBODY>
    <TR>
    <TD width="193" class=innerbiaoti><STRONG>网站参数</STRONG></TD>
        <TD class=innerbiaoti width=568 height=28></TD>
    </TR>
    
    <TR class=list>
        <TD>网站运行模式 : </TD>
        <TD width=568>
        <input type="radio" name="runMode" value="0" <% if runMode=0 then echo"checked" end if %>>动态
        <input type="radio" name="runMode" value="1" <% if runMode=1 then echo"checked" end if %>>静态 </TD>
    </TR>
    
    <TR class=list>
        <TD>静态文件目录 : </TD>
        <TD width=568>
        <input type="radio" name="htmlOnRoot" value="1" <% if htmlOnRoot=1 then echo"checked" end if %>>根目录
        <input type="radio" name="htmlOnRoot" value="0" <% if htmlOnRoot=0 then echo"checked" end if %>>依栏目设置
       <img src="../images/help.gif" class="tTip" title="开启生成到根目录后，所有生成的html文件都会在根目录下" /> </TD>
    </TR>
    
    <TR class=list>
        <TD>网站后台路径 : </TD>
        <TD width=568>
        <INPUT class="input" size="30" style="width:150px;" value="<%=adminPath%>" name="adminPath"/>   <img src="../images/help.gif" class="tTip" title="更改了后台的目录后一定要将后台的名称也一起更改，否则会出现错误！"></TD>
    </TR>
	
    <TR class=list>
        <TD>模板编码 : </TD>
        <TD width=568>
        <input type="radio" name="Charset" value="utf-8" <% if Charset="utf-8" then echo"checked" end if %>>utf-8
        <input type="radio" name="Charset" value="gb2312" <% if Charset="gb2312" then echo"checked" end if %>>gb2312</TD>
    </TR>
    
    <TR class=list>
        <TD>网站状态 : </TD>
        <TD width=568>
        <input type="radio" name="siteMode" value="1" <% if siteMode=1 then echo"checked" end if %>>运行
        <input type="radio" name="siteMode" value="0" <% if siteMode=0 then echo"checked" end if %>>关闭</TD>
    </TR>

    <TR class=list>
        <TD>网站关闭说明 : </TD>
        <TD><INPUT class="input" size="30" style="width:80%" value="<%=siteHelp%>" name="siteHelp"/> </TD>
    </TR>
    
    <TR class=list>
        <TD>手机版本 : </TD>
        <TD width=568>
        <input type="radio" name="switchWapStatus" value="1" <% if switchWapStatus=1 then echo"checked" end if %>>开启
        <input type="radio" name="switchWapStatus" value="0" <% if switchWapStatus=0 then echo"checked" end if %>>关闭</TD>
    </TR>
    
    <TR class=list>
        <TD>手机版域名绑定 : </TD>
        <TD width=568>http://
        <INPUT class="input" size="30" style="width:150px;" value="<%=wapDomain%>" name="wapDomain"/>
         <img src="../images/help.gif" class="tTip" title="如：m.asp4cms.com">
        </TD>
    </TR>
    
    <TR class=list>
        <TD>手机版本调试 : </TD>
        <TD width=568>
        <input type="radio" name="switchWapDebug" value="1" <% if switchWapDebug=1 then echo"checked" end if %>>开启
        <input type="radio" name="switchWapDebug" value="0" <% if switchWapDebug=0 then echo"checked" end if %>>关闭 <img src="../images/help.gif" class="tTip" title="开启后可通过电脑访问PC版"> </TD>
    </TR>
    
    <TR class=list>
        <TD>栏目英文名称 : </TD>
        <TD>
        	<input type="radio" value="1" name="SwitchNavEn" <% if SwitchNavEn=1 then echo "checked" end if%>>开启
            <input type="radio" value="0" name="SwitchNavEn" <% if SwitchNavEn=0 then echo "checked" end if%>>关闭 <img src="../images/help.gif" class="tTip" title="英文栏目开关需要在页面中调用相应的标签才有作用">  </TD>
    </TR>
    
     <TR class=list>
        <TD>栏目删除保护 : </TD>
        <TD>
        	<input type="radio" value="1" name="switchSortDefend" <% if switchSortDefend=1 then echo "checked" end if%>>开启
            <input type="radio" value="0" name="switchSortDefend" <% if switchSortDefend=0 then echo "checked" end if%>>关闭 
            <img src="../images/help.gif" class="tTip" title="开启后栏目管理里面将没有删除功能！"> 
         </TD>
    </TR>
    
    <TR class=list>
      <TD>网站后台验证码开关</TD>
      <TD><input type="radio" value="1" name="admincode" <% if admincode=1 then echo "checked" end if%>>开启
        <input type="radio" value="0" name="admincode" <% if admincode=0 then echo "checked" end if%>>关闭
          </TD>
    </TR>
    <TR class=list>
        <TD>评论功能开关 : </TD>
        <TD>
        	<input type="radio" value="1" name="SwitchComments" <% if SwitchComments=1 then echo "checked" end if%>>开启
            <input type="radio" value="0" name="SwitchComments" <% if SwitchComments=0 then echo "checked" end if%>>关闭 <img src="../images/help.gif" class="tTip" title="评论开关以及评论审核开关需要在页面中调用相应的评论标签才有作用">        </TD>
    </TR>
    <TR class=list>
        <TD>评论审核开关 : </TD>
        <TD><input type="radio" value="1" name="SwitchCommentsStatus" <% if SwitchCommentsStatus=1 then echo "checked" end if%>>开启
            <input type="radio" value="0" name="SwitchCommentsStatus" <% if SwitchCommentsStatus=0 then echo "checked" end if%>>关闭</TD>
    </TR>
    <TR class=list>
        <TD>留言功能开关 : </TD>
        <TD>
            <input type="radio" value="1" name="switchFaq" <% if switchFaq=1 then echo "checked" end if%>>开启
            <input type="radio" value="0" name="switchFaq" <% if switchFaq=0 then echo "checked" end if%>>关闭         </TD>
    </TR> <TR class=list>
        <TD>留言审核开关 : </TD>
        <TD>
            <input type="radio" value="1" name="SwitchFaqStatus" <% if SwitchFaqStatus=1 then echo "checked" end if%>>开启
            <input type="radio" value="0" name="SwitchFaqStatus" <% if SwitchFaqStatus=0 then echo "checked" end if%>>关闭  <img src="../images/help.gif" class="tTip" title="留言开关以及留言审核开关需要在页面中调用相应的留言标签才有作用">         </TD>
    </TR>
    <TR class=list>
        <TD>页面一键分享 : </TD>
        <TD><input type="radio" value="1" name="Share" <% if Share=1 then echo "checked" end if%>>开启
            <input type="radio" value="0" name="Share" <% if Share=0 then echo "checked" end if%>>关闭 <img src="../images/help.gif" class="tTip" title="打开后网页内显示一键分享，选择文章内容也会显示"></TD>
    </TR>
    <TR class=list>
        <TD>过滤设置开关 : </TD>
        <TD><input type="radio" value="1" name="dirtyStrToggle" <% if dirtyStrToggle=1 then echo "checked" end if%>>开启
            <input type="radio" value="0" name="dirtyStrToggle" <% if dirtyStrToggle=0 then echo "checked" end if%>>关闭 <img src="../images/help.gif" class="tTip" title="网站中过滤掉非法字符，请在过滤设置中设置需要过滤的字符"></TD>
    </TR>
    <TR class=list>
        <TD>过滤设置 : </TD>
        <TD><textarea class="textarea" name="dirtyStr" cols="60" style="width:98%" rows="8"><%=decode(dirtyStr)%></textarea></TD>
    </TR>

    <TR>
    	<TD class=innerbiaoti><STRONG>水印设置</STRONG></TD>
        <TD class=innerbiaoti></TD>
    </TR> 
    
    <TR class=list>
        <TD>是否开启水印功能 : </TD>
        <TD>
        <input type="radio" name="waterMark" value="1" <% if waterMark=1 then echo"checked" end if %>>开启
        <input type="radio" name="waterMark" value="0" <% if waterMark=0 then echo"checked" end if %>>关闭 <img src="../images/help.gif" class="tTip" title="水印功能需要相关组件的支持，只能对图片进行加水印" /></TD>
    </TR>
   <TR class="list water">
        <TD>水印类型 : </TD>
        <TD>
        <input type="radio" name="waterType" value="0" <% if waterType=0 then echo"checked" end if %>>文字
        <input type="radio" name="waterType" value="1" <% if waterType=1 then echo"checked" end if %>>图片
        </TD>
    </TR>
    <TR class="list textWater water"  style="<% if waterType=0 then %>display:block<%else%>display:none<%end if %>">
        <TD>水印文字 : </TD>
        <TD><input class="input" size="30" value="<%=waterMarkFont%>" name="waterMarkFont"/></TD>
    </TR>
    <tr class="list picWater water" style="<% if waterType=1 then %>display:block<%else%>display:none<%end if %>">
    	<td>图片路径：</td>
        <td><input type="text" value="<%=waterMarkPic%>" name="waterMarkPic" id="indeximage" style="width:300px;"><br /><iframe name="image" frameborder="0" width='100%' height="40" scrolling="no" src="../editor/upload.asp?sortType=99&stype=file&Tobj=indeximage" allowTransparency="true"></iframe></td>
    </tr>
    <!--<tr class="list picWater water" type="< %' if waterType=1 then %>display:block< %'else%>display:none< %'end if %>">
    	<td>图片设置：</td>
        <td>宽度：<input  type="text" name="markPicWidth" value="< %'=markPicWidth%>" size="4" style="vertical-align:middle">　 高度：<input type="text" me="markPicHeight" value="< %'=markPicHeight%>" size="4"  style="vertical-align:middle">　 透明度：<input type="text" value="< %'=markPicAlpha%>" size="4" name="markPicAlpha"  style="vertical-align:middle"><span id="alpha" style="display:none">(请输入小数，最大为1，最小为0，默认为0.5)</span></td>
    </tr>-->
    <TR class="list water">
        <TD>水印位置 : </TD>
        <TD>
          <table width="300" border="0" cellspacing="1" cellpadding="0">
            <tr>
                <td width="33%"><input type="radio" name="waterMarkLocation"  value="1" <% if waterMarkLocation=1 then echo"checked" end if %>>顶部居左</td>
                <td width="33%"><input type="radio" name="waterMarkLocation"  value="2" <% if waterMarkLocation=2 then echo"checked" end if %>>顶部居中</td>
                <td><input type="radio" name="waterMarkLocation"  value="3" <% if waterMarkLocation=3 then echo"checked" end if %>>顶部居右</td>
            </tr>
            <tr>
                <td><input type="radio" name="waterMarkLocation"  value="4" <% if waterMarkLocation=4 then echo"checked" end if %>>左边居中</td>
                <td><input type="radio" name="waterMarkLocation"  value="5" <% if waterMarkLocation=5 then echo"checked" end if %>>图片中心</td>
                <td><input type="radio" name="waterMarkLocation"  value="6" <% if waterMarkLocation=6 then echo"checked" end if %>>右边居中</td>
            </tr>
            <tr>
                <td><input type="radio" name="waterMarkLocation"  value="7" <% if waterMarkLocation=7 then echo"checked" end if %>>底部居左</td>
                <td><input type="radio" name="waterMarkLocation"  value="8" <% if waterMarkLocation=8 then echo"checked" end if %>>底部居中</td>
                <td><input name="waterMarkLocation" type="radio"  value="9" <% if waterMarkLocation=9 then echo"checked" end if %>>底部居右</td>
            </tr>
         </table>
         </TD>
    </TR>
    
    <TR>
    	<TD class=innerbiaoti><STRONG>邮件设置</STRONG></TD>
        <TD class=innerbiaoti align="right"></TD>
    </TR>   
    <TR class=list>
        <TD>邮件地址 : </TD>
        <TD><INPUT class="input" size="30" value="<%=smtp_usermail%>" name="smtp_usermail"/>
        <img src="../images/help.gif" class="tTip" title="如：12345@163.com" /> </TD>
    </TR>
    <TR class=list>
        <TD>邮件账号 : </TD>
        <TD><INPUT class="input" size="30" value="<%=smtp_user%>" name="smtp_user"/>
         <img src="../images/help.gif" class="tTip" title="如：12345@163.com" /> 
         </TD>
    </TR>
    <TR class=list>
        <TD>邮件密码 : </TD>
        <TD><INPUT class="input" size="30"  type="password" value="<%=smtp_password%>" name="smtp_password"/> 
         <img src="../images/help.gif" class="tTip" title="如：123456" /> 
        </TD>
    </TR>
    <TR class=list>
        <TD>邮件服务器 : </TD>
        <TD><INPUT class="input" size="30" value="<%=smtp_server%>" name="smtp_server"/> 
        	<img src="../images/help.gif" class="tTip" title="如：smtp.163.com" /> 
       </TD>
    </TR>
    <TR>
    	<TD class=innerbiaoti><STRONG>提醒功能</STRONG></TD>
        <TD class=innerbiaoti></TD>
    </TR>   
    <TR class=list>
        <TD>邮件地址 : </TD>
        <TD><INPUT class="input" size="30" value="<%=MessageAlertsEmail%>" name="MessageAlertsEmail"/> 
         <img src="../images/help.gif" class="tTip" title="支持多个邮箱，请用英文逗号隔开" /> 
        </TD>
    </TR>
    <TR class=list>
        <TD>留言提醒 : </TD>
        <TD>
        <input type="radio" name="messageReminded" value="1" <% if messageReminded=1 then echo"checked" end if %>>开启
        <input type="radio" name="messageReminded" value="0" <% if messageReminded=0 then echo"checked" end if %>>关闭  </TD>
    </TR>
    <TR class=list>
        <TD>订单提醒 : </TD>
        <TD>
        <input type="radio" name="orderReminded" value="1" <% if orderReminded=1 then echo"checked" end if %>>开启
        <input type="radio" name="orderReminded" value="0" <% if orderReminded=0 then echo"checked" end if %>>关闭  </TD>
    </TR>
    <TR class=list>
        <TD>应聘提醒 : </TD>
        <TD>
        <input type="radio" name="applyReminded" value="1" <% if applyReminded=1 then echo"checked" end if %>>开启
        <input type="radio" name="applyReminded" value="0" <% if applyReminded=0 then echo"checked" end if %>>关闭  </TD>
    </TR>
    <TR class=list>
        <TD>评论提醒 : </TD>
        <TD>
        <input type="radio" name="commentReminded" value="1" <% if commentReminded=1 then echo"checked" end if %>>开启
        <input type="radio" name="commentReminded" value="0" <% if commentReminded=0 then echo"checked" end if %>>关闭  </TD>
    </TR>
    
    <TR>
    	<TD class=innerbiaoti><a name="cnzz"></a><STRONG>CNZZ设置</STRONG></TD>
        <TD class=innerbiaoti align="right"></TD>
    </TR>   
    <TR class=list>
        <TD>CNZZ参数值 : </TD>
        <TD><INPUT class="input" size="30" value="<%=CNZZUSER%>" name="CNZZUSER"/> </TD>
    </TR>
</TBODY></TABLE>
</DIV>
<DIV class=adminsubmit>
<INPUT type="hidden" value="<%=LanguageID%>" name="LanguageID" />
<INPUT class="button" type="submit" value="保存" />
<INPUT class="button" type="button" value="返回" onClick="history.go(-1)"/> 
 </DIV></FORM>
</DIV>
</BODY>
</HTML>
