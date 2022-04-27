package com.foodpanda.simulation.foodpandatest;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;
import Bean.Items;
import Bean.order_items;
import Bean.orders;

public class MyRowMapper3 implements RowMapper<order_items>{

	@Override
	public order_items mapRow(ResultSet arg0, int arg1) throws SQLException {
		 
		 String item_name = arg0.getString("item_name");
		 String number = arg0.getString("number");
		 String price = arg0.getString("price");
		 order_items vo = new order_items();
		 vo.setItem_name(item_name);
		 vo.setNumber(number);
		 vo.setPrice(price);
		 return vo;
	}
}
