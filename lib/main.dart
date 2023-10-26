import 'package:flutter/material.dart';
import 'package:quatos_app/screens/homepage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'style1',
      ),
      routes: {
        '/': (context) => const HomePage(),
      },
    ),
  );
}
