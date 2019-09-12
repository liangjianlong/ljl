<%@ page import="mapskin.manager.actions.CommonActionEnum" %>
<%@ page import="mapskin.manager.actions.CommonStatusEnum" %>
<%@ page import="mapskin.manager.dao.CommonDAO" %>
<%@ page import="mapskin.manager.entity.Userprivilege" %>
<%@ page import="mapskin.manager.entity.UserprivilegeH" %>
<%@ page import="org.apache.commons.beanutils.BeanUtils" %>
<%@ page import="org.apache.commons.beanutils.ConvertUtils" %>
<%@ page import="org.apache.commons.beanutils.Converter" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="org.codehaus.jackson.map.ObjectMapper" %>
<%@ page import="org.codehaus.jackson.map.SerializationConfig" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="mapskin.manager.util.ManagerUtility" %>


<%!
    Logger logger = Logger.getLogger(this.getClass());

%>
<%--
  Created by IntelliJ IDEA.
  User: wbz
  Date: 2015/9/11
  Time: 19:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getServletContext());
    CommonDAO commonDAO = (CommonDAO) ctx.getBean("commonDAO");
    ManagerUtility.hasPrivilege(null,null);
    ObjectMapper objectMapper = new ObjectMapper();
    objectMapper.configure(SerializationConfig.Feature.WRITE_DATES_AS_TIMESTAMPS, false);
    objectMapper.getSerializationConfig().setDateFormat(new SimpleDateFormat("yyyy年MM月dd日"));
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("success", true);
    try {
        String action = request.getParameter("action");
        if (action.equals(CommonActionEnum.list.name())) {
            String startStr = request.getParameter("start");
            String limitStr = request.getParameter("limit");
            String status = request.getParameter("status");
            int start = 0;
            int limit = Integer.MAX_VALUE;
            if (null != startStr) {
                start = Integer.parseInt(startStr);
                limit = Integer.parseInt(limitStr);
            }
            String whereClause = "select t1.id as privilegeid,t2.id,t1.name as privilegename,t1.description from Privilege t1 left join Userprivilege t2 on t1.id = t2.privilegeid and t2.userid = ? where t1.status = '有效'";
            List list = commonDAO.listBySQL(new String[]{"id","privilegeid","privilegename","description"}, true, whereClause,start,limit,Integer.parseInt(request.getParameter("userid")));
            hashMap.put("items",list);
        } else if (action.equals(CommonActionEnum.update.name()))
        {
            List<Userprivilege> userprivileges = commonDAO.list(Userprivilege.class,"from Userprivilege where userid = ?",0,Integer.MAX_VALUE,Integer.parseInt(request.getParameter("userid")));
            int id1 = new UserprivilegeH().getId();
            for(int i = 0; i < userprivileges.size();i++){
                Userprivilege userprivilege = userprivileges.get(i);
                UserprivilegeH userprivilegeH = new UserprivilegeH();
                BeanUtils.copyProperties(userprivilegeH,userprivilege);
                userprivilegeH.setUserid(userprivilege.getId());
                userprivilegeH.setId(id1);
                commonDAO.save(userprivilegeH);
                commonDAO.delete(userprivilege);
            }
            userprivileges.clear();
            String recordsStr = request.getParameter("records");
            HashMap[] jsonNode = objectMapper.readValue(recordsStr,HashMap[].class);
            for(HashMap hashMap1 : jsonNode){
                Userprivilege userprivilege = new Userprivilege();
                BeanUtils.copyProperties(userprivilege,hashMap1);
                userprivilege.setUserid(Integer.parseInt(request.getParameter("userid")));
                userprivilege.setAction(CommonActionEnum.add.toString());
                userprivilege.setStatus(CommonStatusEnum.valid.toString());
                commonDAO.save(userprivilege);
            }
        }
        else if(action.equals("listuserbyprivilege")){
            String startStr = request.getParameter("start");
            String limitStr = request.getParameter("limit");
            String status = request.getParameter("status");
            String privilegename = request.getParameter("privilegename");
            String username = request.getParameter("username");
            int start = 0;
            int limit = Integer.MAX_VALUE;
            if (null != startStr) {
                start = Integer.parseInt(startStr);
                limit = Integer.parseInt(limitStr);
            }
            String whereClause = " from userprivilege t1 left join user t2 on t1.userid = t2.id left join privilege t3 on (t1.privilegeid = t3.id) where t2.status = ? and t3.name = ?";
            String[] params = new String[]{CommonStatusEnum.valid.toString(),privilegename};
            if(StringUtils.isNotEmpty(username)){
                username = "%"+username+"%";
                whereClause += " and t2.username like ?";
                params = new String[]{CommonStatusEnum.valid.toString(),privilegename,username};
            }
            String whereClause1 = "select t2.id,t2.username,t3.name as privilegename " + whereClause;

            int count = Integer.parseInt(commonDAO.listBySQL(null,false,"select count(*) " + whereClause,0,Integer.MAX_VALUE,params).get(0).toString());
            List list = commonDAO.listBySQL(new String[]{"id","username"}, true, whereClause1,start,limit,params);
            hashMap.put("items",list);
            hashMap.put("total",count);
        }
    } catch (Exception ex) {
        logger.error(ex, ex);
        hashMap.put("success", false);
        hashMap.put("message", ex.getMessage());
    }
    String callback = request.getParameter("callback");
    if(StringUtils.isNotEmpty(callback)){
        %><%=callback%>(<%
    }
    String outputString = objectMapper.writeValueAsString(hashMap);
    %><%=outputString%><%
    if(StringUtils.isNotEmpty(callback)){
%>)<%
    }
    out.flush();
    out = pageContext.pushBody();
%>
