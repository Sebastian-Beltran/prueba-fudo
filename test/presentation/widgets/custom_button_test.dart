import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_fudo/presentation/widgets/custom_button.dart';

void main() {
  group('Testing custom button', () {
    testWidgets('Testing custom button with text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Boton',
              onPressed: () {},
            ),
          ),
        ),
      );
      final findText = find.text('Boton');
      expect(findText, findsOneWidget);
    });
  });
}
