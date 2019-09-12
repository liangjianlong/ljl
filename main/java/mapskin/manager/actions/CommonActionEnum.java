package mapskin.manager.actions;


/**
 * Created by wbz on 2015/9/11.
 */
public enum CommonActionEnum {
    delete("删除"),restore("恢复"),add("增加"),update("修改"),list("列表"),listlogins("列出登录日志"),view("查看"),login("登录"),logout("退出"),
    changepassword("修改密码"),unknow("未知"), forgetpassword("找回密码"), getuserprivileges("获取权限"), validate("验证登录"), getbyopenid("通过微信openid获取用户"), updateopenid("更新微信openid"), disconnectweixin("删除微信ID");
    private final String description;
    private CommonActionEnum(String desc){
        this.description = desc;
    }
    public String toString(){
        return description;
    }

}
