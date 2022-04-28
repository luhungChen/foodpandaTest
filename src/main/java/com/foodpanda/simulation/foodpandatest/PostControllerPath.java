package com.foodpanda.simulation.foodpandatest;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import Bean.Items;
import Bean.index;
import Bean.orders;
import io.lettuce.core.RedisClient;
import io.lettuce.core.api.StatefulRedisConnection;


@Controller
public class PostControllerPath 
{
	@Autowired
	private JdbcTemplate primaryJdbcTemplate;
	
	@RequestMapping("/Login")
    public String Login(HttpServletRequest request,HttpServletResponse response) 
	{
		/*RedisClient redisClient = RedisClient.create("redis://192.168.0.99");
		StatefulRedisConnection<String, String> connection = redisClient.connect();

		System.out.println("Connected to Redis");
		connection.async().set("key", "Hello World");

		connection.close();
		redisClient.shutdown();*/
		
		return "Login";
	}
	
	@RequestMapping("/Homepage")
    public String Login_confirm(HttpServletRequest request,HttpServletResponse response) 
	{
		if(request.getParameter("change")==null)
		{
		  DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		  RedisClient redisClient = RedisClient.create("redis://192.168.0.99");
		  StatefulRedisConnection<String, String> connection = redisClient.connect();
		  connection.async().set(dtf.format(LocalDateTime.now()),request.getRemoteAddr()+"_"+request.getHeader("user-agent"));
		  index.index++;
		  connection.close();
		  redisClient.shutdown();
		}
		
		HttpSession session = request.getSession();
		List <Items> l=  primaryJdbcTemplate.query("select a.pages,a.item_id,a.item_name,a.price,a.stock,b.pagesnumbers from mydata.items a,(select max(pages) pagesnumbers from mydata.items) b Where a.pages=1 and class=1", new MyRowMapper());
		session.setAttribute("Items",l);
		session.setAttribute("Maxpage",Integer.valueOf(l.get(0).getPagesnumbers()));
		session.setAttribute("NowIndex",1);
		session.setAttribute("NowClass",1);
		session.setAttribute("account",request.getParameter("account"));
		return "Homepage";
	}
	
	@RequestMapping("/direct_pages")
    public String direct_pages(HttpServletRequest request,HttpServletResponse response) 
	{
		/*RedisClient redisClient = RedisClient.create("redis://192.168.0.99");
		StatefulRedisConnection<String, String> connection = redisClient.connect();

		System.out.println("Connected to Redis");
		connection.async().set("key", "Hello World");

		connection.close();
		redisClient.shutdown();*/
		HttpSession session = request.getSession();
		List <Items> l=  primaryJdbcTemplate.query("select a.pages,a.item_id,a.item_name,a.price,a.stock,b.pagesnumbers from mydata.items a,(select max(pages) pagesnumbers from mydata.items Where class="+request.getParameter("classes")+") b Where a.pages="+request.getParameter("pagenum")+" and class="+request.getParameter("classes"), new MyRowMapper());
		session.setAttribute("Items",l);
		if(l.size()>0)
		  session.setAttribute("Maxpage",Integer.valueOf(l.get(0).getPagesnumbers()));
		else
		  session.setAttribute("Maxpage",0);
		session.setAttribute("NowIndex",Integer.valueOf(request.getParameter("pagenum")));
		session.setAttribute("NowClass",Integer.valueOf(request.getParameter("classes")));
		return "Homepage";
	}
	
	@RequestMapping("/Order")
    public String order(HttpServletRequest request,HttpServletResponse response) 
	{
		/*RedisClient redisClient = RedisClient.create("redis://192.168.0.99");
		StatefulRedisConnection<String, String> connection = redisClient.connect();

		System.out.println("Connected to Redis");
		connection.async().set("key", "Hello World");

		connection.close();
		redisClient.shutdown();*/
		HttpSession session = request.getSession();
		List <orders> l=  primaryJdbcTemplate.query("SELECT * FROM order_header", new MyRowMapper2());
		session.setAttribute("ordersdata",l);
		session.setAttribute("log_account",request.getParameter("log_account"));
		return "Order";
	}
	
	@RequestMapping("/Changepassword")
    public String changepassword(HttpServletRequest request,HttpServletResponse response) 
	{
		/*RedisClient redisClient = RedisClient.create("redis://192.168.0.99");
		StatefulRedisConnection<String, String> connection = redisClient.connect();

		System.out.println("Connected to Redis");
		connection.async().set("key", "Hello World");

		connection.close();
		redisClient.shutdown();*/
		HttpSession session = request.getSession();
		session.setAttribute("log_account",request.getParameter("account"));
		return "Changepassword";
	}
	@RequestMapping("/Register")
    public String Register(HttpServletRequest request,HttpServletResponse response) 
	{
		/*RedisClient redisClient = RedisClient.create("redis://192.168.0.99");
		StatefulRedisConnection<String, String> connection = redisClient.connect();

		System.out.println("Connected to Redis");
		connection.async().set("key", "Hello World");

		connection.close();
		redisClient.shutdown();*/
		HttpSession session = request.getSession();
		session.setAttribute("log_account",request.getParameter("account"));
		return "Register";
	}
	@GetMapping("/Validate")
    public String Validate(HttpServletRequest request,String account) 
	{
		if(account.equals("")||account.length()!=64)
		{
			return "Forbidden";
		}
		HttpSession session = request.getSession();
		session.setAttribute("sha256code", account);
        return "Validate";
    }
}
