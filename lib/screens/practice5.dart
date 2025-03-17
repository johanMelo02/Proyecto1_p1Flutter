import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'person.dart';

class Practice5 extends StatefulWidget {
  @override
  _Practice5State createState() => _Practice5State();
}

class _Practice5State extends State<Practice5> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  List<Person> _people = [];

  @override
  void initState() {
    super.initState();
    _loadPeople();
  }

  Future<void> _loadPeople() async {
    final people = await DatabaseHelper.instance.getPeople();
    setState(() {
      _people = people;
    });
  }

  Future<void> _addPerson() async {
    final name = _nameController.text;
    final age = int.tryParse(_ageController.text) ?? 0;
    if (name.isNotEmpty && age > 0) {
      final person = Person(name: name, age: age);
      await DatabaseHelper.instance.insertPerson(person);
      _nameController.clear();
      _ageController.clear();
      _loadPeople();  // Actualizamos la lista
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Práctica 5 - SQLite')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Edad'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPerson,
              child: Text('Agregar Persona'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _people.length,
                itemBuilder: (context, index) {
                  final person = _people[index];
                  return ListTile(
                    title: Text('${person.name}'),
                    subtitle: Text('Edad: ${person.age}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
