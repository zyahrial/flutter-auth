import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:blantik/screen/login.dart';
import 'package:blantik/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawer createState() => _NavDrawer();
}

class _NavDrawer extends State<NavDrawer>  {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('lib/assets/image/cover.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              logout();
            },
          ),
        ],
      ),
    );
  }
  void logout() async{
    var res = await Network().getData('/auth/logout');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>Login()));
      localStorage.remove('user');
      localStorage.remove('token');
    }
  }
}