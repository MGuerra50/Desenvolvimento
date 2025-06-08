package com.desenvolvimento;

import java.io.FileReader;

public class App {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Uso: java com.desenvolvimento.App <caminho_para_arquivo_fonte>");
            return;
        }

        String arquivoFonte = args[0];
        System.out.println("Compilando o arquivo: " + arquivoFonte);

        try {
            // 1. Cria o gerenciador de erros
            GerenciadorErros gerenciador = new GerenciadorErros();

            // 2. Cria o lexer, passando o leitor e o gerenciador
            FileReader leitorArquivo = new FileReader(arquivoFonte);
            Yylex lexer = new Yylex(leitorArquivo, gerenciador);

            // 3. Cria o parser, passando o lexer e o gerenciador
            Parser parser = new Parser(lexer, gerenciador);

            // 4. Inicia a análise
            parser.parse();

            // 5. Salva o log de erros, se houver algum
            gerenciador.salvarLog("errors.log");

            if (!gerenciador.temErros()) {
                System.out.println("Compilação concluída com sucesso.");
            }

        } catch (Exception e) {
            System.err.println("Ocorreu um erro fatal durante a compilação:");
            e.printStackTrace();
        }
    }
}