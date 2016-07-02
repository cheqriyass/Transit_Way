package model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@NamedQueries({
        @NamedQuery(name = "selectAll", query = "select a from Arret a"),
        @NamedQuery(name = "count", query = "select count(a) from Arret a "),
        @NamedQuery(name = "names", query = "select a.nom from Arret a ")
})

@Entity
public class Arret {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private long id;
    @Column(unique = true)
    private String nom;
    private double latitude;
    private double longitude;

    @ManyToMany(cascade = CascadeType.MERGE)
    List<Ligne> lignes = new ArrayList<>();


    public Arret() {
    }

    public Arret(int id, String n, double la, double lo) {
        this.id = id;
        nom = n;
        latitude = la;
        longitude = lo;
    }

    public Arret(String nom, double latitude, double longitude, Ligne ligne) {
        this.latitude = latitude;
        this.nom = nom;
        this.longitude = longitude;
//        lignes.add(ligne);
    }


    public Arret(String name)
    {
        nom=name;
    }
    public Arret(long id)
    {
        this.id=id;
    }


    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public List<Ligne> getLignes() {
        return lignes;
    }

    public void setLignes(List<Ligne> lignes) {
        this.lignes = lignes;
    }

    @Override
    public boolean equals(Object obj) {

        return id==((Arret)obj).getId() || this.nom.equals(((Arret)obj).getNom());
    }

}
