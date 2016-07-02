package controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import dao.ArretDaoImpl;
import dao.LigneDaoImpl;
import model.Arret;
import model.Ligne;
import model.Utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "addLigne" , urlPatterns = "/addLigne")
public class addLigne extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ArretDaoImpl dao = new ArretDaoImpl();
        List<Arret> list = dao.selectAll();

        req.getSession().setAttribute("arrets",list);
        req.getSession().setAttribute("couleurs", Utils.ChargerCouleurs());

        req.getRequestDispatcher("addLigne.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String data = req.getParameter("data");
        int numero = Integer.parseInt(req.getParameter("numero"));
        String couleur = req.getParameter("couleur");

        List<Arret> yourList = new Gson().fromJson(data, new TypeToken<List<Arret>>(){}.getType());
        for (Arret a : yourList){
            System.out.println( "#####" + a.getNom() + " " + a.getLatitude() + " " + a.getLongitude());
        }

        System.out.println("couleur = " + couleur);
        System.out.println("numero = " + numero);

        Ligne ligne = new Ligne();

        ligne.setCouleur(couleur);
        ligne.setNumero(numero);
        List<Arret> list = new ArrayList<>();

        for (Arret a : yourList){
           list.add(new Arret(a.getNom(), a.getLatitude(),a.getLongitude(),ligne));
        }

        ligne.setArrets(list);

        LigneDaoImpl ligneDao = new LigneDaoImpl();
        ligneDao.insert(ligne);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write("hello");
        resp.getWriter().close();
    }
}
