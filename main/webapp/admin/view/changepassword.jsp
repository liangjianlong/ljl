<%@ page import="mapskin.manager.entity.User" %>
<%--
  Created by IntelliJ IDEA.
  User: wbz
  Date: 2015/9/27
  Time: 16:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <link rel="stylesheet" href="../../js/Extjs/resources/css/ext-all.css"/>
    <script type="text/javascript" src="../../js/Extjs/ext-all.js"></script>
    <script type="text/javascript" src="../../js/Extjs/locale/ext-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../../js/userinfo.js"></script>
    <title>用户密码修改</title>
</head>
<script type="text/javascript">
    var root = "../../";
    Ext.onReady(function () {
                Ext.QuickTips.init();
                var panel = createUserPasswordPanel(<%=((User)session.getAttribute("user")).getId()%>,root);
            }
    );
</script>
<body>
</body>
</html>
