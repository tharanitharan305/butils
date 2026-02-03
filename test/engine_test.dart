import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:butils/src/engine/butils_engine.dart';
import 'package:butils/src/init.dart';

import 'engine_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;

  setUp(() {
    ButilsEngine.instance.reset(); // Ensure clean slate
    mockClient = MockClient();
  });

  test('ButilsEngine applies transformations from JSON rules', () async {
    when(mockClient.get(Uri.parse('http://localhost:3000/text')))
        .thenAnswer((_) async => http.Response(jsonEncode([
              {'pattern': 'bad', 'replacement': 'good'}
            ]), 200));

    when(mockClient.get(Uri.parse('http://localhost:3000/image')))
        .thenAnswer((_) async => http.Response(jsonEncode([
              {'trigger': 'cat.png', 'target': 'dog.png'}
            ]), 200));

    when(mockClient.get(Uri.parse('http://localhost:3000/tex')))
        .thenAnswer((_) async => http.Response(jsonEncode([
              {'symbol': '\\alpha', 'substitution': '\\beta'}
            ]), 200));

    await Butils.init(client: mockClient);

    expect(ButilsEngine.instance.applyText('This is bad'), 'This is good');
    expect(ButilsEngine.instance.applyImage('https://site.com/cat.png'), 'dog.png');
    expect(ButilsEngine.instance.applyImage('https://site.com/bird.png'), 'https://site.com/bird.png');
    expect(ButilsEngine.instance.applyLatex('x = \\alpha'), 'x = \\beta');
  });

  test('ButilsEngine handles failures gracefully', () async {
    when(mockClient.get(any)).thenThrow(Exception('Server down'));

    await Butils.init(client: mockClient);

    expect(ButilsEngine.instance.applyText('Hello'), 'Hello');
  });
}
