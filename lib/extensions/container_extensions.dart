import 'package:flutter/material.dart';

extension ExpandedExtension on Widget {
  Expanded expanded({int flex = 1}) => Expanded(flex: flex, child: this);
}

extension ClipRRectExtension on Widget {
  ClipRRect clipRect(BorderRadius borderRadius) =>
      ClipRRect(borderRadius: borderRadius, child: this);
}

extension FlexibleExtension on Widget {
  Flexible flexible({int flex = 1}) => Flexible(flex: flex, child: this);
}
