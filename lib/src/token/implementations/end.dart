import 'package:ast_parser/ast_parser.dart';

class EndToken extends Token {
  @override
  TokenMatch? match(String string, [int start = 0]) {
    if (start == string.length) return TokenMatch.emptyAt(this, string, start);
    return null;
  }

  @override String toString() => '\$';
}