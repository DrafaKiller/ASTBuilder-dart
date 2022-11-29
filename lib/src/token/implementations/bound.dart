import 'package:ast_parser/src/token/element.dart';
import 'package:ast_parser/src/token/implementations/parent.dart';

class BoundToken<LeftToken extends Token, RightToken extends Token> extends ParentToken {
  final LeftToken left;
  final RightToken right;

  BoundToken(this.left, this.right, { super.name }) : super([ left, right ]);
}