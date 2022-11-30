import 'package:ast_parser/src/token/implementations/pattern.dart';
import 'package:ast_parser/src/token/match.dart';

class OptionalToken<PatternT extends Pattern> extends PatternToken<PatternT> {
  OptionalToken(super.pattern, { super.name });

  @override
  TokenMatch<OptionalToken<PatternT>>? match(String string, [ int start = 0 ]) {
    final match = pattern.matchAsPrefix(string, start);
    if (match == null) return TokenMatch.emptyAt(this, string, start);
    return TokenMatch(this, match);
  }

  @override String toString() => '(?:$pattern)?';
}