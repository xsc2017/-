

$(function() {
	// 悬浮窗口
	$(".yb_conct").hover(function() {
		$(".yb_conct").css("right", "5px");
	}, function() {
		$(".yb_conct").css("right", "-127px");
    	$(".yb_WeiXin").css("height", "43px");
	});
	// 返回顶部
	$(".yb_top").click(function() {
		$("html,body").animate({
			'scrollTop': '0px'
		}, 300)
	});
	$(".yb_WeiXin").mouseover(function() {
		$(".yb_WeiXin").css("height", "200px");
	});
	
});


