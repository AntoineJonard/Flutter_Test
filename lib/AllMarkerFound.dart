import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllMarkerFound extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All markers found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Great Job !!!',
              style: TextStyle(
                fontSize: 35,
                fontStyle: FontStyle.italic,
                color: Color.fromRGBO(105, 105, 105, 1),
              ),
            ),
            SizedBox(height: 20),
            Icon(
              Icons.wine_bar,
              size: 80,
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: 35,
                  fontStyle: FontStyle.italic,
                  color: Color.fromRGBO(105, 60, 105, 1),
                ),
              ),
            )
          ]
        ),
      )
    );
  }
}
