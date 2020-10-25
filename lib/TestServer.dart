import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class  TestServer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestServerState();
  }

}

class _TestServerState extends State<TestServer> {
  TextEditingController _IdController;
  TextEditingController _PwdController;
  String _response;

  void initState() {
    super.initState();
    _IdController = TextEditingController();
    _PwdController = TextEditingController();
    _response = 'nothing send yet';
  }

  void dispose() {
    _IdController.dispose();
    _PwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Server'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Test server',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _IdController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'UserId',
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                controller: _PwdController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: awaitServerResponse,
              child: Text('Send to server'),
            ),
            SizedBox(height: 20,),
            Text(
              'Response',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple
              ),
            ),
            SizedBox(height: 10,),
            Text(
              '$_response',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> awaitServerResponse() async {
    setState(() {
      _response = 'waiting for a response ...';
    });
    final http.Response response = await http.post(
      'https://www.e-clubs.fr/clubsEcole/mobRoot',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': _IdController.value.text,
        'pwd': _PwdController.value.text
      }),
    );

    if (response.statusCode == 201) {
      setState(() {
        _response = response.body;
      });
    } else if (response.statusCode == 200) {
      setState(() {
        _response = 'Successfully connect but no ressource(s) in body';
      });      throw Exception('Successfully connect but no ressource(s) in body');
    } else {
      setState(() {
        _response = 'Failed to connect';
      });
      throw Exception('Failed to connect');
    }
  }
}