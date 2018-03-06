<!DOCTYPE html>
<html><head>
<title>防止登陆超时</title>
<meta http-equiv="refresh"content="50;url='?action=reset'">
</head>
<%
if Session("adminName")<>"" then
session("resettimeout")=1
else
session("resettimeout")=0
end if
%>
重置:<%=session("resettimeout")%>
<body>
</body>
</html>