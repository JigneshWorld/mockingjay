import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockingjay/mockingjay.dart';
import 'package:mocktail/mocktail.dart';

extension on WidgetTester {
  Future<void> pumpTest({
    required MockNavigator navigator,
    required WidgetBuilder builder,
  }) async {
    await pumpWidget(
      MaterialApp(
        title: 'Mock Navigator Test',
        home: Scaffold(
          body: MockNavigatorProvider(
            navigator: navigator,
            child: Builder(
              builder: builder,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  group('MockNavigator', () {
    late MockNavigator navigator;

    const testRouteName = '__test_route__';
    final testRoute = MaterialPageRoute<void>(
      settings: const RouteSettings(
        name: testRouteName,
      ),
      builder: (_) => const Text(testRouteName),
    );
    bool testRoutePredicate(Route<dynamic> _) => false;
    Route<void> restorableTestRouteBuilder(
      BuildContext context,
      Object? arguments,
    ) {
      return testRoute;
    }

    setUp(() {
      navigator = MockNavigator();
    });

    test('toString returns normally', () {
      expect(
        () => navigator.toString(),
        returnsNormally,
      );
    });

    testWidgets('mocks .push calls', (tester) async {
      when(() => navigator.push(any())).thenAnswer((_) async {});

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context).push(testRoute),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(() => navigator.push(testRoute)).called(1);
    });

    testWidgets('mocks .pushNamed calls', (tester) async {
      when(() => navigator.pushNamed(any())).thenAnswer((_) async {});

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context).pushNamed(testRouteName),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(() => navigator.pushNamed(testRouteName)).called(1);
    });

    testWidgets('mocks .pushNamedAndRemoveUntil calls', (tester) async {
      when(() => navigator.pushNamedAndRemoveUntil(any(), any()))
          .thenAnswer((_) async {});

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
            testRouteName,
            testRoutePredicate,
          ),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(
        () => navigator.pushNamedAndRemoveUntil(
          testRouteName,
          testRoutePredicate,
        ),
      ).called(1);
    });

    testWidgets('mocks .pushReplacement calls', (tester) async {
      when(() => navigator.pushReplacement(any())).thenAnswer((_) async {});

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context).pushReplacement(testRoute),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(() => navigator.pushReplacement(testRoute)).called(1);
    });

    testWidgets('mocks .pushReplacementNamed calls', (tester) async {
      when(() => navigator.pushReplacementNamed(any()))
          .thenAnswer((_) async {});

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed(testRouteName),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(() => navigator.pushReplacementNamed(testRouteName)).called(1);
    });

    testWidgets('mocks .pop calls', (tester) async {
      when(() => navigator.pop(any())).thenAnswer((_) async {});

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context).pop(testRoute),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(() => navigator.pop(testRoute)).called(1);
    });

    testWidgets('mocks .popAndPushNamed calls', (tester) async {
      when(() => navigator.popAndPushNamed(any())).thenAnswer((_) async {});

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context).popAndPushNamed(testRouteName),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(() => navigator.popAndPushNamed(testRouteName)).called(1);
    });

    testWidgets('mocks .popUntil calls', (tester) async {
      when(() => navigator.popUntil(any())).thenAnswer((_) async {});

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context).popUntil(testRoutePredicate),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(() => navigator.popUntil(testRoutePredicate)).called(1);
    });

    testWidgets('mocks .pushAndRemoveUntil calls', (tester) async {
      when(() => navigator.pushAndRemoveUntil(any(), any()))
          .thenAnswer((_) async {});

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context)
              .pushAndRemoveUntil(testRoute, testRoutePredicate),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(
        () => navigator.pushAndRemoveUntil(
          testRoute,
          testRoutePredicate,
        ),
      ).called(1);
    });

    testWidgets('mocks .restorablePopAndPushNamed calls', (tester) async {
      when(() => navigator.restorablePopAndPushNamed(any()))
          .thenReturn(testRouteName);

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () =>
              Navigator.of(context).restorablePopAndPushNamed(testRouteName),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(() => navigator.restorablePopAndPushNamed(testRouteName))
          .called(1);
    });

    testWidgets('mocks .restorablePush calls', (tester) async {
      when(() => navigator.restorablePush(any())).thenReturn(testRouteName);

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () =>
              Navigator.of(context).restorablePush(restorableTestRouteBuilder),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(() => navigator.restorablePush(restorableTestRouteBuilder))
          .called(1);
    });

    testWidgets('mocks .restorablePushAndRemoveUntil calls', (tester) async {
      when(() => navigator.restorablePushAndRemoveUntil(any(), any()))
          .thenReturn(testRouteName);

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context).restorablePushAndRemoveUntil(
            restorableTestRouteBuilder,
            testRoutePredicate,
          ),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(
        () => navigator.restorablePushAndRemoveUntil(
          restorableTestRouteBuilder,
          testRoutePredicate,
        ),
      ).called(1);
    });

    testWidgets('mocks .restorablePushNamed calls', (tester) async {
      when(() => navigator.restorablePushNamed(any()))
          .thenReturn(testRouteName);

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () =>
              Navigator.of(context).restorablePushNamed(testRouteName),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(() => navigator.restorablePushNamed(testRouteName)).called(1);
    });

    testWidgets('mocks .restorablePushNamedAndRemoveUntil calls',
        (tester) async {
      when(() => navigator.restorablePushNamedAndRemoveUntil(any(), any()))
          .thenReturn(testRouteName);

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () =>
              Navigator.of(context).restorablePushNamedAndRemoveUntil(
            testRouteName,
            testRoutePredicate,
          ),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(
        () => navigator.restorablePushNamedAndRemoveUntil(
          testRouteName,
          testRoutePredicate,
        ),
      ).called(1);
    });

    testWidgets('mocks .restorablePushReplacement calls', (tester) async {
      when(() => navigator.restorablePushReplacement(any()))
          .thenReturn(testRouteName);

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context)
              .restorablePushReplacement(restorableTestRouteBuilder),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(
        () => navigator.restorablePushReplacement(restorableTestRouteBuilder),
      ).called(1);
    });

    testWidgets('mocks .restorablePushReplacementNamed calls', (tester) async {
      when(() => navigator.restorablePushReplacementNamed(any()))
          .thenReturn(testRouteName);

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context)
              .restorablePushReplacementNamed(testRouteName),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(() => navigator.restorablePushReplacementNamed(testRouteName))
          .called(1);
    });

    testWidgets('mocks .restorableReplace calls', (tester) async {
      when(() => navigator.restorableReplace(
            oldRoute: any(named: 'oldRoute'),
            newRouteBuilder: any(named: 'newRouteBuilder'),
          )).thenReturn(testRouteName);

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context).restorableReplace(
            oldRoute: testRoute,
            newRouteBuilder: restorableTestRouteBuilder,
          ),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(
        () => navigator.restorableReplace(
          oldRoute: testRoute,
          newRouteBuilder: restorableTestRouteBuilder,
        ),
      ).called(1);
    });

    testWidgets('mocks .restorableReplaceRouteBelow calls', (tester) async {
      when(() => navigator.restorableReplaceRouteBelow(
            anchorRoute: any(named: 'anchorRoute'),
            newRouteBuilder: any(named: 'newRouteBuilder'),
          )).thenReturn(testRouteName);

      await tester.pumpTest(
        navigator: navigator,
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context).restorableReplaceRouteBelow(
            anchorRoute: testRoute,
            newRouteBuilder: restorableTestRouteBuilder,
          ),
          child: const Text('Trigger'),
        ),
      );

      await tester.tap(find.byType(TextButton));
      verify(
        () => navigator.restorableReplaceRouteBelow(
          anchorRoute: testRoute,
          newRouteBuilder: restorableTestRouteBuilder,
        ),
      ).called(1);
    });
  });
}
