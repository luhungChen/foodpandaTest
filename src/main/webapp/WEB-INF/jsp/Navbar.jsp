<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">

</head>
<body>

    <Form name='accountdata' id="accountdata" method="post" action='Order'>
       <input type="hidden" name="log_account" value='<%=session.getAttribute("account") %>'/> 
    </Form>
    <Form name='accounthompage' id="accountdata" method="post" action='Homepage'>
       <input type="hidden" name="account" value='<%=session.getAttribute("account") %>'/> 
    </Form>
    <Form name='changeaccountpass' id="accountdata" method="post" action='Changepassword'>
       <input type="hidden" name="account" value='<%=session.getAttribute("account") %>'/> 
    </Form>
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color:#D9006C;">
        <div class="container-fluid">
             <%if(session.getAttribute("account")!=null) {%>
                <a class="navbar-brand"><font size="6">FoodpandaTest</font><br>Hi!&nbsp;<%=session.getAttribute("account") %></a>
                <div class="navbar-nav">
                     <button class="btn border-white btn-cart text-light" onclick="show_shopping_cart();">�ʪ���<i class="fa fa-cart-plus" style="font-size:24px"></i><span id="cart_num" class="badge badge-pill badge-danger">0</span></button>
                     <a class="nav-link btn border-white btn-outline-primary btn-sm px-4 my-2 my-lg-0 ms-lg-3 text-light" href="Login">�n�X</a>
                     <a class="nav-link btn border-white btn-outline-primary btn-sm px-4 my-2 my-lg-0 ms-lg-3 text-light" href="javascript:document.accountdata.submit();">�q��</a>
                     <a class="nav-link btn border-white btn-outline-primary btn-sm px-4 my-2 my-lg-0 ms-lg-3 text-light" href="javascript:document.accounthompage.submit();">�ӫ�</a>
                     <a class="nav-link btn border-white btn-outline-primary btn-sm px-4 my-2 my-lg-0 ms-lg-3 text-light" href="javascript:document.changeaccountpass.submit();">�ק�K�X</a>
                </div>
             <%}else{ %>
                <a class="navbar-brand"><font size="6">Foodpanda</font></a>
                <div class="navbar-nav">
                     <button class="btn border-white btn-cart text-light" style="display:none;" onclick="show_shopping_cart();">�ʪ���<i class="fa fa-cart-plus" style="font-size:24px"></i><span id="cart_num" class="badge badge-pill badge-danger">0</span></button>
                     <a class="nav-link btn border-white btn-outline-primary btn-sm px-4 my-2 my-lg-0 ms-lg-3 text-light" href="Login">�n�J</a>
                     <a class="nav-link btn border-white btn-outline-primary btn-sm px-4 my-2 my-lg-0 ms-lg-3 text-light" href="Register">���U�s�b��</a>
                     <a class="nav-link btn border-white btn-outline-primary btn-sm px-4 my-2 my-lg-0 ms-lg-3 text-light" href="Homepage">�ӫ�</a>
                </div>
             <%} %>
             
        </div>
    </nav>
</body>
</html>