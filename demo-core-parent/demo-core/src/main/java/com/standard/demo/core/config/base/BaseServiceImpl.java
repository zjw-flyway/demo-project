package com.standard.demo.core.config.base;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.function.Function;
import java.util.stream.Collectors;

import org.apache.ibatis.binding.MapperMethod;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.enums.SqlMethod;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.metadata.TableInfo;
import com.baomidou.mybatisplus.core.metadata.TableInfoHelper;
import com.baomidou.mybatisplus.core.toolkit.Assert;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.core.toolkit.GlobalConfigUtils;
import com.baomidou.mybatisplus.core.toolkit.ReflectionKit;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.toolkit.SqlHelper;

/**
 * @Description IService 实现类（ 泛型：M 是 mapper 对象，T 是实体 ， PK 是主键泛型 ）
 * @Author zhangjw
 * @Date 2020/3/5 16:29
 */
public class BaseServiceImpl<M extends BaseDataMapper<T>, T> implements IService<T> {

	@Autowired
	protected M baseMapper;

	@Override
	public M getBaseMapper() {
		return baseMapper;
	}

	/**
	 * 判断数据库操作是否成功
	 *
	 * @param result 数据库操作返回影响条数
	 * @return boolean
	 */
	protected boolean retBool(Integer result) {
		return SqlHelper.retBool(result);
	}

	protected Class<T> currentModelClass() {
		return (Class<T>) ReflectionKit.getSuperClassGenericType(getClass(), 1);
	}

	/**
	 * 批量操作 SqlSession
	 */
	protected SqlSession sqlSessionBatch() {
		return SqlHelper.sqlSessionBatch(currentModelClass());
	}

	/**
	 * 释放sqlSession
	 *
	 * @param sqlSession session
	 */
	protected void closeSqlSession(SqlSession sqlSession) {
		SqlSessionUtils.closeSqlSession(sqlSession, GlobalConfigUtils.currentSessionFactory(currentModelClass()));
	}

	/**
	 * 获取 SqlStatement
	 *
	 * @param sqlMethod ignore
	 * @return ignore
	 */
	protected String sqlStatement(SqlMethod sqlMethod) {
		return SqlHelper.table(currentModelClass()).getSqlStatement(sqlMethod.getMethod());
	}

	@Override
	public boolean save(T entity) {
		return retBool(baseMapper.insert(entity));
	}

	/**
	 * 批量插入
	 *
	 * @param entityList ignore
	 * @param batchSize  ignore
	 * @return ignore
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public boolean saveBatch(Collection<T> entityList, int batchSize) {
		String sqlStatement = sqlStatement(SqlMethod.INSERT_ONE);
		try (SqlSession batchSqlSession = sqlSessionBatch()) {
			int i = 0;
			for (T anEntityList : entityList) {
				batchSqlSession.insert(sqlStatement, anEntityList);
				if (i >= 1 && i % batchSize == 0) {
					batchSqlSession.flushStatements();
				}
				i++;
			}
			batchSqlSession.flushStatements();
		}
		return true;
	}

	/**
	 * TableId 注解存在更新记录，否插入一条记录
	 *
	 * @param entity 实体对象
	 * @return boolean
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public boolean saveOrUpdate(T entity) {
		if (null != entity) {
			Class<?> cls = entity.getClass();
			TableInfo tableInfo = TableInfoHelper.getTableInfo(cls);
			Assert.notNull(tableInfo, "error: can not execute. because can not find cache of TableInfo for entity!");
			String keyProperty = tableInfo.getKeyProperty();
			Assert.notEmpty(keyProperty, "error: can not execute. because can not find column for id from entity!");
			Object idVal = ReflectionKit.getMethodValue(cls, entity, tableInfo.getKeyProperty());
			return StringUtils.checkValNull(idVal) || Objects.isNull(getById((Serializable) idVal)) ? save(entity)
					: updateById(entity);
		}
		return false;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public boolean saveOrUpdateBatch(Collection<T> entityList, int batchSize) {
		Assert.notEmpty(entityList, "error: entityList must not be empty");
		Class<?> cls = currentModelClass();
		TableInfo tableInfo = TableInfoHelper.getTableInfo(cls);
		Assert.notNull(tableInfo, "error: can not execute. because can not find cache of TableInfo for entity!");
		String keyProperty = tableInfo.getKeyProperty();
		Assert.notEmpty(keyProperty, "error: can not execute. because can not find column for id from entity!");
		try (SqlSession batchSqlSession = sqlSessionBatch()) {
			int i = 0;
			for (T entity : entityList) {
				Object idVal = ReflectionKit.getMethodValue(cls, entity, keyProperty);
				if (StringUtils.checkValNull(idVal) || Objects.isNull(getById((Serializable) idVal))) {
					batchSqlSession.insert(sqlStatement(SqlMethod.INSERT_ONE), entity);
				} else {
					MapperMethod.ParamMap<T> param = new MapperMethod.ParamMap<>();
					param.put(Constants.ENTITY, entity);
					batchSqlSession.update(sqlStatement(SqlMethod.UPDATE_BY_ID), param);
				}
				// 不知道以后会不会有人说更新失败了还要执行插入 😂😂😂
				if (i >= 1 && i % batchSize == 0) {
					batchSqlSession.flushStatements();
				}
				i++;
			}
			batchSqlSession.flushStatements();
		}
		return true;
	}

	@Override
	public boolean removeById(Serializable id) {
		return SqlHelper.delBool(baseMapper.deleteById(id));
	}

	@Override
	public boolean removeByMap(Map<String, Object> columnMap) {
		Assert.notEmpty(columnMap, "error: columnMap must not be empty");
		return SqlHelper.delBool(baseMapper.deleteByMap(columnMap));
	}

	@Override
	public boolean remove(Wrapper<T> wrapper) {
		return SqlHelper.delBool(baseMapper.delete(wrapper));
	}

	@Override
	public boolean removeByIds(Collection<? extends Serializable> idList) {
		return SqlHelper.delBool(baseMapper.deleteBatchIds(idList));
	}

	@Override
	public boolean updateById(T entity) {
		return retBool(baseMapper.updateById(entity));
	}

	@Override
	public boolean update(T entity, Wrapper<T> updateWrapper) {
		return retBool(baseMapper.update(entity, updateWrapper));
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public boolean updateBatchById(Collection<T> entityList, int batchSize) {
		Assert.notEmpty(entityList, "error: entityList must not be empty");
		String sqlStatement = sqlStatement(SqlMethod.UPDATE_BY_ID);
		try (SqlSession batchSqlSession = sqlSessionBatch()) {
			int i = 0;
			for (T anEntityList : entityList) {
				MapperMethod.ParamMap<T> param = new MapperMethod.ParamMap<>();
				param.put(Constants.ENTITY, anEntityList);
				batchSqlSession.update(sqlStatement, param);
				if (i >= 1 && i % batchSize == 0) {
					batchSqlSession.flushStatements();
				}
				i++;
			}
			batchSqlSession.flushStatements();
		}
		return true;
	}

	@Override
	public T getById(Serializable id) {
		return baseMapper.selectById(id);
	}

	@Override
	public Collection<T> listByIds(Collection<? extends Serializable> idList) {
		return baseMapper.selectBatchIds(idList);
	}

	public Collection<T> listByIds(Collection<? extends Serializable> idList, DataScope dataScope) {
		return baseMapper.selectBatchIds(idList, dataScope);
	}

	@Override
	public Collection<T> listByMap(Map<String, Object> columnMap) {
		return baseMapper.selectByMap(columnMap);
	}

	public Collection<T> listByMap(Map<String, Object> columnMap, DataScope dataScope) {
		return baseMapper.selectByMap(columnMap, dataScope);
	}

	@Override
	public T getOne(Wrapper<T> queryWrapper, boolean throwEx) {
		if (throwEx) {
			return baseMapper.selectOne(queryWrapper);
		}
		return SqlHelper.getObject(baseMapper.selectList(queryWrapper));
	}

	public T getOne(Wrapper<T> queryWrapper, boolean throwEx, DataScope dataScope) {
		if (throwEx) {
			return baseMapper.selectOne(queryWrapper, dataScope);
		}
		return SqlHelper.getObject(baseMapper.selectList(queryWrapper, dataScope));
	}

	@Override
	public Map<String, Object> getMap(Wrapper<T> queryWrapper) {
		return SqlHelper.getObject(baseMapper.selectMaps(queryWrapper));
	}

	public Map<String, Object> getMap(Wrapper<T> queryWrapper, DataScope dataScope) {
		return SqlHelper.getObject(baseMapper.selectMaps(queryWrapper, dataScope));
	}

	@Override
	public int count(Wrapper<T> queryWrapper) {
		return SqlHelper.retCount(baseMapper.selectCount(queryWrapper));
	}

	public int count(Wrapper<T> queryWrapper, DataScope dataScope) {
		return SqlHelper.retCount(baseMapper.selectCount(queryWrapper, dataScope));
	}

	@Override
	public List<T> list(Wrapper<T> queryWrapper) {
		return baseMapper.selectList(queryWrapper);
	}

	public List<T> list(Wrapper<T> queryWrapper, DataScope dataScope) {
		return baseMapper.selectList(queryWrapper, dataScope);
	}

	@Override
	public IPage<T> page(IPage<T> page, Wrapper<T> queryWrapper) {
		return baseMapper.selectPage(page, queryWrapper);
	}

	public IPage<T> page(IPage<T> page, Wrapper<T> queryWrapper, DataScope dataScope) {
		return baseMapper.selectPage(page, queryWrapper, dataScope);
	}

	@Override
	public List<Map<String, Object>> listMaps(Wrapper<T> queryWrapper) {
		return baseMapper.selectMaps(queryWrapper);
	}

	public List<Map<String, Object>> listMaps(Wrapper<T> queryWrapper, DataScope dataScope) {
		return baseMapper.selectMaps(queryWrapper, dataScope);
	}

	@Override
	public <V> List<V> listObjs(Wrapper<T> queryWrapper, Function<? super Object, V> mapper) {
		return baseMapper.selectObjs(queryWrapper).stream().filter(Objects::nonNull).map(mapper)
				.collect(Collectors.toList());
	}

	public <V> List<V> listObjs(Wrapper<T> queryWrapper, Function<? super Object, V> mapper, DataScope dataScope) {
		return baseMapper.selectObjs(queryWrapper, dataScope).stream().filter(Objects::nonNull).map(mapper)
				.collect(Collectors.toList());
	}

	@Override
	public IPage<Map<String, Object>> pageMaps(IPage<T> page, Wrapper<T> queryWrapper) {
		return baseMapper.selectMapsPage(page, queryWrapper);
	}

	public IPage<Map<String, Object>> pageMaps(IPage<T> page, Wrapper<T> queryWrapper, DataScope dataScope) {
		return baseMapper.selectMapsPage(page, queryWrapper, dataScope);
	}
}