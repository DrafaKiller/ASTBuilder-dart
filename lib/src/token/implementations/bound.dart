import 'package:ast_parser/src/token/implementations/parent.dart';

class BoundToken<LeftPattern extends Pattern, RightPattern extends Pattern> extends ParentToken {
  final LeftPattern left;
  final RightPattern right;

  BoundToken(this.left, this.right, { super.name }) : super([ left, right ]);
}