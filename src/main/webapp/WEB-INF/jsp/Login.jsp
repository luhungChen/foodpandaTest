<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<meta name="viewport" content="width=device-width,initial-scale=1, maximum-scale=3, minimum-scale=1, user-scalable=no">
	<title>Login Page</title>
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<script charset="UTF-8" src="./js/javascript.js"></script>
<style>
    html,
    body {
      height: 100%;
    }
    body {
      display: flex;
      align-items: center;
      padding-top: 40px;
      padding-bottom: 40px;
      background-color: #FF60AF;
    }

    .form-signin {
      width: 100%;
      max-width: 330px;
      padding: 15px;
      margin: auto;
    }

    .form-signin .checkbox {
      font-weight: 400;
    }

    .form-signin .form-floating:focus-within {
      z-index: 2;
    }

    .form-signin input[type="password"] {
      margin-bottom: 10px;
      border-top-left-radius: 0;
      border-top-right-radius: 0;
    }
  </style>
</head>
<body>
<form id="accountform" method="post" action="Homepage">
      <input type="hidden" name="account" id="account"/> 
</form>
 <main class="form-signin">
     <div class="container">
		<div class="card">
			<div class="card-header">
				<h3>Sign In</h3>
			</div>
			<div class="card-body">
				<form action="Enter" id="Enter" method="POST">
					<div class="form-floating mb-3">
                      <input type="text" class="form-control" name="accounts" id="accounts">
                      <label for="floatingInput">帳號</label>
                    </div>
                    <div class="form-floating">
                      <input type="password" class="form-control" name="password" id="password">
                      <label for="floatingPassword">密碼</label>
                    </div>
                    <div class="form-floating">
                      <button type="button" class="btn btn-secondary w-100" onclick="login_confirm();">登入</button>
                    </div>
                    <br>
                    <div class="form-floating">
                      <button type="button" class="btn btn-secondary w-100" onclick="forget_password();">忘記密碼</button>
                    </div>
                    <br>
                    <div class="form-floating">
                      <button type="button" class="btn btn-secondary w-100" onclick="location.href='Register'">申請會員</button>
                    </div>
                    <br>
                    <div class="form-floating">
                      <button type="button" class="btn btn-secondary w-100" onclick="location.href='Homepage'">首頁</button>
                    </div>
				</form>
			</div>
	    </div>
     </div>
 </main>
<script src="js/jquery-3.6.0.min.js"></script>
  <script>
  function login_confirm()
  {
  	   $.ajax({
  		    type:'POST',
  		    url: 'checkpassword',
  		    async:true,
  		    data: {"account":$("#accounts").val(),"password":$("#password").val()},
  		    success: function(data)
  		    {
  		    	    if(data.split("_")[0]=="success")
		          	{
  		    	    	document.getElementById("account").value=$("#accounts").val();
		          		$('#accountform').submit();
		          	}
  		    	    else if(data=="Novalidate")
		          	{
		          	   alert("此帳密尚未開通!!");
		          	}else
		          	{
		          	   alert("無此帳密!!");
		          	}
  		    }
        });
  }
  </script>
</body>
</html>