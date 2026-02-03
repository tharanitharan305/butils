import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'text_rule.dart';
import 'image_rule.dart';
import 'latex_rule.dart';

/// Singleton engine responsible for fetching and applying transformation rules.
class ButilsEngine {
  static final ButilsEngine _instance = ButilsEngine._internal();
  static ButilsEngine get instance => _instance;

  ButilsEngine._internal();

  bool _isInitialized = false;
  
  final List<TextRule> _textRules = [];
  final List<ImageRule> _imageRules = [];
  final List<LatexRule> _latexRules = [];

  /// Resets the engine state. ONLY for testing.
  @visibleForTesting
  void reset() {
    _isInitialized = false;
    _textRules.clear();
    _imageRules.clear();
    _latexRules.clear();
  }

  /// Fetches configuration from the remote server.
  /// Fails gracefully (no-op) if server is unreachable.
  Future<void> initialize({http.Client? client}) async {
    if (_isInitialized) return;

    final httpClient = client ?? http.Client();

    try {
      await Future.wait([
        _fetchRules(httpClient, 'http://localhost:3000/text', _parseTextRules),
        _fetchRules(httpClient, 'http://localhost:3000/image', _parseImageRules),
        _fetchRules(httpClient, 'http://localhost:3000/tex', _parseLatexRules),
      ]);
    } catch (e) {
      debugPrint('ButilsEngine: Failed to fetch rules. Using defaults.');
    } finally {
      _isInitialized = true;
    }
  }

  Future<void> _fetchRules(
    http.Client client, 
    String url, 
    void Function(dynamic) parser
  ) async {
    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        parser(data);
      }
    } catch (_) {
      // Ignore network errors
    }
  }

  void _parseTextRules(dynamic json) {
    if (json is List) {
      _textRules.addAll(json.map((e) => TextRule.fromJson(e)));
    }
  }

  void _parseImageRules(dynamic json) {
     if (json is List) {
      _imageRules.addAll(json.map((e) => ImageRule.fromJson(e)));
    }
  }

  void _parseLatexRules(dynamic json) {
     if (json is List) {
      _latexRules.addAll(json.map((e) => LatexRule.fromJson(e)));
    }
  }

  String applyText(String input) {
    var result = input;
    for (final rule in _textRules) {
      result = rule.apply(result);
    }
    return result;
  }

  String applyImage(String src) {
    var result = src;
    for (final rule in _imageRules) {
      result = rule.apply(result);
    }
    return result;
  }

  String applyLatex(String tex) {
    var result = tex;
    for (final rule in _latexRules) {
      result = rule.apply(result);
    }
    return result;
  }
}
