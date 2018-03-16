$(function(){
	$('.tabbox .tabbox_this ul').width(652*$('.tabbox .tabbox_this li').length+'px');
	$(".tabbox .tab a").mouseover(function(){
		$(this).addClass('on').siblings().removeClass('on');
		var index = $(this).index();
		number = index;
		var distance = -652*index;
		$('.tabbox .tabbox_this ul').stop().animate({
			left:distance
		});
	});
	
	var auto = 1;  //等于1则自动切换，其他任意数字则不自动切换
	if(auto ==1){
		var number = 0;
		var maxNumber = $('.tabbox .tab a').length;
		function autotab(){
			number++;
			number == maxNumber? number = 0 : number;
			$('.tabbox .tab a:eq('+number+')').addClass('on').siblings().removeClass('on');
			var distance = -652*number;
			$('.tabbox .tabbox_this ul').stop().animate({
				left:distance
			});
		}
		var tabChange = setInterval(autotab,3000);
		//鼠标悬停暂停切换
		$('.tabbox').mouseover(function(){
			clearInterval(tabChange);
		});
		$('.tabbox').mouseout(function(){
			tabChange = setInterval(autotab,3000);
		});
	  }  
});

$(function(){
	$('.tabbox_one .tabbox_one_this ul').width(652*$('.tabbox_one .tabbox_one_this li').length+'px');
	$(".tabbox_one .tab_one a").mouseover(function(){
		$(this).addClass('on').siblings().removeClass('on');
		var index = $(this).index();
		number = index;
		var distance = -652*index;
		$('.tabbox_one .tabbox_one_this ul').stop().animate({
			left:distance
		});
	});
	
	var auto = 1;  //等于1则自动切换，其他任意数字则不自动切换
	if(auto ==1){
		var number = 0;
		var maxNumber = $('.tabbox_one .tab_one a').length;
		function autotab(){
			number++;
			number == maxNumber? number = 0 : number;
			$('.tabbox_one .tab_one a:eq('+number+')').addClass('on').siblings().removeClass('on');
			var distance = -652*number;
			$('.tabbox_one .tabbox_one_this ul').stop().animate({
				left:distance
			});
		}
		var tabChange = setInterval(autotab,3000);
		//鼠标悬停暂停切换
		$('.tabbox_one').mouseover(function(){
			clearInterval(tabChange);
		});
		$('.tabbox_one').mouseout(function(){
			tabChange = setInterval(autotab,3000);
		});
	  }  
});

$(function(){
	$('.tabbox_two .tabbox_two_this ul').width(652*$('.tabbox_two .tabbox_two_this li').length+'px');
	$(".tabbox_two .tab_two a").mouseover(function(){
		$(this).addClass('on').siblings().removeClass('on');
		var index = $(this).index();
		number = index;
		var distance = -652*index;
		$('.tabbox_two .tabbox_two_this ul').stop().animate({
			left:distance
		});
	});
	
	var auto = 1;  //等于1则自动切换，其他任意数字则不自动切换
	if(auto ==1){
		var number = 0;
		var maxNumber = $('.tabbox_two .tab_two a').length;
		function autotab(){
			number++;
			number == maxNumber? number = 0 : number;
			$('.tabbox_two .tab_two a:eq('+number+')').addClass('on').siblings().removeClass('on');
			var distance = -652*number;
			$('.tabbox_two .tabbox_two_this ul').stop().animate({
				left:distance
			});
		}
		var tabChange = setInterval(autotab,3000);
		//鼠标悬停暂停切换
		$('.tabbox_two').mouseover(function(){
			clearInterval(tabChange);
		});
		$('.tabbox_two').mouseout(function(){
			tabChange = setInterval(autotab,3000);
		});
	  }  
});