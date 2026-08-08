import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

// here home is property of material app Home() specify which screen to show first
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext contenxt) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Google Notes",
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 58, 54, 41),
      ),
      home: Home(),
    );
  }
}
