package mapskin.manager.entity;

import java.sql.Timestamp;

/**
 * Created by wbz on 2015/9/17.
 */
public class Userrole {
    private int id;
    private Integer userid;
    private String username;
    private Integer roleid;
    private String rolename;
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

    public Integer getRoleid() {
        return roleid;
    }

    public void setRoleid(Integer roleid) {
        this.roleid = roleid;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
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

        Userrole userrole = (Userrole) o;

        if (id != userrole.id) return false;
        if (action != null ? !action.equals(userrole.action) : userrole.action != null) return false;
        if (createtime != null ? !createtime.equals(userrole.createtime) : userrole.createtime != null) return false;
        if (createusercompany != null ? !createusercompany.equals(userrole.createusercompany) : userrole.createusercompany != null)
            return false;
        if (createuserid != null ? !createuserid.equals(userrole.createuserid) : userrole.createuserid != null)
            return false;
        if (createusermobile != null ? !createusermobile.equals(userrole.createusermobile) : userrole.createusermobile != null)
            return false;
        if (createusername != null ? !createusername.equals(userrole.createusername) : userrole.createusername != null)
            return false;
        if (roleid != null ? !roleid.equals(userrole.roleid) : userrole.roleid != null) return false;
        if (rolename != null ? !rolename.equals(userrole.rolename) : userrole.rolename != null) return false;
        if (status != null ? !status.equals(userrole.status) : userrole.status != null) return false;
        if (userid != null ? !userid.equals(userrole.userid) : userrole.userid != null) return false;
        if (username != null ? !username.equals(userrole.username) : userrole.username != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (userid != null ? userid.hashCode() : 0);
        result = 31 * result + (username != null ? username.hashCode() : 0);
        result = 31 * result + (roleid != null ? roleid.hashCode() : 0);
        result = 31 * result + (rolename != null ? rolename.hashCode() : 0);
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
