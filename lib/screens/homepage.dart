import 'package:flutter/material.dart';
import 'package:quatos_app/model/quotes.dart';
import 'package:quatos_app/utils/global.dart';
import 'package:quatos_app/utils/quates_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Global.quotes = allQuotes.map((e) => Quotes.fromMap(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quotas",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: Global.quotes
                .map(
                  (e) => Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    height: 155,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white60,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.quote,
                          style: style(18, Colors.black87),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "- ${e.author}",
                              style: style(20, Colors.black, FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

TextStyle style(double size, Color color,
    [FontWeight weight = FontWeight.normal]) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: weight,
    fontStyle: FontStyle.italic,
  );
}
