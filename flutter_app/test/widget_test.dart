import 'package:flutter_test/flutter_test.dart';
import 'package:ai_chef_flutter/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AiChefApp());
    expect(find.byType(AiChefApp), findsOneWidget);
  });
}
