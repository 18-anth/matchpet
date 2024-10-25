import 'package:flutter/material.dart';
import 'package:matchpet/Admin/Services/FirestoreService.dart';
import '../models/noticia.dart';
import 'editar_noticia_screen.dart';

class NoticiasFeedScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  NoticiasFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed de Noticias'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navegar a pantalla para agregar una nueva noticia
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditarNoticiaScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Noticia>>(
        stream: _firestoreService.obtenerNoticias(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error al cargar noticias.'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final noticias = snapshot.data!;
          return ListView.builder(
            itemCount: noticias.length,
            itemBuilder: (context, index) {
              final noticia = noticias[index];
              return ListTile(
                title: Text(noticia.titulo),
                subtitle: Text(noticia.fechaPublicacion.toString()),
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
                                EditarNoticiaScreen(noticia: noticia),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _firestoreService.eliminarNoticia(noticia.id);
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
