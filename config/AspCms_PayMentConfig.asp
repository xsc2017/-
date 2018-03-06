<%
	
Const seller_email="idc888@126.com"            	'卖家支付宝
Const subject="[网站订单] aspcms网站订单"     '订单名称
Const partner="2088102164192121"               '合作身份者ID，以2088开头的16位纯数字
Const key="3q5c5vl8ofybd9socygctmxtxzfynr8m"   '安全检验码，以数字和字母组成的32位字符

'服务器异步通知页面路径
Const notify_url="http://www.asp4cms.com/order/alipay/notify_url.asp"
        '需http://格式的完整路径，不能加?id=123这类自定义参数

        '页面跳转同步通知页面路径
Const return_url="http://www.asp4cms.com/order/alipay/return_url.asp"
Const Payment_Online="支付宝"
Const Payment_Bank=""
Const Payment_PostOffice=""
%>