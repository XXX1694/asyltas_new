import 'package:flutter/cupertino.dart';

class HideScrollPanel extends ScrollBehavior {
  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
