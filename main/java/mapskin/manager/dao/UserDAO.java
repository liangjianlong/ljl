package mapskin.manager.dao;

import java.util.List;

/**
 * Created by wbz on 2015/9/20.
 */
public class UserDAO extends CommonDAO {
    public List getUserPrivileges(int userid){
        String sql = "select t1.privilegename from userprivilege t1 where t1.userid = ?";
        List list = this.listBySQL(new String[]{},false,sql,0,Integer.MAX_VALUE,userid);
        return list;
    }
}
