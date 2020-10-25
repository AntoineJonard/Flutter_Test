import 'package:flutter/material.dart';
import 'package:flutter_hello_world/Home.dart';
import 'package:flutter_hello_world/TestServer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu',
      theme: ThemeData(primaryColor: Colors.deepPurple),
      home: Menu()
    );
  }
}

class Menu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter Test',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple
              ),
            ),
            SizedBox(height: 30,),
            TextButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home())),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.black12
                ),
                padding: EdgeInsets.all(5),
                child: Text('Testing App', style: TextStyle(fontSize: 20, color: Colors.black)),
              )
            ),
            SizedBox(height: 30,),
            TextButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => TestServer())),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.black12
                  ),
                  padding: EdgeInsets.all(5),
                  child: Text('Test Server', style: TextStyle(fontSize: 20, color: Colors.black)),
                )
            ),
          ],
        ),
      ),
    );
  }

}

