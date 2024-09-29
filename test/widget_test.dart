// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart'; // Import your main file

void main() {
  testWidgets('Temperature Conversion Test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const TemperatureConverterApp());

    // Verify that the input field is present.
    expect(find.byType(TextField), findsOneWidget);

    // Enter a value in the input field.
    await tester.enterText(find.byType(TextField), '100');

    // Select C to F conversion.
    await tester.tap(
        find.byType(Radio).first); // Tap on the first radio button (C to F)
    await tester.pump();

    // Tap the convert button.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify that the result is displayed.
    expect(find.text('Converted Temperature: 212.00 °F'), findsOneWidget);
  });
}
