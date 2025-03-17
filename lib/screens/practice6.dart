import 'package:flutter/material.dart';
import 'dart:async'; // Importar para manejar el temporizador
import 'database_helper.dart';

class Practice6 extends StatefulWidget {
  @override
  _Practice6State createState() => _Practice6State();
}

class _Practice6State extends State<Practice6> {
  int _counter = 0;
  bool _isGameActive = false;
  Timer? _timer;
  int _timeRemaining = 10;
  List<int> _topScores = [];

  @override
  void initState() {
    super.initState();
    _loadTopScores();
  }

Future<void> _loadTopScores() async {
  final scores = await DatabaseHelper.instance.getTop5Scores();
  setState(() {
    _topScores = scores;
    print('Mejores puntajes: $_topScores'); // Añadir esta línea para depurar
  });
}


  void _startGame() {
    setState(() {
      _counter = 0;
      _isGameActive = true;
      _timeRemaining = 10;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeRemaining--;
      });

      if (_timeRemaining <= 0) {
        _endGame();
        _timer?.cancel();
      }
    });
  }

 Future<void> _endGame() async {
  setState(() {
    _isGameActive = false;
  });

  // Guardar el puntaje en la base de datos
  await DatabaseHelper.instance.insertScore(_counter);
      await _loadTopScores();
     // Cargar los mejores puntajes
  await _loadTopScores();
  _showScoreDialog();
}

void _showScoreDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Juego Terminado'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Puntaje: $_counter'),
            SizedBox(height: 10),
            Text('Top 5 Puntuaciones:'),
            for (var score in _topScores) Text('Puntaje: $score'), // Aquí se muestran los puntajes
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _startGame(); // Para reiniciar el juego
            },
            child: Text('Jugar de Nuevo'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pop(context); // Regresar al menú principal
            },
            child: Text('Menú Principal'),
          ),
        ],
      );
    },
  );
}


  @override
  void dispose() {
    _timer?.cancel(); // Cancelar el temporizador si el widget se destruye
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Práctica 6 - Historial en SQLite')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isGameActive) ...[
              Text('Puntaje: $_counter'),
              SizedBox(height: 20),
              Text('Tiempo Restante: $_timeRemaining segundos'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isGameActive
                    ? () {
                        setState(() {
                          _counter++;
                        });
                      }
                    : null, // El botón solo estará activo durante el juego
                child: Text('Incrementar'),
              ),
            ] else ...[
              Text('Juego no iniciado'),
              ElevatedButton(
                onPressed: _startGame,
                child: Text('Iniciar Juego'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

