import 'package:ast_parser/src/token/element.dart';
import 'package:ast_parser/src/token/match.dart';

class EmptyToken extends Token {
  EmptyToken({ super.name });

  @override
  TokenMatch<EmptyToken>? match(String string, [ int start = 0 ]) => TokenMatch.emptyAt(this, string, start);
}