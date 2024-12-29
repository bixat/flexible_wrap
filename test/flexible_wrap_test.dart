// test/flexible_wrap_widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flexible_wrap/flexible_wrap.dart';

void main() {
  group('FlexibleWrap Widget Tests', () {
    Widget buildTestableWidget(Widget widget) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 400,
              height: 600,
              child: widget,
            ),
          ),
        ),
      );
    }

    testWidgets('FlexibleWrap renders correct number of items',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(
        FlexibleWrap(
          isOneRowExpanded: false,
          spacing: 12.0,
          children: List.generate(5, (int index) {
            return Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(color: Colors.blue.withOpacity(index % 8)),
              child: Center(child: Text('Item $index')),
            );
          }),
        ),
      ));

      expect(find.byType(Container), findsNWidgets(5));
    });

    testWidgets('FlexibleWrap handles item overflow',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(
        FlexibleWrap(
          isOneRowExpanded: false,
          spacing: 12.0,
          children: List.generate(10, (int index) {
            return Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(color: Colors.blue.withOpacity(index % 8)),
              child: Center(child: Text('Item $index')),
            );
          }),
        ),
      ));

      expect(find.byType(Container),
          findsNWidgets(5)); // Only 5 items should be visible
    });

    testWidgets('FlexibleWrap handles orientation change',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(
        FlexibleWrap(
          isOneRowExpanded: false,
          spacing: 12.0,
          children: List.generate(5, (int index) {
            return Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(color: Colors.blue.withOpacity(index % 8)),
              child: Center(child: Text('Item $index')),
            );
          }),
        ),
      ));

      await tester.pumpAndSettle();

      expect(
          find.byType(Container), findsNWidgets(2)); // Should wrap to 2 columns
    });
  });
}
