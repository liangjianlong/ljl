<%@ page import="mapskin.manager.actions.CommonActionEnum" %>
<%@ page import="mapskin.manager.actions.CommonStatusEnum" %>
<%@ page import="mapskin.manager.dao.CommonDAO" %>
<%@ page import="mapskin.manager.dao.UserDAO" %>
<%@ page import="mapskin.manager.entity.User" %>
<%@ page import="mapskin.manager.entity.UserH" %>
<%@ page import="mapskin.manager.login.LoginUsers" %>
<%@ page import="mapskin.manager.mail.EmailUtility" %>
<%@ page import="org.apache.commons.beanutils.BeanUtils" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="org.codehaus.jackson.map.ObjectMapper" %>
<%@ page import="org.codehaus.jackson.map.SerializationConfig" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.UUID" %>
<%@ page import="org.codehaus.jackson.JsonNode" %>
<%@ page import="org.apache.http.impl.client.DefaultHttpClient" %>
<%@ page import="org.apache.http.client.ResponseHandler" %>
<%@ page import="org.apache.http.client.HttpClient" %>
<%@ page import="org.apache.http.impl.client.BasicResponseHandler" %>
<%@ page import="org.apache.http.client.methods.HttpGet" %>


<%!
    Logger logger = Logger.getLogger(this.getClass());
    private void insertLog(CommonDAO commonDAO,User user) throws Exception{
        UserH userH = new UserH();
        BeanUtils.copyProperties(userH, user);
        userH.setUserid(user.getId());
        commonDAO.save(userH);
    }
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
    UserDAO userDAO = (UserDAO) ctx.getBean("userDAO");

    ObjectMapper objectMapper = new ObjectMapper();
    objectMapper.configure(SerializationConfig.Feature.WRITE_DATES_AS_TIMESTAMPS, false);
    objectMapper.getSerializationConfig().setDateFormat(new SimpleDateFormat("yyyy年MM月dd日"));
    HashMap<String,Object> hashMap = new HashMap<String,Object>();
    boolean success = true;
    String message = "";
    hashMap.put("success",success);
    hashMap.put("message","");
    User loginuser = (User)session.getAttribute("user");
    List privileges = (List) session.getAttribute("privileges");
    boolean isAdmin = mapskin.manager.util.ManagerUtility.hasPrivilege(privileges, "用户管理");
    try{
        String actionStr = request.getParameter("action");
        CommonActionEnum action = CommonActionEnum.valueOf(actionStr);
        if(action == null){
            action = CommonActionEnum.unknow;
        }
        //列出用户
        if(action.equals(CommonActionEnum.list)){
            String startStr = request.getParameter("start");
            String limitStr = request.getParameter("limit");
            String keywords = request.getParameter("keywords");
            int start = 0;
            int limit = Integer.MAX_VALUE;
            if (null != startStr) {
                start = Integer.parseInt(startStr);
                limit = Integer.parseInt(limitStr);
            }
            String whereClause = "from User where 1 = 1 ";
            if(StringUtils.isNotEmpty(keywords)){
                whereClause += " and (loginname like '%"+keywords+"%' or ";
                whereClause += " username like '%"+keywords+"%' or ";
                whereClause += " division like '%"+keywords+"%' or ";
                whereClause += " company like '%"+keywords+"%' or ";
                whereClause += " mobile like '%"+keywords+"%' or ";
                whereClause += " fax like '%"+keywords+"%' or ";
                whereClause += " tel like '%"+keywords+"%' or ";
                whereClause += " qq like '%"+keywords+"%'";
                whereClause += ")";
            }
            whereClause += " order by status desc,id desc";
            int count = commonDAO.count(User.class,"select count(*) "+whereClause);
            List<User> users = commonDAO.list(User.class, whereClause, start, limit);
            for(int i = 0; i < users.size();i++){
                users.get(i).setPassword("");
            }
            hashMap.put("total", count);
            hashMap.put("items",users);
        }
        else if(action.equals(CommonActionEnum.getbyopenid)){
            List<User> users = commonDAO.list(User.class,"from User where qq = '"+request.getParameter("openid")+"'",0,1);
            if(users.size()==1){
                hashMap.put("user", users.get(0));
            }
        }
        //查询用户信息
        else if(action.equals(CommonActionEnum.view)){
            User user = commonDAO.get(User.class,Integer.parseInt(request.getParameter("id")));
            user.setPassword("");
            hashMap.put("user", user);
            hashMap.put("data", user);
        }
        //修改用户密码
        else if(action.equals(CommonActionEnum.changepassword)){
            User user = (User)session.getAttribute("user");
            if(user == null){
                message = "您尚未登录，不能修改密码!";
                success = false;
            }
            else {
                int userid = user.getId();
                user = commonDAO.get(User.class,userid);
                if (user.getPassword().equals(request.getParameter("oldpassword"))) {
                    String password = request.getParameter("password");
                    if (password.length() > 10 || password.length() < 6 || !StringUtils.isAlphanumeric(password)) {
                        success = false;
                        message = "密码不符合规则！";
                    } else {
                        user.setPassword(password);
                        mapskin.manager.util.ManagerUtility.fillCreateInfo(user, user, request.getRemoteHost());
                        user.setAction(action.toString());
                        commonDAO.update(user);
                        insertLog(commonDAO,user);
                        success = true;
                    }
                } else {
                    success = false;
                    message = "原始密码输入错误！";
                    hashMap.put("success", success);
                    hashMap.put("message", message);
                }
            }
        }
        else if(action.equals(CommonActionEnum.forgetpassword)){
            List<User> users = commonDAO.list(User.class,"from User where email = ?",0,1,request.getParameter("email"));
            if(users.size() == 1){
                User user = users.get(0);
                mapskin.manager.util.ManagerUtility.fillCreateInfo(user, user, request.getRemoteHost());
                user.setAction(action.toString());
                commonDAO.update(user);
                insertLog(commonDAO,user);
                EmailUtility.sendTextEmail("找回密码",user.getUsername() + ":您的用户名是 " + user.getLoginname() + " ，您的密码是 " + user.getPassword(),user.getEmail());
                success = true;
                message = "密码已经发送到您的信箱，请查收并及时修改密码！";
            }
            else{
                success = false;
                message = "您的email尚未注册，请注册！";
            }
        }
        else if(action.equals(CommonActionEnum.add)) {
            User user = new User();
            BeanUtils.populate(user, request.getParameterMap());
            if (user.getLoginname().length() > 10 || user.getLoginname().length() < 3 || !StringUtils.isAlphanumeric(user.getLoginname())) {
                success = false;
                message = "登录名只能包含数字和字母,最长不超过10个字符，最短不少于3个字符！";
            }
            else{
                user.setStatus(CommonStatusEnum.valid.toString());
                user.setAction(CommonActionEnum.add.toString());
                String loginname = user.getLoginname();
                if(commonDAO.list(User.class," from User where loginname = ? or email = ?",0,1,loginname, user.getEmail()).size() == 0){
                    mapskin.manager.util.ManagerUtility.fillCreateInfo(user, user, request.getRemoteHost());
                    User user1 = (User)commonDAO.save(user);
                    insertLog(commonDAO,user);
                    hashMap.put("user", user1);
                    success = true;
                }
                else{
                    success = false;
                    message = "登录名或注册信箱已被使用！";
                }
            }
        }
        else if(action.equals(CommonActionEnum.delete)){
            //更新用户
            User user = commonDAO.get(User.class, Integer.parseInt(request.getParameter("id")));
            user.setStatus(CommonStatusEnum.invalid.toString());
            user.setAction(CommonActionEnum.delete.toString());
            mapskin.manager.util.ManagerUtility.fillCreateInfo(user, user, request.getRemoteHost());
            commonDAO.update(user);
            insertLog(commonDAO,user);
            success = true;
        }
        else if(action.equals(CommonActionEnum.restore)){
            //更新用户
            User user = commonDAO.get(User.class,Integer.parseInt(request.getParameter("id")));
            user.setStatus(CommonStatusEnum.valid.toString());
            user.setAction(CommonActionEnum.restore.toString());
            mapskin.manager.util.ManagerUtility.fillCreateInfo(user, user, request.getRemoteHost());
            commonDAO.update(user);
            insertLog(commonDAO,user);
            success = true;
        }
        else if(action.equals(CommonActionEnum.update)){
            //更新用户
            User user = commonDAO.get(User.class,Integer.parseInt(request.getParameter("id")));
            String password = user.getPassword();
            String loginname = user.getLoginname();
            BeanUtils.populate(user,request.getParameterMap());
            String email = user.getEmail();
            if(commonDAO.list(User.class," from User where email = ? and loginname <> ?",0,1,email,loginname).size() == 0){
                user.setAction(CommonActionEnum.update.toString());
                user.setPassword(password);
                user.setLoginname(loginname);
                mapskin.manager.util.ManagerUtility.fillCreateInfo(user, user, request.getRemoteHost());
                commonDAO.update(user);
                insertLog(commonDAO,user);
                success = true;
                hashMap.put("user",user);
                hashMap.put("data",user);
            }
            else{
                success = false;
                message = "信箱已被占用！";
            }

        }
        else if(action.equals(CommonActionEnum.updateopenid)){
            User user = commonDAO.get(User.class,Integer.parseInt(request.getParameter("id")));
            user.setQq(request.getParameter("openid"));
            commonDAO.update(user);
            hashMap.put("user",user);
        }
        else if(action.equals(CommonActionEnum.getuserprivileges)){
            String idStr = request.getParameter("userid");
            String sql = "select t1.privilegename from userprivilege t1 where t1.userid = ?";
            List list = commonDAO.listBySQL(new String[]{},false,sql,0,Integer.MAX_VALUE,Integer.parseInt(idStr));
            hashMap.put("items",list);
        }
        else if(action.equals(CommonActionEnum.login)){
            String loginname = request.getParameter("loginname");
            String password = request.getParameter("password");
            List<User> users = userDAO.list(User.class, "from User where loginname = ?", 0, 1, loginname);
            boolean islogin = false;
            if (users != null && users.size() == 1) {
                User user = users.get(0);
                if (user.getPassword().equals(password)) {
                    islogin = true;
                    User user1 = (User) session.getAttribute("user");
                    if (user1 == null || !user1.getLoginname().equals(user.getLoginname())) {
                        session.setAttribute("user", user);
                        session.setAttribute("privileges",userDAO.getUserPrivileges(user.getId()));
                        String uuid = UUID.randomUUID().toString();
                        session.setAttribute("token", uuid);
                        Cookie cookie = new Cookie("token", uuid);
                        cookie.setMaxAge(Integer.MAX_VALUE);
                        response.addCookie(cookie);
                        LoginUsers.addUser(uuid,user);
                    }
                    else{

                    }
                    if(StringUtils.isNotEmpty(request.getParameter("x"))
                            && StringUtils.isNotEmpty(request.getParameter("y"))
                            && StringUtils.isNotEmpty(request.getParameter("imei"))){
                        user.setX(Double.parseDouble(request.getParameter("x")));
                        user.setY(Double.parseDouble(request.getParameter("y")));
                        user.setImei(request.getParameter("imei"));
                        HttpClient webClient = new DefaultHttpClient();
                        ResponseHandler<?> responseHandler = new BasicResponseHandler();
                        String res = (String)webClient.execute(new HttpGet("http://api.map.baidu.com/geoconv/v1/?coords="+user.getX()+","+user.getY()+"&from=1&to=5&ak=FDab7e962dc40944d91ad376d92ffff4"),responseHandler);
                        JsonNode jsonNode = objectMapper.readTree(res);
                        String x1 = jsonNode.get("result").get(0).get("x").getValueAsText();
                        String y1 = jsonNode.get("result").get(0).get("y").getValueAsText();
                        HashMap<String,String> xy = new HashMap<String, String>();
                        xy.put("x1",x1);
                        xy.put("y1",y1);
                        BeanUtils.populate(user,xy);
                    }
                    mapskin.manager.util.ManagerUtility.fillCreateInfo(user, user, request.getRemoteHost());
                    commonDAO.update(user);
                    insertLog(commonDAO,user);
                }
            }
            if (!islogin) {
                success = false;
                message = "尚未登录";
                hashMap.put("user", "");
                hashMap.put("token", "");
            } else {
                success = true;
                hashMap.put("user", session.getAttribute("user"));
                hashMap.put("token", session.getAttribute("token"));
            }
        }
        else if(action.equals(CommonActionEnum.logout)){
            LoginUsers.removeUser(session.getAttribute("token").toString());
            session.removeAttribute("user");
            session.removeAttribute("token");
            success = true;
            User user = commonDAO.get(User.class,loginuser.getId());
            if(StringUtils.isNotEmpty(request.getParameter("x"))
                    && StringUtils.isNotEmpty(request.getParameter("y"))
                    && StringUtils.isNotEmpty(request.getParameter("imei"))){
                user.setX(Double.parseDouble(request.getParameter("x")));
                user.setY(Double.parseDouble(request.getParameter("y")));
                user.setImei(request.getParameter("imei"));
            }
            mapskin.manager.util.ManagerUtility.fillCreateInfo(user, user, request.getRemoteHost());
            user.setAction(action.toString());
            commonDAO.update(loginuser);
            insertLog(commonDAO,loginuser);
            hashMap.put("user", "");
            hashMap.put("token", "");
        }
        else if(action.equals(CommonActionEnum.validate)){
            String token = request.getParameter("token");
            User user = LoginUsers.getUser(token);
            if (user != null) {
                success = true;
                user = commonDAO.get(User.class,user.getId());
                user.setPassword("");
                hashMap.put("user", user);
                hashMap.put("token", token);
                hashMap.put("privileges",userDAO.getUserPrivileges(user.getId()));
            } else {
                success = false;
                hashMap.put("user", "");
                hashMap.put("token", "");
            }
            if(user != null) {
                user = commonDAO.get(User.class,user.getId());
                if(StringUtils.isNotEmpty(request.getParameter("x"))
                        && StringUtils.isNotEmpty(request.getParameter("y"))
                        && StringUtils.isNotEmpty(request.getParameter("imei"))){
                    user.setX(Double.parseDouble(request.getParameter("x")));
                    user.setY(Double.parseDouble(request.getParameter("y")));
                    user.setImei(request.getParameter("imei"));
                }
                mapskin.manager.util.ManagerUtility.fillCreateInfo(user, user, request.getRemoteHost());
                user.setAction(action.toString());
                commonDAO.update(user);
                insertLog(commonDAO, user);
            }
        }
        else if(action.equals(CommonActionEnum.listlogins)){
            String startStr = request.getParameter("start");
            String limitStr = request.getParameter("limit");
            String keywords = request.getParameter("keywords");
            int start = 0;
            int limit = Integer.MAX_VALUE;
            if (null != startStr) {
                start = Integer.parseInt(startStr);
                limit = Integer.parseInt(limitStr);
            }
            String whereClause = "from UserH where 1 = 1 and action like '%登录%'";
            if(StringUtils.isNotEmpty(keywords)){
                whereClause += " and (loginname like '%"+keywords+"%' or ";
                whereClause += " username like '%"+keywords+"%' or ";
                whereClause += " division like '%"+keywords+"%' or ";
                whereClause += " company like '%"+keywords+"%' or ";
                whereClause += " mobile like '%"+keywords+"%' or ";
                whereClause += " fax like '%"+keywords+"%' or ";
                whereClause += " tel like '%"+keywords+"%' or ";
                whereClause += " qq like '%"+keywords+"%'";
                whereClause += ")";
            }
            whereClause += " order by createtime desc";
            int count = commonDAO.count(UserH.class,"select count(*) "+whereClause);
            List<UserH> users = commonDAO.list(UserH.class, whereClause, start, limit);
            for(int i = 0; i < users.size();i++){
                users.get(i).setPassword("");
            }
            hashMap.put("total", count);
            hashMap.put("items",users);
        }
        if(success){

        }
        hashMap.put("success",success);
        hashMap.put("message",message);
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
