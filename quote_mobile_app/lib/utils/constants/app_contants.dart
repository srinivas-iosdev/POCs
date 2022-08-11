import 'package:flutter/material.dart';

enum Screens { author_tab, search_tab, favourites_tab }

class EdgeInsetConstants {
  static EdgeInsets kAll10 = const EdgeInsets.all(10.0);
  static EdgeInsets kAll15 = const EdgeInsets.all(15.0);
  static EdgeInsets kL15T15R15B5 = const EdgeInsets.fromLTRB(15, 15, 15, 5);
}

class DividerConstants {
  static Divider kH2 = const Divider(height: 2, color: Colors.grey);
}
