package mapskin.manager.actions;


/**
 * Created by wbz on 2015/9/11.
 */
public enum CommonStatusEnum {
    valid("有效"),
    invalid("无效");
    private final String description;
    private CommonStatusEnum(String desc){
        this.description = desc;
    }
    public String toString(){
        return description;
    }
}
