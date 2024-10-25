import 'package:flutter/material.dart';
import '../models/noticia.dart';
import 'package:matchpet/Admin/Services/FirestoreService.dart';

class EditarNoticiaScreen extends StatefulWidget {
  final Noticia? noticia; // Si es `null`, es una noticia nueva

  EditarNoticiaScreen({this.noticia});

  @override
  _EditarNoticiaScreenState createState() => _EditarNoticiaScreenState();
}

class _EditarNoticiaScreenState extends State<EditarNoticiaScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();

  // Controladores para los campos
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _contenidoController = TextEditingController();
  TextEditingController _imagenUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Si se pasa una noticia existente, llenamos los campos con sus datos
    if (widget.noticia != null) {
      _tituloController.text = widget.noticia!.titulo;
      _contenidoController.text = widget.noticia!.contenido;
      _imagenUrlController.text = widget.noticia!.imagenUrl;
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _contenidoController.dispose();
    _imagenUrlController.dispose();
    super.dispose();
  }

  Future<void> _guardarNoticia() async {
    if (_formKey.currentState!.validate()) {
      Noticia noticia = Noticia(
        id: widget.noticia?.id ?? '', // Si es nueva, se asigna un ID en Firestore
        titulo: _tituloController.text,
        contenido: _contenidoController.text,
        imagenUrl: _imagenUrlController.text,
        fechaPublicacion: widget.noticia?.fechaPublicacion ?? DateTime.now(),
      );

      if (widget.noticia == null) {
        // Agregar una nueva noticia
        await _firestoreService.agregarNoticia(noticia);
      } else {
        // Actualizar noticia existente
        await _firestoreService.actualizarNoticia(noticia);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noticia == null ? 'Agregar Noticia' : 'Editar Noticia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contenidoController,
                decoration: InputDecoration(labelText: 'Contenido'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa contenido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imagenUrlController,
                decoration: InputDecoration(labelText: 'URL de la imagen'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la URL de la imagen';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardarNoticia,
                child: Text(widget.noticia == null ? 'Agregar Noticia' : 'Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
