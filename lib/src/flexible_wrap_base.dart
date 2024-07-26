import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FlexibleWrap extends StatelessWidget {
  /// Creates a widget that arranges its children in a wrap layout.
  ///
  /// The [length], [builder], and [itemWidth] arguments are required and must not be null.
  /// If [direction] is not specified, it defaults to [Axis.horizontal].
  /// If [alignment] is not specified, it defaults to [WrapAlignment.start].
  /// If [spacing] is not specified, it defaults to 0.0.
  /// If [runAlignment] is not specified, it defaults to [WrapAlignment.start].
  /// If [crossAxisAlignment] is not specified, it defaults to [WrapCrossAlignment.start].
  /// If [verticalDirection] is not specified, it defaults to [VerticalDirection.down].
  ///
  /// The [textDirection] and [clipBehavior] arguments are optional and can be null.
  const FlexibleWrap(
      {super.key,
      required this.length,
      required this.builder,
      required this.itemWidth,
      this.textDirection,
      this.direction = Axis.horizontal,
      this.alignment = WrapAlignment.start,
      this.spacing = 0.0,
      this.runAlignment = WrapAlignment.start,
      this.crossAxisAlignment = WrapCrossAlignment.start,
      this.verticalDirection = VerticalDirection.down,
      this.clipBehavior});

  /// The number of children to display in the wrap.
  final int length;

  /// The builder function to generate children with the given index and extra width.
  final Widget Function(int index) builder;

  /// The width of each item in the wrap.
  final double itemWidth;

  /// The direction to arrange the children in (horizontal or vertical).
  final Axis direction;

  /// How the children within a run should be placed in the main axis.
  final WrapAlignment alignment;

  /// The amount of spacing between the children in the main axis.
  final double spacing;

  /// How the runs themselves should be placed in the cross axis.
  final WrapAlignment runAlignment;

  /// The amount of spacing between the runs in the cross axis.
  final double runSpacing = 0.0;

  /// How the children within a run should be aligned relative to each other in the cross axis.
  final WrapCrossAlignment crossAxisAlignment;

  /// The text direction to use when laying out the children.
  final TextDirection? textDirection;

  /// The direction to use when laying out the runs (down or up).
  final VerticalDirection verticalDirection;

  /// If non-null, determines the clip behavior of the wrap.
  final Clip? clipBehavior;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      double extraWidth = 0.0;
      final double widthWithSpacing = itemWidth + spacing;
      if (constraint.maxWidth.isFinite) {
        int items = (constraint.maxWidth / widthWithSpacing).floor();
        double remainder = constraint.maxWidth.remainder(widthWithSpacing);
        extraWidth = remainder / items;
      }
      return Wrap(
        direction: direction,
        textDirection: textDirection,
        alignment: alignment,
        spacing: spacing,
        crossAxisAlignment: crossAxisAlignment,
        verticalDirection: verticalDirection,
        runAlignment: runAlignment,
        children: List.generate(length, (index) {
          return SizedBox(
            width: itemWidth + extraWidth,
            child: builder(index),
          );
        }),
      );
    });
  }
}

class MyWrap extends Wrap {
  const MyWrap({super.key, super.children});

  @override
  RenderWrap createRenderObject(BuildContext context) {
    return MyRenderWrap(
      direction: direction,
      alignment: alignment,
      spacing: spacing,
      runAlignment: runAlignment,
      runSpacing: runSpacing,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection ?? Directionality.maybeOf(context),
      verticalDirection: verticalDirection,
      clipBehavior: clipBehavior,
    );
  }
}

class MyRenderWrap extends RenderWrap {
  MyRenderWrap({
    super.direction,
    super.alignment,
    super.spacing,
    super.runAlignment,
    super.runSpacing,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.clipBehavior,
  });

  @override
  void performLayout() {
    super.performLayout();
    for (var child = firstChild; child != null; child = childAfter(child)) {
      child.layout(BoxConstraints.tight(Size(216, child.size.height)));
      if (childAfter(child) == null) {
        (child.parentData as WrapParentData).offset = Offset(
            (child.parentData as WrapParentData).offset.dx + 100,
            (child.parentData as WrapParentData).offset.dy);
      }
    }
  }
}
