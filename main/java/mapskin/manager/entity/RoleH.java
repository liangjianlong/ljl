package mapskin.manager.entity;

import java.sql.Timestamp;

/**
 * Created by wbz on 2015/9/17.
 */
public class RoleH {
    private int id;
    private int roleid;
    private String name;
    private String description;
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

    public int getRoleid() {
        return roleid;
    }

    public void setRoleid(int roleid) {
        this.roleid = roleid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String desc) {
        this.description = desc;
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

        RoleH roleH = (RoleH) o;

        if (id != roleH.id) return false;
        if (roleid != roleH.roleid) return false;
        if (action != null ? !action.equals(roleH.action) : roleH.action != null) return false;
        if (createtime != null ? !createtime.equals(roleH.createtime) : roleH.createtime != null) return false;
        if (createusercompany != null ? !createusercompany.equals(roleH.createusercompany) : roleH.createusercompany != null)
            return false;
        if (createuserid != null ? !createuserid.equals(roleH.createuserid) : roleH.createuserid != null) return false;
        if (createusermobile != null ? !createusermobile.equals(roleH.createusermobile) : roleH.createusermobile != null)
            return false;
        if (createusername != null ? !createusername.equals(roleH.createusername) : roleH.createusername != null)
            return false;
        if (description != null ? !description.equals(roleH.description) : roleH.description != null) return false;
        if (name != null ? !name.equals(roleH.name) : roleH.name != null) return false;
        if (status != null ? !status.equals(roleH.status) : roleH.status != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + roleid;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (description != null ? description.hashCode() : 0);
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
