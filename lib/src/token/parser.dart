import 'package:ast_parser/src/token/implementations/main.dart';
import 'package:ast_parser/src/token/navigation.dart';
import 'package:ast_parser/tokenizer.dart';
import 'package:ast_parser/utils/iterable.dart';

class Parser {
  final Set<Token> tokens = {};
  Parser({ Map<String, Token>? tokens, Token? main }) {
    if (tokens != null) addAll(tokens);
    if (main != null) mainExpression = main;
  }

  Token add(String name, Token token) {
    final resolved = token.token(name);
    addToken(resolved);
    return resolved;
  }

  Set<Token> addAll(Map<String, Token> tokens) {
    return tokens.entries.map((entry) => add(entry.key, entry.value)).toSet();
  }

  void addToken(Token token) {
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
  set mainExpression(Token? token) {
    if (token != null) addMain(token);
  }
  void addMain(Token token) => addTokens([ token, MainToken(token) ]);

  TokenMatch? parse(String input) => mainExpression?.match(input);
}
