import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/noticia.dart';
import '../models/animal.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // CRUD Noticias
  Future<void> agregarNoticia(Noticia noticia) {
    return _db.collection('noticias').add(noticia.toMap());
  }

  Future<void> actualizarNoticia(Noticia noticia) {
    return _db.collection('noticias').doc(noticia.id).update(noticia.toMap());
  }

  Future<void> eliminarNoticia(String id) {
    return _db.collection('noticias').doc(id).delete();
  }

  Stream<List<Noticia>> obtenerNoticias() {
    return _db.collection('noticias').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Noticia.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  // CRUD Animales
  Future<void> agregarAnimal(Animal animal) {
    return _db.collection('animales').add(animal.toMap());
  }

  Future<void> actualizarAnimal(Animal animal) {
    return _db.collection('animales').doc(animal.id).update(animal.toMap());
  }

  Future<void> eliminarAnimal(String id) {
    return _db.collection('animales').doc(id).delete();
  }

  Stream<List<Animal>> obtenerAnimales({String? categoria}) {
    Query query = _db.collection('animales');
    if (categoria != null) {
      query = query.where('categoria', isEqualTo: categoria);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?; // Casting explícito
        if (data != null) {
          return Animal.fromMap(data, doc.id); // Si el casting es exitoso
        } else {
          throw Exception("Los datos del animal no son válidos");
        }
      }).toList();
    });
  }
}
