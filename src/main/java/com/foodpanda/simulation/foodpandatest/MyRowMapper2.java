package com.foodpanda.simulation.foodpandatest;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;
import Bean.Items;
import Bean.orders;

public class MyRowMapper2 implements RowMapper<orders>{

	@Override
	public orders mapRow(ResultSet arg0, int arg1) throws SQLException {
		 
		 String user = arg0.getString("user");
		 String order_no = arg0.getString("order_no");
		 String date_time = arg0.getString("date_time");
		 String total_price = arg0.getString("total_price");
		 orders vo = new orders();
		 vo.setUser(user);
		 vo.setOrder_no(order_no);
		 vo.setDate_time(date_time);
		 vo.setTotal_price(total_price);
		 return vo;
	}
}
