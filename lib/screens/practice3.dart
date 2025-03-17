import 'dart:async';
import 'package:flutter/material.dart';

class Practice3 extends StatefulWidget {
  @override
  _Practice3State createState() => _Practice3State();
}

class _Practice3State extends State<Practice3> {
  int _counter = 0;
  bool _isButtonDisabled = false;
  Timer? _timer;
  int _timeLeft = 10;

  void _startTimer() {
    setState(() {
      _timeLeft = 10;  // Reiniciar el tiempo
      _isButtonDisabled = false;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _isButtonDisabled = true;
          timer.cancel();
          _showResultDialog();  // Mostrar el diálogo cuando el tiempo termina
        }
      });
    });
  }

  void _resetGame() {
    setState(() {
      _counter = 0;
      _timeLeft = 10;
      _isButtonDisabled = false;
      _startTimer();  // Reiniciar el temporizador y contador
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tiempo terminado'),
          content: Text('Clicks totales: $_counter'),
          actions: [
            TextButton(
              child: Text('Reiniciar'),
              onPressed: () {
                Navigator.of(context).pop();  // Cerrar el diálogo
                _resetGame();  // Reiniciar el juego
              },
            ),
            TextButton(
              child: Text('Regresar al Menú'),
              onPressed: () {
                Navigator.of(context).pop();  // Cerrar el diálogo
                Navigator.pop(context);  // Regresar al menú principal
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();  // Cancelar el temporizador si se destruye la pantalla
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Práctica 3 - Contador con Temporizador'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tiempo restante: $_timeLeft segundos', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text(
              'Has hecho $_counter clicks',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isButtonDisabled
                  ? null
                  : () {
                      setState(() {
                        _counter++;
                      });
                      if (_timer == null || !_timer!.isActive) {
                        _startTimer();  // Iniciar el temporizador en el primer clic
                      }
                    },
              child: Text('Incrementar'),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);  // Regresar al menú principal
          },
          child: Text('Regresar al Menú'),
        ),
      ],
    );
  }
}
