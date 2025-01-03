import 'package:flexible_wrap/src/render_flexible_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A widget that arranges its children in a flexible wrap layout, allowing them
/// to expand according to available space while maintaining the specified layout
/// properties.
class FlexibleWrap extends Wrap {
  /// Creates a FlexibleWrap widget.
  ///
  /// The [isOneRowExpanded] argument determines whether a single row of children
  /// can expand to fill the available space. The other parameters control the
  /// layout and alignment properties of the wrap.
  const FlexibleWrap(
      {super.key,
      super.children,
      super.textDirection,
      super.spacing,
      this.isOneRowExpanded = false});

  /// Whether a single row of children can expand to fill available space.
  final bool isOneRowExpanded;

  @override
  RenderWrap createRenderObject(BuildContext context) {
    return RenderFlexibleWrap(
        spacing: spacing,
        textDirection: textDirection ?? Directionality.maybeOf(context),
        isOneRowExpanded: isOneRowExpanded);
  }
}
