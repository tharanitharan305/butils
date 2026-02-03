/// Defines a rule for replacing text content.
class TextRule {
  final String pattern;
  final String replacement;

  TextRule({required this.pattern, required this.replacement});

  factory TextRule.fromJson(Map<String, dynamic> json) {
    return TextRule(
      pattern: json['pattern'] as String? ?? '',
      replacement: json['replacement'] as String? ?? '',
    );
  }

  String apply(String input) {
    if (pattern.isEmpty) return input;
    return input.replaceAll(RegExp(pattern), replacement);
  }
}
