package model;

import javax.persistence.*;
import java.util.Date;


@NamedQuery(name="getPosition",query = "select pos from Position pos where pos.bus.ligne.id=:id1")


@Entity
public class Position {

    @Id
    @GeneratedValue(strategy= GenerationType.SEQUENCE)
    private long id;
    @Temporal(TemporalType.TIMESTAMP)
    Date log;
    private double lat;
    private double lon;
    @ManyToOne
    private Bus bus;



    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Date getLog() {
        return log;
    }

    public void setLog(Date log) {
        this.log = log;
    }

    public double getLat() {
        return lat;
    }

    public void setLat(double lat) {
        this.lat = lat;
    }

    public double getLon() {
        return lon;
    }

    public void setLon(double lon) {
        this.lon = lon;
    }

    public Bus getBus() {
        return bus;
    }

    public void setBus(Bus bus) {
        this.bus = bus;
    }

    @Override
    public String toString() {
        return "Position{" +
                "lat=" + lat +
                ", lon=" + lon +
                '}';
    }
}
