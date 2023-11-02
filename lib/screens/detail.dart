import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quatos_app/model/quotes.dart';
import 'package:share_extend/share_extend.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Color chooseColor = Colors.black;
  Color chooseBackGroundColor = Colors.white;
  String? chooseFontFamily;
  String chooseImage = '';

  List<String> family = ['style1', 'style2', 'style3'];

  List<String> bgImage = [
    'https://images.unsplash.com/32/Mc8kW4x9Q3aRR3RkP5Im_IMG_4417.jpg?auto=format&fit=crop&q=80&w=2070&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1533628635777-112b2239b1c7?auto=format&fit=crop&q=80&w=2070&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1486848538113-ce1a4923fbc5?auto=format&fit=crop&q=80&w=1949&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1513542789411-b6a5d4f31634?auto=format&fit=crop&q=80&w=1974&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ];

  GlobalKey repaintBoundry = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Quotes args = ModalRoute.of(context)!.settings.arguments as Quotes;

    void contentCopy() async {
      await Clipboard.setData(
          ClipboardData(text: '${args.quote}\n \t - ${args.author}'));
    }

    void shareImage() async {
      RenderRepaintBoundary renderRepaintBoundary =
          repaintBoundry.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      var image = await renderRepaintBoundary.toImage(pixelRatio: 5);

      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

      Uint8List fetchImage = byteData!.buffer.asUint8List();

      Directory directory = await getApplicationCacheDirectory();

      String path = directory.path;

      File file = File('$path.png');

      file.writeAsBytes(fetchImage);

      ShareExtend.share(file.path, "Image");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Design your Quote"),
        actions: [
          IconButton(
            onPressed: () {
              contentCopy();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Quote copied"),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.copy),
          ),
          IconButton(
            onPressed: () {
              shareImage();
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                chooseColor = Colors.black;
                chooseBackGroundColor = Colors.white;
                chooseFontFamily = 'style1';
                chooseImage = '';
              });
            },
            icon: const Icon(Icons.restart_alt),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            RepaintBoundary(
              key: repaintBoundry,
              child: Card(
                elevation: 8,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  width: double.infinity,
                  height: 400,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: chooseBackGroundColor,
                    image: DecorationImage(
                      image: NetworkImage(chooseImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Text(
                    args.quote,
                    style: TextStyle(
                      fontSize: 24,
                      color: chooseColor,
                      fontFamily: chooseFontFamily,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Change Font Color",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 12),
            Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: Colors.primaries.map(
                    (e) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            chooseColor = e;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: e,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Change Background Color",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 12),
            Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: Colors.accents.map(
                    (e) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            chooseBackGroundColor = e;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: e,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Change Font Family",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 12),
            Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: family.map(
                    (e) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            chooseFontFamily = e;
                          });
                        },
                        child: Card(
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            height: 80,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Aa",
                              style: TextStyle(fontFamily: e, fontSize: 26),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Change Background Image",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 12),
            Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: bgImage.map(
                    (e) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            chooseImage = e;
                          });
                        },
                        child: Card(
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(e),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
