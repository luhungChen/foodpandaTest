package com.foodpanda.simulation.foodpandatest;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;
import Bean.Items;

public class MyRowMapper implements RowMapper<Items>{

	@Override
	public Items mapRow(ResultSet arg0, int arg1) throws SQLException {
		 int pages = arg0.getInt("pages");
		 int item_id = arg0.getInt("item_id");
		 String item_name = arg0.getString("item_name");
		 int price = arg0.getInt("price");
		 int stock = arg0.getInt("stock");
		 int pagesnumbers = arg0.getInt("pagesnumbers");
		 Items vo = new Items();
		 vo.setPages(Integer.toString(pages));
		 vo.setItem_id(Integer.toString(item_id));
		 vo.setItem_name(item_name);
		 vo.setPrice(Integer.toString(price));
		 vo.setStock(Integer.toString(stock));
		 vo.setPagesnumbers(Integer.toString(pagesnumbers));
		 return vo;
	}
}
