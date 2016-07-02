package model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

//@NamedQuery(name = "selectArretLigne", query = "select distinct l from Ligne l join fetch l.arrets ")
@NamedQuery(name = "selectArretLigne", query = "select l from Ligne l ")

@Entity
public class Ligne {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @Column(unique = true, nullable = false)
    private int numero;
    private String couleur;

    @ManyToMany(mappedBy = "lignes")
    List<Arret> arrets;

    @OneToMany(mappedBy = "ligne")
    List<Bus> bus;


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public String getCouleur() {
        return couleur;
    }

    public void setCouleur(String couleur) {
        this.couleur = couleur;
    }

    public List<Arret> getArrets() {
        return arrets;
    }

    public void setArrets(List<Arret> arrets) {
        this.arrets = arrets;
    }

    public List<Bus> getBus() {
        return bus;
    }

    public void setBus(List<Bus> bus) {
        this.bus = bus;
    }


}
