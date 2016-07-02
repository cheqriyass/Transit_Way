package controller;


import dao.LigneDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "deletel" , urlPatterns = "/deleteLigne")
public class deleteLigne extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int num = Integer.parseInt(req.getParameter("ligne"));

        LigneDaoImpl dao = new LigneDaoImpl();
        dao.deleteBynum(num);

        resp.sendRedirect("/transit/home");

    }
}
