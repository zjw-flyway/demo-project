package com.standard.demo.web.core.dto;

import java.io.Serializable;
import java.util.List;
import java.util.Set;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

/**
 * @Description
 * @Author zhangjw
 * @Date 2020/3/31 14:47
 */
@Data
@FieldDefaults(level = AccessLevel.PACKAGE)
@ApiModel("用户信息")
public class UserDto implements Serializable {

	private static final long serialVersionUID = 1L;

	@ApiModelProperty("id")
	Integer id;

	/**
	 * 用户名
	 */
	@ApiModelProperty("用户名称")
	String username;

	/**
	 * 密码
	 */
	@ApiModelProperty("用户密码")
	String password;

	/**
	 * 昵称
	 */
	@ApiModelProperty("昵称")
	String nickname;

	/**
	 * 角色Id列表
	 */
	@ApiModelProperty("角色Id列表")
	Set<Integer> roleIdList;

	/**
	 * 角色名列表
	 */
	@ApiModelProperty("角色名称")
	Set<String> roleNameList;

	/**
	 * 角色英文名称列表
	 */
	@ApiModelProperty("角色英文名称")
	Set<String> roleEnameList;

	/**
	 * 权限列表
	 */
	@ApiModelProperty("权限列表")
	Set<String> permissionList;

	/**
	 * 菜单列表
	 */
	@ApiModelProperty("菜单列表")
	Set<String> menuList;
}
