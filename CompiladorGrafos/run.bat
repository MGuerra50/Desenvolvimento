@echo off
set JCUP_FOLDER=..\java-cup
set JFLEX_FOLDER=..\jflex-1.9.1
set JCUP_JAR="%JCUP_FOLDER%\java-cup-11b.jar"
set JCUP_RUNTIME_JAR="%JCUP_FOLDER%\java-cup-11b-runtime.jar"
set JFLEX_JAR="%JFLEX_FOLDER%\lib\jflex-full-1.9.1.jar"
set CLASSPATH=%JCUP_RUNTIME_JAR%;.

if /i "%1"=="" (
    echo Uso: run.bat [compilar^|executar^|testar_tudo^|limpar]
    goto :eof
)
if /i "%1"=="compilar" goto :compilar
if /i "%1"=="executar" goto :executar
if /i "%1"=="testar_tudo" goto :testar_tudo
if /i "%1"=="limpar" goto :limpar
if /i "%1"=="gerar" goto :gerar
echo Comando desconhecido: %1
goto :eof

:limpar
echo Limpando arquivos gerados...
if exist com\desenvolvimento\*.class del com\desenvolvimento\*.class /Q
if exist com\desenvolvimento\Yylex.java del com\desenvolvimento\Yylex.java /Q
if exist com\desenvolvimento\Parser.java del com\desenvolvimento\Parser.java /Q
if exist com\desenvolvimento\sym.java del com\desenvolvimento\sym.java /Q
rem Apaga os arquivos de log e saída na raiz do projeto
if exist errors.log del errors.log /Q
if exist matriz_adjacencia.txt del matriz_adjacencia.txt /Q
echo Limpeza concluida.
goto :eof

:gerar
echo Gerando fontes do JCup e JFlex...
java -jar %JCUP_JAR% -parser Parser -symbols sym glc.cup
java -jar %JFLEX_JAR% lexical_analyzer.flex
echo Movendo arquivos gerados para o pacote...
if exist Parser.java move Parser.java com\desenvolvimento\ > nul
if exist sym.java move sym.java com\desenvolvimento\ > nul
if exist Yylex.java move Yylex.java com\desenvolvimento\ > nul
echo Fontes gerados e movidos com sucesso.
goto :eof

:compilar
call :limpar
call :gerar
echo Compilando projeto Java...
javac -cp %CLASSPATH% com\desenvolvimento\App.java com\desenvolvimento\Grafo.java com\desenvolvimento\GerenciadorErros.java com\desenvolvimento\Yylex.java com\desenvolvimento\sym.java com\desenvolvimento\Parser.java
echo Compilacao concluida.
goto :eof

:executar
if "%2"=="" (
    echo Erro: Forneca um nome de arquivo para executar.
    echo Exemplo: run.bat executar teste_sucesso.graph
    goto :eof
)
echo --- Executando teste em: %2 ---
java -cp %CLASSPATH% com.desenvolvimento.App %2
echo.
goto :eof

:testar_tudo
call :compilar
echo.
echo --- Executando teste em: teste_sucesso.graph ---
java -cp %CLASSPATH% com.desenvolvimento.App teste_sucesso.graph
echo.
echo --- Executando teste em: teste_erro_lexico.graph ---
java -cp %CLASSPATH% com.desenvolvimento.App teste_erro_lexico.graph
echo.
echo --- Executando teste em: teste_erro_semantico_vertice.graph ---
java -cp %CLASSPATH% com.desenvolvimento.App teste_erro_semantico_vertice.graph
echo.
echo --- Executando teste em: teste_erro_aresta_duplicada.graph ---
java -cp %CLASSPATH% com.desenvolvimento.App teste_erro_aresta_duplicada.graph
echo.
echo --- Executando teste em: teste_erro_tipo_aresta.graph ---
java -cp %CLASSPATH% com.desenvolvimento.App teste_erro_tipo_aresta.graph
echo.
echo --- Todos os testes foram concluidos. ---
goto :eof

:eof