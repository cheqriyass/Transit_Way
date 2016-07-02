import com.google.gson.Gson;
import dao.PositionDaoImpl;
import javafx.geometry.Pos;
import model.JsonRespoPos;
import model.Position;

import java.util.ArrayList;

public class test {
    public static void main(String[] args) {
        ArrayList<JsonRespoPos> list = new ArrayList<>();
        PositionDaoImpl dao = new PositionDaoImpl();


        Position p = dao.findLastPosition("192.168.0.105");
        System.out.println("p = " + p);
        list.add(new JsonRespoPos("192.168.0.105", p.getLat(), p.getLon()));
//        list.add(dao.findLastPosition("12.12.1.2"));



        String json = new Gson().toJson(list);

        System.out.println("json = " + json);
    }
}
