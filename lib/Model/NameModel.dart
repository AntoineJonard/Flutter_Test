import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class NameModel extends ChangeNotifier {
  final _saved = Set<WordPair>();
  Set<WordPair> get saved => _saved;

  void addName(WordPair wp){
    _saved.add(wp);
    notifyListeners();
  }

  void removeName(WordPair wp){
    _saved.remove(wp);
    notifyListeners();
  }

  bool contains(WordPair wp){
    return _saved.contains(wp);
  }
}