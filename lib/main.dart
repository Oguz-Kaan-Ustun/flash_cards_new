
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_cards_new/data/database.dart';
import 'package:flash_cards_new/models/flash_card_model.dart';
import 'package:flash_cards_new/screens/Wrapper.dart';
import 'package:flash_cards_new/screens/folder_main_screen_shop.dart';
import 'package:flash_cards_new/screens/folder_main_screen_downloaded.dart';
import 'package:flash_cards_new/screens/home_screen.dart';
import 'package:flash_cards_new/screens/open_ended_quiz_screen.dart';
import 'package:flash_cards_new/providers/card_provider.dart';
import 'package:flash_cards_new/services/auth_service.dart';
import 'package:flash_cards_new/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_cards_new/screens/flash_card_learning_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  Hive.registerAdapter(FlashModelAdapter());

  prefs = await SharedPreferences.getInstance();

  runApp(const FlashCards());
}

class FlashCards extends StatefulWidget {
  const FlashCards({super.key});

  @override
  State<FlashCards> createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> {

  @override
  void initState() {
    super.initState();
    print('main init is called');
    String flashCardBoxName =
        prefs!.getString(AppConstants.kBoxPreferenceKey) ?? 'default';
    Hive.isBoxOpen(flashCardBoxName) 
        ? null 
        : Hive.openBox(flashCardBoxName).whenComplete((){
          print(Hive.box(flashCardBoxName).name);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('main is called');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CardProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CardsDataBase(),
        ),
      ],
      child: StreamProvider<User?>.value(
        initialData: null,
        value: AuthService().authStateChanges,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            HomeScreen.id: (context) => HomeScreen(),
            FlashCardLearningScreen.id: (context) => FlashCardLearningScreen(),
            FolderMainScreenShop.id: (context) => FolderMainScreenShop(),
            OpenEndedQuizScreen.id: (context) => OpenEndedQuizScreen(),
            FolderMainScreenDownloaded.id: (context) =>
                FolderMainScreenDownloaded(),
          },
          home: Wrapper(),
        ),
      ),
    );
  }
}
