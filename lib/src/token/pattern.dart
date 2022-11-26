import 'package:ast_builder/src/token/element.dart';

extension PatternTokenizer on Pattern {
  /* -= Token Build Methods =- */

  Token operator +(Pattern other) => this & other;
  Token operator &(Pattern other) => Token.and(this, other);
  Token operator |(Pattern other) => Token.or(this, other);

  Token operator >(Pattern other) => Token.and(this, other.token().asAfter);
  Token operator >=(Pattern other) => Token.and(this, other.token().asNotAfter);
  
  Token operator <(Pattern other) => Token.and(token().asBefore, other);
  Token operator <=(Pattern other) => Token.and(token().asNotBefore, other);

  Token get not => Token.not(this);
  Token get multiple => Token.multiple(this);
  Token get multipleOrNone => Token.or(Token.multiple(this), Token.empty());
  Token get optional => Token.optional(this);

  /* -= Token Binding =- */

  Token token([ String? name ]) {
    if (this is Token && name == null) return this as Token;
    return Token(name: name, this);
  }

  Token bind(Token token) => this.token(token.name)
    ..listeners.addAll(token.listeners);
}

extension PatternTokenizerString on String {
  /* -= Token Build Methods =- */
  Token get regex => Token.regex(this);
}
