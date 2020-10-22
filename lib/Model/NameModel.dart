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

  void removeNameFromString(String wp){
    WordPair toRemove;
    for (WordPair wpIn in _saved){
      if (wpIn.asCamelCase.compareTo(wp) == 0) {
        toRemove = wpIn;
      }
    }
    if (toRemove != null) _saved.remove(toRemove);
    notifyListeners();
  }

  bool contains(WordPair wp){
    return _saved.contains(wp);
  }

  List<DropdownMenuItem<String>> getSavedNamesAsDropDownString(){
    List<DropdownMenuItem<String>> stringList = List<DropdownMenuItem<String>>();
    for (WordPair wp in _saved){
      stringList.add(DropdownMenuItem(
        child: Text(wp.asCamelCase),
        value: wp.asCamelCase,
      ));
    }
    return stringList;
  }
}