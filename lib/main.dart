import 'package:flutter/material.dart';
import 'screens/practice1.dart';
import 'screens/practice2.dart';
import 'screens/practice3.dart';
import 'screens/practice4.dart';
import 'screens/practice5.dart';
import 'screens/practice6.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prácticas Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú Principal'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Práctica 1 - Hola Mundo'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Practice1()),
              );
            },
          ),
          ListTile(
            title: Text('Práctica 2 - Contador de Clicks'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Practice2()),
              );
            },
          ),
          ListTile(
            title: Text('Práctica 3 - Contador con Temporizador'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Practice3()),
              );
            },
          ),
          ListTile(
            title: Text('Práctica 4 - Historial en Archivo de Texto'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Practice4()),
              );
            },
          ),
         
          ListTile(
            title: Text('Práctica 5 - Almacenamiento en SQLite'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Practice5()),
              );
            },
          ),

             ListTile(
            title: Text('Práctica 6 - Historial en SQLite'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Practice6()),
              );
            },
          ),
        ],
      ),
    );
  }
}
