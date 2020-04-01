package com.standard.demo.core.config.redis;

import java.util.HashSet;
import java.util.Set;

import org.apache.commons.pool2.impl.GenericObjectPoolConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import redis.clients.jedis.HostAndPort;
import redis.clients.jedis.JedisCluster;

/**
 * @Description redis配置文件
 * @Author zhangjw
 * @Date 2019/8/19 20:08
 */
@Configuration
public class RedisConfiguration {

	@Autowired
	private RedisConfigurationProperties redisConfigurationProperties;

	@Bean
	public JedisCluster jedisCluster() {
		Set<HostAndPort> nodeSet = new HashSet<>();
		for (String node : redisConfigurationProperties.getNodes()) {
			String[] split = node.split(":");
			nodeSet.add(new HostAndPort(split[0], Integer.valueOf(split[1])));
		}

		GenericObjectPoolConfig genericObjectPoolConfig = new GenericObjectPoolConfig();
		genericObjectPoolConfig.setMaxIdle(Integer.parseInt(redisConfigurationProperties.getMaxIdle()));
		genericObjectPoolConfig.setMaxTotal(Integer.parseInt(redisConfigurationProperties.getMaxTotal()));
		genericObjectPoolConfig.setMaxWaitMillis(Integer.parseInt(redisConfigurationProperties.getMaxWait()));
		genericObjectPoolConfig.setTestOnBorrow(true);
		return new JedisCluster(nodeSet);
	}
}
