import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'Model/NameModel.dart';
import 'package:provider/provider.dart';


class SavedNames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _biggerFont = TextStyle(fontSize: 18.0);

    final tiles = context.watch<NameModel>().saved.map(
          (WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );
    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Suggestions'),
      ),
      body: ListView(children: divided),
    );
  }
}