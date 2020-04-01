package com.standard.demo.core.config.base;

import java.util.HashMap;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @Description 数据权限
 * @Author zhangjw
 * @Date 2020/3/5 16:33
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class DataScope extends HashMap {

	/**
	 * 限制范围的字段名称
	 */
	private String scopeName;

	/**
	 * 具体的数据范围
	 */
	private List<Integer> scopeList;

	/**
	 * 是否只查询本用户
	 */
	private Boolean isOnly = false;

}
