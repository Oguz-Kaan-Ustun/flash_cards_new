import 'package:flutter/material.dart';
import '../utilities/small_page_painter.dart';


class DynamicCardWidgetWithNoMenu extends StatelessWidget {
  DynamicCardWidgetWithNoMenu({required this.text, required this.width, required this.height, });//required this.isDoubled
  final Text text;
  final double height;
  final double width;
  //final bool isDoubled;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SmallPagePainter(),//isDoubled: isDoubled
      child: Padding(
        padding: const EdgeInsets.only(top: 3.0, bottom: 3, right: 3),
        child: Container(
          width: width,
          height: height,
          child: Center(
            child: text,
          ),
        )
      ),
    );
  }
}
