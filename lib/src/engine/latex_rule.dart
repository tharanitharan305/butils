/// Defines a rule for modifying mathematical formulas.
class LatexRule {
  final String targetSymbol;
  final String substitution;

  LatexRule({required this.targetSymbol, required this.substitution});

  factory LatexRule.fromJson(Map<String, dynamic> json) {
    return LatexRule(
      targetSymbol: json['symbol'] as String? ?? '',
      substitution: json['substitution'] as String? ?? '',
    );
  }

  String apply(String input) {
    if (targetSymbol.isEmpty) return input;
    return input.replaceAll(targetSymbol, substitution);
  }
}
