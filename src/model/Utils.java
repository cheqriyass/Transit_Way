package model;

import dao.ArretDaoImpl;
import dao.LigneDaoImpl;

import java.util.*;

public class Utils {

    static public String ChargerArrets() {
        ArretDaoImpl arretDao = new ArretDaoImpl();
        List<Arret> arretslist = arretDao.selectAllOrder();


        StringBuilder sb = new StringBuilder();


        for (Arret a: arretslist) {
            sb.append("<option value=\"" + a.getNom() + "\">" + a.getNom() + "</option>");
        }

        return sb.toString();
    }


    static public String ChargerCouleurs() {
        Map<String, String> arrets = new HashMap<String, String>();
        arrets.put("Yellow", "Yellow");
        arrets.put("Green", "Green");
        arrets.put("Red", "Red");
        arrets.put("Black", "Black");
        arrets.put("Orange", "Orange");
        arrets.put("Blue", "Blue");
        arrets.put("Pink", "Pink");
        arrets.put("Brown", "Brown");
        arrets.put("Purple", "Purple");
        arrets.put("Grey", "Grey");
        arrets.put("Aqua", "Aqua");
        arrets.put("Violet", "Violet");

        Map<String, String> treeMap = new TreeMap<String, String>(arrets);


        StringBuilder sb = new StringBuilder();


        for (Map.Entry<String, String> e : treeMap.entrySet()) {
            sb.append("<option value=\"" + e.getValue() + "\">" + e.getKey() + "</option>");
        }

        return sb.toString();
    }


    public static double DMCToDEC(String value,char direc,String type)
    {
        double deg=0,min=0,sec=0;
        if(type.equals("latt"))
        {
            String pos[]=value.split("\\.");
            String pp=String.format("%04d", Integer.parseInt(pos[0]));

            deg=Double.parseDouble(pp.substring(0,2));
            min=Double.parseDouble(pp.substring(2,4)+"."+pos[1]);
            sec=0;
        }
        else
        {
            String pos[]=value.split("\\.");
            String pp=String.format("%05d", Integer.parseInt(pos[0]));

            deg=Double.parseDouble(pp.substring(0,3));
            min=Double.parseDouble(pp.substring(3,5)+"."+pos[1]);
            sec=0;
        }
        double output=deg+(((min*60)+sec)/3600);
        if ((direc == 'S') || (direc == 'W')) {
            output = -output;
        }
        return output;
    }


    static public String chargerLignes() {

        LigneDaoImpl dao = new LigneDaoImpl();
        List<Ligne> list = dao.findall();


        StringBuilder sb = new StringBuilder();

        for (Ligne l: list) {
            sb.append("<option value=\"" + l.getNumero() + "\">" + l.getNumero() + "</option>");
        }

        return sb.toString();
    }


}
