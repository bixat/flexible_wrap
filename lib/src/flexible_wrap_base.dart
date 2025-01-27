import 'package:flexible_wrap/src/render_flexible_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A widget that arranges its children in a flexible wrap layout, allowing them
/// to expand according to available space while maintaining the specified layout
/// properties.
class FlexibleWrap extends MultiChildRenderObjectWidget {
  /// Creates a FlexibleWrap widget.
  ///
  /// The [isOneRowExpanded] argument determines whether a single row of children
  /// can expand to fill the available space. The other parameters control the
  /// layout and alignment properties of the wrap.
  const FlexibleWrap(
      {super.key,
      required super.children,
      this.textDirection,
      this.spacing = 0.0,
      this.runSpacing = 0.0,
      this.isOneRowExpanded = false});

  /// Whether a single row of children can expand to fill available space.
  final bool isOneRowExpanded;
  final double spacing;
  final double runSpacing;
  final TextDirection? textDirection;

  @override
  RenderFlexibleWrap createRenderObject(BuildContext context) {
    return RenderFlexibleWrap(
        spacing: spacing,
        textDirection: textDirection ?? Directionality.maybeOf(context),
        runSpacing: runSpacing,
        isOneRowExpanded: isOneRowExpanded);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderFlexibleWrap renderObject) {
    if (renderObject.spacing != spacing ||
        renderObject.runSpacing != runSpacing ||
        renderObject.textDirection !=
            (textDirection ?? Directionality.maybeOf(context)) ||
        renderObject.isOneRowExpanded != isOneRowExpanded) {
      renderObject
        ..spacing = spacing
        ..runSpacing = runSpacing
        ..textDirection = textDirection ?? Directionality.maybeOf(context)
        ..isOneRowExpanded = isOneRowExpanded;
      renderObject.markNeedsLayout();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('spacing', spacing));
    properties.add(DoubleProperty('runSpacing', runSpacing));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection,
        defaultValue: null));
    properties.add(FlagProperty('isOneRowExpanded',
        value: isOneRowExpanded,
        ifTrue: 'one row expanded',
        ifFalse: 'one row not expanded'));
  }
}
