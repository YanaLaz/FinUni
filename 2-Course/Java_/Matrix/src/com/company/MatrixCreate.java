package com.company;

public class MatrixCreate {
    // переменные класса = поля класса
    private int [][] ar;
    private int a;
    private int b;
    public int c;

    // конструктор класса
    public MatrixCreate(int row, int col) {
        this.ar = new int[row][col];
    }
    // методы класса (функция)
    public int[][] getAr() {
        return this.ar;
    }

}
