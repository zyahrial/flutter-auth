import 'package:flutter/material.dart';
import 'package:blantik/screen/login.dart';
import 'package:blantik/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blantik/network_utils/api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      debugShowCheckedModeBanner: false,
      home: CheckAuth(),
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  @override
  void initState() {
    _checkIfHaveToken();
    // _checkIfLoggedIn();
    super.initState();
  }

  // void _checkIfLoggedIn() async{
  //   var res = await Network().getData('/auth/check');
  //   var body = json.decode(res.body);
  //   if(body['success']){
  //     setState(() {
  //       isAuth = true;
  //     });
  //   }
  // }

  void _checkIfHaveToken() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token != null){
      setState(() {
        isAuth = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = Home();
    } else {
      child = Login();
    }
    return Scaffold(
      body: child,
    );
  }
}
