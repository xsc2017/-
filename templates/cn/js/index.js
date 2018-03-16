$(document).ready(function(){
			$(".list dl dd").animate({
				right:"0px"
			},800);
		});
$(document).ready(function(){
  comeZero(".aa_one");
  comeOne(".aa_three");
  comeTwo(".aa_four"); 
  comeThree(".aa_five"); 
  comeFour(".aa_six"); 
  comeFive(".aa_seven");
  comeSix(".aa_eight");
  comeSeven(".aa_nine");
  comeNine(".aa_ten");
  comeGog(".gonggao dl");
  comeNron(".bb");
  comeDht(".box_two_top");
  comeDzuo(".dd .whip");
  comeDyou(".dd .lis_nav");
  comeDfo(".bf_one");
  comeDft(".bf_two");
  comeDyth(".bf_three");
  comeDyq(".box_four dl");
  comeDxtrz(".box_three dl dt");
  comeDxtry(".box_three dl dd");
}); 

var hash1Viewed = false;
	$(window).scroll(function(){
	  //如果hash1不曾显示
	  if(hash1Viewed == false){
	    //hash1出现
	     if (inView(".box_one")){
	       //标明hash1已经显示
	       hash1Viewed = true;
	       divZero("#lilist .aa_one")
	       divOne("#lilist .aa_three");
	       divTwo("#lilist .aa_four"); 
	       divThree("#lilist .aa_five"); 
	       divFour("#lilist .aa_six");  
	       divFive("#lilist .aa_seven"); 
	       divSix("#lilist .aa_eight");
	      /* divSeven("#lilist .aa_nine");
         divNine("#lilist .aa_ten");*/
         divGog(".gonggao dl");
         divNron(".bb");
	     }
	  } 
});

  
 //判断selector是否在显示范围内
 function inView(selector){
   var option = 100;
   var winTop = $(window).height();
   var winScrolled = $(window).scrollTop();
   var selectorTop = $(selector).offset().top;
   if (winScrolled+winTop>selectorTop+option){
     return true
   }
   else{return false}   
 };

 //将selector用 动画的形式调整回原位、恢复原透明度
  function divZero(selector){
     $(selector).delay(450).animate({
        opacity:'1',
        right:"936px"
      },1000);
 };

  function divOne(selector){
     $(selector).delay(500).animate({
        opacity:'1',
        right:"780px"
      },1000);
 };
  function divTwo(selector){
     $(selector).delay(550).animate({
        opacity:'1',
        right:"624px"
      },1000);
 };
  function divThree(selector){
     $(selector).delay(600).animate({
        opacity:'1',
        right:"468px"
      },1050);
 };
  function divFour(selector){
     $(selector).delay(650).animate({
        opacity:'1',
        right:"312px"
      },1100);
 };
  function divFive(selector){
     $(selector).delay(700).animate({
        opacity:'1',
        right:"156px"
      },1150);
 };

function divSix(selector){
     $(selector).delay(750).animate({
        opacity:'1',
        right:'0px'
      },1200);
 };
 /*function divSeven(selector){
     $(selector).delay(800).animate({
        opacity:'1',
        right:'122px'
      },1250);
 };
  function divNine(selector){
     $(selector).delay(850).animate({
        opacity:'1',
        right:'1px'
      },1250);
 };*/
  function divGog(selector){
     $(selector).animate({
        opacity:'1',
        right:"50%"
      },1200);
 };
   function divNron(selector){
     $(selector).delay(600).animate({
        opacity:'1',
        top:"0"
      },1000);
 };


//将selector的透明度降为0，并初始化左移
 function comeZero(selector){
   $(selector).css("opacity","0");
   $(selector).css("right","700px");
 };
 function comeOne(selector){
   $(selector).css("opacity","0");
   $(selector).css("right","500px");
 };
  function comeTwo(selector){
   $(selector).css("opacity","0");
   $(selector).css("right","300px");
 };
  function comeThree(selector){
   $(selector).css("opacity","0");
   $(selector).css("right","100px");
 };
  function comeFour(selector){
   $(selector).css("opacity","0");
   $(selector).css("right","0");
 };
  function comeFive(selector){
   $(selector).css("opacity","0");
   $(selector).css("right","-100px");
 };
  function comeSix(selector){
   $(selector).css("opacity","0");
   $(selector).css("right","-200px");
 };
  function comeSeven(selector){
   $(selector).css("opacity","0");
   $(selector).css("right","-300px");
 };
   function comeNine(selector){
   $(selector).css("opacity","0");
   $(selector).css("right","-400px");
 };
   function comeGog(selector){
   $(selector).css("opacity","0");
   $(selector).css("right","-60%");
 };
    function comeNron(selector){
   $(selector).css("opacity","0");
   $(selector).css("top","-50%");
 };



 var hash4Viewed = false;
  $(window).scroll(function(){

       if(hash4Viewed == false){
      //hash1出现
       if (inView2(".box_two")){
         //标明hash1已经显示
         hash4Viewed = true;
          divDht(".box_two_top");
          divDzuo(".dd .whip");
          divDyou(".dd .lis_nav");
       }
    }
});
 //判断selector是否在显示范围内
 function inView2(selector2){
   var option2 = 100;
   var winTop2 = $(window).height();
   var winScrolled2 = $(window).scrollTop();
   var selectorTop2 = $(selector2).offset().top;
   if (winScrolled2+winTop2>selectorTop2+option2){
     return true
   }
   else{return false}   
 };

    function divDht(selector2){
     $(selector2).animate({
        opacity:'1',
        top:"0"
      },1200);
 };
     function divDzuo(selector2){
     $(selector2).animate({
        opacity:'1',
        left:"0"
      },1200);
 };
     function divDyou(selector2){
     $(selector2).animate({
        opacity:'1',
        top:"0"
      },1200);
 };


  function comeDht(selector2){
   $(selector2).css("opacity","0");
   $(selector2).css("top","48px");
 };
   function comeDzuo(selector2){
   $(selector2).css("opacity","0");
   $(selector2).css("left","-50%");
 };
   function comeDyou(selector2){
   $(selector2).css("opacity","0");
   $(selector2).css("top","50%");
 };



 var hash2Viewed = false;
  $(window).scroll(function(){

       if(hash2Viewed == false){
      //hash1出现
       if (inView4(".box_big")){
         //标明hash1已经显示
         hash2Viewed = true;
          divDyq(".box_four dl");
          divDxtrz(".box_three dl dt");
          divDxtry(".box_three dl dd");
       }
    }
});
 //判断selector是否在显示范围内
 function inView4(selector4){
   var option4 = 150;
   var winTop4 = $(window).height();
   var winScrolled4 = $(window).scrollTop();
   var selectorTop4 = $(selector4).offset().top;
   if (winScrolled4+winTop4>selectorTop4+option4){
     return true
   }
   else{return false}   
 };

    function divDyq(selector4){
     $(selector4).delay(500).animate({
        opacity:'1',
        top:"0"
      },1400);
 };
     function divDxtrz(selector4){
     $(selector4).animate({
        opacity:'1',
        top:"0"
      },1200);
 };
     function divDxtry(selector4){
     $(selector4).animate({
        opacity:'1',
        top:"0"
      },1200);
 };

   function comeDyq(selector4){
   $(selector4).css("opacity","0");
   $(selector4).css("top","80%");
 };
    function comeDxtrz(selector4){
   $(selector4).css("opacity","0");
   $(selector4).css("top","300px");
 };
    function comeDxtry(selector4){
   $(selector4).css("opacity","0");
   $(selector4).css("top","-300px");
 };



 var hash5Viewed = false;
  $(window).scroll(function(){

       if(hash5Viewed == false){
      //hash1出现
       if (inView3(".box_five")){
         //标明hash1已经显示
         hash5Viewed = true;
          divDfo(".bf_one");
          divDft(".bf_two");
          divDyth(".bf_three");
       }
    }
});
 //判断selector是否在显示范围内
 function inView3(selector3){
   var option3 = 100;
   var winTop3 = $(window).height();
   var winScrolled3 = $(window).scrollTop();
   var selectorTop3 = $(selector3).offset().top;
   if (winScrolled3+winTop3>selectorTop3+option3){
     return true
   }
   else{return false}   
 };

    function divDfo(selector3){
     $(selector3).animate({
        opacity:'1',
        left:"0"
      },1500);
 };
     function divDft(selector3){
     $(selector3).animate({
        opacity:'1',
        left:"466px"
      },1500);
 };
     function divDyth(selector3){
     $(selector3).animate({
        opacity:'1',
        right:"0"
      },1500);
 };


  function comeDfo(selector3){
   $(selector3).css("opacity","0");
   $(selector3).css("left","-50%");
 };
   function comeDft(selector3){
   $(selector3).css("opacity","0");
   $(selector3).css("left","0");
 };
   function comeDyth(selector3){
   $(selector3).css("opacity","0");
   $(selector3).css("right","-50%");
 };