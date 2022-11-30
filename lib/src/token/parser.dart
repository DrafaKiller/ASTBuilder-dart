import 'package:ast_parser/tokenizer.dart';
import 'package:ast_parser/utils/iterable.dart';

class Parser {
  final Set<Token> tokens;
  Parser({ Set<Token>? tokens }) : tokens = tokens ?? <Token>{};

  void add(String name, Token token) => addToken(token.token(name));
  void addAll(Map<String, Token> tokens) => tokens.forEach(add);

  void addToken(Token token) {
    if (token is ReferenceToken) return;
    if (token.name == null) return;
    tokens.add(token);
  }

  Token? token(String name) => tokens.firstWhereOrNull((token) => token.name == name);
  Token ensureToken(String? name) => (name != null ? token(name) : null) ?? (throw ReferenceTokenNotFoundError(name));

  Token? get mainExpression => token('(main)');
  void addMain(Token token) => add('(main)', token);

  Pattern resolve(Pattern pattern) {
    
  }

  TokenMatch? parse(String input) {
    final resolved = resolve(mainExpression!);
    return mainExpression?.match(input);
  }
}