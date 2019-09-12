<%@ page import="mapskin.manager.dao.CommonDAO" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="org.codehaus.jackson.map.ObjectMapper" %>
<%@ page import="mapskin.manager.entity.User" %>
<%@ page import="mapskin.manager.dao.UserDAO" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.HashMap" %>
<%--
Created by IntelliJ IDEA.
User: wbz
Date: 2015/9/20
Time: 8:45
To change this template use File | Settings | File Templates.

action=login&password=&loginname=
action=logout&token=
action=validate&token=
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
    <title>登录</title>
</head>
<body>
<%
    String redirect_url = request.getParameter("redirect_url");
%>
<script type="text/javascript">
    Ext.onReady(function () {
        var required = '<span style="color:red;font-weight:bold" data-qtip="Required">*</span>';
        Ext.create('Ext.window.Window', {
            title: '登录' + "",
            height: 155,
            closable: false,
            width:280,
            modal:true,
            layout: {
                type: 'border',
                padding: 5
            },
            items: {
                xtype: 'form',
                layout: 'form',
                url: '../control/usermanager.jsp',
                width: 250,
                frame:true,
                fieldDefaults: {
                    msgTarget: 'side',
                    labelWidth: 75
                },
                defaultType: 'textfield',
                items: [
                    {
                        fieldLabel: '账号',
                        afterLabelTextTpl: required,
                        name: 'loginname',
                        value:Ext.util.Cookies.get('loginname'),
                        allowBlank: false
                    },
                    {
                        fieldLabel: '密码',
                        afterLabelTextTpl: required,
                        name: 'password',
                        value:Ext.util.Cookies.get('password'),
                        inputType: 'password',
                        allowBlank: false
                    },
                    {
                        fieldLabel:'&nbsp;',
                        labelSeparator:'',
                        xtype:'checkbox',
                        checked:Ext.util.Cookies.get('rememberme'),
                        boxLabel:'记住密码',
                        name:'rememberme'
                    }
                ],
                buttonAlign:'right',
                buttons: [
                    {
                        text: '注册',
                        href:'userregister.jsp',
                        handler: function () {
                            //createUserInfoPanel(undefined,"../../");
                        }
                    },
                    {
                        text: '忘记密码',
                        handler: function () {
                            Ext.Msg.prompt('提示', '请输入您注册的信箱:', function(btn, text){
                                if (btn == 'ok'){
                                    if(Ext.data.validations.email(null,text)){
                                        Ext.Ajax.request({
                                            url:'../control/usermanager.jsp',
                                            params:{
                                                action:'forgetpassword',
                                                email:text
                                            },
                                            success:function(res,opts){
                                                var result = Ext.decode(res.responseText);
                                                Ext.Msg.alert("提示",result.message);
                                            },
                                            failure:function(res,opts){
                                                var result = Ext.decode(res.responseText);
                                                Ext.Msg.alert("提示","原因：" + result.message);
                                            }
                                        })
                                    }
                                    else{
                                        alert(1);
                                    }
                                    // process text value and close...
                                }
                            });
                        }
                    }, {
                        text: '登录',
                        handler: function () {
                            if (this.up('form').getForm().isValid()) {
                                var form1 = this.up("form").getForm();
                                if(form1.getFieldValues()['rememberme']){
                                    Ext.util.Cookies.set('loginname',form1.getFieldValues()['loginname'],Ext.Date.add(new Date(), Ext.Date.DAY, 100));
                                    Ext.util.Cookies.set('password',form1.getFieldValues()['password'],Ext.Date.add(new Date(), Ext.Date.DAY, 100));
                                    Ext.util.Cookies.set('rememberme',form1.getFieldValues()['rememberme'],Ext.Date.add(new Date(), Ext.Date.DAY, 100));
                                }
                                else{
                                    Ext.util.Cookies.clear('loginname');
                                    Ext.util.Cookies.clear('password');
                                    Ext.util.Cookies.clear('rememberme');
                                }
                                this.up('form').getForm().submit({params: {
                                    action: 'login',
                                    redirect_url: '<%=redirect_url%>'
                                },
                                    redirect_url: '<%=redirect_url%>',
                                    success:function(response,options){
                                        if(options.result.success){
                                            location.href=options.redirect_url+"?token=" + options.result.token;
                                        }
                                        else{
                                            Ext.Msg.alert("提示","用户名或密码错误！");
                                        }
                                    },
                                    failure:function(response,options){
                                        if(options.result.success){
                                            location.href=options.redirect_url+"?&token=" + options.result.token;
                                        }
                                        else{
                                            Ext.Msg.alert("提示","用户名或密码错误！");
                                        }
                                    }});
                            }
                        }
                    }
                ]
            }
        }).show();
    });
</script>
</body>
</html>