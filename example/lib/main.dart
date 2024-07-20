import 'package:flexible_wrap/flexible_wrap.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flexible Wrap Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
  final padding = 8.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FlexibleWrap(
        length: 80, // Number of children to display
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        builder: (int index, double itemExtraWidth) {
          print(itemExtraWidth);
          return Padding(
            padding: EdgeInsets.all(padding),
            child: Container(
              height: 60,
              color: Colors.blue,
              width: 380.0 + itemExtraWidth,
              child: Center(child: Text('Item $index')),
            ),
          );
        },
        itemWidth: 380.0 + (padding * 2), // Width of each item + padding value, 2 => horizontal and vertical
        direction: Axis.horizontal, // Direction to arrange the children
        alignment: WrapAlignment.start, // Alignment of children within a run
      ),
    );
  }
}
