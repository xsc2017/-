$(document).ready(function(){
	var label= $('.label');
	var content= $('.content');
	$('.label').addClass('main');
	$('.label').not(":first").removeClass("main");
	$('.content').addClass('main');
	$('.content').not(":first").hide();
	$('.content').not(":first").removeClass("main");
	$('.label').on("mouseenter",function(){
		var labelClicked = $(this);
		var labelContent = labelClicked.next();
		if(labelContent.is(":visible")) {
			return;
		}
		label.removeClass("main");
		$(this).toggleClass("main");
		content.slideUp("normal");
		content.removeClass("main");
		labelContent.slideDown("slow");
		labelContent.addClass('main');
	});



	var label_one= $('.label_one');
	var content_one= $('.content_one');
	$('.label_one').addClass('main');
	$('.label_one').not(":first").removeClass("main");
	$('.content_one').addClass('main');
	$('.content_one').not(":first").hide();
	$('.content_one').not(":first").removeClass("main");
	$('.labe