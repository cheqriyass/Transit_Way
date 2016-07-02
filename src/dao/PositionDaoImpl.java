package dao;

import model.Arret;
import model.Bus;
import model.Position;

import javax.persistence.*;
import java.util.List;

public class PositionDaoImpl {

    EntityManagerFactory ef = Persistence.createEntityManagerFactory("u1");
    EntityManager em=ef.createEntityManager();

    public int inserer(Position p)
    {
        try{
            em.getTransaction().begin();
            em.persist(p);
            em.getTransaction().commit();
            return 1;
        }
        catch(Exception e){
            return 0;
        }

    }

    public List<Position> selectAll()
    {

        Query quer=em.createQuery("select p from Position p");
        List<Position> res=quer.getResultList();
        return res;
    }


    public Position findLastPosition(String ip) {
        TypedQuery<Position> q = em.createQuery("select p from Position p where p.bus.name=:ip order By p.log Desc", Position.class);
        q.setParameter("ip",ip);
        List<Position> list = q.getResultList();

        if (list.isEmpty()) {
            return null;
        }
        return list.get(0);
    }

}
