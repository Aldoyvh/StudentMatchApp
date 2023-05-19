import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prueba/HomeScreen.dart';
import 'package:prueba/camera.dart';
import 'package:prueba/login.dart';
import 'package:prueba/shop.dart';
import 'package:prueba/signup.dart';

class Menu extends StatefulWidget {
   Menu({Key key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          ListTile(
            title: Text('Perfil'),
            leading: Icon(Icons.perm_identity),
            onTap: (){
              //Navigator.of(context).pop();
              //Navigator.pushNamed(context, '/home');
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context){
                    return Camera('');}));
            },
          ),
          ListTile(
            title: Text('Ver Personas'),
            leading: Icon(Icons.people),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context){
                    return HomeScreen();}));
            },
          ),
          ListTile(
            title: Text('Tienda'),
            leading: Icon(Icons.shopping_cart_outlined),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context){
                    return Shop();}));
            },
          ),
        ],
      ),
    );
  }
}

