import 'package:flutter/material.dart';

class Practice2 extends StatefulWidget {
  @override
  _Practice2State createState() => _Practice2State();
}

class _Practice2State extends State<Practice2> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Práctica 2 - Contador de Clicks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Has presionado el botón tantas veces:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar',
        child: Icon(Icons.add),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Regresar al Menú'),
        ),
      ],
    );
  }
}
