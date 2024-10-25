import 'package:flutter/material.dart';
import 'package:matchpet/Admin/Screens/editar_noticia_screen.dart';
import 'package:matchpet/Admin/Services/FirestoreService.dart';
import '../models/animal.dart';
import 'editar_animal_screen.dart';

class AdopcionAdminScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Adopción'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditarNoticiaScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Animal>>(
        stream: _firestoreService.obtenerAnimales(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error al cargar animales.'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final animales = snapshot.data!;
          return ListView.builder(
            itemCount: animales.length,
            itemBuilder: (context, index) {
              final animal = animales[index];
              return ListTile(
                title: Text(animal.nombre),
                subtitle: Text('${animal.tipo} - ${animal.edad} años'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Navegar a pantalla de edición
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditarAnimalScreen(animal: animal),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _firestoreService.eliminarAnimal(animal.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
