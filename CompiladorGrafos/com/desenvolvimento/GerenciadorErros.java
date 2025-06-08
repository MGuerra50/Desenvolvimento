package com.desenvolvimento;

import java.io.FileWriter;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class GerenciadorErros {

    private List<String> erros = new ArrayList<>();

    public void addErro(String tipo, int linha, int coluna, String mensagem) {
        String erroFormatado = String.format("[%s] Linha %d, Coluna %d: %s", tipo, linha, coluna, mensagem);
        erros.add(erroFormatado);
    }

    public boolean temErros() {
        return !erros.isEmpty();
    }

    public void salvarLog(String caminhoArquivo) {
        if (!temErros()) {
            return; // Não cria o arquivo se não houver erros
        }

        try (PrintWriter writer = new PrintWriter(new FileWriter(caminhoArquivo))) {
            for (String erro : erros) {
                writer.println(erro);
            }
            System.out.println("Erros foram detectados. Log salvo em: " + caminhoArquivo);
        } catch (Exception e) {
            System.err.println("Erro ao salvar o log de erros.");
            e.printStackTrace();
        }
    }
}