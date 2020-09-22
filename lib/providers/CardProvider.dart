import 'dart:collection';

import 'package:expenses/models/CardModel.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CardProvider with ChangeNotifier {
  List<CardModel> cards = [];

  UnmodifiableListView<CardModel> get allCards => UnmodifiableListView(cards);

  void initialState() {
    syncDataWithProvider();
  }

  void addcard(CardModel _card) {
    cards.add(_card);
    updateSharedPreferences();
    notifyListeners();
  }

  void removeCard(CardModel _card) {
    cards.removeWhere((card) => card.number == _card.number);
    updateSharedPreferences();
    notifyListeners();
  }

  int getCardLength() {
    return cards.length;
  }

  Future updateSharedPreferences() async {
    List<String> myCards = cards.map((e) => json.encode(e.toJson())).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cards', myCards);
  }

  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('cards');

    if (result != null) {
      cards = result.map((e) => CardModel.fromJson(json.decode(e))).toList();
    }
    notifyListeners();
  }
}
