package dao;

import model.Arret;
import model.Bus;
import model.Ligne;
import model.Ordre;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

public class LigneDaoImpl {

	EntityManagerFactory ef= Persistence.createEntityManagerFactory("u1");
	EntityManager em=ef.createEntityManager();

	public Ligne find(long id)
	{
		Ligne a=em.find(Ligne.class, id);
		return a;

	}

	//fetch stops
	public List<Ligne> findStops()
	{
		try{
			Query quer=em.createNamedQuery("selectArretLigne");
			List<Ligne> result=quer.getResultList();
			return result;
		}
		catch(Exception e){
			return null;
		}
	}


    public Ligne findById(long id)
    {
        Ligne a=em.find(Ligne.class, id);
        a.setArrets(findarret(a.getNumero()));
        return a;

    }



    public List<Ligne> findall()
    {
        try{
            Query quer=em.createQuery("select l from Ligne l order by l.numero");
            List<Ligne> result=quer.getResultList();

            for (int i = 0; i < result.size(); i++) {
                result.get(i).setArrets(findarret(result.get(i).getNumero()));
            }

            return result;
        }
        catch(Exception e){
            return null;
        }
    }

    public int insert(Ligne l) {

        try {
            em.getTransaction().begin();

            Ligne ligne = new Ligne();
            ligne.setNumero(l.getNumero());
            ligne.setCouleur(l.getCouleur());
            List<Arret> arrets = null;


            em.persist(ligne);

            for ( Arret a : l.getArrets() ) {
                Query q = em.createQuery("select a from Arret a where a.nom=:nom");
                q.setParameter("nom",a.getNom());
                arrets = (List<Arret>)q.getResultList();


                if (arrets.size() != 0){ // Arret exist
//                    arrets.add(arret);
                    arrets.get(0).getLignes().add(ligne);
                    em.merge(arrets.get(0));
                    em.persist(new Ordre(ligne.getNumero(),arrets.get(0).getId()));
                } else{
                    a.getLignes().add(ligne);
                    Arret arr = a;
                    em.persist(arr);
                    em.flush();
                    em.persist(new Ordre(ligne.getNumero(),arr.getId()));

//                    arrets.add(a);
                }
            }

//            ligne.setArrets(arrets);
//            em.persist(ligne);


            em.getTransaction().commit();
            return 1;
        } catch (Exception e) {
            return 0;
        }
    }


    public Ligne findByNumero(int numero) {
        Query q = em.createQuery("select l from Ligne l where l.numero=:numero");
        q.setParameter("numero",numero);
        Ligne ligne = (Ligne)q.getSingleResult();

        ligne.setArrets(findarret(numero));

        return ligne;
    }



    public List<Arret> findarret(int ligne){
        List<Arret> arretList = new ArrayList<>();

        Query q = em.createQuery("select o from Ordre o where o.ligne_id =:ligne");
        q.setParameter("ligne", ligne);

        List<Ordre> ordreList = q.getResultList();

        ArretDaoImpl dao = new ArretDaoImpl();

        for (Ordre o:ordreList) {
            arretList.add(dao.find(o.getArret_id()));
        }


        return arretList;
    }

    public void deleteBynum(int num) {

        em.getTransaction().begin();

        Query q = em.createQuery("select l from Ligne l where l.numero=:numero");
        q.setParameter("numero",num);
        Ligne ligne = (Ligne)q.getSingleResult();


        q = em.createQuery("delete from Ordre o where o.ligne_id=:numero");
        q.setParameter("numero",ligne.getNumero());
        q.executeUpdate();


        q = em.createNativeQuery("delete from ARRET_LIGNE where lignes_ID = ?");
        q.setParameter(1,ligne.getId());
        q.executeUpdate();

        for (Bus b: ligne.getBus()) {

            q = em.createQuery("delete from Position o where o.bus.name=:ip");
            q.setParameter("ip",b.getName());
            q.executeUpdate();
            em.remove(b);

        }

        em.remove(ligne);

        em.getTransaction().commit();

    }
}
