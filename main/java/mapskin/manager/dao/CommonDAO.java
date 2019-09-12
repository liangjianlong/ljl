package mapskin.manager.dao;

import org.codehaus.jackson.map.ObjectMapper;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by wbz on 2014/11/20.
 */
public class CommonDAO extends HibernateDaoSupport {
    /***
     * 列表
     * @param entityClass
     * @param whereClause
     * @param startnow
     * @param pagesize
     * @param params
     * @param <T>
     * @return
     */
    public <T> List<T> list(final Class<T> entityClass,final String whereClause,final int startnow,final int pagesize,final Object... params){
        List list = getHibernateTemplate().executeFind(new HibernateCallback() {
            public Object doInHibernate(Session session) throws HibernateException, SQLException {
                Query query = session.createQuery(whereClause);
                for(int i = 0; i < params.length;i++){
                    query.setParameter(i,params[i]);
                }
                query.setFirstResult(startnow);
                query.setMaxResults(pagesize);
                List list = query.list();
                return list;
            }
        });
        return list;
    }
    /***
     * 列表
     *
     * @param toEntityMap
     * @param whereClause
     * @param startnow
     * @param pagesize
     * @param params
     * @return
     */
    public List listBySQL(final String[] scalars, final boolean toEntityMap, final String whereClause, final int startnow, final int pagesize, final Object... params){
        List list = getHibernateTemplate().executeFind(new HibernateCallback() {
            public Object doInHibernate(Session session) throws HibernateException, SQLException {
                SQLQuery sqlQuery = session.createSQLQuery(whereClause);
                for(int i = 0;scalars != null && i < scalars.length;i++){
                    sqlQuery = sqlQuery.addScalar(scalars[i]);
                }
                Query query = sqlQuery;
                if(toEntityMap)
                    query = sqlQuery.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
                for(int i = 0; i < params.length;i++){
                    query.setParameter(i,params[i]);
                }
                query.setFirstResult(startnow);
                query.setMaxResults(pagesize);
                List list = query.list();
                return list;
            }
        });
        return list;
    }

    public void execute(final String sql, final Object...params){
        getHibernateTemplate().execute(new HibernateCallback() {
            public Object doInHibernate(Session session) throws HibernateException, SQLException {
                Query query = session.createSQLQuery(sql).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
                for (int i = 0; i < params.length; i++) {
                    query.setParameter(i, params[i]);
                }
                List list = query.list();
                return list;
            }
        });
    }
    /***
     * 获取
     * @param entityClass
     * @param id
     * @param <T>
     * @return
     */
    public <T> T get(final Class<T> entityClass, Serializable id){
        return getHibernateTemplate().get(entityClass,id);
    }

    /***
     * 计数
     * @param entityClass
     * @param whereClause
     * @param params
     * @param <T>
     * @return
     */
    public <T> int count(final Class<T> entityClass,String whereClause,Object... params){
        logger.debug(params);
        int i =  ((Long)getHibernateTemplate().find(whereClause,params).listIterator().next()).intValue();
        return i;
    }
    /***
     * 计数
     * @param entityClass
     * @param whereClause
     * @param params
     * @param <T>
     * @return
     */
    public <T> int countBySQL(final Class<T> entityClass,String whereClause,Object... params){
        logger.debug(params);
        int i =  ((Long)getHibernateTemplate().find(whereClause,params).listIterator().next()).intValue();
        return i;
    }

    /***
     * 保存
     * @param entity
     * @return
     */
    public Object save(Object entity) throws Exception{
        Serializable serializable = this.getHibernateTemplate().save(entity);
        Object object = this.getHibernateTemplate().get(entity.getClass(),serializable);
        return object;
    }

    /***
     * 更新
     * @param entity
     * @return
     */
    public boolean update(Object entity){
        try {
            this.getHibernateTemplate().update(entity);
            this.getHibernateTemplate().flush();
            return true;
        }
        catch(Exception ex){
            logger.error(this,ex);
            return false;
        }
    }
    public boolean delete(Object entity){
        try {
            this.getHibernateTemplate().delete(entity);
            this.getHibernateTemplate().flush();
            return true;
        }
        catch(Exception ex){
            logger.error(this,ex);
            return false;
        }
    }
}
