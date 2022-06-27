package com.foodpanda.simulation.foodpandatest;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import Bean.order_items;
import Bean.orders;

@Controller
public class AjaxControllerPath 
{
	@Autowired
	private JdbcTemplate primaryJdbcTemplate;
	
	@Autowired
	private JavaMailSender jms;
	
	@RequestMapping("/checkpassword")
    public void Login_confirm(HttpServletRequest request,HttpServletResponse response) 
	{
		System.out.println(request.getRemoteAddr());
		System.out.println(request.getHeader("user-agent"));
		
		int result=0;
        try
		{
        	String sql = "SELECT 1 FROM USER WHERE account=? AND password=?";
            try
            {
            	result = primaryJdbcTemplate.queryForObject(sql,new Object[]{request.getParameter("account"),request.getParameter("password")},java.lang.Integer.class);
                
            }catch(EmptyResultDataAccessException e)
            {	
            }
            PrintWriter writer = null;
		    response.setContentType("text/html;charset=BIG5");
		    if(result==1)
		    {
		    	 result = 0;
		    	 String sql_tmp = "SELECT 1 FROM USER WHERE account=? AND password=? AND status=1";
		    	 try
		         {
		             result = primaryJdbcTemplate.queryForObject(sql_tmp,new Object[]{request.getParameter("account"),request.getParameter("password")},java.lang.Integer.class);
		         }catch(EmptyResultDataAccessException e)
		         {
		            	
		         }
		    	 if(result==1)
		    	 {
		    	     writer = response.getWriter();
			         writer.print("success_"+request.getParameter("account")); 
				     writer.flush();
				     writer.close();
		    	 }else
		    	 {
		    		 writer = response.getWriter();
				     writer.print("Novalidate"); 
					 writer.flush();
					 writer.close(); 
		    	 }
		    }else
		    {
		    	 writer = response.getWriter();
			     writer.print("Noaccount"); 
				 writer.flush();
				 writer.close(); 
		    }
		  }catch(Exception e)
		  {
		  }
    }
	@RequestMapping("/order_create")
    public void order_create(HttpServletRequest request,HttpServletResponse response) 
	{
	  try
	  {
		String user = request.getParameter("log_account");
		String order_data = request.getParameter("order_data");
		int order_no=0;
		order_no = primaryJdbcTemplate.queryForObject("select case when order_no is null then 1 else max(order_no)+1 end order_no from order_header",new Object[]{},java.lang.Integer.class);
		int num=0;
	    num = primaryJdbcTemplate.update("Insert into order_header select '"+user+"',"+order_no+",NOW(),"+order_data.split(",")[order_data.split(",").length-1]+" from dual");
		for(int i=0;i<(order_data.split(",").length-1);i++)
          	num = primaryJdbcTemplate.update("Insert into order_detail select "+order_no+",'"+order_data.split(",")[i].split("_")[0]+"',"+order_data.split(",")[i].split(": ")[1].split("_")[1]+","+order_data.split(",")[i].split(": ")[1].split("_")[0]+" from dual");
        PrintWriter writer = response.getWriter();
        writer.print("success"); 
	    writer.flush();
	    writer.close();
	  }catch(Exception e)
	  {
		  e.printStackTrace();
		PrintWriter writer;
		try {
			writer = response.getWriter();
			writer.print("failure"); 
			writer.flush();
			writer.close();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	      
	  }
	}
	
	@RequestMapping("/delete_order")
    public void delete_order(HttpServletRequest request,HttpServletResponse response) 
	{
	  try
	  {
		String order_no = request.getParameter("order_no");
		String user = request.getParameter("user");
		int num=0;
		num = primaryJdbcTemplate.update("delete from order_header where order_no="+order_no+" and user='"+user+"'");
		num = primaryJdbcTemplate.update("delete from order_detail where order_no="+order_no);
		List <orders> l=  primaryJdbcTemplate.query("SELECT * FROM order_header", new MyRowMapper2());
        String datas="";
		for(int i=0;i<l.size();i++)
        {
			if(i==(l.size()-1))
			  datas+=l.get(i).getUser()+"_"+l.get(i).getOrder_no()+"_"+l.get(i).getTotal_price()+"_"+l.get(i).getDate_time();
		    else
        	  datas+=l.get(i).getUser()+"_"+l.get(i).getOrder_no()+"_"+l.get(i).getTotal_price()+"_"+l.get(i).getDate_time()+",";
        }
		PrintWriter writer = response.getWriter();
        writer.print(datas); 
	    writer.flush();
	    writer.close();
	  }catch(Exception e)
	  {
		  e.printStackTrace();
		PrintWriter writer;
		try {
			writer = response.getWriter();
			writer.print("failure"); 
			writer.flush();
			writer.close();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	      
	  }
	}
	
	@RequestMapping("/get_order_detail")
    public void get_order_detail(HttpServletRequest request,HttpServletResponse response) 
	{
	  try
	  {
		String order_no = request.getParameter("order_no");
		String user = request.getParameter("user");
		int num=0;
		List <order_items> l=  primaryJdbcTemplate.query("SELECT item_name,number,price FROM order_detail where order_no="+request.getParameter("order_no"), new MyRowMapper3());
        String datas="";
		for(int i=0;i<l.size();i++)
        {
			if(i==(l.size()-1))
			  datas+=l.get(i).getItem_name()+"_"+l.get(i).getNumber()+"_"+l.get(i).getPrice();
		    else
		      datas+=l.get(i).getItem_name()+"_"+l.get(i).getNumber()+"_"+l.get(i).getPrice()+",";
        }
		response.setCharacterEncoding("UTF-8");
		PrintWriter writer = response.getWriter();
        writer.print(datas); 
	    writer.flush();
	    writer.close();
	  }catch(Exception e)
	  {
		  e.printStackTrace();
		PrintWriter writer;
		try {
			writer = response.getWriter();
			writer.print("failure"); 
			writer.flush();
			writer.close();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	      
	  }
	}
	
	@RequestMapping("/register")
    public void register(HttpServletRequest request,HttpServletResponse response) 
	{
		String sql = "SELECT 1 FROM USER WHERE account=?";
		int result=0;
		try
        {
            result = primaryJdbcTemplate.queryForObject(sql,new Object[]{request.getParameter("newaccount")},java.lang.Integer.class);
        }catch(Exception e)
        {
        }
		try
		{
		   PrintWriter writer = response.getWriter();
	       response.setContentType("text/html;charset=BIG5");
		   if(result==0)
		   {
			 String encryption_char = "A1BCD2EFGH3IJ9KL4MNOP5QRS6TUVW7XYZ8";
			 String encryption_result="";
			 for(int i=0;i<5;i++)
				 encryption_result+= String.valueOf(encryption_char.charAt((int)((Math.random()*100)%35)));
			 String tm= request.getParameter("newaccount")+encryption_result+request.getParameter("email");
		     MessageDigest digest = MessageDigest.getInstance("SHA-256");
		     byte[] hash = digest.digest(tm.getBytes());
		     StringBuilder hexString = new StringBuilder();
		     for (int i = 0; i < hash.length; i++) {
		            final String hex = Integer.toHexString(0xff & hash[i]);
		            if(hex.length() == 1) 
		              hexString.append('0');
		            hexString.append(hex);
		     }
			 String sql_tmp = "INSERT INTO USER (account,password,email,status,special_encryption) VALUES(?,?,?,?,?)";
		     int num = primaryJdbcTemplate.update(sql_tmp, request.getParameter("newaccount"),request.getParameter("newpassword"),request.getParameter("email"),0,hexString.toString());
		     if(num==1)
		     {
		        writer.print("success"); 
				writer.flush();
				writer.close(); 
		        SimpleMailMessage mailMessage= new SimpleMailMessage();
				mailMessage.setFrom("henrychen0128@gmail.com");
				mailMessage.setTo(request.getParameter("email"));
				mailMessage.setSubject("FoodpandaTest 開通通知");
				mailMessage.setText("Hi!! "+ request.getParameter("newaccount")+"\n請點擊下列連結進行開通帳號手續\nhttp://henrychenmyweb.ddns.net:8083/Validate?account="+hexString.toString());
				jms.send(mailMessage);
		    	
		     }
		   }else
		   {
		     writer.print("sameaccount"); 
			 writer.flush();
			 writer.close(); 
		   }
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/changepassword")
    public void changepassword(HttpServletRequest request,HttpServletResponse response) 
	{
	  try
	  {
		String newpass = request.getParameter("newpassword");
		String oldpass = request.getParameter("oldpassword");
		String account = request.getParameter("account");
		int num=0;
		num = primaryJdbcTemplate.update("update user set password=? where password=? and account=?",newpass,oldpass,account);
		if(num==1)
		{
		 response.setCharacterEncoding("UTF-8");
		 PrintWriter writer = response.getWriter();
         writer.print("success"); 
	     writer.flush();
	     writer.close();
		}else
		{
			response.setCharacterEncoding("UTF-8");
			PrintWriter writer = response.getWriter();
			writer = response.getWriter();
			writer.print("failure"); 
			writer.flush();
			writer.close();	
		}
	  }catch(Exception e)
	  {
		PrintWriter writer;
		try {
			writer = response.getWriter();
			writer.print("failure"); 
			writer.flush();
			writer.close();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	      
	  }
	}
	@RequestMapping("/validateccount")
    public void validate_confirm(HttpServletRequest request,HttpServletResponse response) 
	{
		try
		{
		  String sql = "UPDATE USER SET STATUS = 1 WHERE account=? AND password=? AND special_encryption=?";
		  int num =0;
          try
          {
        	  num = primaryJdbcTemplate.update(sql, request.getParameter("account"),request.getParameter("password"),request.getParameter("sha256code"));
          }catch(EmptyResultDataAccessException e)
          {
          	  
          }
          PrintWriter writer = response.getWriter();
	      response.setContentType("text/html;charset=BIG5");
          if(num==1)
          {
        	 writer.print("success"); 
 			 writer.flush();
 			 writer.close(); 
          }else
          {
        	 writer.print("failure"); 
  			 writer.flush();
  			 writer.close();  
          }
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}
