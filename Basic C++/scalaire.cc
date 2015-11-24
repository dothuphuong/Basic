//Scalar sum product of 2 vectors
//Written by: Thu Phuong DO
//Last modified: 2015-11-23
//Note: Coursera - Initation C++ by Ecole Polytechnique de Lausanne

#include <iostream>
#include <vector>
using namespace std;

//-----------------Prototype------------------------
double sumproduct(vector<double> u, vector<double> v);
vector<double> vector_element(int n);
//--------------------------------------------------

int main ()
{
	vector<double> v1;
	vector<double> v2;
	
	int N_max(5);
	
	int n;
	do {
		cout << "What is the size of vector ? ";
		cin >> n;
	} while (n > N_max);
	
	v1 = vector_element(n);
	v2 = vector_element(n);
	
	cout << scalaire(v1,v2) << endl;
	return 0;
}

//Scalar sum product of 2 vectors
double sumproduct(vector<double> u, vector<double> v)
{
	double prod (0.0);
	for (size_t i(0); i < u.size(); ++i) {
			prod += u[i] * v[i];
	}
	return prod;
}

//Enter the components of vector
vector<double> vector_element(int n)
{
	vector<double> v(n);
	
	cout << "Enter the components of the vector : " << endl;
	for (int i(0); i < n; ++i) {
		cout << "Enter element " << i << ": ";
		cin >> v[i];
	}
	return v;
}
