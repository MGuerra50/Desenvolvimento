package com.desenvolvimento;

import java.io.FileNotFoundException;
import java.io.FileReader;

public class App {

    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Uso: java com.desenvolvimento.App <caminho_para_arquivo_fonte>");
            return;
        }

        String arquivoFonte = args[0];
        GerenciadorErros gerenciador = new GerenciadorErros();

        try {
            System.out.println("Compilando o arquivo: " + arquivoFonte);

            FileReader leitorArquivo = new FileReader(arquivoFonte);
            Yylex lexer = new Yylex(leitorArquivo, gerenciador);
            Parser parser = new Parser(lexer, gerenciador);
            
            parser.parse();

        } catch (FileNotFoundException e) {
            String msg = "Arquivo de entrada não encontrado: '" + arquivoFonte + "'";
            gerenciador.addErro("Fatal", 0, 0, msg);

        } catch (Exception e) {
            String msg = "Ocorreu um erro fatal durante a compilação. Causa: " + e.getMessage();
            gerenciador.addErro("Fatal", 0, 0, msg);
            e.printStackTrace();
        } finally {
            if (gerenciador.temErros()) {
                gerenciador.salvarLog("errors.log");
            } else {
                System.out.println("Compilação concluída com sucesso.");
            }
        }
    }
}