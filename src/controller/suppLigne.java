package controller;


import model.Utils;

import javax.rmi.CORBA.Util;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "suppligne" , urlPatterns = "/suppligne")
public class suppLigne extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getSession().setAttribute("lignes", Utils.chargerLignes());

        req.getRequestDispatcher("/supprimerLigne.jsp").forward(req, resp);

    }
}
