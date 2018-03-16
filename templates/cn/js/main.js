 $(document).ready(function(){
        $(function () {
            $(window).scroll(function(){
                if ($(window).scrollTop()>100){
                    $(".go_top").fadeIn(200);
                }
                else
                {
                    $(".go_top").fadeOut(200);
                }
            });
        });
    });

        $(document).ready(function(){
            $(":range").rangeinput({progress: true});

            /* Slide Toogle */
            $("ul li> div.der").click(function()
            {
                var arrow = $(this).find("span.arrow");

                if(arrow.hasClass("up"))
                {
                    arrow.removeClass("up");
                    arrow.addClass("down");
                }
                else if(arrow.hasClass("down"))
                {
                    arrow.removeClass("down");
                    arrow.addClass("up");
                }

                $(this).parent().find("div.menu").slideToggle();
            });
        });