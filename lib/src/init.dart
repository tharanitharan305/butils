import 'package:http/http.dart' as http;
import 'engine/butils_engine.dart';

/// The public entry point for initializing the Butils package.
class Butils {
  /// Initializes the transformation engine.
  /// 
  /// This must be called before using [BText], [BImage], or [BLatex].
  /// Ideally called in `main()` before `runApp()`.
  ///
  /// [client] can be provided for testing purposes.
  static Future<void> init({http.Client? client}) async {
    await ButilsEngine.instance.initialize(client: client);
  }
}
