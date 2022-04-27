/**
 * 
 */




function page_click(page,mpage)
{
	if(page==0)
	{
      alert("這是第一頁!!");
	}else if(page>mpage)
	{
	  alert("這是最後一頁!!");
	}else
	{
		document.getElementById("pagenum").value=page;
		document.getElementById("pageform").submit();
	}
}
function set_class(name)
{
	document.getElementById("classes").value=name;
	document.getElementById("pageform").submit();
}

function item_shopping_cart(item_id)
{
	if(document.getElementById("log_account").value=='null')
	{
	  document.location.href="Login";
	}else
	{
	  document.getElementById("item_picture").setAttribute("src","./img/"+item_id+".jpg");
	  document.getElementById("item_stock").innerText="庫存: "+(Number(document.getElementById("item_stock_"+item_id).innerText.replace("庫存: ","")));
	  document.getElementById("itemqty").value=0;
	  document.getElementById("item_price").innerText=document.getElementById("item_price_"+item_id).innerText;
	  document.getElementById("item_name").innerText=document.getElementById("item_name_"+item_id).innerText;
	  var msgModal = new bootstrap.Modal(document.getElementById('Modal_item'), {
	    keyboard: false
	  });
	  msgModal.show();
	}
}

function count_qty(cal)
{
	if(cal=="+")
	{
		if(Number(document.getElementById("item_stock").innerText.split(":")[1].replace("庫存: ",""))<=0)
		{
			alert("已經沒貨囉!!");
		}else
		{
			document.getElementById("itemqty").value=(Number(document.getElementById("itemqty").value)+1);
			document.getElementById("item_stock").innerText="庫存: "+(Number(document.getElementById("item_stock").innerText.split(":")[1].replace(" ",""))-1);
		}
	}else
	{
		if((Number(document.getElementById("itemqty").value)-1)<0)
		{
			alert("數量不能小於0");
		}else
		{
			document.getElementById("itemqty").value=(Number(document.getElementById("itemqty").value)-1);
			document.getElementById("item_stock").innerText="庫存: "+(Number(document.getElementById("item_stock").innerText.split(":")[1].replace(" ",""))+1);
		}
	}
}

function add_shopping_cart()
{
	if(Number(document.getElementById("itemqty").value)>0)
	{
	   if(localStorage.hasOwnProperty(document.getElementById("item_name").innerText)==false)
	      document.getElementById("cart_num").innerText=Number(document.getElementById("cart_num").innerText)+1;
	   localStorage.setItem(document.getElementById("item_name").innerText,document.getElementById("item_name").innerText.replace("商品名稱: ","")+"_"+document.getElementById("item_price").innerText+"_"+document.getElementById("itemqty").value);
	   var totalprice = 0;
		for (var attr in localStorage){
			if(localStorage.getItem(attr)==null)
				break;
			if(attr=="total_price")
				continue;
			totalprice += localStorage.getItem(attr).split(": ")[1].split("_")[0]*localStorage.getItem(attr).split(": ")[1].split("_")[1];
		}
		localStorage.setItem("total_price",totalprice);
		document.getElementById("total_price").innerText=localStorage.getItem("total_price")+"元";
	   $('#Modal_item').modal('hide');
	}else
	{
		alert("請選擇訂購數量!!");
	}
}
function delete_shopping_cart(name)
{
	localStorage.removeItem("商品名稱: "+name);
	document.getElementById("shopping_cart_content").removeChild(document.getElementById("div:"+name));
	if(Number(document.getElementById("cart_num").innerText)>0)
	document.getElementById("cart_num").innerText=Number(document.getElementById("cart_num").innerText)-1;
	 var totalprice = 0;
		for (var attr in localStorage){
			if(localStorage.getItem(attr)==null)
				break;
			if(attr=="total_price")
				continue;
			totalprice += localStorage.getItem(attr).split(": ")[1].split("_")[0]*localStorage.getItem(attr).split(": ")[1].split("_")[1];
		}
		localStorage.setItem("total_price",totalprice);
		document.getElementById("total_price").innerText=localStorage.getItem("total_price")+"元";
}
function add_order()
{
	var send = '';
	for (var attr in localStorage){
		if(localStorage.getItem(attr)==null)
			break;
		if(attr=="total_price")
			continue;
		send += localStorage.getItem(attr)+","
	}
	send+=localStorage.getItem("total_price");
	if(localStorage.length==1)
	{
		alert("購物車無商品");
	}else
	{
		var go=confirm("是否確定下單");
	  if(go){
	  $.ajax({
		    type:'POST',
		    url: 'order_create',
		    async:true,
		    data: {"order_data":send,"log_account":document.getElementById("log_account").value},
		    success: function(data)
		    {
		    	if(data=="success")
		    	{
		    	   alert("訂單建立成功!!");
		    	   $('#Modal_shopping_cart').modal('hide');
		    	   localStorage.clear();
		    	   document.getElementById("cart_num").innerText=0;
		    	}else
		    	{
		    	   alert("訂單建立失敗!!");	
		    	}
		    }
       });
	  }
	}
}
function deleteOrder(order_no)
{
	var html='';
	var go=confirm("是否確定刪除訂單"+order_no.split("_")[1]+"?");
	if(go)
	{
	 $.ajax({
	    type:'POST',
	    url: 'delete_order',
	    async:true,
	    data: {"user":order_no.split("_")[0],"order_no":order_no.split("_")[1]},
	    success: function(data)
	    {
	    	if(data!="failure")
	    	{
	    		$('#OrderTableBody').html('');
	    		for(var i=0;i<data.split(",").length;i++)
 		        {
	    			if(data.split(",")[i].split("_")[0]!='')
 		    	      html += "<tr><td>" + data.split(",")[i].split("_")[0] + "</td><td>" + data.split(",")[i].split("_")[1] + "</td><td>" + data.split(",")[i].split("_")[2] + "</td><td>" + data.split(",")[i].split("_")[3] + "</td><td><input type='button' class='btn btn-primary' name ='"+ data.split(",")[i].split("_")[1]+"' value='顯示詳細訂單資料' onclick='getOrderDetail(this.name);'/>&nbsp;<input type='button' class='btn btn-primary' value= '刪除訂單' name ='"+data.split(",")[i].split("_")[0]+"_"+data.split(",")[i].split("_")[1]+"' onclick='deleteOrder(this.name);'/></td></tr>";
 		        }
	    		
	    		$("#OrderTableBody").html(html);
	    	}else
	    	{
	    	   alert("訂單刪除失敗!!");	
	    	}
	    }
   });
	}
}
function show_shopping_cart()
{
	var msgModal = new bootstrap.Modal(document.getElementById('Modal_shopping_cart'), {
	    keyboard: false
	});
	var div = document.getElementById("shopping_cart_content");
	div.setAttribute("style","background-color:#FFD9EC;");
	document.getElementById("shopping_cart_content").innerHTML = "";
	var title_div = document.getElementById("shopping_cart_content");
	var titleheaderdiv = document.createElement("div");
	titleheaderdiv.setAttribute("class","modal-header");
	var titlespan = document.createElement("span");
	titlespan.setAttribute("class","modal-title fs-2 fw-bold");
	titlespan.setAttribute("style","margin-left:40%");
	titlespan.textContent="購物車";
	var titlebutton = document.createElement("button");
	titlebutton.setAttribute("class","btn-close");
	titlebutton.setAttribute("data-bs-dismiss","modal");
	titlebutton.setAttribute("aria-label","Close");
	titleheaderdiv.appendChild(titlespan);
	titleheaderdiv.appendChild(titlebutton);
	title_div.appendChild(titleheaderdiv);
	for (var attr in localStorage){
		if(localStorage.getItem(attr)==null)
			break;
		if(attr=="total_price")
			continue;
		var divsecond = document.createElement("div");
		divsecond.setAttribute("class","modal-body");
		divsecond.setAttribute("style","text-align:center;border-bottom-style:groove;border-color:#D9006C;");
		divsecond.setAttribute("id","div:"+attr.split(": ")[1]);
		var span = document.createElement("span");
		span.textContent=localStorage.getItem(attr).split("_價錢:")[0]+localStorage.getItem(attr).split("_價錢:")[1].split("_")[0]+"元"; 
		span.setAttribute('name', attr.split(": ")[1]);
		var text = document.createElement("input");
		text.type="text";
		text.setAttribute('value',localStorage.getItem(attr).split("_價錢:")[1].split("_")[1]);
		text.setAttribute('style',"margin-left:5%;width:10%;");
		text.setAttribute('id',"text:"+attr.split(": ")[1]);
		var button = document.createElement("button");
		button.setAttribute("class","btn btn-primary");
		button.setAttribute("name", attr.split(": ")[1]);
		button.setAttribute("style","margin-left:10%");
		button.setAttribute("onclick","delete_shopping_cart(this.name);");
		button.textContent="刪除商品";
		divsecond.appendChild(span);
		divsecond.appendChild(text);
		divsecond.appendChild(button);
		div.appendChild(divsecond);
	}
	var totalpricediv = document.createElement("div");
	totalpricediv.setAttribute("class","modal-footer p-2 justify-content-center");
	var totalpricespan = document.createElement("span");
	totalpricespan.textContent="0元";
	totalpricespan.setAttribute("class","fs-7 fw-bold");
	totalpricespan.setAttribute("id","total_price");
	totalpricespan.setAttribute("style","text-align:center;");
	totalpricediv.appendChild(totalpricespan);
	var orderadddiv = document.createElement("div");
	orderadddiv.setAttribute("class","modal-footer p-2 justify-content-center");
	var orderaddbutton = document.createElement("button");
	orderaddbutton.setAttribute("class","btn btn-danger");
	orderaddbutton.setAttribute("onclick","add_order();");
	orderaddbutton.textContent="成立訂單";
	orderadddiv.appendChild(orderaddbutton);
	div.appendChild(totalpricediv);
	div.appendChild(orderadddiv);
	var totalprice = 0;
	for (var attr in localStorage){
		if(localStorage.getItem(attr)==null)
			break;
		if(attr=="total_price")
			continue;
		totalprice += localStorage.getItem(attr).split(": ")[1].split("_")[0]*localStorage.getItem(attr).split(": ")[1].split("_")[1];
	}
	localStorage.setItem("total_price",totalprice);
	document.getElementById("total_price").innerText=localStorage.getItem("total_price")+"元";
	msgModal.show();
	/*var div = document.getElementById("shopping_cart_content");
	var divsecond = document.createElement("div");
	divsecond.setAttribute("class","modal-body");
	divsecond.setAttribute("style","text-align:center;");
	var span = document.createElement("span");
	span.setAttribute('name', 'gg');   
	divsecond.appendChild(span);
	div.appendChild(divsecond);
	msgModal.show();*/
}

function getOrderDetail(name)
{
	var msgModal = new bootstrap.Modal(document.getElementById('show_order_detail'), {
	    keyboard: false
	});
	
	$.ajax({
	    type:'POST',
	    url: 'get_order_detail',
	    async:true,
	    data: {"order_no":name},
	    success: function(data)
	    {
	    	if(data!="failure")
	    	{
	    		document.getElementById("order_detail").innerText='';
	    		document.getElementById("order_no").innerText="訂單編號"+name;
	    		var text='';
	    		for(var i=0;i<data.split(",").length;i++)
	    		{
	    		   text +=data.split(",")[i].split("_")[0]+" "+data.split(",")[i].split("_")[2]+"元 "+data.split(",")[i].split("_")[1]+"個\n";
	    		  
	    		}
	    		document.getElementById("order_detail").innerText=text;
	    		msgModal.show();
	    	}
	    }
   });
	
}

function register_account()
{
  alert("正在開發中  請用 帳號: henrychen0128 密碼: 1111 登入");
}

function forget_password()
{
  alert("正在開發中  請用 帳號: henrychen0128 密碼: 1111 登入");
}