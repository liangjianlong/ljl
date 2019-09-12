package mapskin.manager.util;

import mapskin.manager.entity.User;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.Converter;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * Created by wbz on 2015/10/9.
 */
public class ManagerUtility {
    private static Logger logger = Logger.getLogger(ManagerUtility.class.toString());

    public static void fillCreateInfo(Object dest, User user, String ip) throws Exception {
        HashMap<String, Object> createInfoHashMap = new HashMap<String, Object>();
        createInfoHashMap.put("createuserid", user.getId());
        createInfoHashMap.put("createtime", new Timestamp(new Date().getTime()));
        createInfoHashMap.put("createusercompany", user.getCompany());
        createInfoHashMap.put("createuserip", ip);
        createInfoHashMap.put("createusername", user.getUsername());
        createInfoHashMap.put("createusermobile", user.getMobile());
        BeanUtils.populate(dest, createInfoHashMap);
    }
    public static boolean hasPrivilege(List<String> privileges,String privilege){
        return privileges!=null && privileges.contains(privilege);
    }
    static {
        ConvertUtils.register(ConvertCustom.dateConverter, Timestamp.class);
        ConvertUtils.register(ConvertCustom.dateConverter, java.sql.Date.class);
        ConvertUtils.register(ConvertCustom.dateConverter, Integer.class);
        ConvertUtils.register(ConvertCustom.dateConverter, Double.class);
    }
}

class ConvertCustom{
    private static Logger logger = Logger.getLogger(ConvertCustom.class.toString());

    public static Converter dateConverter = new Converter() {
        @Override
        public Object convert(Class type, Object value) {
            if (value == null) {
                return null;
            }
            if (type.equals(Integer.class)) {
                if (StringUtils.isEmpty(value.toString())) {
                    return null;
                } else {
                    return Integer.parseInt(value.toString());
                }
            }
            if (type.equals(Timestamp.class) || type.equals(Date.class) || type.equals(java.sql.Date.class)) {
                if (value instanceof Timestamp || value instanceof Date) {
                    return value;
                }

                if (value.equals("")) {
                    return null;
                }
                //自定义时间的格式为yyyy-MM-dd
                SimpleDateFormat sdf = null;
                sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
                if(value.toString().contains("年"))
                    sdf = new SimpleDateFormat("yyyy年MM月dd日");

                //创建日期类对象
                Date dt = null;

                try {
                    //使用自定义日期的格式转化value参数为yyyy-MM-dd格式
                    if (value instanceof Date) {
                        dt = (Date) value;
                    } else {
                        dt = sdf.parse((String) value);
                    }
                    logger.info(dt);
                    if (type.equals(Timestamp.class)) {
                        Timestamp date = new Timestamp(dt.getTime());
                        return date;
                    } else if (type.equals(Date.class)) {
                        Date date = new Date(dt.getTime());
                        return date;
                    }
                    else if (type.equals(java.sql.Date.class)) {
                        java.sql.Date date = new java.sql.Date(dt.getTime());
                        return date;
                    }

                } catch (ParseException e) {
                    logger.error(e, e);
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
                //返回dt日期对象
                return dt;
            }
            return value;
        }
    };
}
