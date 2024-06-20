import 'package:flutter/material.dart';
import 'Page/user_selection_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PetCare Hub',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserSelectionPage());
  }
}
