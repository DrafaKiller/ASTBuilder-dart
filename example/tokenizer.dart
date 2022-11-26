import 'package:ast_builder/tokenizer.dart';

void main() {
  final whitespace = ' ' | '\t';
  final lineBreak = '\n' | '\r';
  final space = (whitespace | lineBreak).multiple;

  final letter = '[a-zA-Z]'.regex;
  final digit = '[0-9]'.regex;

  final identifier = letter & (letter | digit).multiple.optional;
  
  final number = digit.multiple & ('.' & digit.multiple).optional;
  final string = '"' & '[^"]*'.regex & '"'
               | "'" & "[^']*".regex & "'";

  final variableDeclaration =
    'var' & space & identifier & space.optional & '=' & space.optional & (number | string) & space.optional & (';' | space);

  final main = (variableDeclaration | space).multiple;

  final match = main.full.matchAsPrefix('''
    var hello = "world";
    var foo = 123;
    var bar = 123.456;
  ''');
  
  final numbers = match?.get(number).map((match) => match.group(0));
  final identifiers = match?.get(identifier).map((match) => '"${ match.group(0) }"');
  
  print('Numbers: $numbers');
  print('Identifiers: $identifiers');
}
