import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:butils/butils.dart';
import 'package:butils/src/engine/butils_engine.dart'; // Import to access reset()

import 'widget_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;

  setUp(() async {
    // RESET THE ENGINE STATE BEFORE EVERY TEST
    ButilsEngine.instance.reset();

    mockClient = MockClient();

    // 1. DEFAULT MOCK (Must be first)
    // This catches calls to image/tex and returns empty list
    when(mockClient.get(any)).thenAnswer((_) async => http.Response('[]', 200));

    // 2. SPECIFIC MOCK (Must be after default to override it)
    when(mockClient.get(Uri.parse('http://localhost:3000/text')))
        .thenAnswer((_) async => http.Response(
            jsonEncode([
              {'pattern': 'Apple', 'replacement': 'Orange'}
            ]),
            200));

    await Butils.init(client: mockClient);
  });

  testWidgets('BText applies engine rules', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: BText('I like Apple')),
    ));

    expect(find.text('I like Orange'), findsOneWidget);
    expect(find.text('I like Apple'), findsNothing);
  });

  testWidgets('BLatex renders Math widget with transformed content',
      (WidgetTester tester) async {
    // Reset and re-init for this specific test case
    ButilsEngine.instance.reset();

    mockClient = MockClient();

    // 1. DEFAULT MOCK
    when(mockClient.get(any)).thenAnswer((_) async => http.Response('[]', 200));

    // 2. SPECIFIC MOCK
    when(mockClient.get(Uri.parse('http://localhost:3000/tex')))
        .thenAnswer((_) async => http.Response(
            jsonEncode([
              {'symbol': '1', 'substitution': '2'}
            ]),
            200));

    await Butils.init(client: mockClient);
  });
}
