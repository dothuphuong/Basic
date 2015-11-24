//Multiply matrices
//Written by: Thu Phuong DO
//Last modified: 2015-11-23
//Note: Coursera - Initation C++ by Ecole Polytechnique de Lausanne

#include <iostream>
#include <vector>
using namespace std;

//-------------------------PROTOTYPE------------------------------------
vector<vector<double>> read_matrix();
vector<vector<double>> multMat(const vector<vector<double>>& Mat1,
                               const vector<vector<double>>& Mat2);
void display_matrix(const vector<vector<double>> M);
//----------------------------------------------------------------------
                                
int main()
{
	vector<vector<double>> M1(read_matrix());
	
	vector<vector<double>> M2(read_matrix());
	
	if (M1[0].size() != M2.size()) {
		cout << "Matrix multiplication is impossible !" << endl;
	}
	else {
		cout << "Result" << endl;
		display_matrix(multMat(M1,M2));
	}
	return 0;
}

//--------------------------------------------------------------------//
//Read matrix
vector<vector<double>> read_matrix()
{
	cout << "Fill in the content of matrix" << endl;
	
	unsigned int l; //number of rows
	do {
		cout << "Number of rows : ";
		cin >> l;
	} while (l < 1);
	
	unsigned int c; //number of columns
	do {
		cout << "Number of colums : ";
		cin >> c;
	} while (c < 1);
	
	vector<vector<double> > M(l, vector<double>(c));	
	for (unsigned int i(0); i < l; ++i) {
		for (unsigned int j(0); j < c; ++j) {
			cout << "M[" << i+1 << "," << j+1 << "] = ";
			cin >> M[i][j];
		}
	}
	return M;
}

//--------------------------------------------------------------------//
//Multiply 2 matrix
vector<vector<double>> multMat(const vector<vector<double>>& Mat1,
                                      const vector<vector<double>>& Mat2)
{	
	//Create vector result with the same number of rows as Mat1
	//and the same number of columns as Mat2
	vector<vector<double>> result(Mat1.size(), vector<double>(Mat2[0].size()));
	
	for (size_t i(0); i < Mat1.size(); ++i) {
		for (size_t j(0); j < Mat2[0].size(); ++j) {
			for (size_t k(0); k < Mat2.size(); ++k) {
				result[i][j] += Mat1[i][k] * Mat2[k][j];
			}
		}
	}
	return result;
}

//--------------------------------------------------------------------//
//Display the content of a matrix
void  display_matrix(const vector<vector<double>> M)
{
	for (size_t i(0); i < M.size(); ++i) {
		for (size_t j(0); j < M[i].size(); ++j) {
			cout << M[i][j] << " ";
		}
		cout << endl;
	}
}
