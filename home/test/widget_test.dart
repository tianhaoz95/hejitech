import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hejitech_home/main.dart';

void main() {
  testWidgets('HejiTech landing page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HejiTechApp());

    // Verify that the company name is present.
    expect(find.text('HEJI TECHNOLOGY'), findsOneWidget);
    expect(find.text('Building the\nAI-native future.'), findsOneWidget);

    // Verify that some products are listed.
    expect(find.text('MicroForge'), findsOneWidget);
    expect(find.text('Snowglobe'), findsOneWidget);

    // Verify footer contains Terms of Service.
    expect(find.text('TERMS OF SERVICE'), findsOneWidget);
  });

  testWidgets('Navigate to Terms of Service', (WidgetTester tester) async {
    await tester.pumpWidget(const HejiTechApp());

    // Find and tap the Terms of Service link.
    final termsLink = find.text('TERMS OF SERVICE');
    expect(termsLink, findsOneWidget);
    
    // Scroll to footer if necessary (though in 800x600 it might be off screen)
    await tester.scrollUntilVisible(termsLink, 100);
    await tester.tap(termsLink);
    await tester.pumpAndSettle();

    // Verify we are on the Terms of Service page.
    expect(find.text('Legal Framework'), findsOneWidget);
    expect(find.text('1. Acceptance of Terms'), findsOneWidget);

    // Go back.
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify we are back on the home page.
    expect(find.text('Building the\nAI-native future.'), findsOneWidget);
  });
}
