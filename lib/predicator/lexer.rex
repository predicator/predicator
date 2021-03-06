class Predicator::Lexer
options
  lineno
  column
macro
  SPACE       /[ \t\r\n]/
  LPAREN      /\(/
  RPAREN      /\)/
  LBRACKET    /\[/
  RBRACKET    /\]/
  TRUE        /true\b/
  FALSE       /false\b/
  BETWEEN     /between\b/
  IN          /in\b/
  BANG        /!/
  NOT         /not\b/
  DOT         /\./
  COMMA       /,/
  AND         /and\b/
  OR          /or\b/
  EQ          /=/
  GT          />/
  LT          /</
  ENDSWITH    /ends with/
  STARTSWITH  /starts with/
  BEGINSWITH  /begins with/
  BLANK       /is blank/
  PRESENT     /is present/
  AGO         /ago/
  FROMNOW     /from now/
  DATE        /\d{4}[-|\/]\d{2}[-|\/]\d{2}/i
  DURATION    /\d+d/
  INTEGER     /[+-]?\d(_?\d)*\b/
  STRING      /(["'])(?:\\?.)*?\1/
  IDENTIFIER  /[a-z][A-Za-z0-9_]*\b/
rule
  /#{SPACE}/       # ignore space
  /#{LPAREN}/      { [:LPAREN, text] }
  /#{RPAREN}/      { [:RPAREN, text] }
  /#{LBRACKET}/    { [:LBRACKET, text] }
  /#{RBRACKET}/    { [:RBRACKET, text] }
  /#{TRUE}/        { [:TRUE, text] }
  /#{FALSE}/       { [:FALSE, text] }
  /#{BETWEEN}/     { [:BETWEEN, text] }
  /#{IN}/          { [:IN, text] }
  /#{BANG}/        { [:BANG, text] }
  /#{NOT}/         { [:NOT, text] }
  /#{DOT}/         { [:DOT, text] }
  /#{COMMA}/       { [:COMMA, text] }
  /#{AND}/         { [:AND, text] }
  /#{OR}/          { [:OR, text] }
  /#{EQ}/          { [:EQ, text] }
  /#{GT}/          { [:GT, text] }
  /#{LT}/          { [:LT, text] }
  /#{AGO}/         { [:AGO, text] }
  /#{FROMNOW}/     { [:FROMNOW, text] }
  /#{ENDSWITH}/    { [:ENDSWITH, text] }
  /#{STARTSWITH}/  { [:STARTSWITH, text] }
  /#{BEGINSWITH}/  { [:STARTSWITH, text] }
  /#{BLANK}/       { [:BLANK, text] }
  /#{PRESENT}/     { [:PRESENT, text] }
  /#{DATE}/        { [:DATE, text] }
  /#{DURATION}/    { [:DURATION, text] }
  /#{INTEGER}/     { [:INTEGER, text] }
  /#{STRING}/      { [:STRING, text[1...-1]] }
  /#{IDENTIFIER}/  { [:IDENTIFIER, text] }
inner
  def do_parse; end
end
