/*Written by Thu Phuong DO
Last modified: 2016-02-03
Graded exam assignment Week 2
Note: Coursera - Introduction C++ by Ecole Polytechnique de Lausanne*/

#include <iostream>
using namespace std;

class Souris
{
  /*****************************************************
    Compléter le code à partir d'ici
  *******************************************************/
//Public methods
public:
	Souris(double p, string c, unsigned int a = 0, unsigned int v = 36)
	: poids(p), couleur(c), age(a), esperance_vie(v), clonee(false)
	{cout << "Une nouvelle souris !" << endl;}
	
	Souris(Souris const& s)
	: poids(s.poids), couleur(s.couleur), age(s.age), 
	esperance_vie(s.esperance_vie * 4/5), clonee(true)
	{cout << "Clonage d'une souris !" << endl;}
	
	~Souris() {cout << "Fin d'une souris..." << endl;}
	
	void afficher() const {
		cout << "Une souris " << couleur;
		if (clonee == true) {
			cout << ", clonee,";
		}		
		cout << " de " << age << " mois et pesant " << poids << " grammes" << endl;
	}
	
	void vieillir() {
		age++;
		if ((clonee == true) && (age > 0.5 * esperance_vie)) {
			couleur = "verte";
		}
	}
	
	void evolue() {
		while (age < esperance_vie) {
			vieillir();
		}
	}
//Properties
private:
	double poids;
	string couleur;
	unsigned int age;
	unsigned int esperance_vie;
	bool clonee;
	
  /*******************************************
   * Ne rien modifier après cette ligne.
   *******************************************/

}; // fin de la classe Souris

int main()
{
  Souris s1(50.0, "blanche", 2);
  Souris s2(45.0, "grise");
  Souris s3(s2);
  // ... un tableau peut-être...
  s1.afficher();
  s2.afficher();
  s3.afficher();
  s1.evolue();
  s2.evolue();
  s3.evolue();
  s1.afficher();
  s2.afficher();
  s3.afficher();
  return 0;
}
