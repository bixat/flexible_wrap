import 'package:flutter/rendering.dart';

class RenderFlexibleWrap extends RenderWrap {
  RenderFlexibleWrap({
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
    var child = firstChild;
    final parentSize = constraints.maxWidth;
    double extraWidth = 0.0;
    int items = 0;
    for (var i = 0; i < childCount; i++) {
      final double widthWithSpacing = child!.size.width;
      if (parentSize.isFinite) {
        items = (parentSize / widthWithSpacing).floor();
        double remainder = parentSize.remainder(widthWithSpacing);
        extraWidth = remainder / items;
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
    size = Size(size.width + extraWidth * items, size.height);
  }
}
