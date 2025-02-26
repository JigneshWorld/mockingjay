import 'package:example/ui/ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockingjay/mockingjay.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers.dart';

void main() {
  group('QuizDialog', () {
    late MockNavigator navigator;

    setUp(() {
      navigator = MockNavigator();
    });

    group('pizza button', () {
      testWidgets('is rendered', (tester) async {
        await tester.pumpTest(
          builder: (context) {
            return const QuizDialog();
          },
        );

        expect(find.text('🍕'), findsOneWidget);
      });

      testWidgets(
        'pops route with pizza option when pressed',
        (tester) async {
          await tester.pumpTest(
            builder: (context) {
              return MockNavigatorProvider(
                navigator: navigator,
                child: const QuizDialog(),
              );
            },
          );

          await tester.tap(find.text('🍕'));

          verify(() => navigator.pop(QuizOption.pizza)).called(1);
        },
      );
    });

    group('hamburger button', () {
      testWidgets('is rendered', (tester) async {
        await tester.pumpTest(
          builder: (context) {
            return const QuizDialog();
          },
        );

        expect(find.text('🍔'), findsOneWidget);
      });

      testWidgets(
        'pops route with hamburger option when pressed',
        (tester) async {
          await tester.pumpTest(
            builder: (context) {
              return MockNavigatorProvider(
                navigator: navigator,
                child: const QuizDialog(),
              );
            },
          );

          await tester.tap(find.text('🍔'));

          verify(() => navigator.pop(QuizOption.hamburger)).called(1);
        },
      );
    });
  });
}
