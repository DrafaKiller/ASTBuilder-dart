import 'package:ast_parser/src/token/element.dart';
import 'package:ast_parser/src/token/match.dart';

class StartToken extends Token {
  @override
  TokenMatch? match(String string, [ int start = 0 ]) {
    if (start == 0) return TokenMatch.emptyAt(this, string, start);
    return null;
  }

  @override String toString() => '^';
}