import 'package:flexible_wrap/src/render_flexible_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FlexibleWrap extends Wrap {
  /// Creates a widget that arranges its children in a flexible wrap layout, allowing them to expand according to available space while maintaining the specified layout properties.

  const FlexibleWrap(
      {super.key,
      super.children,
      super.textDirection,
      super.direction,
      super.alignment,
      super.spacing,
      super.runAlignment,
      super.crossAxisAlignment,
      super.verticalDirection,
      super.clipBehavior,
      this.isOneRowExpanded = false});

  final bool isOneRowExpanded;

  @override
  RenderWrap createRenderObject(BuildContext context) {
    return RenderFlexibleWrap(
        direction: direction,
        alignment: alignment,
        spacing: spacing,
        runAlignment: runAlignment,
        runSpacing: runSpacing,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection ?? Directionality.maybeOf(context),
        verticalDirection: verticalDirection,
        clipBehavior: clipBehavior,
        isOneRowExpanded: isOneRowExpanded);
  }
}
