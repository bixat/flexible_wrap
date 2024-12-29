import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flexible_wrap/src/render_flexible_wrap.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  void layout(RenderBox box, {required BoxConstraints constraints}) {
    box.layout(constraints, parentUsesSize: true);
  }

  group('RenderFlexibleWrap', () {
    late RenderFlexibleWrap renderFlexibleWrap;
    late RenderBox child1;
    late RenderBox child2;
    late RenderBox child3;

    setUp(() {
      renderFlexibleWrap = RenderFlexibleWrap(
        spacing: 10.0,
        textDirection: TextDirection.ltr,
        isOneRowExpanded: false,
      );

      child1 = RenderConstrainedBox(
        additionalConstraints: BoxConstraints.tight(const Size(50.0, 50.0)),
      );
      child2 = RenderConstrainedBox(
        additionalConstraints: BoxConstraints.tight(const Size(50.0, 50.0)),
      );
      child3 = RenderConstrainedBox(
        additionalConstraints: BoxConstraints.tight(const Size(50.0, 50.0)),
      );
    });

    test('basic layout properties', () {
      renderFlexibleWrap.addAll([child1, child2, child3]);
      layout(renderFlexibleWrap,
          constraints: BoxConstraints.tight(const Size(200.0, 100.0)));

      expect(renderFlexibleWrap.size.width, equals(200.0));
      expect(child1.size.width, greaterThan(50.0)); // Should be expanded
    });

    test('RTL support', () {
      renderFlexibleWrap = RenderFlexibleWrap(
        spacing: 10.0,
        textDirection: TextDirection.rtl,
        isOneRowExpanded: false,
      );
      renderFlexibleWrap.addAll([child1, child2]);
      layout(renderFlexibleWrap,
          constraints: BoxConstraints.tight(const Size(200.0, 100.0)));

      final child1Pos = (child1.parentData as WrapParentData).offset.dx;
      final child2Pos = (child2.parentData as WrapParentData).offset.dx;
      expect(child1Pos, greaterThan(child2Pos)); // RTL ordering
    });

    test('single row expansion', () {
      renderFlexibleWrap = RenderFlexibleWrap(
        spacing: 10.0,
        textDirection: TextDirection.ltr,
        isOneRowExpanded: true,
      );
      renderFlexibleWrap.addAll([child1, child2]);
      layout(renderFlexibleWrap,
          constraints: BoxConstraints.tight(const Size(200.0, 100.0)));

      final totalWidth =
          child1.size.width + child2.size.width + 10.0;
      expect(totalWidth, equals(210.0));
    });

    test('multi-row wrapping', () {
      renderFlexibleWrap.addAll([child1, child2, child3]);
      layout(renderFlexibleWrap,
          constraints: BoxConstraints.tight(const Size(120.0, 200.0)));

      final child1Y = (child1.parentData as WrapParentData).offset.dy;
      final child3Y = (child3.parentData as WrapParentData).offset.dy;
      expect(child3Y, greaterThan(child1Y)); // Should wrap to next line
    });

    test('spacing calculation', () {
      renderFlexibleWrap.addAll([child1, child2]);
      layout(renderFlexibleWrap,
          constraints: BoxConstraints.tight(const Size(200.0, 100.0)));

      final child1Pos = (child1.parentData as WrapParentData).offset.dx;
      final child2Pos = (child2.parentData as WrapParentData).offset.dx;
      expect(child2Pos - (child1Pos + child1.size.width),
          equals(0.0));
    });
  });
}
