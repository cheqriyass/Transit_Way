package model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Ordre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private int ligne_id;
    private long arret_id;


    public Ordre() {
    }


    public Ordre(int ligne_id, long arret_id) {
        this.ligne_id = ligne_id;
        this.arret_id = arret_id;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getLigne_id() {
        return ligne_id;
    }

    public void setLigne_id(int ligne_id) {
        this.ligne_id = ligne_id;
    }

    public long getArret_id() {
        return arret_id;
    }

    public void setArret_id(long arret_id) {
        this.arret_id = arret_id;
    }
}
