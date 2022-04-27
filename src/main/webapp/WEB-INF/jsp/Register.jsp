<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<meta name="viewport" content="width=device-width,initial-scale=1, maximum-scale=3, minimum-scale=1, user-scalable=no">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<title>���U</title>
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
<body bgcolor='#FF60AF'>
  <main class="form-signin">
     <div class="container">
		<div class="card">
			<div class="card-header">
				<h3>Register</h3>
			</div>
			<div class="card-body">
				<form action="Enter" id="Enter" method="POST">
					<div class="form-floating mb-3">
                      <input type="text" class="form-control" name="newaccount" id="newaccount">
                      <label for="floatingInput">�b��</label>
                    </div>
                    <div class="form-floating">
                      <input type="password" class="form-control" name="newassword" id="newpassword">
                      <label for="floatingPassword">�K�X</label>
                    </div>
                    <div class="form-floating">
                      <input type="text" class="form-control" name="email" id="email">
                      <label for="floatingPassword">�q�l�l��</label>
                    </div>
                    <br>
                    <div class="form-floating">
                      <button type="button" class="btn btn-secondary w-100" onclick="register_confirm();">���U</button>
                    </div>
				</form>
			</div>
	    </div>
     </div>
  </main>
  <script src="js/jquery-3.6.0.min.js"></script>
  <script>
     function register_confirm()
     {
    	 var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    	 if(!regex.test($("#email").val())) {
    		   alert("email �榡���~!!");
    	 }else{
    		 $.ajax({
 	  		    type:'POST',
 	  		    url: 'register',
 	  		    async:true,
 	  		    data: {"newaccount":$("#newaccount").val(),"newpassword":$("#newpassword").val(),"email":$("#email").val()},
 	  		    success: function(data)
 	  		    {
 	  		    	if(data=="success")
 	  		    	{
 	  		    	   alert("���U���\!!�Ш�H�c���H�}�q�b��");
 	  		    	   document.location.href="Homepage";
 	  		    	}else if (data=="sameaccount")
 	  		    	{
 	  		    	   alert("���b���W�w�g���H�ϥ�!!");	
 	  		    	}else
 	  		    	{
 	  		    	   alert("���U����!!");	
 	  		    	}
 	  		    }
 	        });
          }
    	  	   
     }
  </script>
</body>
</html>