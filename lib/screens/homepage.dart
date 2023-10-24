import 'dart:math';

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
  Random random = Random();

  @override
  void initState() {
    super.initState();
    Global.quotes = allQuotes.map((e) => Quotes.fromMap(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> shouldExit() async {
      bool isBack = false;

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Exit an App"),
          content: const Text("Are you sure to want to Exit an App?"),
          actions: [
            OutlinedButton(
              onPressed: () {
                setState(() {
                  isBack = false;
                });
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isBack = true;
                });
                Navigator.of(context).pop();
              },
              child: const Text(
                "Exit",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );

      print(isBack);

      return isBack;
    }

    return WillPopScope(
      onWillPop: shouldExit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Quotas",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                int i = random.nextInt(Global.quotes.length);

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Quote"),
                    content: Text(Global.quotes[i].quote),
                    actions: [
                      Text(
                        "- ${Global.quotes[i].author}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.format_quote_sharp),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Delete Photos"),
                content: const Text("Are you sure to want to delete photos?"),
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          child: ListView.builder(
            itemCount: Global.quotes.length,
            itemBuilder: (context, i) => Container(
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
                    Global.quotes[i].quote,
                    style: style(18, Colors.black87),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "- ${Global.quotes[i].author}",
                        style: style(20, Colors.black, FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
