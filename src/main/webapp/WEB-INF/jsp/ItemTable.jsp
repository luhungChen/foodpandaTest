<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ page import="java.util.*"%>
<%@ page import="Bean.Items"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Insert title here</title>
</head>
<body>
<%List <Items> l = (List <Items>)session.getAttribute("Items"); %>
  <% int tmp=0;
               for(int i=0;i<l.size();i++){ %>
                  <%if(i%3==0){ %>
                     <div class="row">
                  <%}else{ tmp++;%>
               <%} %>
                  <div class="col-sm-4" style="border:2px green solid;border-radius:10px;background-color:#eee;text-align:center;">
                    <span id="item_name_<%=l.get(i).getItem_id()%>" class="text-light" style="background-color:#D9006C;">商品名稱: <%=l.get(i).getItem_name() %></span>
                    <br>
                    <img id="item_picture_<%=l.get(i).getItem_id()%>" src="./img/<%=l.get(i).getItem_id()%>.jpg" width="200" height="200"/>
                    <br>
                    <span id="item_stock_<%=l.get(i).getItem_id()%>">庫存: <%=l.get(i).getStock() %></span>
                    <br>
                    <span id="item_price_<%=l.get(i).getItem_id()%>">價錢: <%=l.get(i).getPrice() %></span>
                    <br>
                    <input type ="button" name="<%=l.get(i).getItem_id() %>" value="加入購物車" class="w-100 text-light" style="border-radius:10px;background-color:#D9006C;" onclick="item_shopping_cart(this.name);"/>
                    <br>
                  </div>
               <%if(tmp==2||i==(l.size()-1)) {%>
                </div>
                <br>
                <%tmp=0;} %>
                <%} %>
                
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
                      <div class="modal-footer p-2 justify-content-center">
                        <span class="fs-7 fw-bold" style="text-align:center;" id="total_price"></span>
                      </div>
                    </div>
                  </div>
                </div>
                        
</body>
</html>