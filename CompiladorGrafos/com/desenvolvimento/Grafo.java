package com.desenvolvimento;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Grafo {

    private String tipo; 
    private final List<String> vertices; 
    private final Map<String, Integer> indiceVertices;
    private int[][] matrizAdjacencia;

    public Grafo() {
        this.vertices = new ArrayList<>();
        this.indiceVertices = new HashMap<>();
        this.matrizAdjacencia = null; 
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public boolean addVertice(String nome) {
        if (!indiceVertices.containsKey(nome)) {
            vertices.add(nome);
            indiceVertices.put(nome, vertices.size() - 1);
            return true;
        }
        return false; 
    }

    public boolean verticeExiste(String nome) {
        return indiceVertices.containsKey(nome);
    }

    public void inicializarMatriz() {
        int numVertices = this.vertices.size();
        this.matrizAdjacencia = new int[numVertices][numVertices];
    }

    public boolean addAresta(String v1, String v2) {
        if (this.matrizAdjacencia == null) {
            inicializarMatriz();
        }
        
        int indice1 = indiceVertices.get(v1);
        int indice2 = indiceVertices.get(v2);

         if (matrizAdjacencia[indice1][indice2] == 1) {
            return false;
        }
    
        matrizAdjacencia[indice1][indice2] = 1;

        if ("undirected".equals(this.tipo)) {
            matrizAdjacencia[indice2][indice1] = 1;
        }
         return true;
    }

    public void imprimirMatrizAdjacencia(String nomeArquivo) {
        if (this.matrizAdjacencia == null) {
            inicializarMatriz();
        }

        try (PrintWriter writer = new PrintWriter(new FileWriter(nomeArquivo))) {
            writer.print("    ");
            for (String vertice : vertices) {
                writer.print(vertice + " ");
            }
            writer.println();

            for (int i = 0; i < vertices.size(); i++) {
                writer.print(vertices.get(i) + " | ");
                for (int j = 0; j < vertices.size(); j++) {
                    writer.print(matrizAdjacencia[i][j] + " ");
                }
                writer.println();
            }
            System.out.println("Matriz de adjacência salva em: " + nomeArquivo);
        } catch (Exception e) {
            System.err.println("Erro ao salvar a matriz de adjacência.");
            e.printStackTrace();
        }
    }
}