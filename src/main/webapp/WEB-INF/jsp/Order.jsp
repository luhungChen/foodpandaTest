<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ page import="java.util.*"%>
<%@ page import="Bean.orders"%>
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
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.js"></script>
<title>訂單查詢</title>
</head>
<body>
  <%if(session.getAttribute("account")==null) 
	  response.sendRedirect("Login");
  %>
  <%List <orders>orderdata = (List <orders>)session.getAttribute("ordersdata");%>
  <input type="hidden" id="log_account" value="<%=session.getAttribute("account") %>"/>
  <div class="container-fluid h-100">
         <div class="row">
            <div class="col">
                <%@include file="Navbar.jsp" %>
                <br>
                <br>
            </div>
         </div>
          <div class="row" style="height:70%;overflow-y:scroll;">
            <div class="col">
               <table class="table table-border table-dark" style="text-align:center;" id="OrderTableDetail">
               <thead>
                    <tr>
                       <th scope="col">下單人</th>
                       <th scope="col">訂單編號</th>
                       <th scope="col">總金額</th>
                       <th scope="col">訂單成立時間</th>
                       <th scope="col">行為</th>
                    </tr>
               </thead>
               <tbody id="OrderTableBody">
                   <%for(int i =0 ;i<orderdata.size();i++){ %>
                    <tr>
                       <td><%=orderdata.get(i).getUser()%></td>
                       <td><%=orderdata.get(i).getOrder_no()%></td>
                       <td><%=orderdata.get(i).getTotal_price()%></td>
                       <td><%=orderdata.get(i).getDate_time()%></td>
                       
                       <td><input type="button" class='btn btn-primary' name ='<%=orderdata.get(i).getOrder_no()%>' value="顯示詳細訂單資料" onclick="getOrderDetail(this.name);"/>&nbsp;<input type="button" class='btn btn-primary' name ='<%=orderdata.get(i).getUser()+"_"+orderdata.get(i).getOrder_no()%>' value="刪除訂單" onclick="deleteOrder(this.name);"/></td>
                    </tr>
                    <%} %>
               </tbody>
               </table>
            </div>
         </div>
         <div class="row" style="height:5%;text-align:center;">
            <div class="col">
           
            </div>
         </div>
         <div class="row align-items-end" style="background-color:#D9006C;height:15%">
            <div class="col">
               
            </div>
         </div>
     </div>
     <div class="modal fade" id="Modal_item" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalMsgLabel" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header" >
                        <span class="modal-title fs-2 fw-bold" style="margin-left:28%" id="item_name"></span>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      </div>
                      <div class="modal-body" style="text-align:center;">
                        <img id="item_picture" src="" width="200" height="200"/>
                      </div>
                      <div class="modal-footer p-2 justify-content-center">
                        <span class="fs-7 fw-bold" id="item_price"></span>
                      </div>
                      <div class="modal-footer p-2 justify-content-center">
                        <span class="fs-7 fw-bold" id="item_stock"></span>
                      </div>
                      <div class="modal-footer p-2 justify-content-center">
                         <input type="button" style="border-radius:20px;width:30px;font-weight:bold;" value="-" onclick="count_qty(this.value);"/><input type="text" id="itemqty" style="text-align:center;" size="5" value="1" disabled/><input style="border-radius:20px;width:30px;font-weight:bold;" type="button" value="+" onclick="count_qty(this.value);"/>
                      </div>
                      <div class="modal-footer p-2 justify-content-center" id="confirmMsgBtn">
                        <button type="button" class="btn btn-danger" onclick="add_shopping_cart();">確定加入購物車</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                      </div>
                    </div>
                  </div>
                </div>
                
                <div class="modal fade" id="Modal_shopping_cart" data-bs-backdrop="static" data-bs-keyboard="true" tabindex="-1" aria-labelledby="modalMsgLabel" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content" id="shopping_cart_content">
                      <div class="modal-header" >
                        <span class="modal-title fs-2 fw-bold" style="margin-left:40%">購物車</span>
                        <button type="button" class="btn-close"  data-bs-dismiss="modal" aria-label="Close"></button>
                      </div>
                    </div>
                  </div>
                </div>
                
                <div class="modal fade" id="show_order_detail" data-bs-dismiss="modal" data-bs-backdrop="static" data-bs-keyboard="true" tabindex="-1" aria-labelledby="modalMsgLabel" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content" id="shopping_cart_content">
                      <div class="modal-header justify-content-center" >
                        <span class="modal-title fs-2 fw-bold">訂單詳細資訊</span>
                      </div>
                      <div class="modal-footer p-2 justify-content-center">
                        <span class="fs-7 fw-bold" id="order_no"></span>
                      </div>
                      <div class="modal-footer p-2 justify-content-center">
                        <span class="fs-7 fw-bold" id="order_detail"></span>
                      </div>
                    </div>
                  </div>
                </div>
                <script>
                $(document).ready( function () {
                    $('#OrderTableDetail').DataTable({
                    	  language: {
                    		   emptyTable: "No data available in table", // 
                    		   loadingRecords: "Please wait .. ", // default Loading...
                    		   zeroRecords: "No matching records found"
                    		  }
                    		});
                } );
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