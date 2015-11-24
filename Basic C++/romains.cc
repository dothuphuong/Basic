//Convert arabic number into roman letter and vice versa
//Written by Thu Phuong DO
//Last modified: 2015-11-22
//Note: Coursera - Initiation C++ by Ecole Polytechnique de Lausanne

#include <iostream>
#include <string>
#include <vector>
using namespace std;

struct Alphabet {
	char romain;
	int arabe;
};

const vector<Alphabet> SYMBOLES = {
	{'M', 1000},
	{'D', 500},
	{'C', 100},
	{'L', 50},
	{'X', 10},
	{'V', 5},
	{'I', 1}
};

const int MAX = 3999;

//Convert a roman character into arabic number
int romain_en_arabe (char romain)
{
	int resultat;
	for (size_t i(0); i < SYMBOLES.size(); ++i) {
		if (romain == SYMBOLES[i].romain) {
			resultat = SYMBOLES[i].arabe;
		}
	}
	return resultat;
}

//Convert a roman string into arabic number
int romains_en_arabes(string romain)
{	
	int resultat(0);
	
	for (size_t i(0); i < (romain.size() - 1); ++i) {
		//Subtract if the value of previous letter is less than that of next letter. 
		//Example: IX
		if (romain_en_arabe(romain[i]) < romain_en_arabe(romain[i+1])) {
			resultat += - romain_en_arabe(romain[i]);
		}
		//Else: add. Example: XI
		else {
			resultat += romain_en_arabe(romain[i]) ;
		}		
	}
	resultat += romain_en_arabe(romain[romain.size()-1]);
	return resultat;
}

//Multiply a same character n times
string multiply_char (char c, int n)
{
	string mult_c;
	for (int i(1); i <= n; ++i) {
		mult_c = mult_c + c;
	}
	return mult_c;
}

string arabes_en_romains(int arabes)
{
	if (arabes > MAX) {
		return string("Out of capacity");
	}
	
	string resultat;
	for (size_t i(0); i < SYMBOLES.size(); ++i) {
		int n;		
		n = arabes/SYMBOLES[i].arabe;		
	
		if ((n >= 1) and (n<=3)) {
			//Example: 9,9x,9xx			
			if ((arabes >= SYMBOLES[i].arabe + 4*SYMBOLES[i+1].arabe)
			and (arabes < SYMBOLES[i-1].arabe) and (n != 3)) {
				resultat = resultat + SYMBOLES[i+1].romain + SYMBOLES[i-1].romain;
				arabes = arabes - SYMBOLES[i].arabe - 4*SYMBOLES[i+1].arabe;
			}
		 else {
			resultat = resultat + multiply_char(SYMBOLES[i].romain,n);
			arabes = arabes - n * SYMBOLES[i].arabe;
			}			
		}
		
		//n = 4. Example: 4x, 4xx
		else if (n == 4) {
			resultat = resultat + SYMBOLES[i].romain + SYMBOLES[i-1].romain;
			arabes = arabes - n * SYMBOLES[i].arabe;			
		}							
	}	
	return resultat;
}


/*******************************************
 *  			MAIN PROGRAM			   *
 *******************************************/

int main()
{
  string romain;

  cout << "Entrer a roman number in CAPITAL : ";
  cin >> romain;
  cout << romain << " --> " << romains_en_arabes(romain) << endl;

  int arabe(0);
  do {
    cout << "Enter an arabic number between 1 and " << MAX << " : ";
    cin >> arabe;
  } while ((arabe <= 0) or (arabe > MAX)) ;
  cout << arabe << " = " << arabes_en_romains(arabe) << endl;
}
