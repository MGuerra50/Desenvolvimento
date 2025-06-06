package com.desenvolvimento;

import java_cup.runtime.Symbol;

%%

%class Yylex
%public
%cup
%line
%column

%{
  private Symbol symbol(int type) {
    return new Symbol(type, yyline + 1, yycolumn + 1);
  }

  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline + 1, yycolumn + 1, value);
  }
%}

ID = [a-zA-Z][a-zA-Z0-9]*
WHITESPACE = [ \t\r\n\f]+

%%

"GRAPH"      { return new Symbol (sym.KW_GRAPH, yytext()); }
"vertex"     { return new Symbol (sym.KW_VERTEX, yytext()); }
"edge"       { return new Symbol (sym.KW_EDGE, yytext()); }
"print"      { return new Symbol (sym.KW_PRINT, yytext()); }
"adjacency"  { return new Symbol (sym.KW_ADJACENCY, yytext()); }
"directed"   { return new Symbol (sym.KW_DIRECTED, yytext()); }
"undirected" { return new Symbol (sym.KW_UNDIRECTED, yytext()); }

"->"         { return new Symbol (sym.SYM_ARROW_DIR, yytext()); }
"--"         { return new Symbol (sym.SYM_ARROW_UNDIR, yytext()); }

{ID}         { return new Symbol (sym.ID, yytext()); }

{WHITESPACE} { }

<<EOF>>      { return new Symbol (sym.EOF, yytext()); }

.            {
                System.err.println("Erro Léxico na linha " + (yyline+1) + ", coluna " + (yycolumn+1) + ": Comando ou caractere desconhecido: '" + yytext() + "'");
              }