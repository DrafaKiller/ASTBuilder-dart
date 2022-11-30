import 'package:ast_parser/src/token/implementations/main.dart';
import 'package:ast_parser/src/token/navigation.dart';
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

    if (token is Navigable) {
      for (final reference in token.get<ReferenceToken>()) {
        reference.bind(this);
        if (reference.referenceName == '(self)') reference.referenceToken = token;
      }
    }

    tokens.add(token);
  }
  void addTokens(Iterable<Token> tokens) => tokens.forEach(addToken);

  Token? token(String name) => tokens.firstWhereOrNull((token) => token.name == name);

  Token? get mainExpression => token('(main)');
  void addMain(Token token) => addTokens([ token, MainToken(token) ]);

  TokenMatch? parse(String input) => mainExpression?.match(input);
}
