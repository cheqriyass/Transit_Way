package model;

import javax.persistence.*;

@NamedQuery(name="selectLigne",query="select b from Bus b where b.name=:name1")


@Entity
public class Bus {

	
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private long id;
	@Column(unique=true,nullable=false)
	private String name;
	
	@ManyToOne
	Ligne ligne;


	public Bus() {
	}

	public Bus(String name, Ligne ligne) {
		this.name = name;
		this.ligne = ligne;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setId(long id) {
		this.id = id;
	}
	public Ligne getLigne() {
		return ligne;
	}
	public void setLigne(Ligne ligne) {
		this.ligne = ligne;
	}
	
	
	
}
