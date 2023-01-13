import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'ContextMenu.dart';

/// Show a [ContextMenu] on the given [BuildContext]. For other parameters, see [ContextMenu].
void showContextMenu({
  required Offset offset,
  required BuildContext context,
  required List<Widget> children,
  double verticalPadding = 8,
  double width = 320,
  BorderRadius borderRadius = BorderRadius.zero,
  double? elevation,
  Color? color,
}) {
  showModal(
    context: context,
    configuration: FadeScaleTransitionConfiguration(
      barrierColor: Colors.transparent,
    ),
    builder: (context) => ContextMenu(
      position: offset,
      children: children,
      verticalPadding: verticalPadding,
      width: width,
      borderRadius: borderRadius,
      elevation: elevation,
      color: color,
    ),
  );
}

/// The [ContextMenuArea] is the way to use a [ContextMenu]
///
/// It listens for right click and long press and executes [showContextMenu]
/// with the corresponding location [Offset].

class ContextMenuArea extends StatelessWidget {
  /// The widget displayed inside the [ContextMenuArea]
  final Widget child;

  /// A [List] of items to be displayed in an opened [ContextMenu]
  ///
  /// Usually, a [ListTile] might be the way to go.
  final List<Widget> items;

  /// The padding value at the top an bottom between the edge of the [ContextMenu] and the first / last item
  final double verticalPadding;

  /// The width for the [ContextMenu]. 320 by default according to Material Design specs.
  final double width;

  /// The radii for each corner.
  final BorderRadius borderRadius;

  final double? elevation;

  final Color? color;

  const ContextMenuArea({
    Key? key,
    required this.child,
    required this.items,
    this.verticalPadding = 8,
    this.width = 320,
    this.borderRadius = BorderRadius.zero,
    this.elevation = 0,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapDown: (details) => showContextMenu(
        offset: details.globalPosition,
        context: context,
        children: items,
        verticalPadding: verticalPadding,
        width: width,
        borderRadius: borderRadius,
        elevation: elevation,
        color: color,
      ),
      onLongPressStart: (details) => showContextMenu(
        offset: details.globalPosition,
        context: context,
        children: items,
        verticalPadding: verticalPadding,
        width: width,
        borderRadius: borderRadius,
        elevation: elevation,
        color: color,
      ),
      child: child,
    );
  }
}
