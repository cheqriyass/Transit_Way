package controller;

import dao.PositionDaoImpl;
import model.Position;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "show Pos", urlPatterns = "/showPos")
public class showPositions extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PositionDaoImpl dao = new PositionDaoImpl();
        List<Position> list = dao.selectAll();

        req.getSession().setAttribute("positions", list);

        req.getRequestDispatcher("/WEB-INF/showPos.jsp").forward(req,resp);
    }
}
