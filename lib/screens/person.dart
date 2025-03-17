class Person {
  final int? id;
  final String name;
  final int age;

  Person({this.id, required this.name, required this.age});

  // Método para convertir los datos a un Map
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }

  // Crear un objeto Person desde un Map
  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      name: map['name'],
      age: map['age'],
    );
  }
}
