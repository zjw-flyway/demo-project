package com.standard.demo.web.core.utils;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;

import com.standard.demo.core.constant.CommonConstants;
import com.standard.demo.web.core.dto.UserDto;

/**
 * @Description 用户工具类
 * @Author zhangjw
 * @Date 2020/3/17 17:51
 */
public class UserUtils {

	/**
	 * 获得当前登录人
	 * 
	 * @return
	 */
	public static UserDto getUser() {
		// 从session获取用户信息
		Session session = SecurityUtils.getSubject().getSession();
		UserDto userInfo = (UserDto) session.getAttribute(CommonConstants.SESSION_USER_INFO);
		return userInfo;
	}

	/**
	 * 得到当前登录人的Id
	 * 
	 * @return
	 */
	public static Integer getCurrentUserId() {
		return getUser().getId();
	}

	/**
	 * 对密码进行加密
	 * 
	 * @return
	 */
	public static String encrytPassword(String password) {
		// 加密方式
		String hashAlgorithmName = "MD5";
		// 加密次数
		int hashIterations = 2;
		SimpleHash result = new SimpleHash(hashAlgorithmName, password, null, hashIterations);
		return result.toString();
	}

	public static void main(String[] args) {
		System.out.println(encrytPassword("123456"));
	}
}
