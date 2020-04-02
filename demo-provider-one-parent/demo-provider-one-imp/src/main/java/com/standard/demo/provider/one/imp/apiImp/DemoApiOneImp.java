package com.standard.demo.provider.one.imp.apiImp;

import org.apache.dubbo.config.annotation.Reference;
import org.apache.dubbo.config.annotation.Service;
import org.springframework.cache.annotation.Cacheable;

import com.standard.demo.provider.one.api.api.DemoOneApi;
import com.standard.demo.provider.two.api.api.DemoTwoApi;

import lombok.extern.slf4j.Slf4j;

/**
 * @Description
 * @Author zhangjw
 * @Date 2020/3/27 12:05
 */
//此处的service是dubbo的service不是spring的
@Service(version = "${dubbo.version}")
@Slf4j
public class DemoApiOneImp implements DemoOneApi {

	@Reference(version = "${dubbo.version}")
	private DemoTwoApi demoTwoApi;

	@Override
	public String sayHello(String name) {
		return "DemoOne " + name + ";" + demoTwoApi.sayHello(name);
	}

	@Cacheable(value = "demoCache")
	public String demoCache(String name) {
		log.info("进入name了：{}", name);
		return name;
	}
}
