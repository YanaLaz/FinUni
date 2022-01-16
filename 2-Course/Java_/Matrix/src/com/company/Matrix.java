package com.company;

import java.util.Arrays;

public class Matrix {
    public static void main(String[] args) {
        MatrixCreate matrix1 = new MatrixCreate( 10, 10);
        MatrixCreate matrix2 = new MatrixCreate( 5, 5);
        System.out.println(Arrays.deepToString(matrix1.getAr()));

        MatrixEx matrixEx = new MatrixEx();

    }
}
