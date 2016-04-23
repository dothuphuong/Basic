/*Written by Thu Phuong DO
Last modified: 2016-03-20
Graded exam assignment Week 4
Note: Coursera - Introduction C++ by Ecole Polytechnique de Lausanne*/

#include <iostream>
#include <string>
using namespace std;

class Timbre
{
private:
  static constexpr unsigned int ANNEE_COURANTE = 2016;

  /*****************************************************
   * Compléter le code à partir d'ici
   *****************************************************/
protected:
	string nom;
	unsigned int annee;
	string pays;
	double valeur_faciale;
	
public:
	//constructeur avec pays et valeur faciale par defaut
	Timbre(const string& n, const unsigned int& a, const string& p = "Suisse", const double& v = 1.0)
	: nom(n), annee(a), pays(p), valeur_faciale(v) {}
	
	unsigned int age() {
		return ANNEE_COURANTE - annee;
	}
	
	double prix() {
		if (age() < 5) {
			return valeur_faciale;
		}
		else {
			return valeur_faciale * 2.5 * age();
		}
	}
	
	double vente() {
		return prix();
	}
	
	ostream& afficher(ostream& sortie, const string pre = "") const {
		 return sortie << pre << "de nom " << nom << " datant de " << annee << " (provenance " << pays <<
		 ") ayant pour valeur faciale " << valeur_faciale << " francs";
	}	
};
	

class Rare : public Timbre {
	private:
	unsigned int nb_exemplaires_;
	static constexpr double PRIX_BASE_TRES_RARE = 600.0;
	static constexpr double PRIX_BASE_RARE = 400.0;
	static constexpr double PRIX_BASE_PEU_RARE = 50.0;
	
	public:
	Rare(const string& nom, const unsigned int& annee, const string& pays = "Suisse", 
		 const double valeur_faciale = 1.0, unsigned int nb = 100)
	:Timbre(nom, annee, pays, valeur_faciale),
	nb_exemplaires_(nb) {}
	
	unsigned int nb_exemplaires() {
		return nb_exemplaires_;
	}
	
	ostream& afficher(ostream& sortie) const {
		 return sortie << "Timbre rare (" << nb_exemplaires_ << " ex.) de nom " << nom << " datant de " << annee << " (provenance " << pays <<
		 ") ayant pour valeur faciale " << valeur_faciale << " francs";
	}
	
	double vente() {
		double prix_base(0.0);
		if (nb_exemplaires_ < 100) {
			prix_base = PRIX_BASE_TRES_RARE;
		}
		else if((nb_exemplaires_ > 100) && (nb_exemplaires_ < 1000)) {
			prix_base = PRIX_BASE_RARE;
		}
		else {
			prix_base = PRIX_BASE_PEU_RARE;
		}
		return prix_base * age() / 10.0;
	}
};

class Commemoratif : public Timbre {
	public:
	Commemoratif(const string& nom, const unsigned int& annee, const string& pays = "Suisse",
				const double& valeur_faciale = 1.0)
	:Timbre(nom, annee, pays, valeur_faciale) {}
	
	
	double vente() {
		return prix() * 2.0;
	}
};

	ostream& operator<<(ostream& sortie, const Timbre& t) {
		return t.afficher(sortie, "Timbre ");
	}
	
	ostream& operator<<(ostream& sortie, Rare& r) {
		return r.afficher(sortie);
	}
	
	ostream& operator<<(ostream& sortie, Commemoratif& c) {
		return c.afficher(sortie, "Timbre commémoratif ");
	} 

/*******************************************
 * Ne rien modifier après cette ligne.
 *******************************************/
int main()
{
  /* Ordre des arguments :
  *  nom, année d'émission, pays, valeur faciale, nombre d'exemplaires
  */
  Rare t1( "Guarana-4574", 1960, "Mexique", 0.2, 98 );
  Rare t2( "Yoddle-201"  , 1916, "Suisse" , 0.8,  3 );

  /* Ordre des arguments :
  *  nom, année d'émission, pays, valeur faciale, nombre d'exemplaires
  */
  Commemoratif t3( "700eme-501"  , 2002, "Suisse", 1.5 );
  Timbre       t4( "Setchuan-302", 2004, "Chine" , 0.2 );

  /* Nous n'avons pas encore le polymorphisme :-(
   * (=> pas moyen de faire sans copie ici :-( )  */
  cout << t1 << endl;
  cout << "Prix vente : " << t1.vente() << " francs" << endl;
  cout << t2 << endl;
  cout << "Prix vente : " << t2.vente() << " francs" << endl;
  cout << t3 << endl;
  cout << "Prix vente : " << t3.vente() << " francs" << endl;
  cout << t4 << endl;
  cout << "Prix vente : " << t4.vente() << " francs" << endl;

  return 0;
}
