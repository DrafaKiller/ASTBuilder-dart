import 'package:ast_builder/src/node/element.dart';
import 'package:ast_builder/src/token/element.dart';
import 'package:ast_builder/src/token/match.dart';

void main() {
  final variable = Variable();


}

mixin ASTElement {
  abstract final ASTNode node;
}


class Identifier {
  String name;
  Identifier(this.name);

  String toSource() => name;
}

class ASTIdentifier extends Identifier with ASTElement {
  @override final ASTNode node;

  ASTIdentifier({ required this.node }) : super(name);
}





class Identifier extends NodeElement {
  Identifier({ required super.node });
}