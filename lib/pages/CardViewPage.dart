import 'package:expenses/components/CardView.dart';
import 'package:expenses/models/CardModel.dart';
import 'package:expenses/providers/CardProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardViewPage extends StatefulWidget {
  final CardModel card;
  const CardViewPage({Key key, this.card}) : super(key: key);

  @override
  _CardViewPageState createState() => _CardViewPageState();
}

class _CardViewPageState extends State<CardViewPage> {
  void onRemove(card) {
    Provider.of<CardProvider>(context).removeCard(card);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 241, 242, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(238, 241, 242, 1),
        title: Text(
          "Card View",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.black45,
            ),
            onPressed: () {
              onRemove(widget.card);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Transform.translate(
            offset: Offset.fromDirection(0, 15),
            child: Container(
              height: 210,
              child: CardView(widget.card),
            ),
          ),
        ),
      ),
    );
  }
}
