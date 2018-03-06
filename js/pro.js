// JavaScript Document

$(function(){
	var a=$(".mod-detail-sku-batch"),
	h = $("a.toggle-detail",a),
	k = $("div.table-sku",a),
	g = $("div.content",a),
	i = $("div.ordernum-box",a),
	j = "hide-detail";
  
	h.attr("trace", "purchaselistclose");
	h.click(function(l) {
		l.preventDefault();
		var m = $(this);
		if (m.hasClass(j)) {
			m.removeClass(j);
			m.children("span").text("\u6536\u8d77");
			m.attr("trace", "purchaselistopen");
			g.removeClass("zeroize-height");
			k.slideDown(200,
			function() {
				i.addClass("fd-locate")
			})
		} else {
			m.addClass(j);
			m.children("span").text("\u5c55\u5f00");
			m.attr("trace", "purchaselistclose");
			k.slideUp(200,
			function() {
				g.addClass("zeroize-height");
				
			})
		}
	})
})
	
$(function(){
	var f=$("dl.d-sku"),g=$("dd.d-sku-list",f),h=$("dd.d-sku-all",f);
	h.each(function(j){
		var m=$(this),l,k;
		if(m.hasClass("fd-hide")){return}
		k=f.eq(j).hasClass("d-sku-img")?78:58;
		l=$("a",m);
		l.click(function(p){
			p.preventDefault();
			var q=$(this),
			n=$("span",q),
			i=g.eq(j),
			o=i.children("ul").outerHeight(true);
			if(q.hasClass("d-sku-more")){
				q.removeClass("d-sku-more");
				n.text("\u6536\u8d77\u90e8\u5206");
				q.attr("title","\u6536\u8d77\u90e8\u5206");
				i.animate({height:o},"normal",function(){})
			}
			else{
				q.addClass("d-sku-more");
				n.text("\u5c55\u5f00\u5168\u90e8");
				q.attr("title","\u5c55\u5f00\u5168\u90e8");
				i.animate({height:k},"normal")}
		})
	})

var downs=$("a.amount-down"),inputs=$("input.amount-input"),ups=$("a.amount-up");
var summary,amount,view,detail
		amount=$(".amount");
		summary=$(".summary span",amount);
		view=$(".view",amount);
		detail=$(".detail",amount);
var j = /^[0-9]+\d*$/;

	downs.each(function(n){
		var down=downs.eq(n),input=inputs.eq(n),up=ups.eq(n),t
		down.click(function(p){
			p.preventDefault();
			if (Number(input.val())>1){
				input.val(Number(input.val())-1);
				input.blur();
			}})
		up.click(function(p){
			p.preventDefault();
			if (Number(input.val())<Number(input.attr("data-count"))){
				input.val(Number(input.val())+1);
				input.blur();
			}})
	});
	inputs.keyup(function() {
		var m = $(this),
                l = m.val();
                if (l) {
                    if (j.test(l)) {
                        i = l;

                    } else {
                        m.val(i);
                    }
                } else {
                    i = "";
                }
    });

	view.click(function(p){
		p.preventDefault();
		if(amount.hasClass("amount-hover")){
			amount.removeClass("amount-hover");
			detail.hide();
			}
		else{
			amount.addClass("amount-hover");
			detail.show()}
	})
	var	buy=$("dl dd.d-btn-buy a"),
	addcart=$(".do-cart"),
	dobuy=$(".do-buy"),
	addok=$(".widget-dialog.purchase-dialog"),
	tip=$("#J_ActionPanel p",addok),
	htmlbody=$("body"),success="",
	proid=$("#proid");
	closebtn= $(".close-btn",addok)
	longbuy= $(".long-buy",addok)
	var proids ="",counts ="",prices ="",n=0,ok=0;
	addcart.click(function(p){
		p.preventDefault();
		n=0;ok=0;
		proids=escape(proid.val());
		counts=inputs.val();
		prices=inputs.attr("data-price");
		n=n+1;
		if(counts.length){
			$.post( "/order/",{act:"add","proid":proids,"count":counts,"price":prices},
			function(html){
				$.get("/order/", { act: "select",uncatch:Math.floor(Math.random()*1000)},
				function(html){
					success=unescape(html);
					tip.html(success);
					addok.show();
					
				});
			});
		}
	});
	
	dobuy.click(function(p){
		p.preventDefault();
		n=0;ok=0;
		proids=escape(proid.val());
		counts=inputs.val();
		prices=inputs.attr("data-price");
		n=n+1;
		
		 if(confirm('你是否希望直接购买该产品?\r\n(直接购产品会清空购物车其他产品)')){ ok=1;}else{ ok=0; return;}
		if(counts.length ){
			$.get( "/order/checkout.asp",{act:"directbuy"},
				function(html){
					$.post( "/order/",{act:"add","proid":proids,"count":counts,"price":prices},
						function(html){
							window.location.href="/order/checkout.asp"
						});
				});
		}
	});
	
	
	closebtn.click(function(p){p.preventDefault();addok.hide();})
	longbuy.click(function(p){p.preventDefault();addok.hide();})
	buy.click(function(p){
		p.preventDefault();
		proids=[]; counts=[]; prices=[];n=0;ok=0;
		inputs.each(function(i) {
			inpt=inputs.eq(i); 
			if (Number(inpt.val())){
				proids[n]=escape(proid.val()+"_"+inpt.attr("data-color")+"_"+inpt.attr("data-height"));
				counts[n]=inpt.val();
				prices[n]=inpt.attr("data-price");
				n=n+1;
			}		
		});
		if(counts.length){
			$.post( "/order/",{act:"buy","proid":proids,"count":counts,"price":prices},function(html){
				window.navigate("/order/checkout.asp");});
		}
		else{
			alert("订购数量必须为大于0的整数！")
		};
			
	});
	
});
                                                         
														 
														 
														 