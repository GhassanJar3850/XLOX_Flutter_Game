import 'package:flutter/material.dart';
import 'package:xlox/Screens/GUI.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLOX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        cardColor: Colors.transparent,
        hoverColor: Colors.grey.withOpacity(0.4),
        highlightColor: Colors.transparent,
        useMaterial3: true,
      ),
      initialRoute: XLOXGame.id,
      routes: {XLOXGame.id: (route) => XLOXGame()},
    );
  }
}
