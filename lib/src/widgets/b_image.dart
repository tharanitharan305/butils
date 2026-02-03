import '../engine/butils_engine.dart';
import 'package:flutter/material.dart';

/// A drop-in replacement for [Image] that validates source integrity.
class BImage extends StatelessWidget {
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;

  /// Creates a widget that displays an image from the network.
  const BImage.network(
    this.src, {
    super.key,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    // Apply transformation synchronously
    final processedSrc = ButilsEngine.instance.applyImage(src);

    return Image.network(
      processedSrc,
      width: width,
      height: height,
      fit: fit,
      // Supply simple placeholders for errors/loading to mimic robust behavior
      errorBuilder: (ctx, err, stack) => SizedBox(
          width: width,
          height: height,
          child: const Center(child: Icon(Icons.broken_image))),
    );
  }
}
