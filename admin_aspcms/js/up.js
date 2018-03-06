window.onload = function() {
	if (CookieGet('CloseTips') == 'CloseTips') {
		document.getElementById('Tip').style.display = 'none';
		document.getElementById('Tip1').style.display = 'none'
	} else {
		 $.ajax({
			type : "get",
		    async: false,
            url: CheckURL('http://www.aspcms.cn/getver/'),
            dataType:"jsonp",
			jsonp: "callbackparam",
            jsonpCallback:"jsonpback",
            success:function(res){
		                document.getElementById('Tip').style.display = 'block';
		                document.getElementById('Tip1').style.display = 'block'
				document.getElementById("Tip").innerHTML = res;
            }
        })
	}
}
function CheckURL(Verurl){
	var timstamp=(new Date()).valueOf();
	if(Verurl.indexOf("?")>=0){
		Verurl+="&t="+timstamp+"&ver="+ver;
	}
	else{
		Verurl+="?t="+timstamp+"&ver="+ver;	
	}
	return Verurl;
}
function GetVer(ver) {
	var UpVer = null;
	if (window.XMLHttpRequest) {
		UpVer = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		UpVer = new ActiveXObject("Microsoft.XMLHTTP");
	}
	if (UpVer) {
		UpVer.open("get", ver, true);
		UpVer.onreadystatechange = function() {
			if (UpVer.readyState === 4) {
				if (UpVer.status == 200 || UpVer.status == 0) {
					document.getElementById("Tip").innerHTML = UpVer.responseText;
				}
			}
		}
		UpVer.send(null);
	} else {
		alert("未找到");
	}
}

function CookieSave(n, v, mins, dn, path)
{
    if(n)
    {
		
	    if(!mins) mins = 7*24*60;
		if(!path) path = "/";
	    var date = new Date();
		
	    date.setTime(date.getTime() + (mins * 60 * 1000));
		
	    var expires = "; expires=" + date.toGMTString();
		
	    if(dn) dn = "domain=" + dn + "; ";
	    document.cookie = n + "=" + v + expires + "; " + dn + "path=" + path;
    }
}
function CookieGet(n)
{
    var name = n + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i<ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length); 
		if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
	}
	return "";
}
function CloseTips(){
	document.getElementById('Tip').style.display='none';
	document.getElementById('Tip1').style.display='none'
  if(document.getElementById("Upver").checked){
	CookieSave('CloseTips','CloseTips','','','');
	}
}

function Close_div(){
		document.getElementById('Tip').style.display = 'none';
		document.getElementById('Tip1').style.display = 'none'
	}