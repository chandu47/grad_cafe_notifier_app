import 'package:flutter/material.dart';
import 'package:grad_cafe_notifier_app/screens/feedScreen.dart';
import 'package:grad_cafe_notifier_app/screens/settingScreen.dart';
import 'package:grad_cafe_notifier_app/widgets/settingsCard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GradCafe Notifier',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    FeedScreen(),
    SettingScreen()
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled) , label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
}
