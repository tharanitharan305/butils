import 'package:flutter/widgets.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../engine/butils_engine.dart';

/// A wrapper for rendering LaTeX equations with automatic formatting.
class BLatex extends StatelessWidget {
  final String tex;
  final TextStyle? textStyle;

  const BLatex(
    this.tex, {
    super.key,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    // Apply transformation synchronously
    final processedTex = ButilsEngine.instance.applyLatex(tex);

    return Math.tex(
      processedTex,
      textStyle: textStyle,
      onErrorFallback: (err) => Text(tex), // Fallback to raw tex on error
    );
  }
}
