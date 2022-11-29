import 'package:ast_parser/src/token/element.dart';
import 'package:ast_parser/src/token/implementations/bound.dart';
import 'package:ast_parser/src/token/match.dart';

class AndToken<LeftToken extends Token, RightToken extends Token> extends BoundToken<LeftToken, RightToken> {
  AndToken(super.left, super.right, { super.name });
}