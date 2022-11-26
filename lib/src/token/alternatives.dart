import 'package:ast_builder/src/token/element.dart';
import 'package:ast_builder/src/token/match.dart';
import 'package:ast_builder/src/token/pattern.dart';



String _escapeString(Pattern pattern) {
  if (pattern is! String) return pattern.toString();
  return RegExp.escape(pattern);
}



class EmptyToken extends Token {
  EmptyToken({ super.name, super.listeners }) : super('');
}

class AndToken extends Token {
  final Pattern left;
  final Pattern right;

  AndToken(this.left, this.right, { super.name, super.listeners })
    : super(RegExp('(?:${ _escapeString(left) }${ _escapeString(right) })'));

  @override
  TokenMatchBound? matchAsPrefix(String string, [int start = 0]) {
    final leftMatch = left.matchAsPrefix(string, start);
    if (leftMatch == null) return null;

    final rightMatch = right.matchAsPrefix(string, leftMatch.end);
    if (rightMatch == null) return null;

    return emit(TokenMatchBound(this, leftMatch, rightMatch));
  }
}

class OrToken extends Token {
  final Pattern left;
  final Pattern right;

  final bool rightPriority;

  OrToken(this.left, this.right, { super.name, super.listeners, this.rightPriority = false })
    : super(RegExp('(?:${ _escapeString(!rightPriority ? left : right) })|(?:${ _escapeString(!rightPriority ? right : left) })'));

  @override
  TokenMatch? matchAsPrefix(String string, [int start = 0]) {
    if (!rightPriority) {
      final leftMatch = left.matchAsPrefix(string, start);
      if (leftMatch != null) return emit(TokenMatch(this, leftMatch));

      final rightMatch = right.matchAsPrefix(string, start);
      if (rightMatch != null) return emit(TokenMatch(this, rightMatch));
    } else {
      final rightMatch = right.matchAsPrefix(string, start);
      if (rightMatch != null) return emit(TokenMatch(this, rightMatch));
      
      final leftMatch = left.matchAsPrefix(string, start);
      if (leftMatch != null) return emit(TokenMatch(this, leftMatch));
    }

    return null;
  }
}

class NotToken extends Token {
  NotToken(super.pattern, { super.name, super.listeners });

  @override
  TokenMatch? matchAsPrefix(String string, [int start = 0]) {
    final match = pattern.matchAsPrefix(string, start);
    if (match == null) return emit(TokenMatch(this, ''.matchAsPrefix(string, start)!));
    return null;
  }

  @override
  String toString() => '(?!$pattern)';
}

class MultipleToken extends Token {
  MultipleToken(super.pattern, { super.name, super.listeners });

  @override
  TokenMatchBound? matchAsPrefix(String string, [int start = 0]) {
    final token = pattern.token();
    
    var match = token.matchAsPrefix(string, start);
    while (match != null) {
      final nextMatch = token.matchAsPrefix(string, match.end);
      if (nextMatch == null) break;
      match = TokenMatchBound(token, match, nextMatch);
    }

    if (match == null) return null;
    return emit(
      match is TokenMatchBound
        ? match
        : TokenMatchBound(this, match, ''.matchAsPrefix(string, match.end)!)
    );
  }

  @override
  String toString() => '$pattern*';
}

class OptionalToken extends OrToken {
  OptionalToken(Pattern pattern, { super.name, super.listeners }) : super(pattern, EmptyToken());

  @override String toString() => '(?:$left)?';
}

class FullToken extends Token {
  FullToken(super.pattern, { super.name, super.listeners });

  @override
  TokenMatchBound? matchAsPrefix(String string, [int start = 0]) {
    final match = pattern.matchAsPrefix(string, start);
    if (match == null) return null;
    if (match.end != string.length) return null;
    return emit(TokenMatchBound(this, match, ''.matchAsPrefix(string, match.end)!));
  }

  @override
  String toString() => '^$pattern\$';
}