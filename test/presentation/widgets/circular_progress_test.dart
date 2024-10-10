import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_fudo/presentation/widgets/circular_progress.dart';

void main() {
  group('Testing circular progress', () {
    testWidgets('Testing circular progress', (tester) async {
      const childWidget = CircularProgress();
      await tester.pumpWidget(Container(child: childWidget));
      expect(find.byWidget(childWidget), findsOneWidget);
    });
  });
}
