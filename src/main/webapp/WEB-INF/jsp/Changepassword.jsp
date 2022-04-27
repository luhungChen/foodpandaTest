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
      <input type="hidden" name="account" id="account" value="<%=session.getAttribute("log_account") %>"/> 
      <input type="hidden" name="change" value="change"/> 
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
					  <input type="text" class="form-control" id="account" disabled="disabled" value="<%=session.getAttribute("log_account") %>">
                    </div>
                    <div class="form-floating">
                      <input type="password" class="form-control" id="oldpassword">
                      <label for="floatingPassword">請輸入舊密碼</label>
                    </div>
                    <div class="form-floating">
                      <input type="password" class="form-control" id="newpassword">
                      <label for="floatingPassword">請輸入新密碼</label>
                    </div>
                    <div class="form-floating">
                      <input type="password" class="form-control" id="repeatpassword">
                      <label for="floatingPassword">再輸入一次新密碼</label>
                    </div>
                    <br>
                    <div class="form-floating">
                      <button type="button" class="btn btn-secondary w-100" onclick="modify();">修改</button>
                    </div>
                    <br>
                    <div class="form-floating">
                      <button type="button" class="btn btn-secondary w-100" onclick="sub();">首頁</button>
                    </div>
				</form>
			</div>
	    </div>
     </div>
 </main>
<script src="js/jquery-3.6.0.min.js"></script>
  <script>
  function modify()
  {
	   if($("#newpassword").val()!=$("#repeatpassword").val())
	   {
		   alert("密碼不一致!!");
	   }
	   else
	   {
  	     $.ajax({
  		    type:'POST',
  		    url: 'changepassword',
  		    async:true,
  		    data: {"oldpassword":$("#oldpassword").val(),"newpassword":$("#newpassword").val(),"account":"<%=session.getAttribute("log_account") %>"},
  		    success: function(data)
  		    {
  		    	if(data=="success")
  		    	{
  		    	   alert("密碼變更成功!!");
  		    	 document.getElementById("accountform").submit();
  		    	   
  		    	}else
  		    	{
  		    	   alert("密碼變更失敗!!");	
  		    	}
  		    }
          });
	   }
  }
  function sub()
  {
	  document.getElementById("accountform").submit();
  }
  </script>
</body>
</html>