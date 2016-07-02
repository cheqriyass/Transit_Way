package controller;

import dao.BusDaoImpl;
import dao.PositionDaoImpl;
import model.Bus;
import model.Position;
import model.Utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;


@WebServlet(name = "PutServlet" , urlPatterns = "/put")
public class PutServlet extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String line=request.getParameter("gprmc");
        System.out.println("line = " + line);
        System.out.println("sender = " + request.getRemoteAddr());

        double latitude=Utils.DMCToDEC(line.split(",")[3],line.split(",")[4].charAt(0),"latt");
        double longitude=Utils.DMCToDEC(line.split(",")[5],line.split(",")[6].charAt(0),"long");

        BusDaoImpl busDao=new BusDaoImpl();

        Bus bus=busDao.findByIp(request.getRemoteAddr());

        Date date=new Date();

        Position position=new Position();
        position.setBus(bus);
        position.setLat(latitude);
        position.setLon(longitude);
        position.setLog(date);

        PositionDaoImpl dao=new PositionDaoImpl();
        dao.inserer(position);

    }

}
