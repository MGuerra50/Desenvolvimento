O arquivo run.bat automatiza a execução do compilador, segue a baixo uma lista dos comandos disponíveis:

run.bat compilar
* Limpa o projeto, gera os fontes do analisador léxico e sintático, e por fim, compila o código Java

run.bat executar <nomeDoArquivo>
* Executa o compilador em um único arquivo .graph. Exemplo: C:\meus_projetos\CompiladorGrafos> run.bat executar meuArquivo.graph
(O arquivo deve estar dentro da pasta 'com')

run.bat gerar
* Gera os arquivos fontes do analisador léxico e sintático

run.bat testar_tudo
* Executa todos os comando