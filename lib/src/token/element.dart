import 'package:ast_parser/src/token/alternatives.dart';
import 'package:ast_parser/src/token/match.dart';

abstract class Token extends Pattern {
  final String? name;
  
  Token({ this.name });

  /* -= Relation Methods =- */

  @override
  bool operator ==(Object other) {
    if (other is Token) {
      if (name != null || other.name != null) return name == other.name;
    }
    return hashCode == other.hashCode;
  }
  
  @override
  int get hashCode => name.hashCode;

  /* -= Pattern Methods =- */
  
  @override
  Iterable<TokenMatch> allMatches(String string, [ int start = 0 ]) {
    final match = matchAsPrefix(string, start);
    return [ if (match != null) match ];
  }

  @override
  TokenMatch? matchAsPrefix(String string, [ int start = 0 ]) => match(string, start);
  TokenMatch? match(String string, [ int start = 0 ]);

  /* -= Alternative Tokens =- */

  factory Token.and(Pattern left, Pattern right, { String? name }) = AndToken;
  factory Token.or(Pattern left, Pattern right, { String? name }) = OrToken;
  factory Token.not(Pattern token, { String? name }) = NotToken;
  factory Token.multiple(Pattern token, { String? name }) = MultipleToken;
  factory Token.optional(Pattern token, { String? name }) = OptionalToken;
  factory Token.full(Pattern token, { String? name }) = FullToken;
  factory Token.empty() = EmptyToken;

  Token and(Token token) => Token.and(this, token);
  Token or(Token token) => Token.or(this, token);
  Token get not => Token.not(this);
  Token get multiple => Token.multiple(this);
  Token get multipleOrNone => Token.or(Token.multiple(this), Token.empty());
  Token get full => Token.full(this);
  Token get optional => Token.optional(this);

  Token get asBefore => Token.regex('(?<=$this)');
  Token get asNotBefore => Token.regex('(?<!$this)');
  
  Token get asAfter => Token.regex('(?=$this)');
  Token get asNotAfter => Token.regex('(?!$this)');
}

typedef TokenMatchCallback = void Function(TokenMatch match);