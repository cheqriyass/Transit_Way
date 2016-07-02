package dao;

import model.Arret;
import model.Ligne;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import java.util.List;
import java.util.Vector;

public class ArretDaoImpl {

	static private EntityManagerFactory ef= Persistence.createEntityManagerFactory("u1");
	static private EntityManager em=ef.createEntityManager();
	
	public int inserer(Arret a)
	{
		try{
			em.getTransaction().begin();
			em.persist(a);
			em.getTransaction().commit();
			return 1;
		}
		catch(Exception e){
			return 0;
		}
			
	}
	
	public Arret find(long id)
	{
		Arret a=em.find(Arret.class, id);
		return a;
		
	}
	
	public List<Arret> selectAll()
	{

		Query quer=em.createNamedQuery("selectAll");
		List<Arret> res=quer.getResultList();
		return res;
	}


	public List<Arret> selectAllOrder()
	{

		Query quer=em.createQuery("select a from Arret a order by a.nom Asc");
		List<Arret> res=quer.getResultList();
		return res;
	}

	public Vector<Arret> selectAllVector()
	{

		Query quer=em.createNamedQuery("selectAll");
		Vector<Arret> res= (Vector<Arret>)quer.getResultList();
		return res;
	}

//	public List<Arret> selectLigne(String nom)
//	{
//		Query quer=em.createNamedQuery("selectLigne");
//		quer.setParameter("n1", nom);
//		List<Arret> res=quer.getResultList();
//		return res;
//	}

	public int compterArret()
	{
		Query quer=em.createNamedQuery("count");
		long total=(Long) quer.getSingleResult();

		return (int)total;
	}


	public List<String> getNames()
	{
		Query quer=em.createNamedQuery("names");
		List<String> res=(List<String>) quer.getResultList();

		return res;
	}


	public void deleteByname(String name) {
		em.getTransaction().begin();

		Query q = em.createQuery("select a from Arret a where a.nom=:name");
		q.setParameter("name",name);
		Arret arret = (Arret)q.getSingleResult();



		em.remove(arret);

		int x = compterArret();
		x++;
		q = em.createNativeQuery("ALTER TABLE ARRET AUTO_INCREMENT = " + x);
		q.executeUpdate();


		em.getTransaction().commit();

	}
}
