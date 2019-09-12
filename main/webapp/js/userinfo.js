/**
 * Created by wbz on 2015/9/20.
 */
function createUserInfoPanel(userid,root){
    var required = '<span style="color:red;font-weight:bold" data-qtip="Required">*</span>';
    var panel = Ext.create('Ext.form.Panel', {
        id: 'simpleForm',
        url: (root?root:'') + 'admin/control/usermanager.jsp',
        frame: true,
        width: 350,
        fieldDefaults: {
            msgTarget: 'side',
            labelWidth: 75
        },
        layout: 'anchor',
        defaults: {
            anchor: '100%'
        },
        defaultType: 'textfield',
        items: [{
            fieldLabel: '序号',
            name: 'id',
            readOnly:true
        },{
            fieldLabel: '登录名',
            afterLabelTextTpl: required,
            name: 'loginname',
            allowBlank: false,
            readOnly:userid,
            maxLength:15
        },{
            fieldLabel: '输入密码',
            inputType:'password',
            name: 'password',
            minLength:6,
            maxLength:10,
            allowBlank:false,
            disabled:userid?true:false
        }, {
            fieldLabel: '重复密码',
            inputType:'password',
            name: 'passcfrm',
            minLength:6,
            maxLength:10,
            allowBlank:false,
            disabled:userid?true:false
        },{
            fieldLabel: '姓名',
            afterLabelTextTpl: required,
            name: 'username',
            allowBlank: false,
            maxLength:15
        },{
            fieldLabel: 'Email',
            afterLabelTextTpl: required,
            name: 'email',
            hideTrigger: true,
            maxLength:15,
            vtype: 'email',
            allowBlank:false
        },{
            fieldLabel: '性别',
            xtype:'combobox',
            store:Ext.create('Ext.data.Store', {
                fields: ['key', 'value'],
                data : [
                    {"key":"未设置", "value":""},
                    {"key":"男", "value":"男"},
                    {"key":"女", "value":"女"}
                ]
            }),
            foreSelection:true,
            editable:false,
            displayField: 'key',
            valueField:'value',
            name: 'sex'
        }, {
            fieldLabel: '出生年月',
            name: 'borndate',
            xtype: 'datefield',
            submitFormat:'Y年m月d日',
            format:'Y年m月d日'
        }, {
            fieldLabel: '微信OpenId',
            name: 'qq',
            hideTrigger: true,
            maxLength:50,
            readOnly:false
        }, {
            xtype: 'numberfield',
            hideTrigger: true,
            fieldLabel: '手机',
            name: 'mobile',
            maxLength:11
        }, {
            fieldLabel: '电话',
            name: 'tel',
            maxLength:25
        }, {
            fieldLabel: '传真',
            name: 'fax',
            maxLength:25
        }, {
            fieldLabel: '单位',
            name: 'company',
            maxLength:100
        }, {
            fieldLabel: '地址',
            name: 'division',
            maxLength:100
        }],
        buttons: [{
            text: '保存',
            handler: function() {
                var form1 = this.up('form').getForm();
                if(form1.isValid()){
                    var datas = form1.getFieldValues();
                    if(!userid){
                        if(datas.password != datas.passcfrm){
                            Ext.Msg.alert("提示","两次输入密码不一致！");
                            return;
                        }
                    }
                    var action = form1.getFieldValues()['id']?'update':'add';
                    form1.submit({
                        params:{
                            action:action
                        },
                        success:function(response,result){
                            var userid1 = userid;
                            if(result.result){
                                if(result.result.user){
                                    if(result.result.user.id){
                                        userid1 = result.result.user.id;
                                    }
                                }
                            }
                            if(userid)
                            {
                                loaduserinfo(userid1,root);
                                Ext.Msg.alert("提示","用户信息更新成功！");
                            }
                            else{
                                Ext.Msg.alert("提示","注册成功！");
                            }
                        },
                        failure:function(response,result){
                            Ext.Msg.alert("提示","用户信息更新失败，原因：" + result.result.message);
                        }
                    });
                }

            }
        },{
            text: '重置',
            handler: function() {
                this.up('form').getForm().reset();
                loaduserinfo(userid,root);
            }
        }]
    });
    function loaduserinfo(userid,root){
        if(userid){
            panel.getForm().load({
                url:(root?root:'')+'admin/control/usermanager.jsp',
                params:{
                    action:'view',
                    id:userid
                },
                success:function(form,action){
                    var result = action.result;
                    if(result.user.borndate){
                        var time = result.user.borndate;
                        result.user.borndate = Ext.Date.parse(time,"Y年m月d日");
                    }
                    form.setValues(result.user);
                }
            });
        }
    }
    if(userid)
        loaduserinfo(userid,root);
    var windowuser = Ext.create('widget.window', {
        title: '用户信息',
        modal:true,
        closable: true,
        closeAction: 'hide',
        width: 380,
        height: 460,
        layout: {
            type: 'border',
            padding: 5
        },
        items:panel
    });
    windowuser.show();
    return windowuser;
}
function createUserPasswordPanel(userid,root){
    var panel = Ext.create('Ext.form.Panel', {
        frame: true,
        width: 350,
        fieldDefaults: {
            msgTarget: 'side',
            labelWidth: 75
        },
        url:(root?root:'') + 'admin/control/usermanager.jsp',
        layout: 'anchor',
        defaults: {
            anchor: '100%',
            inputType: 'password'
        },
        defaultType: 'textfield',
        items: [{
            fieldLabel: '原始密码',
            name: 'oldpassword',
            maxLength:10,
            itemId: 'oldpassword',
            allowBlank:false
        },{
            fieldLabel: '输入密码',
            name: 'password',
            itemId: 'password',
            minLength:6,
            maxLength:10,
            allowBlank:false
        }, {
            fieldLabel: '重复密码',
            name: 'passcfrm',
            minLength:6,
            maxLength:10,
            allowBlank:false
        }],
        buttons: [{
            text: '保存',
            handler: function() {
                var form1 = this.up('form').getForm();
                var datas = form1.getFieldValues();
                if(form1.isValid() && datas.password == datas.passcfrm){
                    form1.submit({
                        params:{
                            action:'changepassword',
                            id:userid
                        },
                        success:function(response,result){
                            Ext.Msg.alert("提示","密码修改成功！");
                        },
                        failure:function(response,result){
                            Ext.Msg.alert("提示","密码修改失败，原因：" + result.result.message);
                        }
                    });
                }
                else{
                    Ext.Msg.alert("提示","密码重复输入不正确!");
                }

            }
        },{
            text: '重置',
            handler: function() {
                this.up('form').getForm().reset();
            }
        }]
    });
    var windowuser = Ext.create('widget.window', {
        title: '修改密码',
        modal:true,
        closable: true,
        closeAction: 'hide',
        width: 380,
        layout: {
            type: 'fit',
            padding: 5
        },
        items:panel
    });
    windowuser.show();
    return windowuser;
}