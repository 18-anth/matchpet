class Animal {
  String id;
  String nombre;
  String tipo;
  String categoria; // Gato, Perro, etc.
  int edad;
  String descripcion;
  String imagenUrl;

  Animal({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.categoria,
    required this.edad,
    required this.descripcion,
    required this.imagenUrl,
  });

  factory Animal.fromMap(Map<String, dynamic> data, String documentId) {
    return Animal(
      id: documentId,
      nombre: data['nombre'] ?? '',
      tipo: data['tipo'] ?? '',
      categoria: data['categoria'] ?? '',
      edad: data['edad'] ?? 0,
      descripcion: data['descripcion'] ?? '',
      imagenUrl: data['imagenUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'tipo': tipo,
      'categoria': categoria,
      'edad': edad,
      'descripcion': descripcion,
      'imagenUrl': imagenUrl,
    };
  }
}
