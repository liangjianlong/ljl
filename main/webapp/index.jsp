<%@ page import="org.apache.commons.beanutils.BeanUtils" %>
<%@ page import="mapskin.manager.entity.*" %>
<%@ page import="org.codehaus.jackson.map.ObjectMapper" %>
<%@ page import="java.util.List" %>
<%@ page import="mapskin.manager.util.ManagerUtility" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <style type="text/css">
        body, html, #allmap, #results {
            width: 100%;
            height: 100%;
            overflow: hidden;
            margin: 0;
            font-family: "微软雅黑";
        }

        #results {
            overflow-y: scroll
        }
    </style>
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=FDab7e962dc40944d91ad376d92ffff4"></script>
    <link rel="stylesheet" href="js/Extjs/resources/css/ext-all.css"/>
    <script type="text/javascript" src="js/Extjs/ext-all.js"></script>
    <script type="text/javascript" src="js/Extjs/locale/ext-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/userinfo.js"></script>
    <title>用户管理系统</title>
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
    List privileges = (List) session.getAttribute("privileges");
    boolean islogin = (user != null);
%>
</body>
</html>
<%
    if (islogin) {
%>
<script type="text/javascript">
Ext.onReady(function () {
    Ext.QuickTips.init();
    var viewport = new Ext.Viewport({
        //layout: 'border' 表示我们使用了BorderLayout的布局方式，这各布局方式称为边界布局，它将页面分为东、西、南、北、中5个部分。
        layout: 'border',
        items: [
            {
                // region为它里面的组件指定具体的放置位置
                region: 'north',
                height: 115,
                border:0,
                split: false,
                collapsible: false,
                xtype: 'panel',
                header: false,
                title: '运维系统',
                html: '<img src="images/banner.jpg" />',
                bodyStyle: 'font-size: 25px;line-height: 2;color: blue;background-image:url(images/bannerbg.jpg);background-repeat: repeat-x',
                bbar: [
                    {xtype: 'label', text: '欢迎您，<%=user.getUsername()%>' },
                    {xtype: 'button', text: '修改资料', listeners: {click: function () {
                        var panel = createUserInfoPanel("<%=user.getId()%>");
                        panel.on({
                            close: function () {
                                getUserlistpanel().getStore().reload();
                            }
                        });
                    }}},
                    {xtype: 'button', text: '修改密码', listeners: {click: function () {
                        var panel = createUserPasswordPanel("<%=user.getId()%>");
                        panel.on({
                            close: function () {
                                getUserlistpanel().getStore().reload();
                            }
                        });
                    }}},
                    {xtype: 'button', text: '退出', listeners: {click: function () {
                        Ext.Ajax.request({
                            url: 'admin/control/usermanager.jsp?redirect',
                            params: {
                                action: 'logout'
                            },
                            success: function () {
                                location.reload();
                            }
                        })
                    }}}
                ]
            },
            /*
             {
             region: 'west',
             width: 250,
             title:'检索结果',
             split: true,
             xtype: 'panel',
             html:'<div id="results"></div>'
             },*/
            {
                region: 'center',
                id: 'taskpanels',
                xtype: 'tabpanel',
                items: [
                    <%=(user.getLoginname().equals("admin") || ManagerUtility.hasPrivilege(privileges,"用户管理"))?"getUserlistpanel(),getPrivilegelistpanel(),getUserloginlistpanel()":"" %>
                ]
            }
        ]
    });
});
//创建或者获取Userlistpanel
//var userCellEditing;
function getUserlistpanel(listid, actions) {
    var id = "userlistpanel";
    if (listid) {
        id = listid;
    }
    var userCellEditing = Ext.create('Ext.grid.plugin.CellEditing', {
        clicksToEdit: 2
    });
    <%
    ObjectMapper objectMapper = new ObjectMapper();
    String fields = objectMapper.writeValueAsString(BeanUtils.describe(new User()).keySet());
    %>
    var userlistpanel = Ext.getCmp(id);
    if (userlistpanel == null) {
        var userliststore = Ext.create('Ext.data.Store', {
            fields:<%=fields%>,
            pageSize: 10,
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: 'admin/control/usermanager.jsp?action=list',
                extraParams: {

                },
                reader: {
                    type: 'json',
                    root: 'items',
                    totalProperty: 'total'
                }
            }
        });
        userlistpanel = Ext.create('Ext.grid.Panel', {
            id: id,
            title: '用户管理',
            store: userliststore,
            columns: [
                { text: '序号', dataIndex: 'id', width: 40 },
                { text: '修改保存', dataIndex: 'id', width: 100, xtype: 'actioncolumn', items: actions ? actions : [
                    {
                        icon: 'images/icons/group_gear.png',  // Use a URL in the icon config
                        tooltip: '修改用户信息',
                        handler: function (grid, rowIndex, colIndex) {
                            var panel = createUserInfoPanel(grid.getStore().getAt(rowIndex).getData()['id']);
                            panel.on({
                                close: function () {
                                    getUserlistpanel().getStore().reload();
                                }
                            });
                        }
                    },
                    {
                        icon: 'images/icons/user_key.png',  // Use a URL in the icon config
                        tooltip: '修改用户密码',
                        handler: function (grid, rowIndex, colIndex) {
                            var panel = createUserPasswordPanel(grid.getStore().getAt(rowIndex).getData()['id']);
                        }
                    },

                    {
                        icon: 'images/icons/cog_edit.png',  // Use a URL in the icon config
                        tooltip: '修改用户权限',
                        handler: function (grid, rowIndex, colIndex) {
                            var record = grid.getStore().getAt(rowIndex);//.get('id')
                            var panel = getUserPrivilegelistpanel(record.get('id'), record.get('username'));
                            if (!Ext.getCmp('taskpanels').items.contains(panel)) {
                                Ext.getCmp('taskpanels').add(panel);
                            }
                            Ext.getCmp('taskpanels').setActiveTab(panel);
                            panel.focus();
                            Ext.getCmp('taskpanels').doLayout();
                        }
                    },
                    {
                        icon: 'images/icons/delete.gif',  // Use a URL in the icon config
                        tooltip: '删除用户',
                        handler: function (grid, rowIndex, colIndex) {
                            var rec = grid.getStore().getAt(rowIndex).getData();
                            Ext.Ajax.request({
                                url: 'admin/control/usermanager.jsp?action=delete&id=' + grid.getStore().getAt(rowIndex).getData()['id'],
                                success: function (response, opts) {
                                    getUserlistpanel().getStore().reload();
                                },
                                failure: function (response, opts) {

                                }
                            });
                        }
                    },
                    {
                        icon: 'images/icons/add.png',  // Use a URL in the icon config
                        padding: 20,
                        tooltip: '恢复用户',
                        handler: function (grid, rowIndex, colIndex) {
                            var rec = grid.getStore().getAt(rowIndex).getChanges();
                            Ext.Ajax.request({
                                url: 'admin/control/usermanager.jsp?action=restore&id=' + grid.getStore().getAt(rowIndex).getData()['id'],
                                params: rec,
                                success: function (response, opts) {
                                    getUserlistpanel().getStore().reload();
                                },
                                failure: function (response, opts) {

                                }
                            });
                        }
                    }
                ]},

                { text: '登录名', dataIndex: 'loginname', width: 80, editor: {allowBlank: false}},
                { text: '姓名', dataIndex: 'username', width: 80, editor: {allowBlank: false}},
                { text: 'Email', dataIndex: 'email', editor: {allowBlank: false}},
                { text: '性别', dataIndex: 'sex', width: 40, editor: {allowBlank: false}},
                { text: '出生年月', width: 120, dataIndex: 'borndate', editor: {xtype: 'datefield',
                    allowBlank: false,
                    format: 'Y年m月d日'
                }, renderer: function (value) {
                    if (value instanceof Date) {
                        return Ext.Date.format(value, 'Y年m月d日');
                    }
                    else
                        return value;
                }},
                { text: '微信OpenId', dataIndex: 'qq', width: 80},
                { text: '手机', dataIndex: 'mobile', editor: {allowBlank: false}},
                { text: '电话', dataIndex: 'tel', editor: {allowBlank: false}},
                { text: '传真', dataIndex: 'fax', editor: {allowBlank: false}},
                { text: '单位', dataIndex: 'company', editor: {allowBlank: false}},
                { text: '地址', dataIndex: 'division', editor: {allowBlank: false}},
                { text: '状态', dataIndex: 'status', width: 60, renderer: function (value) {
                    return "<p style='color:" + (value == '有效' ? 'black' : 'red') + "'>" + value + "</p>"
                }},
                { text: '操作', dataIndex: 'action' },
                { text: '操作时间', dataIndex: 'createtime' },
                { text: '上次手机登录坐标X', dataIndex: 'x' },
                { text: '上次手机登录坐标Y', dataIndex: 'y' },
                { text: '上次登录IMEI号', dataIndex: 'imei' }
            ],
            dockedItems: [
                {
                    dock: 'top',
                    xtype: 'toolbar',
                    items: [
                        {
                            text: '创建用户',
                            labelWidth: 70,
                            xtype: 'button',
                            handler: function () {
                                var panel = createUserInfoPanel();
                                panel.on({
                                    close: function () {
                                        getUserlistpanel().getStore().reload();
                                    }
                                });
                                return;
                            }
                        },
                        {
                            fieldLabel: '关键字',
                            labelWidth: 70,
                            id: id + 'keywords',
                            xtype: 'textfield'
                        },
                        {
                            text: '查询',
                            labelWidth: 70,
                            xtype: 'button',
                            handler: function () {
                                var keywords = Ext.getCmp(id + "keywords").getValue();
                                userliststore.getProxy().setExtraParam('keywords', keywords);
                                userliststore.loadPage(1);
                            }
                        },
                        {
                            text: '查看全部',
                            labelWidth: 70,
                            xtype: 'button',
                            handler: function () {
                                var keywords = Ext.getCmp(id + "keywords").setValue("");
                                delete userliststore.getProxy().extraParams['keywords'];
                                userliststore.loadPage(1);
                            }
                        }
                    ]
                },
                createPageingtool(userliststore)
            ],
            listeners: {
                celldblclick: function (table, td, cellIndex, record, tr, rowindex, e, eOpts) {
                    var panel = createUserInfoPanel(record.getData()['id']);
                    panel.on({
                        close: function () {
                            getUserlistpanel().getStore().reload();
                        }
                    });
                }
            }
        });
    }
    return userlistpanel;
}

//创建或者获取Rolelistpanel
function getRolelistpanel(listid, actions) {
    var id = "rolelistpanel";
    if (listid) {
        id = listid;
    }
    var rolelistpanel = Ext.getCmp(id);
    <%
    fields = objectMapper.writeValueAsString(BeanUtils.describe(new Role()).keySet());

    %>
    if (rolelistpanel == null) {
        var roleliststore = Ext.create('Ext.data.Store', {
            fields:<%=fields%>,
            pageSize: 10,
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: 'admin/control/rolemanager.jsp?action=list',
                extraParams: {

                },
                reader: {
                    type: 'json',
                    root: 'items',
                    totalProperty: 'total'
                }
            }
        });
        rolelistpanel = Ext.create('Ext.grid.Panel', {
            id: id,
            title: '角色管理',
            store: roleliststore,
            columns: [
                { text: '序号', dataIndex: 'id', width: 40 },
                { text: '操作', dataIndex: 'id', width: 100, xtype: 'actioncolumn', items: [
                    {
                        icon: 'images/icons/table_save.png',  // Use a URL in the icon config
                        tooltip: 'Sell stock',
                        handler: function (grid, rowIndex, colIndex) {
                            var rec = grid.getStore().getAt(rowIndex).getChanges();
                            if (rec.borndate && !(rec.borndate instanceof Date)) {
                                var date1 = new Date();
                                date1.setTime(rec.borndate.time);
                                rec.borndate = date1;
                            }
                            var id = grid.getStore().getAt(rowIndex).getData()['id'];
                            var action = 'update';
                            if (!id) {
                                action = 'add';
                            }
                            Ext.Ajax.request({
                                url: 'admin/control/rolemanager.jsp?action=' + action + '&id=' + id,
                                params: rec,
                                success: function (response, opts) {
                                    var rolelistpanel = getRolelistpanel(listid, actions);
                                    rolelistpanel.getStore().reload();
                                },
                                failure: function (response, opts) {

                                }
                            });

                        }
                    },
                    {
                        icon: 'images/icons/cog_edit.png',  // Use a URL in the icon config
                        tooltip: 'Sell stock',
                        handler: function (grid, rowIndex, colIndex) {
                            var rec = grid.getStore().getAt(rowIndex).getChanges();
                            if (rec.borndate && !(rec.borndate instanceof Date)) {
                                var date1 = new Date();
                                date1.setTime(rec.borndate.time);
                                rec.borndate = date1;
                            }
                            var id = grid.getStore().getAt(rowIndex).getData()['id'];
                            var action = 'update';
                            if (!id) {
                                action = 'add';
                            }
                            Ext.Ajax.request({
                                url: 'admin/control/rolemanager.jsp?action=' + action + '&id=' + id,
                                params: rec,
                                success: function (response, opts) {
                                    var rolelistpanel = getRolelistpanel(listid, actions);
                                    rolelistpanel.getStore().reload();
                                },
                                failure: function (response, opts) {

                                }
                            });

                        }
                    },
                    {
                        icon: 'images/icons/delete.gif',  // Use a URL in the icon config
                        tooltip: 'Sell stock',
                        handler: function (grid, rowIndex, colIndex) {
                            var rec = grid.getStore().getAt(rowIndex).getData();
                            Ext.Ajax.request({
                                url: 'admin/control/rolemanager.jsp?action=delete&id=' + grid.getStore().getAt(rowIndex).getData()['id'],
                                success: function (response, opts) {
                                    var rolelistpanel = getRolelistpanel(listid, actions);
                                    rolelistpanel.getStore().reload();
                                },
                                failure: function (response, opts) {

                                }
                            });
                        }
                    },
                    {
                        icon: 'images/icons/add.png',  // Use a URL in the icon config
                        padding: 20,
                        tooltip: 'Sell stock',
                        handler: function (grid, rowIndex, colIndex) {
                            var rec = grid.getStore().getAt(rowIndex).getChanges();
                            Ext.Ajax.request({
                                url: 'admin/control/rolemanager.jsp?action=restore&id=' + grid.getStore().getAt(rowIndex).getData()['id'],
                                params: rec,
                                success: function (response, opts) {
                                    var rolelistpanel = getRolelistpanel(listid, actions);
                                    rolelistpanel.getStore().reload();
                                },
                                failure: function (response, opts) {

                                }
                            });
                        }
                    }
                ]},

                { text: '角色名称', dataIndex: 'name', editor: {allowBlank: false}},
                { text: '描述', dataIndex: 'description', editor: {allowBlank: false}},
                { text: '状态', dataIndex: 'status', width: 60, renderer: function (value) {
                    return "<p style='color:" + (value == '有效' ? 'black' : 'red') + "'>" + value + "</p>"
                } }/*,
                 { text: '操作', dataIndex: 'action' },
                 { text: '操作时间', dataIndex: 'createtime' },
                 { text: '操作人姓名', dataIndex: 'createusername' },
                 { text: '操作人手机', dataIndex: 'createusermobile' },
                 { text: '操作人单位', dataIndex: 'createusercompany' },
                 { text: '操作人ID', dataIndex: 'createuserid' }*/
            ],
            dockedItems: [
                {
                    dock: 'top',
                    xtype: 'toolbar',
                    items: [
                        {
                            text: '创建新用户',
                            labelWidth: 70,
                            xtype: 'button',
                            handler: function () {
                                roleCellEditing.cancelEdit();
                                var rolelistpanel = getRolelistpanel();
                                var store = rolelistpanel.getStore();
                                Ext.data.StoreManager.lookup('roleliststore').insert(0, {});
                            }
                        },
                        {
                            fieldLabel: '关键字',
                            labelWidth: 70,
                            id: 'keywords',
                            xtype: 'textfield'
                        },
                        {
                            text: '查询',
                            labelWidth: 70,
                            xtype: 'button',
                            handler: function () {
                                var keywords = Ext.getCmp("keywords").getValue();
                                roleliststore.getProxy().setExtraParam('keywords', keywords);
                                roleliststore.loadPage(1);
                            }
                        },
                        {
                            text: '查看全部',
                            labelWidth: 70,
                            xtype: 'button',
                            handler: function () {
                                var keywords = Ext.getCmp("keywords").setValue("");
                                delete roleliststore.getProxy().extraParams['keywords'];
                                roleliststore.loadPage(1);
                            }
                        }
                    ]
                },
                createPageingtool(roleliststore)
            ]
        });
    }
    return rolelistpanel;
}

//创建或者获取Rolelistpanel
function getPrivilegelistpanel(listid, actions) {
    var id = "privilegelistpanel";
    if (listid) {
        id = listid;
    }
    <%
    fields = objectMapper.writeValueAsString(BeanUtils.describe(new Privilege()).keySet());

    %>
    var privilegelistpanel = Ext.getCmp(id);
    if (privilegelistpanel == null) {
        var privilegeliststore = Ext.create('Ext.data.Store', {
            fields:<%=fields%>,
            pageSize: 10,
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: 'admin/control/privilegemanager.jsp?action=list',
                extraParams: {

                },
                reader: {
                    type: 'json',
                    root: 'items',
                    totalProperty: 'total'
                }
            }
        });
        var privilegeCellEditing = Ext.create('Ext.grid.plugin.CellEditing', {
            clicksToEdit: 2
        });
        privilegelistpanel = Ext.create('Ext.grid.Panel', {
            id: id,
            title: '权限管理',
            store: privilegeliststore,
            columns: [
                { text: '序号', dataIndex: 'id', width: 40 },
                { text: '保存修改', dataIndex: 'id', width: 100, xtype: 'actioncolumn', items: [
                    {
                        icon: 'images/icons/table_save.png',  // Use a URL in the icon config
                        tooltip: '保存权限信息',
                        handler: function (grid, rowIndex, colIndex) {
                            var rec = grid.getStore().getAt(rowIndex).getChanges();
                            if (rec.borndate && !(rec.borndate instanceof Date)) {
                                var date1 = new Date();
                                date1.setTime(rec.borndate.time);
                                rec.borndate = date1;
                            }
                            var id = grid.getStore().getAt(rowIndex).getData()['id'];
                            var action = 'update';
                            if (!id) {
                                action = 'add';
                            }
                            Ext.Ajax.request({
                                url: 'admin/control/privilegemanager.jsp?action=' + action + '&id=' + id,
                                params: rec,
                                success: function (response, opts) {
                                    privilegeliststore.reload();
                                },
                                failure: function (response, opts) {

                                }
                            });

                        }
                    }
                ]},

                { text: '权限名称', dataIndex: 'name', editor: {allowBlank: false}},
                { text: '描述', dataIndex: 'description', editor: {allowBlank: false}},
                { text: '状态', dataIndex: 'status', width: 60, renderer: function (value) {
                    return "<p style='color:" + (value == '有效' ? 'black' : 'red') + "'>" + value + "</p>"
                }},
                { text: '删除与恢复', dataIndex: 'id', width: 100, xtype: 'actioncolumn', items: [
                    {
                        icon: 'images/icons/delete.gif',  // Use a URL in the icon config
                        tooltip: '删除权限信息',
                        handler: function (grid, rowIndex, colIndex) {
                            var rec = grid.getStore().getAt(rowIndex).getData();
                            Ext.Ajax.request({
                                url: 'admin/control/privilegemanager.jsp?action=delete&id=' + grid.getStore().getAt(rowIndex).getData()['id'],
                                success: function (response, opts) {
                                    privilegeliststore.reload();
                                },
                                failure: function (response, opts) {

                                }
                            });
                        }
                    },
                    {
                        icon: 'images/icons/add.png',  // Use a URL in the icon config
                        padding: 20,
                        tooltip: '恢复权限',
                        handler: function (grid, rowIndex, colIndex) {
                            var rec = grid.getStore().getAt(rowIndex).getChanges();
                            Ext.Ajax.request({
                                url: 'admin/control/privilegemanager.jsp?action=restore&id=' + grid.getStore().getAt(rowIndex).getData()['id'],
                                params: rec,
                                success: function (response, opts) {
                                    privilegeliststore.reload();
                                },
                                failure: function (response, opts) {

                                }
                            });
                        }
                    }
                ]}
                /*,
                 { text: '操作', dataIndex: 'action' },
                 { text: '操作时间', dataIndex: 'createtime' },
                 { text: '操作人姓名', dataIndex: 'createusername' },
                 { text: '操作人手机', dataIndex: 'createusermobile' },
                 { text: '操作人单位', dataIndex: 'createusercompany' },
                 { text: '操作人ID', dataIndex: 'createuserid' }*/
            ],
            plugins: [privilegeCellEditing],
            dockedItems: [
                {
                    dock: 'top',
                    xtype: 'toolbar',
                    items: [
                        {
                            text: '创建权限',
                            labelWidth: 70,
                            xtype: 'button',
                            handler: function () {
                                privilegeCellEditing.cancelEdit();
                                privilegeliststore.insert(0, {});
                                privilegeCellEditing.startEdit(0, 0);
                            }
                        },
                        {
                            fieldLabel: '关键字',
                            labelWidth: 70,
                            id: id + 'keywords',
                            xtype: 'textfield'
                        },
                        {
                            text: '查询',
                            labelWidth: 70,
                            xtype: 'button',
                            handler: function () {
                                var keywords = Ext.getCmp(id + "keywords").getValue();
                                privilegeliststore.getProxy().setExtraParam('keywords', keywords);
                                privilegeliststore.loadPage(1);
                            }
                        },
                        {
                            text: '查看全部',
                            labelWidth: 70,
                            xtype: 'button',
                            handler: function () {
                                var keywords = Ext.getCmp(id + "keywords").setValue("");
                                delete privilegeliststore.getProxy().extraParams['keywords'];
                                privilegeliststore.loadPage(1);
                            }
                        }
                    ]
                },
                createPageingtool(privilegeliststore)
            ]
        });
    }
    return privilegelistpanel;
}
function getUserPrivilegelistpanel(userid, username) {
    var id = "userprivilegelistpanel" + userid;
    var userprivilegelistpanel = Ext.getCmp(id);
    if (userprivilegelistpanel == null) {
        var userprivilegeliststore = Ext.create('Ext.data.Store', {
            storeId: 'userprivilegeliststore',
            fields: ['id', 'privilegeid', 'privilegename', 'description'],
            pageSize: Math.maxValue,
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: 'admin/control/userprivilegemanager.jsp?action=list',
                extraParams: {
                    userid: userid
                },
                reader: {
                    type: 'json',
                    root: 'items',
                    totalProperty: 'total'
                }
            },
            listeners: {
                load: function (store, records) {
                    for (var i = 0; i < records.length; i++) {
                        var data = records[i].getData();
                        if (data['id']) {
                            sm.select(records[i], true);
                        }
                    }
                }
            }
        });
        var sm = Ext.create('Ext.selection.CheckboxModel');
        userprivilegelistpanel = Ext.create('Ext.grid.Panel', {
            id: id,
            closable: true,
            focusOnFront: true,
            title: '管理' + username + '的权限',
            selModel: sm,
            store: userprivilegeliststore,
            columns: [
                { text: '序号', dataIndex: 'privilegeid', width: 40, editor: 'checkbox'},
                { text: '权限名称', dataIndex: 'privilegename', editor: {allowBlank: false}},
                { text: '权限描述', dataIndex: 'description', editor: {allowBlank: false}}
                /*,
                 { text: '操作', dataIndex: 'action' },
                 { text: '操作时间', dataIndex: 'createtime' },
                 { text: '操作人姓名', dataIndex: 'createusername' },
                 { text: '操作人手机', dataIndex: 'createusermobile' },
                 { text: '操作人单位', dataIndex: 'createusercompany' },
                 { text: '操作人ID', dataIndex: 'createuserid' }*/
            ],
            dockedItems: [
                {
                    dock: 'top',
                    xtype: 'toolbar',
                    items: [
                        {
                            text: '保存修改',
                            labelWidth: 70,
                            xtype: 'button',
                            handler: function () {
                                var userprivilegelistpanel = getUserPrivilegelistpanel(userid);
                                var records = userprivilegelistpanel.getSelectionModel().getSelection();
                                var datas = new Array();
                                for (var i = 0; i < records.length; i++) {
                                    datas.push(records[i].getData());
                                }
                                Ext.Ajax.request({
                                    url: 'admin/control/userprivilegemanager.jsp?action=update&userid=' + userid,
                                    params: {records: Ext.JSON.encode(datas)},
                                    success: function (response, opts) {
                                        getUserPrivilegelistpanel(userid).getStore().reload();
                                    },
                                    failure: function (response, opts) {

                                    }
                                });
                            }
                        }
                    ]
                },
                createPageingtool(userprivilegeliststore)
            ]
        });
    }
    return userprivilegelistpanel;
}


function getUserloginlistpanel(listid, actions) {
    var id = "userloginlistpanel";
    if (listid) {
        id = listid;
    }
    var userCellEditing = Ext.create('Ext.grid.plugin.CellEditing', {
        clicksToEdit: 2
    });
    <%
    objectMapper = new ObjectMapper();
    fields = objectMapper.writeValueAsString(BeanUtils.describe(new UserH()).keySet());
    %>
    var userloginlistpanel = Ext.getCmp(id);
    if (userloginlistpanel == null) {
        var userloginliststore = Ext.create('Ext.data.Store', {
            fields:<%=fields%>,
            pageSize: 10,
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: 'admin/control/usermanager.jsp?action=listlogins',
                extraParams: {

                },
                reader: {
                    type: 'json',
                    root: 'items',
                    totalProperty: 'total'
                }
            }
        });

        userloginlistpanel = Ext.create('Ext.grid.Panel', {
            id: id,
            title: '登录日志',
            store: userloginliststore,
            columns: [
                { text: '序号', dataIndex: 'id', width: 40 },
                { text: '登录名', dataIndex: 'loginname', width: 80, editor: {allowBlank: false}},
                { text: '姓名', dataIndex: 'username', width: 80, editor: {allowBlank: false}},
                { text: 'Email', dataIndex: 'email', editor: {allowBlank: false}},
                { text: '性别', dataIndex: 'sex', width: 40, editor: {allowBlank: false}},
                { text: '出生年月', width: 120, dataIndex: 'borndate', editor: {xtype: 'datefield',
                    allowBlank: false,
                    format: 'Y年m月d日'
                }, renderer: function (value) {
                    if (value instanceof Date) {
                        return Ext.Date.format(value, 'Y年m月d日');
                    }
                    else
                        return value;
                }},
                { text: '微信OpenId', dataIndex: 'qq', width: 80},
                { text: '手机', dataIndex: 'mobile', editor: {allowBlank: false}},
                { text: '电话', dataIndex: 'tel', editor: {allowBlank: false}},
                { text: '传真', dataIndex: 'fax', editor: {allowBlank: false}},
                { text: '单位', dataIndex: 'company', editor: {allowBlank: false}},
                { text: '地址', dataIndex: 'division', editor: {allowBlank: false}},
                { text: '状态', dataIndex: 'status', width: 60, renderer: function (value) {
                    return "<p style='color:" + (value == '有效' ? 'black' : 'red') + "'>" + value + "</p>"
                }},
                { text: '操作', dataIndex: 'id', width: 100, xtype: 'actioncolumn', items: actions ? actions : []
                },
                { text: '操作', dataIndex: 'action' },
                { text: '操作时间', dataIndex: 'createtime' },
                { text: '最近登录坐标X', dataIndex: 'x' },
                { text: '最近登录坐标Y', dataIndex: 'y' },
                { text: '最近登录IMEI号', dataIndex: 'imei' }
            ],
            //plugins: [userCellEditing],
            dockedItems: [
                {
                    dock: 'top',
                    xtype: 'toolbar',
                    items: [
                        {
                            fieldLabel: '关键字',
                            labelWidth: 70,
                            id: id + 'keywords',
                            xtype: 'textfield'
                        },
                        {
                            text: '查询',
                            labelWidth: 70,
                            xtype: 'button',
                            handler: function () {
                                var keywords = Ext.getCmp(id + "keywords").getValue();
                                userloginliststore.getProxy().setExtraParam('keywords', keywords);
                                userloginliststore.loadPage(1);
                            }
                        },
                        {
                            text: '查看全部',
                            labelWidth: 70,
                            xtype: 'button',
                            handler: function () {
                                var keywords = Ext.getCmp(id + "keywords").setValue("");
                                delete userloginliststore.getProxy().extraParams['keywords'];
                                userloginliststore.loadPage(1);
                            }
                        }
                    ]
                },createPageingtool(userloginliststore)
            ]
        });
    }
    return userloginlistpanel;
}
function createPageingtool(store) {
    var pagesize =Ext.Number.from(Ext.util.Cookies.get('pagesize'),20);
    store.pageSize = pagesize;
    return {
        xtype: 'pagingtoolbar',
        beforePageText: "第",
        store: store,   // same store GridPanel is using
        dock: 'bottom',
        html: '',
        items: [Ext.create('Ext.form.ComboBox', {
            fieldLabel: '每页',
            labelSeparator: '',
            labelWidth: 30,
            width: 100,
            store: Ext.create('Ext.data.Store', {
                fields: ['abbr', 'size'],
                data: [
                    {"abbr": 10, "size": 10},
                    {"abbr": 20, "size": 20},
                    {"abbr": 50, "size": 50},
                    {"abbr": 100, "size": 100},
                    {"abbr": 500, "size": 500}
                ]
            }),
            forceSelection: true,
            editable: false,
            value: pagesize,
            listeners: {
                change: function (cmp, newValue, oldValue, eOpts) {
                    Ext.util.Cookies.set('pagesize',newValue,Ext.Date.add(new Date(), Ext.Date.DAY, 100));
                    store.pageSize = newValue;
                    store.loadPage(1);
                }
            },
            allowBlank: false,
            queryMode: 'local',
            displayField: 'abbr',
            valueField: 'abbr'
        }),
            {
                xtype: 'label',
                text: '条'
            }],
        displayInfo: true,
        displayMsg: "当前显示第 {0} - {1} 条, 共{2}条",
        afterPageText: "页，共 {0} 页"
    };
}
</script>
<%
    } else {
        response.sendRedirect("admin/view/login.jsp?responsetype=html&redirect_url=" + request.getRequestURL());
    }
%>