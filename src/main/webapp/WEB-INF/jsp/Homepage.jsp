<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ page import="java.util.*"%>
<%@ page import="Bean.Items"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<meta name="viewport" content="width=device-width,initial-scale=1, maximum-scale=3, minimum-scale=1, user-scalable=no">
<link rel="stylesheet" href="./css/homepage.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script charset="UTF-8" src="./js/bootstrap.bundle.js"></script>
<script charset="UTF-8" src="./js/jquery-3.6.0.min.js"></script>
<script charset="UTF-8" src="./js/javascript.js"></script>


<title>首頁</title>
</head>
<body>
    <%int maxpages = (int)session.getAttribute("Maxpage"); 
      int thispage = (int)session.getAttribute("NowIndex");
      int nowclasses =1;
      if(session.getAttribute("NowClass")!=null)
        nowclasses = (int)session.getAttribute("NowClass"); 
    %>
    <form name="myfrom" id="pageform" method="post" action="direct_pages">
      <input type="hidden" value = "1" name="pagenum" id="pagenum"/> 
      <input type="hidden" value = "1" name="classes" id="classes"/> 
    </form>
    <input type="hidden" id="log_account" value="<%=session.getAttribute("account") %>"/>
     <div class="container-fluid h-100">
         <div class="row">
            <div class="col">
                <%@include file="Navbar.jsp" %>
                <br>
                <br>
            </div>
         </div>
          <div class="row" style="height:80%">
            <div class="col" style="text-align:center;"> 
            <%if(nowclasses==1){%>
                 <a class="h2 text-danger" name="1" style="text-decoration:none;" href="javascript: void(0)" onclick='set_class(this.name);'>水果</a>
                 &nbsp;
                 <a class="h2 text-primary" name="2" style="text-decoration:none;" href="javascript: void(0)" onclick='set_class(this.name);'>3C產品</a>
               <%}else if(nowclasses==2){ %>
                 <a class="h2 text-primary" name="1" style="text-decoration:none;" href="javascript: void(0)" onclick='set_class(this.name);'>水果</a>
                 &nbsp;
                 <a class="h2 text-danger" name="2" style="text-decoration:none;" href="javascript: void(0)" onclick='set_class(this.name);'>3C產品</a>
               <%} %>
             <%@include file="ItemTable.jsp" %>
             <a class="border h2" style="text-decoration:none;" name="<%=thispage-1%>" id="<%=maxpages %>" href="javascript: void(0)" onclick='page_click(this.name,this.id)'>上一頁</a>
              <%for(int i=1;i<=maxpages;i++)
                  if(i==thispage)
                  {
             %>
             
              <a class="border h2 text-danger" name="<%=i%>" id="<%=maxpages%>" style="text-decoration:none;" href="javascript: void(0)" onclick='page_click(this.name,this.id)'><%=i %></a>
                <%}else{ %>
                <a class="border h2" style="text-decoration:none;" name="<%=i%>" id="<%=maxpages %>" href="javascript: void(0)" onclick='page_click(this.name,this.id)'><%=i%></a>
                <%} %>
             <a class="border h2" style="text-decoration:none;" name="<%=thispage+1%>" id="<%=maxpages %>" href="javascript: void(0)" onclick='page_click(this.name,this.id)'>下一頁</a>
            </div>
         </div>
         
         <div class="row" style="background-color:#D9006C;height:7%">
            <div class="col">
               
            </div>
         </div>
     </div>
     <script>
     window.onload=function(){
    	 if(localStorage.length==0)
    		 document.getElementById("cart_num").innerText=localStorage.length;
    	 else
    	     document.getElementById("cart_num").innerText=localStorage.length-1;
    	var totalprice = 0;
    	for (var attr in localStorage){
    		if(localStorage.getItem(attr)==null)
    			break;
    		if(attr=="total_price")
    			continue;
    		totalprice += localStorage.getItem(attr).split(": ")[1].split("_")[0]*localStorage.getItem(attr).split(": ")[1].split("_")[1];
    	}
    	localStorage.setItem("total_price",totalprice);
    	
    }
     </script>
</body>
</html>