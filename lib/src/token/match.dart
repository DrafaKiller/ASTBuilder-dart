import 'package:ast_builder/src/token/element.dart';

class TokenMatch<TokenT extends Token> extends Match {
  final TokenT token;
  final Match match;

  TokenMatch(this.token, this.match);

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
    if (match is TokenMatchBound) ... (match as TokenMatchBound).children
    else match,
  };
}

class TokenMatchBound extends TokenMatch {
  final Match match2;
  TokenMatchBound(super.token, super.match, this.match2);
  
  @override int get end => match2.end;

  @override String? operator [](int group) {
    if (group == 0) return match.input.substring(start, end);
    if (group <= match.groupCount) return match[group];
    return match2[group - match.groupCount];
  }
  
  @override String? group(int group) {
    if (group == 0) return match.input.substring(start, end);
    if (group <= match.groupCount) return match.group(group);
    return match2.group(group - match.groupCount);
  }
  
  @override int get groupCount => match.groupCount + match2.groupCount;
  @override List<String?> groups(List<int> groupIndices) =>
    groupIndices.map((group) => this.group(group)).toList();
    
  /* -= Analyzing Methods =- */

  @override
  Set<TokenMatch<T>> get<T extends Token>(T token) => {
    if (match is TokenMatch) ... {
      if ((match as TokenMatch).token == token) match as TokenMatch<T>,
      ... (match as TokenMatch).get(token)
    },
    if (match2 is TokenMatch) ... {
      if ((match2 as TokenMatch).token == token) match2 as TokenMatch<T>,
      ... (match2 as TokenMatch).get(token)
    }
  };

  @override
  Set<Match> get children => {
    if (match is TokenMatchBound) ... (match as TokenMatchBound).children
    else match,
    match2,
  };
}