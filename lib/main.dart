import 'package:flutter/material.dart';
import 'package:flutter_hello_world/Home.dart';
import 'file:///C:/Users/antoi/AndroidStudioProjects/flutter_hello_world/lib/Model/NameModel.dart';
import 'Model/MarkModel.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NameModel()),
        ChangeNotifierProvider(create: (context) => MarkerModel())
      ],
      child: MaterialApp(
          title: 'Funny Marker',
          home: Home(),
          theme: ThemeData(primaryColor: Colors.deepPurple)
      ),
    );
  }
}

