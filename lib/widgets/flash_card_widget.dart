import '../utilities/page_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flash_cards_new/models/flash_card_model.dart';
import 'package:provider/provider.dart';
import 'package:flash_cards_new/providers/card_provider.dart';
import 'dart:math';


class FlipCardController {
  _FlashCardWidgetState? _state;

  Future flipCard() async => _state?.flipCard();
}

class FlashCardWidget extends StatefulWidget {

  FlashCardWidget({required this.flashModel, required this.isTop});

  final FlashModel flashModel;
  final bool isTop;


  @override
  State<FlashCardWidget> createState() => _FlashCardWidgetState();
}

class _FlashCardWidgetState extends State<FlashCardWidget> with SingleTickerProviderStateMixin {
  final FlipCardController controller = FlipCardController();
  late AnimationController animationController;
  bool isFront = true;

  String cardContents(int side){
    if(side == 0) {
      return widget.flashModel.front;
    } else {
      return widget.flashModel.back;
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final size = MediaQuery.of(context).size;

      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });

    controller._state = this;
    
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.isTop) {
      return buildFrontCard();
    } else {
      return buildNormalCard(0, false);
    }
  }

  Future flipCard() async {
    if(animationController.isAnimating) return;
    isFront = !isFront;

    if(isFront){
      await animationController.reverse();
    } else {
      await animationController.forward();
    }
  }

  bool isFrontFace(double angle) {
    final degrees90 = pi/2;
    final degrees270 = 3 * pi / 2;

    return angle <= degrees90 || angle >=  degrees270;
  }

  Widget buildFrontCard(){
    return Container(
      child: GestureDetector(
        onPanStart: (details) {
          final provider =
          Provider.of<CardProvider>(context, listen: false);

          provider.startPosition(details);
        },
        onPanUpdate: (details) {
          final provider =
          Provider.of<CardProvider>(context, listen: false);

          provider.updatePosition(details);
        },
        onPanEnd: (details) {
          final provider =
          Provider.of<CardProvider>(context, listen: false);

          provider.endPosition();
        },
        onDoubleTap: () async {
          await controller.flipCard();
        },

        child: LayoutBuilder(
          builder: (context, constraints) => AnimatedBuilder(
            animation: animationController,
            builder: (context, child){
            final angleForFlip = animationController.value * -pi;
            final transform = Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(angleForFlip);

            final provider =
            Provider.of<CardProvider>(context, listen: true);
            final position = provider.position;
            final milliseconds = provider.isDragging ? 0 : 400;

            final center = constraints.smallest.center(Offset.zero);
            final angle = provider.angle * pi / 180;
            final rotatedMatrix = Matrix4.identity()
              ..translate(center.dx, center.dy)
              ..rotateZ(angle)
              ..translate(-center.dx, -center.dy);

            return Transform(
              transform: transform,
              alignment: Alignment.center,
              child:  isFrontFace(angleForFlip.abs())
                  ? AnimatedContainer(
                child: buildNormalCard(0, true),
                duration: Duration(milliseconds: milliseconds),
                curve: Curves.easeInOut,
                transform: rotatedMatrix
                  ..translate(position.dx, position.dy),
              )
                  : Transform(
              transform: Matrix4.identity()..rotateY(pi),
              alignment: Alignment.center,
              child: AnimatedContainer(
                  child: buildNormalCard(1, true),
                  duration: Duration(milliseconds: milliseconds),
                  curve: Curves.easeInOut,
                  transform: rotatedMatrix
                    ..translate(position.dx, position.dy),
                ),
              ),
            );
          },
          ),
        ),
      ),
    );
  }

  Widget buildNormalCard(int cardSide, bool hasContent){
    return CustomPaint(
      painter: PagePainter(),
      child: Container(
        width: 300,
        //TODO: MAKE THE HEIGHT DYNAMIC
        height: 500,
        child: Row(
          children: [
            SizedBox(width: 40),
            Container(
              width: 250,
              child: Center(
                child: Text(
                  hasContent? cardContents(cardSide) : ' ',
                  style: GoogleFonts.indieFlower(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

