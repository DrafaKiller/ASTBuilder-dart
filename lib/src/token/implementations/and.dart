import 'package:ast_parser/src/token/element.dart';
import 'package:ast_parser/src/token/implementations/bound.dart';

class AndToken<LeftToken extends Pattern, RightToken extends Pattern> extends BoundToken<LeftToken, RightToken> {
  AndToken(super.left, super.right, { super.name });
}