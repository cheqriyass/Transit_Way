package algorithms;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.PriorityQueue;
import java.util.concurrent.TimeUnit;

import com.google.maps.DistanceMatrixApi;
import com.google.maps.GeoApiContext;
import com.google.maps.model.DistanceMatrix;
import com.google.maps.model.LatLng;

import model.Arret;

public class Dijkstra {


	public static int[] dijkstra(ArrayList<ArrayList<Edge>> vois,Arret src,Arret dest)
	{
		PriorityQueue<Edge> q=new PriorityQueue<Edge>();
		double dist[]=new double[vois.size()+1];
		int prev[]=new int[vois.size()+1];
		for(int i=0;i<vois.size()+1;i++)
		{
			dist[i]=(int) 1e6;
			prev[i]=-1;
		}

		dist[(int) src.getId()]=0;

		Arret begin=new Arret();
		begin.setId(0);
		begin.setLatitude(0);
		begin.setLongitude(0);begin.setNom("");

		q.add(new Edge(new Arret(),src,0,0,0));

		while(q.size()!=0)
		{
			Edge e=q.poll();
			if(e.getWidth()>dist[(int) e.getTo().getId()]){
				continue;
			}

			prev[(int) e.getTo().getId()]=(int) e.getFrom().getId();
			for(int j=0;j<vois.get((int) e.getTo().getId()-1).size();j++)
			{
				//System.out.println("here");
				Edge ne=vois.get((int) e.getTo().getId()-1).get(j);
				BigDecimal d1=BigDecimal.valueOf(dist[(int) ne.getFrom().getId()]);
				BigDecimal d2=BigDecimal.valueOf(ne.getWidth());
				double dst=d1.add(d2).doubleValue();

				if(dist[(int) ne.getTo().getId()]>dst)
				{
					//if(ne.getTo().getNom().equals("ensa"))
					//	System.out.println(ne.getFrom().getNom()+" :  "+dist[(int) ne.getFrom().getId()]+"   "+ne.getWidth());

					dist[(int) ne.getTo().getId()]=dst;
					ne.setWidth(dst);

					//if(ne.getTo().getNom().equals("ensa")) {
					//System.out.println(ne.getFrom().getNom() + " :  " + dist[(int) ne.getFrom().getId()] + "   " + ne.getWidth());

					//}
					q.add(ne);
				}
			}
		}

		return prev;
	}



	static public double[] calcDistDur(double depart[], double arrive[]){
//		GeoApiContext context = new GeoApiContext().setApiKey("AIzaSyBr4rYLJirubQX8aZgF6I-7ylwCzSzrMJ8");
		GeoApiContext context = new GeoApiContext().setApiKey("AIzaSyAkB3oJ1rKgHxV1vFa3vmOO1cTnNu_imgc");
//		GeoApiContext context = new GeoApiContext().setApiKey("AIzaSyAtOb8DSUoz15hUC0-kjN__mNA9Vliezxw");
//		GeoApiContext context = new GeoApiContext().setApiKey("AIzaSyDUbT3DWSHg9hdrgPwGC8-yQZar5dxyIJY");
		context.setRetryTimeout(0, TimeUnit.MINUTES);
		double res[] = new double[2];
		try {
			DistanceMatrix matrix =  DistanceMatrixApi.newRequest(context)
					.origins(new LatLng(depart[0], depart[1]))
					.destinations(new LatLng(arrive[0],arrive[1]))
					.awaitIgnoreError();

			res[0] = Double.parseDouble(matrix.rows[0].elements[0].distance.humanReadable.split(" ")[0]);
			res[1] = Double.parseDouble(matrix.rows[0].elements[0].duration.humanReadable.split(" ")[0]);


		} catch (Exception e1) {
			e1.printStackTrace();
		}
		return res;
	}

/*	public static void main(String[] args)
	{
		ArrayList<ArrayList<Edge>> vois=new ArrayList<ArrayList<Edge>>();

		ArrayList<Edge> e1=new ArrayList<Edge>();
		Arret a1=new Arret(1,"casa",12,12.2);
		Arret a2=new Arret(2,"asd",12,12.2);
		Arret a4=new Arret(3,"ssdsd",12,12.2);
		Arret a5=new Arret(4,"roioti",12,12.2);
		Arret a6=new Arret(5,"cado",12,12.2);
		Arret a7=new Arret(6,"sabt",12,12.2);
		Arret a8=new Arret(7,"had",12,12.2);
		Edge a=new Edge(a1,a2,3,0);
		Edge c=new Edge(a1,a6,45,0);
		Edge d=new Edge(a2,a1,3,0);
		Edge e=new Edge(a2,a4,14);
		Edge r=new Edge(a2,a5,10);
		Edge f=new Edge(a5,a2,10);
		Edge h=new Edge(a5,a8,85);
		Edge i=new Edge(a5,a7,9);
		Edge j=new Edge(a8,a7,6);
		Edge u=new Edge(a8,a5,85);
		Edge l=new Edge(a7,a6,4);
		Edge m=new Edge(a7,a5,9);
		Edge z=new Edge(a7,a8,6);
		Edge n=new Edge(a6,a4,3);
		Edge o=new Edge(a6,a1,45);
		Edge v=new Edge(a6,a7,4);
		Edge p=new Edge(a4,a2,14);
		Edge y=new Edge(a4,a6,3);

		e1.add(a);		e1.add(c);			vois.add(e1);   ArrayList<Edge> e2=new ArrayList<Edge>();
		e2.add(d);e2.add(r);	e2.add(e);	vois.add(e2);   ArrayList<Edge> e3=new ArrayList<Edge>();
		e3.add(p);e3.add(y); 				vois.add(e3);   ArrayList<Edge> e4=new ArrayList<Edge>();
		e4.add(h); e4.add(i);e4.add(f);		vois.add(e4);   ArrayList<Edge> e5=new ArrayList<Edge>();
		e5.add(n); e5.add(o);e5.add(v);		vois.add(e5);   ArrayList<Edge> e6=new ArrayList<Edge>();
		e6.add(l);   e6.add(m);	e6.add(z);	vois.add(e6);   ArrayList<Edge> e7=new ArrayList<Edge>();
		e7.add(j);e7.add(u);				vois.add(e7);

		Dijkstra dd=new Dijkstra();
		int mat[]=dd.dijkstra(vois,a1,a8);

		for(int i1=0;i1<mat.length;i1++)
			System.out.println(mat[i1]);

		for(int h1=(int) a8.getId();mat[h1]!=0;h1=mat[h1])
			System.out.print(h1+"   ");
		System.out.print(a1.getId());


	}
	*/

}
