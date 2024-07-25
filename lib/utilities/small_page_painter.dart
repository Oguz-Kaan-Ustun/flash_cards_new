import 'package:flutter/material.dart';

class SmallPagePainter extends CustomPainter {
  //SmallPagePainter({required this.isDoubled});
  // final bool isDoubled;

  @override
  void paint(Canvas canvas, Size size) {

    // if(isDoubled){
    //   //Bottom Step 1
    //   final paintgrey2 = Paint()..color = Colors.grey;
    //   var rrectRed2 =
    //   RRect.fromLTRBR(-15, -10, size.width-15, size.height-10, Radius.circular(8.0));
    //   canvas.drawRRect(rrectRed2, paintgrey2);
    //
    //   //Bottom Step 2
    //   final paintWhite2 = Paint()..color = Color(0xFFFBF287);
    //   var rrectWhite2 =
    //   RRect.fromLTRBR(-10, -10, size.width-15, size.height-10, Radius.circular(8.0));
    //   canvas.drawRRect(rrectWhite2, paintWhite2);
    //
    //   //Bottom Step 3
    //   final int numOfLines2 = (size.height/30).round();
    //   final double linePlacementRatio2 = 1/numOfLines2;
    //   final paintDarkgrey2 = Paint()
    //     ..color = Colors.blueGrey
    //     ..strokeWidth = 1.0;
    //   for (var i = 1; i < numOfLines2; i++){
    //     canvas.drawLine(Offset(-10, size.height * linePlacementRatio2*i-10),
    //         Offset(size.width-10, size.height * linePlacementRatio2*i-10), paintDarkgrey2);
    //   }
    //
    //   //Bottom Step 4
    //   final paintPink2 = Paint()
    //     ..color = Colors.pinkAccent
    //     ..strokeWidth = 2.5;
    //   canvas.drawLine(Offset(size.width * .1 -15, -10),
    //       Offset(size.width * .1, size.height), paintPink2);
    // }

    //Step 1
    final paintgrey = Paint()..color = Colors.grey;
    var rrectRed =
    RRect.fromLTRBR(0, 0, size.width, size.height, Radius.circular(8.0));
    canvas.drawRRect(rrectRed, paintgrey);

    //Step 2
    final paintWhite = Paint()..color = Color(0xFFFBF287);
    var rrectWhite =
    RRect.fromLTRBR(5, 2, size.width, size.height, Radius.circular(8.0));
    canvas.drawRRect(rrectWhite, paintWhite);

    //Step 3
    final int numOfLines = (size.height/30).round();
    final double linePlacementRatio = 1/numOfLines;
    final paintDarkgrey = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 1.0;
    for (var i = 1; i < numOfLines; i++){
      canvas.drawLine(Offset(0, size.height * linePlacementRatio*i),
          Offset(size.width, size.height * linePlacementRatio*i), paintDarkgrey);
    }

    //Step 4
    final paintPink = Paint()
      ..color = Colors.pinkAccent
      ..strokeWidth = 2.5;
    canvas.drawLine(Offset(size.width * .1, 0),
        Offset(size.width * .1, size.height), paintPink);
  }

  @override
  bool shouldRepaint(SmallPagePainter oldDelegate) {
    return false;
  }

  @override
  bool shouldRebuildSemantics(SmallPagePainter oldDelegate) {
    return false;
  }
}