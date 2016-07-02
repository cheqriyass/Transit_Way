package controller;


import model.Utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "supparret" , urlPatterns = "/supparret")
public class supparret extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getSession().setAttribute("arrets", Utils.ChargerArrets());

        req.getRequestDispatcher("/SupprimerArret.jsp").forward(req, resp);

    }
}
