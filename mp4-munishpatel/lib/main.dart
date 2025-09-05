import 'package:cs442_mp4/providers/deckprovider.dart';
import 'package:cs442_mp4/utils/converter.dart';
import 'package:cs442_mp4/views/decklist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/flashcardsprovider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await insertJsonDataToDB();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DeckProvider()), 
        ChangeNotifierProvider(create: (context) => FlashcardProvider()), 
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DeckList(),
      ),
    ),
  );
}

