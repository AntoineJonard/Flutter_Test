import 'package:flutter/material.dart';
import 'package:flutter_hello_world/FindPosition.dart';
import 'package:flutter_hello_world/Map.dart';
import 'package:provider/provider.dart';
import 'Model/MarkModel.dart';
import 'Model/NameModel.dart';
import 'RandomWords.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State{
  int _selectedIndex = 0;

  void setIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _pagesRoutes = <Widget>[
    RandomWords(),
    Map(),
    FindPosition()
  ];
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NameModel()),
        ChangeNotifierProvider(create: (context) => MarkerModel())
      ],
      child: MaterialApp(
        title: 'Funny Marker',
        home: Scaffold(
          body: Center(
              child: _pagesRoutes.elementAt(_selectedIndex)
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Names'),
              BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
              BottomNavigationBarItem(icon: Icon(Icons.find_in_page),label: 'Find')
            ],
            currentIndex: _selectedIndex,
            onTap: setIndex,
            selectedItemColor: Colors.deepPurple,
          ),
        ),
        theme: ThemeData(primaryColor: Colors.deepPurple)
      ),
    );
  }
}