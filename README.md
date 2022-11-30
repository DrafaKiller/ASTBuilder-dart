# AST Parser

An intuitive AST Parser that includes syntax/grammar definition, tokenization, parsing, compilation and evaluation.

## Features

- Tokenization

## Getting Started 

```
dart pub add ast_parser
```

And import the package:

```dart
import 'package:ast_parser/ast_parser.dart';
```

## Example

<details>
  <summary>
    Tokenization
    <a href="https://github.com/DrafaKiller/ASTParser-dart/blob/dev/example/tokenizer.dart">
      <code>(example/tokenizer.dart)</code>
    </a>
  </summary>
    
  ```dart
  import 'package:ast_parser/ast_parser.dart';

  void main() {
    final whitespace = ' ' | '\t';
    final lineBreak = '\n' | '\r';
    final space = (whitespace | lineBreak).multiple;

    final letter = '[a-zA-Z]'.regex;
    final digit = '[0-9]'.regex;

    final identifier = letter & (letter | digit).multiple.optional;
    
    final number = digit.multiple & ('.' & digit.multiple).optional;
    final string = '"' & '[^"]*'.regex & '"'
                | "'" & "[^']*".regex & "'";

    final variableDeclaration =
      'var' & space & identifier & space.optional & '=' & space.optional & (number | string) & space.optional & (';' | space);

    final main = (variableDeclaration | space).multiple;

    final match = main.matchAsPrefix('''
      var hello = "world";
      var foo = 123;
      var bar = 123.456;
    ''');

    print('Full Match: ${ match?.group(0) == match?.input ? 'Yes' : 'No' }\n');
    
    final numbers = match?.get(number).map((match) => match.group(0));
    final identifiers = match?.get(identifier).map((match) => '"${ match.group(0) }"');
    
    print('Numbers: $numbers');
    print('Identifiers: $identifiers');
  }
  ```
</details>
