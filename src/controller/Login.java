package controller;


import dao.UserDaoImpl;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(name = "login" , urlPatterns = "/login")
public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getSession().removeAttribute("loginerror");
        req.getRequestDispatcher("/WEB-INF/loginForm.jsp").forward(req,resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        UserDaoImpl dao = new UserDaoImpl();
        User user = dao.findByCredentials(username,password);

        req.getSession().removeAttribute("loginerror");
        req.getSession().setAttribute("username",username );

        if (user==null){
            System.out.println("********* null ");
            req.getSession().setAttribute("loginerror", "email or password incorrect!");
            req.getRequestDispatcher("/WEB-INF/loginForm.jsp").forward(req,resp);

        }else {
            System.out.println("********* not null ");

            Cookie cookie = new Cookie("username", username);
            cookie.setMaxAge(60*60*24*30);
            resp.addCookie(cookie);

            req.getSession().setAttribute("user",user);

            resp.sendRedirect("/transit/home");
        }

    }
}
