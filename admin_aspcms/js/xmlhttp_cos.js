var xmlhttp = null;

function xRequest(method,url,asynch,x_handle){
if(window.XMLHttpRequest){
   xmlhttp = new XMLHttpRequest(); //火狐浏览器。
}
else if(window.ActiveXObject){
   xmlhttp = new ActiveXObject("Msxml2.XMLHTTP"); //IE浏览器。
   if(!xmlhttp){xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");}
}

if(xmlhttp){
   if(method.toLowerCase() != "post"){ //判断method参数的值是post还是get。
    initRequest(method,url,asynch,x_handle);
   }else{
    var args = arguments[4];
    if(args != null && args.length > 0){
     initRequest(method,url,asynch,x_handle,args);
    }
   }
}else{
   alert("您的浏览器居然不支持XMLHttpRequest组件！")
}
}

function initRequest(method,url,asynch,x_handle){
try{
   xmlhttp.onreadystatechange = x_handle; //调用x_handle()函数，用来判断异步调用状态与处理远程返回的数据。
   xmlhttp.open(method,url,asynch); //加载url对应的远程服务器来处理我们提交的数据。
   if(method.toLowerCase() == "post"){
    xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    xmlhttp.send(arguments[4]); //发送post类型的异步请求。
   }else{xmlhttp.send(null);} //发送get类型的异步请求。
}catch(e){
   alert("连接出现异常，也许是外星电波干涉！请重试。")
}
}