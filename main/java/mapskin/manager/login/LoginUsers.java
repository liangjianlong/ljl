package mapskin.manager.login;

import mapskin.manager.entity.User;

import java.util.Date;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by wbz on 2015/9/20.
 */
public class LoginUsers {
    private static ConcurrentHashMap<String,User> LoginUsers = new ConcurrentHashMap<String, User>();
    private static ConcurrentHashMap<String,Date> LoginDateTime = new ConcurrentHashMap<String, Date>();
    public static User getUser(String token){
        if(LoginUsers.containsKey(token)){
            Date lastvdate = LoginDateTime.get(token);
            if(lastvdate == null){
                LoginUsers.remove(token);
                LoginDateTime.remove(token);
            }
            else{
                if(new Date().compareTo(lastvdate) > 1*60*1000){
                    LoginUsers.remove(token);
                    LoginDateTime.remove(token);
                }
            }
            addUser(token,LoginUsers.get(token));
        }
        return LoginUsers.get(token);
    }
    public static boolean removeUser(String token){
        LoginUsers.remove(token);
        LoginDateTime.remove(token);
        return true;
    }
    public static boolean addUser(String token,User user){
        LoginUsers.put(token,user);
        LoginDateTime.put(token,new Date());
        return true;
    }
    public static boolean refreshUser(){
        return true;
    }
}
