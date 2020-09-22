import 'package:expenses/components/CardList.dart';
import 'package:expenses/components/TransactionView.dart';
import 'package:expenses/models/TransactionModel.dart';
import 'package:expenses/pages/AddCardPage.dart';
import 'package:expenses/providers/CardProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<CardProvider>(
    create: (context) => CardProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Expenses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<CardProvider>(context).initialState();
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 241, 242, 1),
      appBar: AppBar(
        brightness: Brightness.light,
        centerTitle: true,
        backgroundColor: Color.fromRGBO(238, 241, 242, 1),
        title: Text(
          "Home page",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: null,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black45,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddCardPage()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (Provider.of<CardProvider>(context).getCardLength() > 0
                    ? Container(
                        height: 210,
                        child: Consumer<CardProvider>(
                          builder: (context, card, child) => CardList(
                            cards: card.allCards,
                          ),
                        )
                        // CardView(CardModel(
                        //     available: 1000,
                        //     name: "MasterCard",
                        //     currency: "IDR",
                        //     number: "1234 **** **** 4321"))
                        )
                    : Container(
                        height: 210,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Add your new card click the \n + \n button in the top right.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ))),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Last Transaction",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black45),
                ),
                SizedBox(
                  height: 15,
                ),
                TransactionView(
                  transaction: TransactionModel(
                      name: "Shopping",
                      type: "-",
                      price: 5000000,
                      currency: "IDR"),
                ),
                TransactionView(
                  transaction: TransactionModel(
                      name: "Salary",
                      type: "+",
                      price: 10000000,
                      currency: "IDR"),
                ),
                TransactionView(
                  transaction: TransactionModel(
                      name: "Freelance",
                      type: "+",
                      price: 3000000,
                      currency: "IDR"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
