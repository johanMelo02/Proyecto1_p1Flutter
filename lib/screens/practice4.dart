import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Practice4 extends StatefulWidget {
  @override
  _Practice4State createState() => _Practice4State();
}

class _Practice4State extends State<Practice4> {
  int _counter = 0;
  bool _isButtonDisabled = false;
  Timer? _timer;
  int _timeLeft = 10;
  List<int> _scores = [];

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/scores.txt';
  }

  Future<File> _getFile() async {
    final path = await _getFilePath();
    return File(path);
  }

  Future<void> _saveScore(int score) async {
    final file = await _getFile();
    await file.writeAsString('$score\n', mode: FileMode.append);
  }

  Future<void> _loadScores() async {
    try {
      final file = await _getFile();
      final contents = await file.readAsString();
      setState(() {
        _scores = contents
            .split('\n')
            .where((line) => line.isNotEmpty)
            .map((line) => int.parse(line))
            .toList();
      });
    } catch (e) {
      print('Error al leer el archivo: $e');
    }
  }

  List<int> _getTop5Scores() {
    List<int> sortedScores = List.from(_scores);
    sortedScores.sort((a, b) => b.compareTo(a));
    return sortedScores.take(5).toList();
  }

  void _startTimer() {
    setState(() {
      _timeLeft = 10;
      _counter = 0;
      _isButtonDisabled = false;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _isButtonDisabled = true;
          timer.cancel();
          _completeGame();
        }
      });
    });
  }

  Future<void> _completeGame() async {
    // Detenemos cualquier proceso y guardamos los puntajes
    await _saveScore(_counter);
    await _loadScores();
    _showResultDialog();
  }

  void _showResultDialog() {
    List<int> topScores = _getTop5Scores();

    showDialog(
      context: context,
      barrierDismissible: false, // Evitar cerrar el diálogo tocando fuera
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tiempo terminado'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Clicks totales: $_counter'),
              SizedBox(height: 10),
              Text('Top 5 Puntajes:'),
              for (var score in topScores) Text('Score: $score'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Reiniciar'),
              onPressed: () {
                Navigator.of(context).pop();
                _startTimer();  // Reiniciamos el juego al presionar reiniciar
              },
            ),
            TextButton(
              child: Text('Regresar al Menú'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);  // Volver al menú principal
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();  // Aseguramos que el temporizador se detiene al salir
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Práctica 4 - Historial en Archivo de Texto'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tiempo restante: $_timeLeft segundos', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Has hecho $_counter clicks', style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isButtonDisabled
                  ? null
                  : () {
                      setState(() {
                        _counter++;
                      });
                      if (_timer == null || !_timer!.isActive) {
                        _startTimer();
                      }
                    },
              child: Text('Incrementar'),
            ),
            SizedBox(height: 20),
            Text('Historial de puntajes:', style: TextStyle(fontSize: 18)),
            Expanded(
              child: ListView.builder(
                itemCount: _scores.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Score: ${_scores[index]}'),
                  );
                },
              ),
            ),
          ],
        ),
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
