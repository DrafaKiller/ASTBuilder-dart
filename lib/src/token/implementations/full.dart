import 'package:ast_parser/src/token/implementations/pattern.dart';
import 'package:ast_parser/src/token/match.dart';

class FullToken<PatternT extends Pattern> extends PatternToken<PatternT> {
  FullToken(super.pattern, { super.name });

  @override
  TokenMatch<FullToken<PatternT>>? match(String string, [ int start = 0 ]) {
    final match = pattern.matchAsPrefix(string, start);
    if (match == null) return null;
    if (match.end != string.length) return null;
    return TokenMatch(this, match);
  }

  @override
  String toString() => '^$pattern\$';
}