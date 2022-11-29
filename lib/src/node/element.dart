import 'package:ast_parser/src/token/match.dart';

abstract class ASTNode {
  final ASTNode? parent;
  final List<ASTNode> children = [];

  ASTNode(this.parent);

  /* -= Accessor Methods =- */

  ASTNode get root => parent?.root ?? this;
  
  int get depth => (parent?.depth ?? -1) + 1;
  int get index => parent?.children.indexOf(this) ?? 0;

  ASTNode? get previous => index > 0 ? parent?.children[index - 1] : null;
  ASTNode? get next => index < (parent?.children.length ?? 0) ? parent?.children[index + 1] : null;
}

abstract class ASTToken extends ASTNode {
  final TokenMatch match;

  ASTToken(this.match, super.parent);

  /* -= Accessor Methods =- */

  String get value => match.value;
  int get start => match.start;
  int get end => match.end;
}