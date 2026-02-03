import 'package:flutter/widgets.dart';
import '../engine/butils_engine.dart';

/// A drop-in replacement for [Text] that ensures content compliance.
class BText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;

  const BText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    // Apply transformation synchronously
    final processedText = ButilsEngine.instance.applyText(data);

    return Text(
      processedText,
      style: style,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
