package mapskin.manager.entity;

import java.sql.Timestamp;

/**
 * Created by wbz on 2015/11/1.
 */
public class UserH {
    private Integer id;
    private Integer userid;
    private String loginname;
    private String password;
    private String username;
    private String sex;
    private Timestamp borndate;
    private String company;
    private String email;
    private String mobile;
    private String fax;
    private String tel;
    private String qq;
    private String division;
    private Timestamp createtime;
    private String action;
    private String status;
    private String createusername;
    private Integer createuserid;
    private String createusercompany;
    private String createuserip;
    private String createusermobile;
    private Double x;
    private Double y;
    private String imei;
    private Double x1;
    private Double y1;

    public Double getY1() {
        return y1;
    }

    public void setY1(Double y1) {
        this.y1 = y1;
    }

    public Double getX1() {
        return x1;
    }

    public void setX1(Double x1) {
        this.x1 = x1;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Timestamp getBorndate() {
        return borndate;
    }

    public void setBorndate(Timestamp borndate) {
        this.borndate = borndate;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getDivision() {
        return division;
    }

    public void setDivision(String division) {
        this.division = division;
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

    public String getCreateuserip() {
        return createuserip;
    }

    public void setCreateuserip(String createuserip) {
        this.createuserip = createuserip;
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

        UserH userH = (UserH) o;

        if (action != null ? !action.equals(userH.action) : userH.action != null) return false;
        if (borndate != null ? !borndate.equals(userH.borndate) : userH.borndate != null) return false;
        if (company != null ? !company.equals(userH.company) : userH.company != null) return false;
        if (createtime != null ? !createtime.equals(userH.createtime) : userH.createtime != null) return false;
        if (createusercompany != null ? !createusercompany.equals(userH.createusercompany) : userH.createusercompany != null)
            return false;
        if (createuserid != null ? !createuserid.equals(userH.createuserid) : userH.createuserid != null) return false;
        if (createuserip != null ? !createuserip.equals(userH.createuserip) : userH.createuserip != null) return false;
        if (createusermobile != null ? !createusermobile.equals(userH.createusermobile) : userH.createusermobile != null)
            return false;
        if (createusername != null ? !createusername.equals(userH.createusername) : userH.createusername != null)
            return false;
        if (division != null ? !division.equals(userH.division) : userH.division != null) return false;
        if (email != null ? !email.equals(userH.email) : userH.email != null) return false;
        if (fax != null ? !fax.equals(userH.fax) : userH.fax != null) return false;
        if (id != null ? !id.equals(userH.id) : userH.id != null) return false;
        if (loginname != null ? !loginname.equals(userH.loginname) : userH.loginname != null) return false;
        if (mobile != null ? !mobile.equals(userH.mobile) : userH.mobile != null) return false;
        if (password != null ? !password.equals(userH.password) : userH.password != null) return false;
        if (qq != null ? !qq.equals(userH.qq) : userH.qq != null) return false;
        if (sex != null ? !sex.equals(userH.sex) : userH.sex != null) return false;
        if (status != null ? !status.equals(userH.status) : userH.status != null) return false;
        if (tel != null ? !tel.equals(userH.tel) : userH.tel != null) return false;
        if (userid != null ? !userid.equals(userH.userid) : userH.userid != null) return false;
        if (username != null ? !username.equals(userH.username) : userH.username != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (userid != null ? userid.hashCode() : 0);
        result = 31 * result + (loginname != null ? loginname.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (username != null ? username.hashCode() : 0);
        result = 31 * result + (sex != null ? sex.hashCode() : 0);
        result = 31 * result + (borndate != null ? borndate.hashCode() : 0);
        result = 31 * result + (company != null ? company.hashCode() : 0);
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (mobile != null ? mobile.hashCode() : 0);
        result = 31 * result + (fax != null ? fax.hashCode() : 0);
        result = 31 * result + (tel != null ? tel.hashCode() : 0);
        result = 31 * result + (qq != null ? qq.hashCode() : 0);
        result = 31 * result + (division != null ? division.hashCode() : 0);
        result = 31 * result + (createtime != null ? createtime.hashCode() : 0);
        result = 31 * result + (action != null ? action.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (createusername != null ? createusername.hashCode() : 0);
        result = 31 * result + (createuserid != null ? createuserid.hashCode() : 0);
        result = 31 * result + (createusercompany != null ? createusercompany.hashCode() : 0);
        result = 31 * result + (createuserip != null ? createuserip.hashCode() : 0);
        result = 31 * result + (createusermobile != null ? createusermobile.hashCode() : 0);
        return result;
    }

    public Double getX() {
        return x;
    }

    public void setX(Double x) {
        this.x = x;
    }

    public Double getY() {
        return y;
    }

    public void setY(Double y) {
        this.y = y;
    }

    public String getImei() {
        return imei;
    }

    public void setImei(String imei) {
        this.imei = imei;
    }
}
