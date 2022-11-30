import 'package:ast_parser/src/token/element.dart';
import 'package:ast_parser/src/token/match.dart';

class ParentToken<PatternT extends Pattern> extends Token {
  final List<PatternT> children;

  ParentToken(this.children, { super.name });

  /* -= Relation Methods =- */

  @override
  // ignore: hash_and_equals
  int get hashCode => name.hashCode ^ children.hashCode;

  /* -= Pattern Methods =- */

  @override
  TokenMatch<ParentToken<PatternT>>? match(String string, [ int start = 0 ]) {
    final matches = <Match>[];
    int index = start;
    for (final child in children) {
      final match = child.matchAsPrefix(string, index);
      if (match == null) return null;
      matches.add(match);
      index = match.end;
    }
    return TokenMatch.all(this, matches);
  }
}