package dao;

import model.Ligne;
import model.Message;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import java.util.List;

public class MessageDaoImpl {

    EntityManagerFactory ef = Persistence.createEntityManagerFactory("u1");
    EntityManager em = ef.createEntityManager();

    public int insert(Message m) {
        try {
            em.getTransaction().begin();
            em.persist(m);
            em.getTransaction().commit();
            return 1;
        } catch (Exception e) {
            return 0;
        }
    }

    public List<Message> findall()
    {
        try{
            em.getTransaction().begin();
            Query quer=em.createQuery("select l from Message l order by l.timestamp Desc");
            List<Message> result=quer.getResultList();
            return result;
        }
        catch(Exception e){
            return null;
        }
    }


}
