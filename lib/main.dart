// This example shows a [Scaffold] with an [AppBar], a [BottomAppBar] and a
// [FloatingActionButton]. The [body] is a [Text] placed in a [Center] in order
// to center the text within the [Scaffold] and the [FloatingActionButton] is
// centered and docked within the [BottomAppBar] using
// [FloatingActionButtonLocation.centerDocked]. The [FloatingActionButton] is
// connected to a callback that increments a counter.

import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'transaction.dart';


void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for material.Scaffold',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }

  void login() {

  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int amount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainBody,
    );
  }
}

var balanceRow = Row(
  children: <Widget>[
    Text('Balance: ',
      style: TextStyle(fontWeight: FontWeight.normal),
    ),
    Text('Rs. 25,000',
      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),)
  ],
);

var mainBody = Container(
  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
  child: x,
);

var verticalPadding = Padding(
  padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
  child: null,
);

Row getInsightRow(String key, String value) {
  key = key;
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(key, style: TextStyle(fontWeight: FontWeight.bold)),
      Text(value)
    ],
  );
}

Padding getVerticalPadding( {multiplier=1.0} ) {
  return Padding(
    padding: EdgeInsets.only(top: 16.0*multiplier),
  );
}

var x = ListView(
  children: <Widget>[
    verticalPadding,
    balanceRow,
    getVerticalPadding(multiplier: 1.5),
    Text('Insights', style: TextStyle(
      color: Colors.deepPurpleAccent,
      fontWeight: FontWeight.bold
    ),),
    verticalPadding,
    getInsightRow("Food", "2032.1"),
    getInsightRow("Travel", "40000"),
    getInsightRow("Entertainment", "232"),
    getInsightRow("PUBG", "932"),
    verticalPadding,
    Text('Transactions', style: TextStyle(
        color: Colors.brown,
        fontWeight: FontWeight.bold
    ),),

    verticalPadding,
    q,
    Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide())
      ),
    ),
    p
  ],
);

// -- End homescreen

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final _widgetOptions = [
    HomeScreen(),
    Image(
      image: NetworkImage("https://plot.ly/~sravanbrahma/0.png"),
    ),
    WebviewScaffold(
      url: "http://40.67.145.100:3333",
    ),
    Center(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        color: const Color(0xFF00FF00),
        width: 48.0,
        height: 48.0,
        child: Text('Hello World'),
        foregroundDecoration: BoxDecoration(
          border: Border.all(width: 2.0)
        ),
      ),
    ),
    Text('Hello'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kubera'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Charts')),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), title: Text('Chatbot')),
          BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('Settings'))
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

// Login Implementation
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Kubera Login'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                    decoration: new InputDecoration(
                        labelText: 'User ID'
                    )
                ),
                new TextFormField(
                    obscureText: true, // Use secure text for passwords.
                    decoration: new InputDecoration(
                        labelText: 'Enter your password'
                    )
                ),
                new Container(
                  width: screenSize.width,
                  child: new RaisedButton(
                    child: new Text(
                      'Login',
                      style: new TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage())
                      );
                    },
                    color: Colors.blue,
                  ),
                  margin: new EdgeInsets.only(
                      top: 20.0
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}

// End Login

// Post related shit
Future<http.Response> fetchPost() {
  return http.get('https://jsonplaceholder.typicode.com/posts/1');
}

class Post {
  final int userId;
  final String title;

  Post({this.userId, this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      title: json['title'],
    );
  }
}


