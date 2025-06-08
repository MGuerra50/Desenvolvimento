package com.desenvolvimento;
import com.desenvolvimento.GerenciadorErros; 
import java_cup.runtime.Symbol;

%%

%class Yylex
%public
%cup
%line
%column

%{
  private GerenciadorErros gerenciador;

  public Yylex(java.io.Reader in, GerenciadorErros gerenciador) {
    this(in);
    this.gerenciador = gerenciador;
  }

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

"GRAPH"      { return symbol(sym.KW_GRAPH); }
"vertex"     { return symbol(sym.KW_VERTEX); }
"edge"       { return symbol(sym.KW_EDGE); }
"print"      { return symbol(sym.KW_PRINT); }
"adjacency"  { return symbol(sym.KW_ADJACENCY); }
"directed"   { return symbol(sym.KW_DIRECTED); }
"undirected" { return symbol(sym.KW_UNDIRECTED); }

"->"         { return symbol(sym.SYM_ARROW_DIR); }
"--"         { return symbol(sym.SYM_ARROW_UNDIR); }

{ID}         { return symbol(sym.ID, yytext()); }

{WHITESPACE} { }

<<EOF>>      { return new Symbol(sym.EOF); }

. {
    this.gerenciador.addErro("Léxico", yyline + 1, yycolumn + 1, "Caractere ou comando desconhecido: '" + yytext() + "'");
    return symbol(sym.error);
  }