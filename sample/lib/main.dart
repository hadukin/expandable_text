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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ExpandableText(
                // 'dasdas https://pub.dev lolkek @das #ddd time 00:00:01 01:50:12 23:29 33:29 68:12',
                '''
      06:33
      7:44
      22:22:55
      08:11:32
      33:29
      45:29
      68:29
      58:59
      4:29
      89 :44
      89
      :44
      ---
      h:mm:ss
      0:00:00
      1:20:45
      0-00-00
      1.20.45
      1h20m45s
      0h00m00s
      ----
      hh:mm:ss
      00:00:00
      01:00:00
      01:20:45
      12:59:59
      23:59:59
      13:60:00
      24:00:00
      00-00-00
      01.20.45
      12#59#59
      23@59@59
      01-00-00
      00h00m00s
      01h20m45s
      12H59M59S
      23h59m59s
      01h00m00s
      HH:mm:ss
      Hh:Mm:Ss
      ----
      m:ss
      0:00
      1:05
      2:05
      -9:10
      9:-10
      1:60
      10:
      0-00
      1:05
      2-05
      0m00s
      1m05s
      2m05s
      ----
      mm:ss
      00:00
      01:05
      10:59
      59:59
      02:05
      01:60
      60:00
      00-00
      10#59
      59@59
      02-05
      00m00s
      01m05s
      10M59S
      59s59M
      02m05s
      MM:SS
      Mm:Ss
      bmss
      01Ms
      
      https://the-hole.tv/ 
      
      ftp://ftp.example.com/file.txt
      
      https://www.example.com/page.html#section-3
      
      user@example.com
      
      javascript:void(0)
      
      https://twitter.com/elonmusk

      https ://pub.dev

      https: //pub.dev

      https:// pub.dev
      
      https://pub.dev
      
      the-hole.com
      
      @das 
      
      #ddd
      ''',
                expandText: 'show more',
                maxLines: 1000,
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
                onUrlTap: (v) {
                  print(v);
                },
                onTimeCodeTap: (v) {
                  print(v);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
