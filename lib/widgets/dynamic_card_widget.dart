import 'package:flash_cards_new/widgets/folder_widget.dart';
import 'package:flash_cards_new/widgets/popup_items_edit_card.dart';
import 'package:flutter/material.dart';
import 'package:flash_cards_new/models/flash_card_model.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utilities/small_page_painter.dart';
import 'package:popover/popover.dart';

class DynamicCardWidget extends StatelessWidget {
  DynamicCardWidget({
    required this.flashModel,
    required this.folderLocation,
    this.listName,
    this.indexOfCard,
    this.docId,
    this.existingCards,
    this.ownerId,
  });

  final String? listName;
  final int? indexOfCard;
  final FlashModel flashModel;
  final String? docId;
  final List? existingCards;
  final FolderLocation folderLocation;
  final String? ownerId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          painter: SmallPagePainter(), //isDoubled: isDoubled
          child: Padding(
            padding: const EdgeInsets.only(top: 3.0, bottom: 3, right: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                folderLocation == FolderLocation.userFolders
                    ? Expanded(
                        flex: 4,
                        child: IconButton(
                          onPressed: () => showPopover(
                            context: context,
                            bodyBuilder: (context) => PopupItemsEditCard(
                              listName: listName!,
                              indexOfCard: indexOfCard!,
                              docId: docId!,
                              existingCards: existingCards!,
                              ownerId: ownerId!,
                            ),
                            height: 115,
                            width: 250,
                            direction: PopoverDirection.top,
                            backgroundColor: Color(0xFF81D4FA),
                            transitionDuration: Duration(milliseconds: 100),
                            arrowDxOffset: -165,
                          ),
                          icon: Icon(Icons.more_horiz),
                          iconSize: 30,
                          padding: EdgeInsets.zero,
                          alignment: Alignment.topCenter,
                        ),
                      )
                    : Expanded(child: SizedBox(height: 0), flex: 4),
                Expanded(
                  flex: 31,
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question: ${flashModel.front}',
                          softWrap: true,
                          style: GoogleFonts.indieFlower(
                            textStyle: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Text(
                          'Answer: ${flashModel.back}',
                          softWrap: true,
                          style: GoogleFonts.indieFlower(
                            textStyle: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Text(
                          'Learned status: ${flashModel.isKnown}',
                          softWrap: true,
                          style: GoogleFonts.indieFlower(
                            textStyle: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
