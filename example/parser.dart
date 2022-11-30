import 'package:ast_parser/src/token/parser.dart';
import 'package:ast_parser/tokenizer.dart';

void main() {
  var parser = Parser();

  final expression = 'a' | Token.reference('expression');

  parser.addToken(expression.token('expression'));

  var result = parser.parse('a');
  print(result);
}