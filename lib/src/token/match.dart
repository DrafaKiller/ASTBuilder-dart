import 'package:ast_parser/src/token/element.dart';
import 'package:ast_parser/utils/iterable.dart';

class TokenMatch<TokenT extends Token> extends Match {
  final TokenT token;
  final Match match;

  TokenMatch(this.token, this.match);
  TokenMatch.all(this.token, List<Match> matches) : match = ParentMatch(token, matches);

  /* -= Accessor Methods =- */

  String get value => match.group(0) ?? '';

  /* -= Overridden Methods =- */

  @override Pattern get pattern => token;
  @override String get input => match.input;

  @override int get start => match.start;
  @override int get end => match.end;

  @override String? operator [](int group) => match[group];
  @override String? group(int group) => match.group(group);
  @override int get groupCount => match.groupCount;
  @override List<String?> groups(List<int> groupIndices) => match.groups(groupIndices);

  /* -= Analyzing Methods =- */

  Set<TokenMatch<T>> get<T extends Token>(T token) {
    if (match is! TokenMatch) return <TokenMatch<T>>{};
    return {
      if ((match as TokenMatch).token == token) match as TokenMatch<T>,
      ... (match as TokenMatch).get(token)
    };
  }

  Set<Match> get children => {
    if (match is ParentMatch) ... (match as ParentMatch).children
    else match,
  };
}

class ParentMatch<PatternT extends Pattern> extends Match {
  @override final PatternT pattern;
  final List<Match> children;

  ParentMatch(this.pattern, this.children);
  
  @override String get input => (children.isNotEmpty ? children.first : null)?.input ?? '';

  @override int get start => children.firstOrNull?.start ?? 0;
  @override int get end => children.lastOrNull?.end ?? 0;
  
  @override String? operator [](int group) => this.group(group);
  @override String? group(int group) {
    if (group == 0) return input.substring(start, end);
    for (final child in children) {
      if (group <= child.groupCount) return child.group(group);
      group -= child.groupCount;
    }
    return null;
  }
  
  @override int get groupCount => children.fold(0, (value, element) => value + element.groupCount);
  @override List<String?> groups(List<int> groupIndices) => groupIndices.map((group) => this.group(group)).toList();
}