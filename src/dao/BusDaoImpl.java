package dao;

import model.Bus;
import model.Ligne;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import java.util.List;

public class BusDaoImpl {

    EntityManagerFactory ef = Persistence.createEntityManagerFactory("u1");
    EntityManager em = ef.createEntityManager();

    public int insert(Bus b) {
        try {
            em.getTransaction().begin();
            em.persist(b);
            em.getTransaction().commit();
            return 1;
        } catch (Exception e) {
            return 0;
        }
    }


    public List<Bus> findByligne(int numero) {
        TypedQuery<Bus> q = em.createQuery("select b from Bus b where b.ligne.numero=:numero", Bus.class);
        q.setParameter("numero",numero);
        List<Bus> list = q.getResultList();

        return list;
    }

    public Bus findByIp(String ip) {
        TypedQuery<Bus> q = em.createQuery("select b from Bus b where b.name=:ip", Bus.class);
        q.setParameter("ip",ip);
        List<Bus> list = q.getResultList();

        return list.get(0);
    }
}
