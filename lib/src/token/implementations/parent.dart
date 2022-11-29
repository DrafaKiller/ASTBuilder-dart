import 'package:ast_parser/src/token/element.dart';
import 'package:ast_parser/src/token/match.dart';

class ParentToken extends Token {
  final List<Pattern> children;
  final bool any;

  ParentToken(this.children, { super.name, this.any = false });

  /* -= Relation Methods =- */

  @override
  // ignore: hash_and_equals
  int get hashCode => name.hashCode ^ children.hashCode;

  /* -= Pattern Methods =- */

  @override
  TokenMatch<ParentToken>? match(String string, [ int start = 0 ]) {
    final matches = <Match>[];
    var current = start;
    for (final child in children) {
      final match = child.matchAsPrefix(string, current);
      if (match == null) {
        if (any) continue;
        return null;
      }
      matches.add(match);
      current = match.end;
    }
    return TokenMatch.all(this, matches);
  }
}