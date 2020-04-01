package com.standard.demo.provider.two.imp.apiImp;

import com.standard.demo.provider.two.api.api.DemoTwoApi;
import org.apache.dubbo.config.annotation.Service;

/**
 * @Description
 * @Author zhangjw
 * @Date 2020/3/27 12:05
 */
//此处的service是dubbo的service不是spring的
@Service(version = "${dubbo.version}")
public class DemoApiTwoImp implements DemoTwoApi {

	@Override
	public String sayHello(String name) {
		return "DemoTwo " + name;
	}
}
