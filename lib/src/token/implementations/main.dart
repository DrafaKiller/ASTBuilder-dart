import 'package:ast_parser/src/token/implementations/full.dart';

class MainToken<PatternT extends Pattern> extends FullToken<PatternT> {
  MainToken(super.pattern) : super(name: '(main)');
}