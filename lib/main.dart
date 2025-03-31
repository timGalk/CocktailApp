import 'package:cocktail_app/screens/DrinkScreen.dart';
import 'package:cocktail_app/screens/cocktails_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DrinkApp());
}

class DrinkApp extends StatelessWidget {
  const DrinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drink List',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.orange[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange,
          elevation: 2,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      // home: DrinkListScreen(),
      home:CocktailsPage(), // Change this to your desired screen
    );
  }
}


