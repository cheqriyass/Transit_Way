package controller;

import dao.BusDaoImpl;
import dao.LigneDaoImpl;
import model.Bus;
import model.Ligne;
import model.Utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(name = "addbus" , urlPatterns = "/addBus")
public class addBus extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String lignes = Utils.chargerLignes();
        req.getSession().setAttribute("lignes",lignes);

        System.out.println("lignes = " + lignes);
        
        req.getRequestDispatcher("addBus.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String ip = req.getParameter("busid");
        int numligne = Integer.parseInt(req.getParameter("ligne"));

        LigneDaoImpl lignedao = new LigneDaoImpl();
        Ligne ligne = lignedao.findByNumero(numligne);

        Bus bus = new Bus(ip,ligne);


        BusDaoImpl busdao = new BusDaoImpl();
        busdao.insert(bus);

        req.getRequestDispatcher("index.jsp").forward(req,resp);

    }
}
