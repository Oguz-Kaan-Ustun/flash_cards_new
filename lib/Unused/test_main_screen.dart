import 'package:flash_cards_new/screens/multiple_choice_quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flash_cards_new/data/database.dart';

class TestMainScreen extends StatefulWidget {
  static const String id = 'test_main_screen';

  TestMainScreen({required this.folderName});
  String folderName;

  @override
  State<TestMainScreen> createState() => _TestMainScreenState();
}

class _TestMainScreenState extends State<TestMainScreen> {
  CardsDataBase dataBase = CardsDataBase();

  bool switchValue_01 = true;

  bool switchValue_02 = true;

  bool switchValue_03 = true;

  bool switchValue_04 = true;

  bool switchValue_05 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Test Main Screen of ${widget.folderName}',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Number of Questions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:
                          '/${dataBase.loadData(widget.folderName).length}',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onSubmitted: (value) {
                      if (int.parse(value) >
                          dataBase.loadData(widget.folderName).length) {
                        throw ('This folder doesn\'t have that many cards');
                      }
                    },
                  ),
                ),
              ],
            ),
            MyDivider(),
            BuildRow(label: 'Multiple Choice', switchNumber: switchValue_01),
            BuildRow(label: 'True/False', switchNumber: switchValue_02),
            BuildRow(label: 'Open-Ended', switchNumber: switchValue_03),
            MyDivider(),
            BuildRow(
                label: 'Ask Only Unknown Questions',
                switchNumber: switchValue_04),
            MyDivider(),
            BuildRow(
                label: 'Mark Wrong Answers \n        as Unknown',
                switchNumber: switchValue_05),
            //TODO: FİX THAT!^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen(folderName: widget.folderName)));
        },
        label: Text('Start Test'),
      ),
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1,
      color: Colors.black,
      height: 40,
      endIndent: 30,
      indent: 30,
    );
  }
}

class BuildRow extends StatefulWidget {
  BuildRow({required this.label, required this.switchNumber});

  String label;
  bool switchNumber;

  @override
  State<BuildRow> createState() => _BuildRowState();
}

class _BuildRowState extends State<BuildRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Switch(
          value: widget.switchNumber,
          onChanged: (bool value) {
            setState(() {
              widget.switchNumber = value;
            });
          },
        ),
      ],
    );
  }
}
