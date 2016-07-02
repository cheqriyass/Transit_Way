package controller;

import com.google.gson.Gson;
import dao.BusDaoImpl;
import dao.PositionDaoImpl;
import model.Bus;
import model.JsonRespoPos;
import model.Position;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@WebServlet(name = "refresh" , urlPatterns = "/refresh")
public class refreshPos extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

//        System.out.println("***********ligne = " + req.getParameter("ligne"));

        int ligne = Integer.parseInt(req.getParameter("ligne"));



        BusDaoImpl busDao = new BusDaoImpl();
        PositionDaoImpl positionDao = new PositionDaoImpl();


        List<Bus> buses = busDao.findByligne(ligne);

        Position pos;
        List<JsonRespoPos> listpos = new ArrayList<>();





        for (Bus b : buses) {
            pos = positionDao.findLastPosition(b.getName());

            if (pos != null){
//                System.out.println("++++pos: " + pos);
                listpos.add(new JsonRespoPos(b.getName(), pos.getLat(), pos.getLon()));
            }
        }



        Gson gson = new Gson();


        String json = gson.toJson(listpos);


        PrintWriter out = resp.getWriter();


        out.println(json);
        out.close();
    }
}
