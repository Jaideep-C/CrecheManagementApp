import 'package:five/modules/user.dart';
import 'package:five/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/authenticate.dart';

class Decide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Authenticate());
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home());
    }
    
  }
}