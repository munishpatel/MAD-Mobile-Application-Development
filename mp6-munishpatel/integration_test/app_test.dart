import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:cs442_mp6/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('MoodMate full flow with insights check', (WidgetTester tester) async {
    await tester.pumpWidget(MoodMateApp());

    // Verify startup screen
    expect(find.text('MoodMate'), findsOneWidget);
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Submit a mood entry
    await tester.enterText(find.byType(TextField), 'Feeling motivated!');
    await tester.tap(find.text('Happy'));
    await tester.tap(find.text('Save Entry'));
    await tester.pump();
    expect(find.text('Mood entry saved!'), findsOneWidget);

    // Navigate to journal page and verify entry
    await tester.tap(find.byIcon(Icons.book));
    await tester.pumpAndSettle();
    expect(find.textContaining('Feeling motivated!'), findsOneWidget);

    // Navigate to insights page
    await tester.pageBack(); // Go back to HomePage
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.insights));
    await tester.pumpAndSettle();

    // Wait for quote to load
    await tester.pump(Duration(seconds: 3));

    // Assert that some quote text is displayed (not loading/error)
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text && widget.data != null && widget.data!.contains('—'),
      ),
      findsOneWidget,
    );
  });
}
