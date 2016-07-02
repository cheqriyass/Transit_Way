package controller;


import antlr.debug.MessageAdapter;
import com.sun.xml.internal.ws.api.model.MEP;
import dao.MessageDaoImpl;
import model.Message;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "message" , urlPatterns = "/message")
public class MessageConroller extends HttpServlet{


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        MessageDaoImpl dao = new MessageDaoImpl();

        List<Message> list = dao.findall();

        req.getSession().setAttribute("messages", list);

        req.getRequestDispatcher("messages.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String subject = req.getParameter("subject");
        String message = req.getParameter("message");

        Message m = new Message(name,email,message,subject);

        System.out.println("m = " + m);

        MessageDaoImpl dao = new MessageDaoImpl();
        dao.insert(m);

        req.getRequestDispatcher("index.jsp").forward(req,resp);
    }
}
