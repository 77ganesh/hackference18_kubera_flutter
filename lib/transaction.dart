import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Transaction {
  String CustomerId;
  String Category;
  DateTime TimeStamp;
  double Amount;

  Transaction({this.CustomerId, this.Category, this.TimeStamp, this.Amount});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      CustomerId: json["CustomerId"],
        Category: json["Category"],
      Amount: double.parse(json["Amount"]),
      TimeStamp: DateTime.parse("2012-04-23T18:25:43.511Z")
//      TimeStamp: DateTime.parse(json["TimeStamp"]),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final Transaction t;

  const TransactionItem({Key key, this.t}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(t.TimeStamp.day.toString()),
        Text(t.Category),
        Text(t.Amount.toString())
      ],
    );
  }
}

Future<Transaction> fetchP() async {
  final r = await http.get("http://10.0.2.2:3000/test");

  if (r.statusCode == 200) {
    return Transaction.fromJson(json.decode(r.body));
  } else {
    throw Exception('Failed to load transaction');
  }
}

var p = FutureBuilder<Transaction>(
  future: fetchP(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return TransactionItem(t: snapshot.data);
      } else if (snapshot.hasError) {
        return Text(snapshot.error.toString());
      }

      return CircularProgressIndicator();
    }
);

var q = Row(
mainAxisSize: MainAxisSize.max,
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: <Widget>[
Text("Day"),
Text("Category"),
Text("Amount")
],
);