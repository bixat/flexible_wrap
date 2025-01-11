import 'package:flexible_wrap/flexible_wrap.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flexible Wrap Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flexible Wrap Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double spacing = 12.0;
  int itemCount = 20;
  double itemHeight = 100;
  double itemWidth = 300;
  double wrapWidth = 700;
  bool isRTL = true;
  bool isOneRowExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        spacing: 20.0,
        children: [
          ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('RTL:'),
                            Switch(
                              value: isRTL,
                              onChanged: (value) {
                                setState(() {
                                  isRTL = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('One Row Expanded:'),
                            Switch(
                              value: isOneRowExpanded,
                              onChanged: (value) {
                                setState(() {
                                  isOneRowExpanded = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Spacing:'),
                            Expanded(
                              child: Slider(
                                value: spacing,
                                min: 0,
                                max: 50,
                                divisions: 50,
                                label: spacing.round().toString(),
                                onChanged: (value) {
                                  setState(() {
                                    spacing = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Item Count:'),
                            Expanded(
                              child: Slider(
                                value: itemCount.toDouble(),
                                min: 1,
                                max: 50,
                                divisions: 49,
                                label: itemCount.toString(),
                                onChanged: (value) {
                                  setState(() {
                                    itemCount = value.toInt();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Item Height:'),
                            Expanded(
                              child: Slider(
                                value: itemHeight,
                                min: 50,
                                max: 200,
                                divisions: 150,
                                label: itemHeight.round().toString(),
                                onChanged: (value) {
                                  setState(() {
                                    itemHeight = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Item Width:'),
                            Expanded(
                              child: Slider(
                                value: itemWidth,
                                min: 50,
                                max: 400,
                                divisions: 350,
                                label: itemWidth.round().toString(),
                                onChanged: (value) {
                                  setState(() {
                                    itemWidth = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Wrap Width:'),
                            Expanded(
                              child: Slider(
                                value: wrapWidth,
                                min: 100,
                                max: MediaQuery.of(context).size.width,
                                divisions: 100,
                                label: wrapWidth.round().toString(),
                                onChanged: (value) {
                                  setState(() {
                                    wrapWidth = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: wrapWidth,
                  child: FlexibleWrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    isOneRowExpanded: isOneRowExpanded,
                    textDirection:
                        isRTL ? TextDirection.rtl : TextDirection.ltr,
                    children: List.generate(itemCount, (int index) {
                      return SizedBox(
                        height: itemHeight,
                        width: itemWidth,
                        child: ListTile(
                          tileColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          title: const Text(
                            "Lorem Ipsum is simply dummy text",
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: const Text(
                            "Lorem Ipsum has been the industry's standard",
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: Icon(
                            Icons.insert_emoticon,
                            color: Colors.white,
                            size: itemWidth / 5,
                          ),
                          trailing: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
