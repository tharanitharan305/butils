/// Defines a rule for redirecting or swapping image URLs.
class ImageRule {
  final String triggerUrl;
  final String targetUrl;

  ImageRule({required this.triggerUrl, required this.targetUrl});

  factory ImageRule.fromJson(Map<String, dynamic> json) {
    return ImageRule(
      triggerUrl: json['trigger'] as String? ?? '',
      targetUrl: json['target'] as String? ?? '',
    );
  }

  String apply(String input) {
    if (triggerUrl.isEmpty) return input;
    if (input.contains(triggerUrl)) {
      return targetUrl;
    }
    return input;
  }
}
