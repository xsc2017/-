var miniBlogShare = function() {
//指定位置驻入节点
$('<img id="imgSinaShare" class="img_share" title="将选中内容分享到新浪微博" src="/img/uploadimg/20111107/1714550.gif" /><img id="imgQqShare" class="img_share" title="将选中内容分享到腾讯微博" src="/img/uploadimg/20111107/1714551.png" />').appendTo('body');

//默认样式
$('.img_share').css({
display : 'none',
position : 'absolute',
cursor : 'pointer'
});

//选中文字
var funGetSelectTxt = function() {
var txt = '';
if(document.selection) {
txt = document.selection.createRange().text;
} else {
txt = document.getSelection();
}
return txt.toString();
};

//选中文字后显示微博图标
$('html,body').mouseup(function(e) {
if (e.target.id == 'imgSinaShare' || e.target.id == 'imgQqShare') {
return
}
e = e || window.event;
var txt = funGetSelectTxt(),
sh = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0,
left = (e.clientX - 40 < 0) ? e.clientX + 20 : e.clientX - 40,
top = (e.clientY - 40 < 0) ? e.clientY + sh + 20 : e.clientY + sh - 40;
if (txt) {
$('#imgSinaShare').css({
display : 'inline',
left : left,
top : top
});
$('#imgQqShare').css({
display : 'inline',
left : left + 30,
top : top
});
} else {
$('#imgSinaShare').css('display', 'none');
$('#imgQqShare').css('display', 'none');
}
});

//点击新浪微博
$('#imgSinaShare').click(function() {
var txt = funGetSelectTxt(), title = $('title').html();
if (txt) {
window.open('http://v.t.sina.com.cn/share/share.php?title=' + txt + ' —— 转载自：' + title + '&url=' + window.location.href);
}
});

//点击腾讯微博
$('#imgQqShare').click(function() {
var txt = funGetSelectTxt(), title = $('title').html();
if (txt) {
window.open('http://v.t.qq.com/share/share.php?title=' + encodeURIComponent(txt + ' —— 转载自：' + title) + '&url=' + window.location.href);
}
});
}();