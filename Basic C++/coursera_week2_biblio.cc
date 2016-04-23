/*Written by Thu Phuong DO
Last modified: 2016-02-03
Graded exam assignment Week 2
Note: Coursera - Introduction C++ by Ecole Polytechnique de Lausanne*/

#include <iostream>
#include <vector>
#include <string>
using namespace std;

/*******************************************
 * Completez le programme a partir d'ici.
 *******************************************/
class Auteur {
	public:
	//constructor
	Auteur(string n, bool p = false)
	: nom(n), prime(p)
	{}
	
	//do not allow to copy class Auteur
	Auteur(Auteur const&) = delete;
	
	string getNom() const {return nom;}
	bool getPrix() const {return prime;}
	
	private:
	string nom;
	bool prime;
};

class Oeuvre {
	public:
	Oeuvre(string t, const Auteur& a, string l)
	: titre(t), auteur(a), langue(l) 
	{}
	
	//do not allow to copy Oeuvre
	Oeuvre(Oeuvre const&) = delete;
	
	string getTitre() const {return titre;}
	const Auteur& getAuteur() const {return auteur;}
	string getLangue() const {return langue;}
	
	void affiche() const {
		cout << titre << ", " << auteur.getNom() << ", en " << langue;
	}
	
	
	~Oeuvre() {
		cout << "L'oeuvre " << "\"";
		affiche();
		cout << "\"" << " n'est plus disponible." << endl;
	}
	
	private:
	string titre;
	const Auteur& auteur;
	string langue;
};

class Exemplaire {
	public:
	Exemplaire(const Oeuvre& o)
	: oeuvre(o) {
		cout << "Nouvel exemplaire de : ";
		oeuvre.affiche();
		cout << endl;
	}
	
	Exemplaire(Exemplaire& e) 
	:oeuvre(e.getOeuvre())
	{
		cout << "Copie d'un exemplaire de : ";
		e.getOeuvre().affiche();
		cout << endl;
	}
	
	~Exemplaire() {
		cout << "Un exemplaire de " << "\"";
		oeuvre.affiche();
	    cout << "\"" << " a été jeté !" << endl;	
	}
	
	const Oeuvre& getOeuvre() const {return oeuvre;}
	
	void affiche(){
		cout << "Exemplaire de : ";
		oeuvre.affiche();
		cout << endl;
	}
	
	private:
	const Oeuvre& oeuvre;
};

class Bibliotheque {
	public:
	Bibliotheque(string n): nom(n){
		cout << "La bibliothèque " << nom << " est ouverte !" << endl;
	}
	
	~Bibliotheque() {
		cout << "La bibliothèque " << nom << " ferme ses portes," << endl;
		cout << "et détruit ses exemplaires : " << endl;
		for (auto exemplaire : exemplaires) {delete exemplaire;}
	}
	
	string getNom() const {return nom;}
	
	void stocker(Oeuvre& o, int n = 1) {
		for (int i=1; i<= n; ++i) {
			exemplaires.push_back(new Exemplaire(o));
		}
	}
	
	void lister_exemplaires(string langue = "") {
		if (langue == ""){
			for (auto exemplaire : exemplaires) {
				exemplaire->affiche();
			}
		}
		else {
			for (auto exemplaire : exemplaires) {
				if (exemplaire->getOeuvre().getLangue() == langue) {
					exemplaire->affiche();
				}
			}
		}
	}
	
	unsigned int compter_exemplaires(Oeuvre& o) {
		unsigned int n = 0;
		for (auto exemplaire : exemplaires) {
			if (exemplaire->getOeuvre().getTitre() == o.getTitre()) {
				n+=1;
			}
		}
		return n;
	}
	
	void afficher_auteurs(bool prix = false) {
		if (not prix) {
			for (auto exemplaire : exemplaires) {
				cout << exemplaire->getOeuvre().getAuteur().getNom() << endl;
			}
		}
		else {
			for (auto exemplaire : exemplaires) {
				if (exemplaire->getOeuvre().getAuteur().getPrix()) {
					cout << exemplaire->getOeuvre().getAuteur().getNom() << endl;
				}
			}
		}
	}
		
	private:
	string nom;
	vector<Exemplaire*> exemplaires;
};

/*******************************************
 * Ne rien modifier apres cette ligne.
 *******************************************/

int main()
{
  Auteur a1("Victor Hugo"),
         a2("Alexandre Dumas"),
         a3("Raymond Queneau", true);

  Oeuvre o1("Les Misérables"           , a1, "français" ),
         o2("L'Homme qui rit"          , a1, "français" ),
         o3("Le Comte de Monte-Cristo" , a2, "français" ),
         o4("Zazie dans le métro"      , a3, "français" ),
         o5("The Count of Monte-Cristo", a2, "anglais" );

  Bibliotheque biblio("municipale");
  biblio.stocker(o1, 2);
  biblio.stocker(o2);
  biblio.stocker(o3, 3);
  biblio.stocker(o4);
  biblio.stocker(o5);

  cout << "La bibliothèque " << biblio.getNom()
       << " offre les exemplaires suivants :" << endl;
  biblio.lister_exemplaires();

  const string langue("anglais");
  cout << " Les exemplaires en "<< langue << " sont :" << endl;
  biblio.lister_exemplaires(langue);

  cout << " Les auteurs à succès sont :" << endl;
  biblio.afficher_auteurs(true);

  cout << " Il y a " << biblio.compter_exemplaires(o3) << " exemplaires de "
       << o3.getTitre() << endl;

  return 0;
}
