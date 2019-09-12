package mapskin.manager.entity;

import java.sql.Timestamp;

/**
 * Created by wbz on 2015/9/17.
 */
public class UserprivilegeH {
    private int id;
    private int userprivilegeid;
    private Integer userid;
    private String username;
    private Integer privilegeid;
    private String privilegename;
    private Timestamp createtime;
    private String action;
    private String status;
    private String createusername;
    private Integer createuserid;
    private String createusercompany;
    private String createusermobile;
    private String createuserip;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserprivilegeid() {
        return userprivilegeid;
    }

    public void setUserprivilegeid(int userprivilegeid) {
        this.userprivilegeid = userprivilegeid;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getPrivilegeid() {
        return privilegeid;
    }

    public void setPrivilegeid(Integer privilegeid) {
        this.privilegeid = privilegeid;
    }

    public String getPrivilegename() {
        return privilegename;
    }

    public void setPrivilegename(String privilegename) {
        this.privilegename = privilegename;
    }

    public Timestamp getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Timestamp createtime) {
        this.createtime = createtime;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreateusername() {
        return createusername;
    }

    public void setCreateusername(String createusername) {
        this.createusername = createusername;
    }

    public Integer getCreateuserid() {
        return createuserid;
    }

    public void setCreateuserid(Integer createuserid) {
        this.createuserid = createuserid;
    }

    public String getCreateusercompany() {
        return createusercompany;
    }

    public void setCreateusercompany(String createusercompany) {
        this.createusercompany = createusercompany;
    }

    public String getCreateusermobile() {
        return createusermobile;
    }

    public void setCreateusermobile(String createusermobile) {
        this.createusermobile = createusermobile;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UserprivilegeH that = (UserprivilegeH) o;

        if (id != that.id) return false;
        if (userprivilegeid != that.userprivilegeid) return false;
        if (action != null ? !action.equals(that.action) : that.action != null) return false;
        if (createtime != null ? !createtime.equals(that.createtime) : that.createtime != null) return false;
        if (createusercompany != null ? !createusercompany.equals(that.createusercompany) : that.createusercompany != null)
            return false;
        if (createuserid != null ? !createuserid.equals(that.createuserid) : that.createuserid != null) return false;
        if (createusermobile != null ? !createusermobile.equals(that.createusermobile) : that.createusermobile != null)
            return false;
        if (createusername != null ? !createusername.equals(that.createusername) : that.createusername != null)
            return false;
        if (privilegeid != null ? !privilegeid.equals(that.privilegeid) : that.privilegeid != null) return false;
        if (privilegename != null ? !privilegename.equals(that.privilegename) : that.privilegename != null)
            return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (userid != null ? !userid.equals(that.userid) : that.userid != null) return false;
        if (username != null ? !username.equals(that.username) : that.username != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + userprivilegeid;
        result = 31 * result + (userid != null ? userid.hashCode() : 0);
        result = 31 * result + (username != null ? username.hashCode() : 0);
        result = 31 * result + (privilegeid != null ? privilegeid.hashCode() : 0);
        result = 31 * result + (privilegename != null ? privilegename.hashCode() : 0);
        result = 31 * result + (createtime != null ? createtime.hashCode() : 0);
        result = 31 * result + (action != null ? action.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (createusername != null ? createusername.hashCode() : 0);
        result = 31 * result + (createuserid != null ? createuserid.hashCode() : 0);
        result = 31 * result + (createusercompany != null ? createusercompany.hashCode() : 0);
        result = 31 * result + (createusermobile != null ? createusermobile.hashCode() : 0);
        return result;
    }

    public String getCreateuserip() {
        return createuserip;
    }

    public void setCreateuserip(String createuserip) {
        this.createuserip = createuserip;
    }
}
