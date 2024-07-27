import 'package:flutter/rendering.dart';

/// A custom RenderBox that allows flexible wrapping of children within a given layout constraint.
class RenderFlexibleWrap extends RenderWrap {
  /// Constructs a [RenderFlexibleWrap].
  ///
  /// The [isOneRowExpanded] parameter decides whether to expand a single row to fill the available space.
  RenderFlexibleWrap(
      {super.direction,
      super.alignment,
      super.spacing,
      super.runAlignment,
      super.runSpacing,
      super.crossAxisAlignment,
      super.textDirection,
      super.verticalDirection,
      super.clipBehavior,
      this.isOneRowExpanded = false});

  /// Indicates whether a single row should be expanded to fill the available space.
  final bool isOneRowExpanded;

  @override
  void performLayout() {
    super.performLayout();
    var child = firstChild;
    final parentWidth = constraints.maxWidth;
    double extraWidth = 0.0;
    int baseItems = 0;
    for (var i = 0; i < childCount; i++) {
      final double widthWithSpacing = child!.size.width + spacing;
      if (parentWidth.isFinite) {
        final items = (parentWidth / widthWithSpacing).floor();
        final isOneRow = items >= childCount && isOneRowExpanded;
        baseItems = (isOneRow ? childCount : items);
        double remainder = parentWidth - (widthWithSpacing * baseItems);
        extraWidth = remainder / baseItems;
      }
      final newWidth = extraWidth + child.size.width;
      final thisOffset = (child.parentData as WrapParentData).offset;
      child.layout(BoxConstraints.tight(Size(newWidth, child.size.height)));
      (child.parentData as WrapParentData).offset = Offset(
          thisOffset.dx +
              (extraWidth * (thisOffset.dx / widthWithSpacing).floor()),
          thisOffset.dy);
      child = childAfter(child);
    }
    size = Size(size.width + extraWidth * baseItems, size.height);
  }
}
