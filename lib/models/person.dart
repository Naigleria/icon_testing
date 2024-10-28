



class Person {
  int? id;
  String nombre;
  String email;
  int edad;

  Person({
    required this.id,
    required this.nombre,
    required this.email,
    required this.edad, 
    
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'edad': edad,
    };
  }

  static Person fromMap(Map<String, dynamic> map) {
    return Person(
      id: map["person_id"],
      nombre: map['nombre'],
      email: map['email'],
      edad: map['edad'], 
    );
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['person_id'],
      nombre: json['name'],
      email: json['email'],
      edad: json['age']
    );
  }
}