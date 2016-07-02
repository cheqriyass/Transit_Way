package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;



@WebServlet(name = "signout" , urlPatterns = "/signout")
public class signout extends HttpServlet{


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (int i=0; i<cookies.length ; i++) {
                if (cookies[i].getName().equals("username")) {
                    cookies[i].setValue("");
                    resp.addCookie(cookies[i]);
                    break;
                }
            }
        }
        req.getRequestDispatcher("/home").forward(req,resp);

    }
}
