import 'package:cardholder/widgets/ch_button.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cardholder/main.dart';

void main() {
  testWidgets('Exampletest', (WidgetTester tester) async {
    await tester.pumpWidget(Cardholder());

    expect(find.widgetWithText(Button, 'Lobby suchen'), findsOneWidget);
    expect(find.widgetWithText(Button, 'Lobby erstellen'), findsOneWidget);
  });
}
