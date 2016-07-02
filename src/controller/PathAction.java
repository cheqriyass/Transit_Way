package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import algorithms.Dijkstra;
import algorithms.Edge;
import dao.ArretDaoImpl;
import dao.BusDaoImpl;
import dao.LigneDaoImpl;
import dao.PositionDaoImpl;
import model.Arret;
import model.Bus;
import model.Ligne;
import model.Position;


@WebServlet(name = "path", urlPatterns = "/path")

public class PathAction extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        ArretDaoImpl arretDao = new ArretDaoImpl();

        //calculer le plus court chemin
        Vector<Arret> edges = arretDao.selectAllVector();

        List<Ligne> lignes=new LigneDaoImpl().findStops();

        int StopNumber=new ArretDaoImpl().compterArret();
        ArrayList<ArrayList<Edge>> vois=new ArrayList<ArrayList<Edge> >();
        for (int i = 0; i < StopNumber; i++) {
            vois.add(new ArrayList<Edge>());
        }


        for (Ligne ll : lignes) {
            for (int i = 0; i < ll.getArrets().size(); i++)
                for (int j = i + 1; j < ll.getArrets().size(); j++) {
                    Arret a1 = ll.getArrets().get(i);
                    Arret a2 = ll.getArrets().get(j);
                    double coord1[] = {a1.getLatitude(), a1.getLongitude()};
                    double coord2[] = {a2.getLatitude(), a2.getLongitude()};

                    double[] res = Dijkstra.calcDistDur(coord1, coord2);
                    double[] res2 = Dijkstra.calcDistDur(coord2, coord1);

                    double dist = res[0] < res2[0] ? res[0] : res2[0];
                    double dure = res[1] < res2[1] ? res[1] : res2[1];
                    //System.out.println("here "+ res[0]+"   "+res[1]);

                    Edge e = new Edge(a1, a2, dist, dure, ll.getId());
                    Edge f = new Edge(a2, a1, dist, dure, ll.getId());

                    if (!vois.get((int) (a1.getId() - 1)).contains(e)) {
                        vois.get((int) (a1.getId() - 1)).add(e);
                        vois.get((int) (a2.getId() - 1)).add(f);
                    }

                }
        }



        Arret start = edges.get(edges.indexOf(new Arret(req.getParameter("from"))));
        Arret end = edges.get(edges.indexOf(new Arret(req.getParameter("to"))));


        int stops[]=Dijkstra.dijkstra(vois, start, end);

        ArrayList<Edge> result=new ArrayList<Edge>();
        for(int i=(int)end.getId();stops[i]!=0;i=stops[i])
        {
            Arret ss=edges.get(stops[i]-1);
            Arret rr=edges.get(i-1);
            Edge ee=new Edge(ss, rr);//edge de prev[i]->i

            Edge current=vois.get(stops[i]-1).get(vois.get(stops[i]-1).indexOf(ee));
            result.add(current);
        }





        List<Long> idlignes = new ArrayList<>();
        List<Ligne> lignelist = new ArrayList<>();

        LigneDaoImpl lignedao = new LigneDaoImpl();


        BusDaoImpl busDao = new BusDaoImpl();
        PositionDaoImpl positionDao = new PositionDaoImpl();


        List<List<Position>> listofpos = new ArrayList<>();
        List<List<Bus>> listofbus = new ArrayList<>();

//        List<Bus> buses = busDao.findByligne(numligne);
//
//        Position pos;


        List<Position> listpos = new ArrayList<>();
        List<Bus> lesbus = new ArrayList<>();



        for (Edge e: result) {
            if (!idlignes.contains(e.getLigne())){
                idlignes.add(e.getLigne());
                Ligne l = lignedao.findById(e.getLigne());
                lignelist.add(l);
                Position pos;
                listpos = new ArrayList<>();
                lesbus = new ArrayList<>();
                for (Bus b : l.getBus()) {
                    pos = positionDao.findLastPosition(b.getName());
                    if (pos != null){
                        System.out.println("pos = " + pos.toString());
                        listpos.add(pos);
                        lesbus.add(b);
                    }
                }

                listofpos.add(listpos);
                listofbus.add(lesbus);

            }
        }







        req.getSession().setAttribute("listofpos", listofpos);
        req.getSession().setAttribute("listofbus", listofbus);


        req.getSession().setAttribute("lignelist", lignelist);
        req.getSession().setAttribute("path", result);


        req.getRequestDispatcher("pathresult.jsp").forward(req,resp);
    }
}
