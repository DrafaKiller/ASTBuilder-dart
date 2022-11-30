import 'package:ast_parser/src/token/implementations/reference.dart';

class SelfToken extends ReferenceToken {
  SelfToken({ super.parser }) : super('(self)');
}