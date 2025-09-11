import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:cs442_mp6/pages/home_page.dart';
import 'package:cs442_mp6/pages/journal_page.dart';
import 'package:cs442_mp6/pages/insights_page.dart';
import 'package:cs442_mp6/providers/journal_provider.dart';

void main() {
  Widget createWidget(Widget child) => ChangeNotifierProvider(
        create: (_) => JournalProvider(),
        child: MaterialApp(home: child),
      );

  testWidgets('HomePage shows mood buttons', (WidgetTester tester) async {
    await tester.pumpWidget(createWidget(HomePage()));
    expect(find.text('Happy'), findsOneWidget);
    expect(find.text('Sad'), findsOneWidget);
    expect(find.text('Angry'), findsOneWidget);
    expect(find.text('Neutral'), findsOneWidget);
  });

  testWidgets('HomePage accepts journal input and shows snackbar',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidget(HomePage()));
    await tester.enterText(find.byType(TextField), 'Feeling good!');
    await tester.tap(find.text('Happy'));
    await tester.tap(find.text('Save Entry'));
    await tester.pump(); // allow snackbar to appear
    expect(find.text('Mood entry saved!'), findsOneWidget);
  });

  testWidgets('JournalPage shows empty state by default',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidget(JournalPage()));
    expect(find.text('No entries yet.'), findsOneWidget);
  });

  testWidgets('InsightsPage shows loading initially',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: InsightsPage()));
    expect(find.textContaining('Loading'), findsOneWidget);
  });

  testWidgets('Tapping journal icon navigates to JournalPage',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidget(HomePage()));
    await tester.tap(find.byIcon(Icons.book));
    await tester.pumpAndSettle();
    expect(find.text('My Journal'), findsOneWidget);
  });
}
