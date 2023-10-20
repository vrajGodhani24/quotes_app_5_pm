import 'package:flutter/material.dart';
import 'package:quatos_app/screens/homepage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.dark,
      routes: {
        '/': (context) => const HomePage(),
      },
    ),
  );
}
