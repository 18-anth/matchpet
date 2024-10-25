import 'package:cloud_firestore/cloud_firestore.dart';

class Noticia {
  String id;
  String titulo;
  String contenido;
  String imagenUrl;
  DateTime fechaPublicacion;

  Noticia({
    required this.id,
    required this.titulo,
    required this.contenido,
    required this.imagenUrl,
    required this.fechaPublicacion,
  });

  factory Noticia.fromMap(Map<String, dynamic> data, String documentId) {
    return Noticia(
      id: documentId,
      titulo: data['titulo'] ?? '',
      contenido: data['contenido'] ?? '',
      imagenUrl: data['imagenUrl'] ?? '',
      fechaPublicacion: (data['fechaPublicacion'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'contenido': contenido,
      'imagenUrl': imagenUrl,
      'fechaPublicacion': fechaPublicacion,
    };
  }
}