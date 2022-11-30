import 'package:ast_parser/ast_parser.dart';
import 'package:ast_parser/src/token/element.dart';

mixin Navigable on Token {
  List<Pattern> get children;
  Set<T> get<T extends Pattern>([ String? name ]) {
    final tokens = <T>{};
    for (final child in children) {
      if ((name == null || (child is Token && child.name == name)) && child is T) {
        tokens.add(child);
      }
      if (child is Navigable) tokens.addAll(child.get(name));
    }
    return tokens;
  }
}