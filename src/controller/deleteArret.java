package controller;


import dao.ArretDaoImpl;
import dao.LigneDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "deletea" , urlPatterns = "/deleteArret")
public class deleteArret extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("arret");

        ArretDaoImpl dao = new ArretDaoImpl();
        dao.deleteByname(name);
        resp.sendRedirect("/transit/supparret");

    }
}
