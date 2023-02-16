import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expandable Text'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ExpandableText(
              'dasdas https://pub.dev lolkek @das #ddd time 00:00:01 01:50:12 23:29',
              expandText: 'show more',
              maxLines: 4,
              linkColor: Colors.blue,
              style: TextStyle(color: Colors.black),
              prefixStyle: TextStyle(color: Colors.red),
              hashtagStyle: TextStyle(color: Colors.red),
              urlStyle: TextStyle(color: Colors.red),
              mentionStyle: TextStyle(color: Colors.red),
              timeCodeStyle: TextStyle(color: Colors.green),
              collapseText: 'show less',
              onMentionTap: (v) {},
              onPrefixTap: () {},
              onUrlTap: (v) {},
              onTimeCodeTap: (v) {
                print(v);
              },
            ),
          ],
        ),
      ),
    );
  }
}
