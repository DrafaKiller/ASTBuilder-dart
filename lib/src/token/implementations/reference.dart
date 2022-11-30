import 'package:ast_parser/src/token/element.dart';
import 'package:ast_parser/src/token/match.dart';

class ReferenceToken extends Token {
  ReferenceToken(String name) : super(name: name);

  @override
  TokenMatch<ReferenceToken>? match(String string, [ int start = 0 ]) => throw ReferenceTokenUseError();
}

class ReferenceTokenUseError extends Error {
  @override
  String toString() =>
    'ReferenceToken present in pattern, '
    'must be replaced with a concrete token before using it. ';
}

class ReferenceTokenNotFoundError extends Error {
  final String? name;
  ReferenceTokenNotFoundError(this.name);

  @override
  String toString() => 'Token reference ${ name == null ? 'null' : '"$name"' } not found in parser. ';
}