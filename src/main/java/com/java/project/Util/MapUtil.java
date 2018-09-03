package com.java.project.Util;

import java.util.HashMap;
import java.util.Map;

public class MapUtil {
	// 파라미터 sql : 검색할메소드 (selectOne,selectList,update 등)  ,sqlType : xml에서 찾을 문 user.select 등
	public static Map<String, Object> makeParam(String sql, String sqlType){
		HashMap<String, Object>param = new HashMap<String,Object>();
		param.put("sql", sql);
		param.put("sqlType", sqlType);
		return param;
	}
}
