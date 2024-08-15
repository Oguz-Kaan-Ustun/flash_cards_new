import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_cards_new/data/database.dart';
import 'package:flash_cards_new/data/firestore_database.dart';
import 'package:flash_cards_new/models/flash_card_model.dart';
import 'package:flash_cards_new/screens/Wrapper.dart';
import 'package:flash_cards_new/screens/folder_main_screen.dart';
import 'package:flash_cards_new/screens/home_screen.dart';
import 'package:flash_cards_new/screens/open_ended_quiz_screen.dart';
import 'package:flash_cards_new/screens/profile_screen.dart';
import 'package:flash_cards_new/providers/card_provider.dart';
import 'package:flash_cards_new/services/auth_service.dart';
import 'package:flash_cards_new/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_cards_new/screens/flash_card_learning_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  Hive.registerAdapter(FlashModelAdapter());

  var box = await Hive.openBox(AppConstants.flashCardBoxName);

  runApp(FlashCards());
}

class FlashCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            ProfileScreen.id: (context) => ProfileScreen(),
            FlashCardLearningScreen.id: (context) => FlashCardLearningScreen(),
            FolderMainScreen.id: (context) => FolderMainScreen(),
            OpenEndedQuizScreen.id: (context) => OpenEndedQuizScreen(),
          },
          home: Wrapper(),
        ),
      ),
    );
  }
}