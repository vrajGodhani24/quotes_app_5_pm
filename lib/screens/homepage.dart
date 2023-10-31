import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quatos_app/model/quotes.dart';
import 'package:quatos_app/utils/global.dart';
import 'package:quatos_app/utils/quates_data.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Random random = Random();

  bool isList = false;

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
      return isBack;
    }

    return WillPopScope(
      onWillPop: shouldExit,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.change_circle),
            onPressed: () {
              setState(() {
                isList = !isList;
              });
            },
          ),
          title: const Text("Quotas"),
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
          child: (isList)
              ? ListView.builder(
                  itemCount: Global.quotes.length,
                  itemBuilder: (context, i) => Slidable(
                    dragStartBehavior: DragStartBehavior.start,
                    endActionPane: ActionPane(
                      motion: BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (val) {},
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                        SlidableAction(
                          onPressed: (val) {},
                          backgroundColor: Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.share,
                          label: 'Share',
                        ),
                      ],
                    ),
                    startActionPane: ActionPane(
                      motion: BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (val) {},
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                        SlidableAction(
                          onPressed: (val) {},
                          backgroundColor: Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.share,
                          label: 'Share',
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      color: Colors.black,
                      child: Container(
                        height: 70,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(8),
                        child: Text(
                          Global.quotes[i].quote,
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                )
              : Scrollbar(
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                    ),
                    children: Global.quotes
                        .map(
                          (e) => InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('detail', arguments: e);
                            },
                            child: Card(
                              elevation: 5,
                              shadowColor: Colors.grey,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.black,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      e.quote,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white70),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '- ${e.author}',
                                          style: GoogleFonts.getFont(
                                            'Pacifico',
                                            color: Colors.white70,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          // style: GoogleFonts.pacifico(
                                          //   color: Colors.white70,
                                          //   fontSize: 18,
                                          //   fontWeight: FontWeight.bold,
                                          // ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
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
