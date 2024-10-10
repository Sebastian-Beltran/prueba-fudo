import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_fudo/presentation/widgets/card_post_widget.dart';

void main() {
  group('Testing Card post widget', () {
    testWidgets('Testing Card post widget with params', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CardPostWidget(
              title: 'Title',
              body: 'Body',
              id: 1,
            ),
          ),
        ),
      );
      final findTitle = find.text('Title');
      final findBody = find.text('Body');
      final findId = find.text('1');
      expect(findTitle, findsOneWidget);
      expect(findBody, findsOneWidget);
      expect(findId, findsOneWidget);
    });
  });
}
