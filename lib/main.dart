import 'package:flutter/material.dart';

import 'screens/Home.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.deepOrange,
        accentColor: Colors.deepOrange,
        textTheme: TextTheme(
          body1: Theme.of(context).textTheme.body1.apply(color: Colors.black),
        ),
      ),
      home: App(),
    );
  }
}
