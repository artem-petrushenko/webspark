import 'package:flutter/material.dart';

enum ResultPointType {
  start(Color(0xFF64FFDA)),
  end(Color(0xFF009688)),
  path(Color(0xFF4CAF50)),
  empty(Color(0xFFFFFFFF)),
  block(Color(0xFF000000));

  const ResultPointType(this.color);

  final Color color;
}
