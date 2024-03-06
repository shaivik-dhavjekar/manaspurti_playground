import 'package:flutter/material.dart';

double getScaleValue(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;
  final size = MediaQuery.of(context).size;

  // final shortestSide = size.shortestSide;
  // double baseScale = shortestSide / 412;
  double baseScale = 1;

  const double mobileWidthBreakpoint = 450;
  const double tabletWidthBreakpoint = 850;
  const double height = 1000;


  if (size.width < mobileWidthBreakpoint) {
    baseScale *= 1; // Size for mobile devices
  } else if (size.width < tabletWidthBreakpoint) {
    if (size.height > height) {
      baseScale *= 1.2; // Size for tablets
    } else {
      baseScale *= 1.0; // Size for unfolded mobiles
    }
  } else {
    if (size.shortestSide > mobileWidthBreakpoint) {
      baseScale *= 1.2; // Size for tablets
    } else {
      baseScale *= 1.0; // Size for unfolded mobiles, landscape orientation mobiles
    }
  }

  return baseScale;
}