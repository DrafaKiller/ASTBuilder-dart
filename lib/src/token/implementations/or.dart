import 'package:ast_parser/src/token/implementations/bound.dart';
import 'package:ast_parser/src/token/match.dart';
import 'package:ast_parser/utils/string.dart';

class OrToken<LeftToken extends Pattern, RightToken extends Pattern> extends BoundToken<LeftToken, RightToken> {
  final bool rightPriority;

  OrToken(super.left, super.right, { super.name, this.rightPriority = false });

  @override
  TokenMatch<OrToken<LeftToken, RightToken>>? match(String string, [ int start = 0 ]) {
    if (!rightPriority) {
      final leftMatch = left.matchAsPrefix(string, start);
      if (leftMatch != null) return TokenMatch(this, leftMatch);

      final rightMatch = right.matchAsPrefix(string, start);
      if (rightMatch != null) return TokenMatch(this, rightMatch);
    } else {
      final rightMatch = right.matchAsPrefix(string, start);
      if (rightMatch != null) return TokenMatch(this, rightMatch);
      
      final leftMatch = left.matchAsPrefix(string, start);
      if (leftMatch != null) return TokenMatch(this, leftMatch);
    }

    return null;
  }

  @override
  String toString() => 
    !rightPriority
      ? '(?:${ escapeString(left) }|${ escapeString(right) })'
      : '(?:${ escapeString(right) }|${ escapeString(left) })';
}