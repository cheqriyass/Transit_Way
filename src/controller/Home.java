package controller;


import dao.ArretDaoImpl;
import model.Arret;
import model.Utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "home" , urlPatterns = "/home")
public class Home extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


//        ArretDaoImpl arretDao = new ArretDaoImpl();

//        req.getSession().setAttribute("stops", arretDao.selectAllVector());


//        System.out.println("posi:");
//        for (Arret a: arretDao.selectAllVector()) {
//            System.out.println(a.getNom());
//        }

        req.getSession().setAttribute("arrets", Utils.ChargerArrets());
        req.getRequestDispatcher("index.jsp").forward(req,resp);
    }

}
