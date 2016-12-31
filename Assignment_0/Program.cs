/*Nicholas Vadivelu
SPH 4U0
12 January 2015
3.4.3 C Programming Assignment
4.3.3.1 Least Squares as well as Bonus (i), (ii)*/

using System;
using System.Collections.Generic;

namespace Assignment0 {
    class Program {
        public static void printMatrix(double[,] matrix) { //method to display a formatted matrix
            for (int i = 0; i < matrix.GetLength(0); i++) { //loops through rows
                for (int j = 0; j < matrix.GetLength(1); j++) { //loops through cols
                    if (matrix[i, j] < 100000000 && matrix[i, j] >= 0.0000001 ) {
                        Console.Write(Math.Round(matrix[i, j], 3).ToString().PadLeft(11)); //outs array with appropriate format
                    } else if (matrix[i,j] < 0) {
                        Console.Write("  {0:#.00e+00}".PadLeft(11), matrix[i, j]); //if the number is too long, it will make enough space for it
                    } else {
                        Console.Write("   {0:#.00e+00}".PadLeft(11), matrix[i, j]); //extra space if it si negative
                    }

                }
                Console.WriteLine();
            }
        }
        public static double[,] transpose(double[,] matrix) {
            //create a result array that's dimension are the inverse of the input (w x h --> h x w)
            double[,] result = new double[matrix.GetLength(1), matrix.GetLength(0)];
            for (int i = 0; i < matrix.GetLength(0); i++) { //for all rows in matrix
                for (int j = 0; j < matrix.GetLength(1); j++) { //for all columns in matrix
                    result[j, i] = matrix[i, j]; //assigns value to transposed position
                }
            }
            return result;
        }

        public static double[,] inverse(double[,] matrix) { //computes the inverse of a matrix
            double det = determinant(matrix); //gets the determinant of the matrix
            if (det == 0) { //ensures matrix is square and determinant is non zero
                Console.WriteLine("Cannot invert matrix; it is not square or determinant = 0"); //notifies user of the issue
                return matrix; //to exit function
            } else {
                //This method utilizes a Minors Matrix, Cofactors
                int len = matrix.GetLength(0); //for convenient access to the length of the array
                double[,] result = new double[len, len]; //array that will be returned
                double[,] temp = new double[len - 1, len - 1]; //temporary array used when finding the minors matrix
                double[] mult = { 1.0, -1.0 }; //used as a coefficient when computing the cofactors matrix

                for (int i = 0; i < len; i++) {
                    for (int j = 0; j < len; j++) {
                        //First, calculate the minor matrix
                        int row = 0, col = 0; //row and column will be incremented seperately since one col and one row will be skipped each time
                        for (int x = 0; x < len; x++) {
                            if (x != j) {
                                col = 0;
                                for (int y = 0; y < len; y++) {
                                    if (y != i) {
                                        temp[row, col] = matrix[x, y];
                                        col++;
                                    }
                                }
                                row++; 
                            }
                        }

                        //Next get cofactor of matrix
                        result[i,j] = mult[(i+j)%2] * determinant(temp) / det;
                    }
                }
                return result; //returns result
            }
        }

        public static double determinant(double[,] matrix) { //calculates the determinate of the input matrix (of any dimension)
            if (matrix.GetLength(1) != matrix.GetLength(0)) { //ensure matrix is a square
                Console.WriteLine("Error finding determinant: matrix is not a square."); //notify user of issue
                return matrix[0, 0];
            } else if (matrix.GetLength(0) == 1) { //if the matrix is a scalar, the determinate is the scalar
                return matrix[0, 0];
            } else if (matrix.GetLength(0) == 2) { //base case that can be computed without recursion (2x2 matrix)
                return ((matrix[0, 0] * matrix[1, 1]) - (matrix[0, 1] * matrix[1, 0])); //returns determinant
            } else { //recursive case where matrix is larger than 2x2
                int len = matrix.GetLength(0), indi = 0, indj = 0; //indi and indj will be incrememnted seperately because one row and col must be skipped each time
                double det = 0; //declare determinate variable
                double[,] temp = new double[len - 1, len - 1]; //smaller temporary variable that gets smaller each recursion, until it reaches the base case of 2x2
                double[] mult = { 1.0, -1.0 }; //used to alternate between adding and subtracting

                for (int n = 0; n < len; n++) {
                    indi = 0;
                    for (int i = 1; i < len; i++) {
                        indj = 0;
                        for (int j = 0; j < len; j++) {
                            if (j == n) { //the program must skip this column whose element is used as a multipler
                                continue;
                            }
                            temp[indi, indj] = matrix[i, j];
                            indj++;
                        }
                        indi++;
                    }
                    det += mult[n % 2] * matrix[0, n] * determinant(temp); //the determinate is the sum of determinates within the matrix
                }
                return det; //return
            }
        }

        public static double[,] matrixMultiply(double[,] a, double[,] b) { //this function performs matrix multiplication
            if (a.GetLength(1) != b.GetLength(0)) { //checks to ensure matrices can be multiplied. columns of a must = rows of b
                Console.WriteLine("maxtrixMultiply failed. Inner matrix dimensions do not match."); //notifies user of issue
                return a; //exits function
            } else {
                double[,] result = new double[a.GetLength(0), b.GetLength(1)]; //creates square result matrix
                for (int i = 0; i < a.GetLength(0); i++) {
                    for (int j = 0; j < b.GetLength(1); j++) {
                        result[i, j] = 0; //initializes value
                        for (int k = 0; k < a.GetLength(1); k++) {
                            result[i, j] += a[i, k] * b[k, j]; //sums up the required products 

                        }
                    }
                }
                return result;
            }
        }

        public static int getInput(int min, int max) { //this function ensures user input is within set bounds
            int input;//declare input integer
            input = Convert.ToInt32(Console.ReadLine());//receive input from user
            while (input > max || input < min) { //if the data is out of bounds, keep prompting user
                Console.Write("Input out of range. Ensure input is between " + min + " and " + max + ".\nEnter input: ");
                input = Convert.ToInt32(Double.Parse((Console.ReadLine())));
            }
            return input; //use user's input when it is acceptable
        }


        static void Main(string[] args) {
            char choice = 'y'; //this will be changed by user to choose to run the program multiple times
            while (choice != 'n') { //until user chooses to exit
                Console.WriteLine("-----------------Least Squares Polynomial Fitter-----------------\n"); //header (title)
                //Get number of data points
                int numPoints = 0; //declare numPoints variable
                Console.Write("Input number of data points: "); //prompts user for data points
                numPoints = getInput(1, Int32.MaxValue); //get number of data points from keyboard input
                Console.WriteLine();

                //Create arrays with that data
                double[] x = new double[numPoints];
                double[,] y = new double[numPoints, 1]; //declare x and y arrays
                for (int i = 0; i < numPoints; i++) { //get all x values from user input
                    Console.Write("x[" + (i + 1) + "]: ");
                    x[i] = Double.Parse(Console.ReadLine());
                }
                Console.WriteLine(); //add extra line to seperate x and y input
                for (int i = 0; i < numPoints; i++) { //get all y values from user input
                    Console.Write("y[" + (i + 1) + "]: ");
                    y[i, 0] = Double.Parse(Console.ReadLine());
                }
                Console.WriteLine(); //add extra line to seperate sections

                //Prompt user for which degree polynomial to fit the data
                int degree = 0; //declare degree integer
                Console.Write("Input degree of polynomial fit: "); //prompt user for degree
                degree = getInput(1, Int32.MaxValue); //receive input

                double[,] vand = new double[numPoints, degree + 1]; //creates the vandermonde matrix
                for (int i = 0; i < numPoints; i++) {
                    for (int j = 0; j <= degree; j++) {
                        vand[i, j] = Math.Pow(x[i], j); //vandermonde matrix contains each x value increasing geometrically with the coumns
                    }
                }


                double[,] coeff = new double[degree + 1, 1]; //a matrix (will be a column vector) to hold coefficients of line of best fit
                double[,] transposedVand = transpose(vand); //variable holding transposed vandermonde matrix to make below computation simpler
                coeff = matrixMultiply(matrixMultiply(inverse(matrixMultiply(transposedVand, vand)), transposedVand), y); //inv(trans*vand)*vand*y

                //Show all the steps of the calculation
                Console.WriteLine("\n\nVandermonde Matrix ");
                printMatrix(vand);
                Console.WriteLine("\n\nTransposed Vandermonde Matrix ");
                printMatrix(transposedVand);
                Console.WriteLine("\n\n (Transposed Vandermonde)*(Vandermonde) ");
                printMatrix(matrixMultiply(transposedVand, vand));
                Console.WriteLine("\n\n Inverse((Transposed Vandermonde)*(Vandermonde)) ");
                printMatrix(inverse(matrixMultiply(transposedVand, vand)));
                Console.WriteLine("\n\n Inverse((Transposed Vandermonde)*(Vandermonde))*(Transposed Vandermonde) ");
                printMatrix(matrixMultiply(inverse(matrixMultiply(transposedVand, vand)), transposedVand));
                Console.WriteLine("\n\n Inverse((Transposed Vandermonde)*(Vandermonde))*(Transposed Vandermonde)*Y ");
                printMatrix(matrixMultiply(matrixMultiply(inverse(matrixMultiply(transposedVand, vand)), transposedVand), y));

                //show user of the line of best fit
                Console.Write("\n\nLine of Best Fit: y = " + Math.Round(coeff[0, 0], 3) + " + " + Math.Round(coeff[1, 0], 3) + "x ");
                for (int i = 2; i <= degree; i++) {
                    Console.Write((coeff[1, 0] < 1 ? "+ " : "- ") + Math.Abs(Math.Round(coeff[i, 0], 3)) + "x^" + i + " ");
                }

                //Run agian?
                Console.Write("\n\nRun Again? (y/n) "); //prompt user to run again or exit
                choice = Console.ReadLine()[0]; //get input
                Console.WriteLine("\n\n"); //create space for next iteration
                Console.Clear();
            }
        }
    }
}
