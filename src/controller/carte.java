package controller;

import algorithms.Edge;
import dao.BusDaoImpl;
import dao.LigneDaoImpl;
import dao.PositionDaoImpl;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "carte", urlPatterns = "/carte")
public class carte extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int numligne;
        String ligneoptions = Utils.chargerLignes();
        Ligne ligne;

        LigneDaoImpl daoligne = new LigneDaoImpl();
        BusDaoImpl busDao = new BusDaoImpl();
        PositionDaoImpl positionDao = new PositionDaoImpl();


        if (req.getParameter("ligne") == null) {

            List<Ligne> lignelist = daoligne.findall();

            List<List<Position>> listofpos = new ArrayList<>();
            List<List<Bus>> listofbus = new ArrayList<>();


            List<Position> listpos = new ArrayList<>();
            List<Bus> lesbus = new ArrayList<>();


            for (Ligne l : lignelist) {
                if (l.getBus() == null || l.getBus().size()==0)
                    continue;

                Position pos;
                listpos = new ArrayList<>();
                lesbus = new ArrayList<>();
                for (Bus b : l.getBus()) {
                    pos = positionDao.findLastPosition(b.getName());
                    if (pos != null) {
                        listpos.add(pos);
                        lesbus.add(b);
                    }
                }

                listofpos.add(listpos);
                listofbus.add(lesbus);

            }


            req.getSession().setAttribute("listofpos", listofpos);
            req.getSession().setAttribute("listofbus", listofbus);


            req.getSession().setAttribute("lignelist", lignelist);

            req.getSession().setAttribute("lignes", ligneoptions);

            req.getRequestDispatcher("carteAll.jsp").forward(req, resp);
            return;

        } else {
            numligne = Integer.parseInt(req.getParameter("ligne"));
            ligne = daoligne.findByNumero(numligne);
        }


        for (Arret a : ligne.getArrets()) {
            System.out.print(a.getNom() + " -> ");
        }

        System.out.println();


        List<Bus> buses = busDao.findByligne(numligne);

        Position pos;
        List<Position> listpos = new ArrayList<>();
        List<Bus> lesbus = new ArrayList<>();


        for (Bus b : buses) {
            System.out.println("b = " + b.getName());
            pos = positionDao.findLastPosition(b.getName());
            if (pos != null) {
                System.out.println("pos = " + pos.toString());
                listpos.add(pos);
                lesbus.add(b);
            }
        }


        req.getSession().setAttribute("buses", lesbus);
        req.getSession().setAttribute("pos", listpos);

        req.getSession().setAttribute("ligne", ligne);
        req.getSession().setAttribute("lignes", ligneoptions);


        req.getRequestDispatcher("carte.jsp").forward(req, resp);


    }


}
