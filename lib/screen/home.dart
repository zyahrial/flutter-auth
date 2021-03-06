import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:blantik/screen/login.dart';
import 'package:blantik/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blantik/widgets/nav-drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  String name;
  String mytoken;

  @override
  void initState(){
    _loadUserData();
    super.initState();
  }

  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    var token = jsonDecode(localStorage.getString('token'));
    if(user != null) {
      setState(() {
        name = user['name'];
      });
    }
    if(token != null) {
      setState(() {
        mytoken = token['token'];
      });
    }else{
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Widget child;
    // if (isAuth) {
    //   child = Home();
    // } else {
    //   child = Login();
    // }
    // return Scaffold(
    //   body: child,
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text('Test App'),
        backgroundColor: Colors.teal,
      ),
      drawer: NavDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Hi, $name',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
            Center(
              // child: RaisedButton(
              //   elevation: 10,
              //   onPressed: (){
              //     logout();
              //   },
              //   color: Colors.teal,
              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              //   child: Text('Logout'),
              // ),
            ),
          ],
        ),
      ),
    );
  }

  // void logout() async{
  //   var res = await Network().getData('/auth/logout');
  //   var body = json.decode(res.body);
  //   if(body['success']){
  //     SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     localStorage.remove('user');
  //     localStorage.remove('token');
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context)=>Login()));
  //   }
  // }
}