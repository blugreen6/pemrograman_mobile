import 'package:flutter_test/flutter_test.dart';
import 'package:worldly/main.dart';

void main() {
  testWidgets('Worldly app launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const WorldlyApp());

    expect(find.text('WORLDLY'), findsOneWidget);
  });
}
