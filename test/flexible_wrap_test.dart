import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlexibleWrap Widget Tests', () {
    Widget buildFlexibleWrap({
      required List<Widget> children,
      bool isOneRowExpanded = false,
      TextDirection textDirection = TextDirection.ltr,
      double spacing = 10.0,
      double runSpacing = 10.0,
    }) {
      return MaterialApp(
        home: Directionality(
          textDirection: textDirection,
          child: Scaffold(
            body: Container(
              color: Colors.brown,
              width: 300,
              child: Wrap(
                spacing: spacing,
                runSpacing: runSpacing,
                children: children,
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('renders multiple children correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildFlexibleWrap(
          children: List.generate(
            3,
            (index) => SizedBox(
              width: 100,
              height: 50,
              child: Text('Item $index'),
            ),
          ),
        ),
      );

      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('handles RTL direction correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildFlexibleWrap(
          textDirection: TextDirection.rtl,
          children: List.generate(
            2,
            (index) => SizedBox(
              width: 100,
              height: 50,
              child: Text('Item $index'),
            ),
          ),
        ),
      );

      final firstItemFinder = find.text('Item 0');
      final secondItemFinder = find.text('Item 1');

      expect(
          tester.getTopRight(firstItemFinder).dx >
              tester.getTopRight(secondItemFinder).dx,
          true);
    });

    testWidgets('expands items in single row when enabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildFlexibleWrap(
          isOneRowExpanded: true,
          children: List.generate(
            2,
            (index) => Container(
              color: Colors.brown,
              width: 100,
              height: 50,
              child: Text('Item $index'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.constraints?.maxWidth, 300);
    });

    testWidgets('wraps items to next line when width exceeded',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildFlexibleWrap(
          children: List.generate(
            4,
            (index) => SizedBox(
              width: 100,
              height: 50,
              child: Text('Item $index'),
            ),
          ),
        ),
      );

      final firstItemPos = tester.getTopLeft(find.text('Item 0'));
      final lastItemPos = tester.getTopLeft(find.text('Item 3'));

      expect(lastItemPos.dy > firstItemPos.dy, true);
    });

    testWidgets('applies vertical spacing correctly',
        (WidgetTester tester) async {
      const runSpacing = 20.0;
      const itemHeight = 50.0;

      await tester.pumpWidget(
        buildFlexibleWrap(
          runSpacing: runSpacing,
          children: List.generate(
            4,
            (index) => SizedBox(
              width: 200, // Forces wrap with 300px parent
              height: itemHeight,
              child: Text('Item $index'),
            ),
          ),
        ),
      );

      // Find positions of item 2
      final thirdItemPos = tester.getTopLeft(find.text('Item 2'));

      // Verify vertical spacing
      expect(thirdItemPos.dy, (itemHeight + runSpacing) * 2);
    });

    testWidgets('maintains correct spacing between items',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildFlexibleWrap(
          spacing: 20.0,
          children: List.generate(
            2,
            (index) => SizedBox(
              width: 100,
              height: 50,
              child: Text('Item $index'),
            ),
          ),
        ),
      );

      final firstItemRight = tester.getTopRight(find.text('Item 0'));
      final secondItemLeft = tester.getTopLeft(find.text('Item 1'));

      expect((secondItemLeft.dx - firstItemRight.dx).round(), 20);
    });

    testWidgets('rebuilds correctly when children change',
        (WidgetTester tester) async {
      final List<Widget> initialChildren = List.generate(
        2,
        (index) => SizedBox(
          width: 100,
          height: 50,
          child: Text('Item $index'),
        ),
      );

      await tester.pumpWidget(buildFlexibleWrap(children: initialChildren));
      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);

      final List<Widget> updatedChildren = List.generate(
        3,
        (index) => SizedBox(
          width: 100,
          height: 50,
          child: Text('Item $index'),
        ),
      );

      await tester.pumpWidget(buildFlexibleWrap(children: updatedChildren));
      expect(find.text('Item 2'), findsOneWidget);
    });
  });
}
