package algorithms;

import com.google.maps.DistanceMatrixApi;
import com.google.maps.GeoApiContext;
import com.google.maps.model.DistanceMatrix;
import com.google.maps.model.LatLng;

import model.Arret;

public class Edge implements Comparable<Edge>{

	private Arret from;
	private Arret to;
	private double distance;
	private double width;
	private double time;
	private long ligne;


	public Edge(Arret f,Arret t,double dist,double ti,long id)
	{
		from=f;
		to=t;
		time=ti;
		distance=dist;
		width=dist;
		ligne=id;
	}
	public Edge(){};

	public Edge(Arret start,Arret arr)
	{
		from=start;
		to=arr;
	}

	public long getLigne() {
		return ligne;
	}

	public void setLigne(long ligne) {
		this.ligne = ligne;
	}


	public Arret getFrom() {
		return from;
	}
	public void setFrom(Arret from) {
		this.from = from;
	}
	public Arret getTo() {
		return to;
	}
	public void setTo(Arret to) {
		this.to = to;
	}
	public double getDistance() {
		return distance;
	}
	public void setDistance(double distance) {
		this.distance = distance;
	}

	public double getWidth() {
		return width;
	}

	public void setWidth(double width) {
		this.width = width;
	}

	public double getTime() {
		return time;
	}
	public void setTime(double time) {
		this.time = time;
	}

	public int compareTo(Edge o) {
		if(distance>o.distance)
			return -1;
		else if(distance<o.distance)
			return 1;
		return 0;
	}
	@Override
	public String toString() {

		return "from :"+from.getNom()+" to : "+to.getNom()+" dist: "+distance+" duration : "+time+" ligne: "+ligne;
	}

	@Override
	public boolean equals(Object ee) {

		return ((Edge)ee).from.equals(this.from) && ((Edge)ee).to.equals(this.to);

	}





}
