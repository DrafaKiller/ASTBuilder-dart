import 'package:ast_parser/src/token/implementations/pattern.dart';
import 'package:ast_parser/src/token/match.dart';

class NotToken extends PatternToken {
  NotToken(super.pattern, { super.name });

  @override
  TokenMatch? matchAsPrefix(String string, [ int start = 0 ]) {
    final match = pattern.matchAsPrefix(string, start);
    if (match == null) return TokenMatch.emptyAt(this, string, start);
    return null;
  }

  @override
  String toString() => '(?!$pattern)';
}