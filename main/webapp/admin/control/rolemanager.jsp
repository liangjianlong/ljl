<%@ page import="mapskin.manager.actions.CommonActionEnum" %>
<%@ page import="mapskin.manager.dao.CommonDAO" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="mapskin.manager.entity.Role" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.beanutils.BeanUtils" %>
<%@ page import="mapskin.manager.actions.CommonStatusEnum" %>
<%@ page import="org.apache.commons.beanutils.ConvertUtils" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="org.apache.commons.beanutils.Converter" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.sql.Date" %>
<%@ page import="org.codehaus.jackson.map.ObjectMapper" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="org.codehaus.jackson.map.SerializationConfig" %>
<%@ page import="mapskin.manager.entity.RoleH" %>
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
    HashMap<String,Object> hashMap = new HashMap<String,Object>();
    hashMap.put("success", true);
    try{
        String action = request.getParameter("action");
        if(action.equals(CommonActionEnum.list.name())){
            String startStr = request.getParameter("start");
            String limitStr = request.getParameter("limit");
            String status = request.getParameter("status");
            int start = 0;
            int limit = Integer.MAX_VALUE;
            if (null != startStr) {
                start = Integer.parseInt(startStr);
                limit = Integer.parseInt(limitStr);
            }
            String whereClause = "from Role where 1 = 1 ";
            int count = commonDAO.count(Role.class,"select count(*) " + whereClause);
            List<Role> users = commonDAO.list(Role.class,whereClause,start,limit);

            hashMap.put("total",count);
            hashMap.put("items",users);
        }
        else if(action.equals(CommonActionEnum.view.name())){
        }
        else if(action.equals(CommonActionEnum.add.name())){
            Role Role = new Role();
            BeanUtils.populate(Role,request.getParameterMap());
            Role.setStatus(CommonStatusEnum.valid.toString());
            Role.setAction(CommonActionEnum.add.toString());
            commonDAO.save(Role);
        }
        else if(action.equals(CommonActionEnum.delete.name())){
            //更新用户
            Role Role1 = commonDAO.get(Role.class,Integer.parseInt(request.getParameter("id")));
            Role1.setStatus(CommonStatusEnum.invalid.toString());
            Role1.setAction(CommonActionEnum.delete.toString());
            commonDAO.update(Role1);
            //插入用户更新历史
            RoleH RoleH = new RoleH();
            int id = RoleH.getId();
            BeanUtils.copyProperties(RoleH,Role1);
            RoleH.setId(id);
            RoleH.setRoleid(Role1.getId());
            commonDAO.save(RoleH);
        }
        else if(action.equals(CommonActionEnum.restore.name())){
            //更新用户
            Role Role1 = commonDAO.get(Role.class,Integer.parseInt(request.getParameter("id")));
            Role1.setStatus(CommonStatusEnum.valid.toString());
            Role1.setAction(CommonActionEnum.restore.toString());
            commonDAO.update(Role1);
            //插入用户更新历史
            RoleH RoleH = new RoleH();
            int id = RoleH.getId();
            BeanUtils.copyProperties(RoleH,Role1);
            RoleH.setId(id);
            RoleH.setRoleid(Role1.getId());
            commonDAO.save(RoleH);
        }
        else if(action.equals(CommonActionEnum.update.name())){
            //更新用户
            Role Role1 = commonDAO.get(Role.class,Integer.parseInt(request.getParameter("id")));
            BeanUtils.populate(Role1,request.getParameterMap());
            Role1.setAction(CommonActionEnum.update.toString());
            commonDAO.update(Role1);
            //插入用户更新历史
            RoleH RoleH = new RoleH();
            int id = RoleH.getId();
            BeanUtils.copyProperties(RoleH,Role1);
            RoleH.setId(id);
            RoleH.setRoleid(Role1.getId());
            commonDAO.save(RoleH);
        }
    }
    catch (Exception ex){
        logger.error(ex,ex);
        hashMap.put("success",false);
        hashMap.put("message",ex.getMessage());
    }
    objectMapper.writeValue(out,hashMap);
    out.flush();
    out = pageContext.pushBody();
%>
