import 'package:ast_parser/src/token/parser.dart';
import 'package:ast_parser/tokenizer.dart';

void main() {
  var parser = Parser();

  final expression = 'a' & Token.self().optional;

  parser.addMain(expression.token('expression'));

  var result = parser.parse('aaa');
  print(result?.get(expression));
}