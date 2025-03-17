import 'package:flutter/material.dart';

class Practice1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Práctica 1 - Hola Mundo'),
      ),
      body: Center(
        child: Text('Hola Mundo!', style: TextStyle(fontSize: 24)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
