package mapskin.manager.filter;


import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: daixx
 * Date: 13-9-16
 * Time: 上午11:06
 * To change this template use File | Settings | File Templates.
 */
public class LoginFilter implements Filter {

    public   void   init(FilterConfig filterConfig)   throws ServletException {
    }

    public   void   doFilter(ServletRequest request,   ServletResponse response,
                             FilterChain   chain)   throws IOException,   ServletException   {
        HttpServletRequest req   =   (HttpServletRequest)   request;
        HttpServletResponse res   =   (HttpServletResponse)   response;

        HttpSession session   =   req.getSession(true);
        /*
        //从session里取的用户名信息
        User   user   =   (User)   session.getAttribute("user");
        if(user==null){
            //跳转到登陆页面
            res.sendRedirect("../index.jsp");
        }else {
            String userName = user.getUserName();
            //判断如果没有取到用户信息,就跳转到登陆页面
            if   (userName   ==   null   ||   "".equals(userName))   {
                //跳转到登陆页面
                //res.sendRedirect("http://"+req.getHeader("Host")+"/login.jsp");
                res.sendRedirect("../index.jsp");
            }else{
                //已经登陆,继续此次请求
                chain.doFilter(request,response);
            }
        }
        */

    }

    public   void   destroy()   {
    }
}