package mapskin.manager.entity;

import java.sql.Timestamp;

/**
 * Created by wbz on 2015/11/1.
 */
public class User {
    private Integer id;
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
    private Double y1;
    private Double x1;

    public Double getX1() {
        return x1;
    }

    public void setX1(Double x1) {
        this.x1 = x1;
    }

    public Double getY1() {
        return y1;
    }

    public void setY1(Double y1) {
        this.y1 = y1;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        User user = (User) o;

        if (action != null ? !action.equals(user.action) : user.action != null) return false;
        if (borndate != null ? !borndate.equals(user.borndate) : user.borndate != null) return false;
        if (company != null ? !company.equals(user.company) : user.company != null) return false;
        if (createtime != null ? !createtime.equals(user.createtime) : user.createtime != null) return false;
        if (createusercompany != null ? !createusercompany.equals(user.createusercompany) : user.createusercompany != null)
            return false;
        if (createuserid != null ? !createuserid.equals(user.createuserid) : user.createuserid != null) return false;
        if (createuserip != null ? !createuserip.equals(user.createuserip) : user.createuserip != null) return false;
        if (createusermobile != null ? !createusermobile.equals(user.createusermobile) : user.createusermobile != null)
            return false;
        if (createusername != null ? !createusername.equals(user.createusername) : user.createusername != null)
            return false;
        if (division != null ? !division.equals(user.division) : user.division != null) return false;
        if (email != null ? !email.equals(user.email) : user.email != null) return false;
        if (fax != null ? !fax.equals(user.fax) : user.fax != null) return false;
        if (id != null ? !id.equals(user.id) : user.id != null) return false;
        if (imei != null ? !imei.equals(user.imei) : user.imei != null) return false;
        if (loginname != null ? !loginname.equals(user.loginname) : user.loginname != null) return false;
        if (mobile != null ? !mobile.equals(user.mobile) : user.mobile != null) return false;
        if (password != null ? !password.equals(user.password) : user.password != null) return false;
        if (qq != null ? !qq.equals(user.qq) : user.qq != null) return false;
        if (sex != null ? !sex.equals(user.sex) : user.sex != null) return false;
        if (status != null ? !status.equals(user.status) : user.status != null) return false;
        if (tel != null ? !tel.equals(user.tel) : user.tel != null) return false;
        if (username != null ? !username.equals(user.username) : user.username != null) return false;
        if (x != null ? !x.equals(user.x) : user.x != null) return false;
        if (y != null ? !y.equals(user.y) : user.y != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
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
        result = 31 * result + (x != null ? x.hashCode() : 0);
        result = 31 * result + (y != null ? y.hashCode() : 0);
        result = 31 * result + (imei != null ? imei.hashCode() : 0);
        return result;
    }
}
