import 'package:flutter/material.dart';
import 'package:matchpet/Admin/Services/FirestoreService.dart';
import '../models/animal.dart';

class EditarAnimalScreen extends StatefulWidget {
  final Animal? animal;

  EditarAnimalScreen({this.animal});

  @override
  _EditarAnimalScreenState createState() => _EditarAnimalScreenState();
}

class _EditarAnimalScreenState extends State<EditarAnimalScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();

  // Controladores para los campos
  late TextEditingController _nombreController;
  late TextEditingController _tipoController;
  late TextEditingController _categoriaController;
  late TextEditingController _edadController;
  late TextEditingController _descripcionController;
  late TextEditingController _imagenUrlController;

  @override
  void initState() {
    super.initState();
    // Inicializamos los controladores con valores si estamos editando
    _nombreController = TextEditingController(text: widget.animal?.nombre ?? '');
    _tipoController = TextEditingController(text: widget.animal?.tipo ?? '');
    _categoriaController = TextEditingController(text: widget.animal?.categoria ?? '');
    _edadController = TextEditingController(text: widget.animal?.edad.toString() ?? '');
    _descripcionController = TextEditingController(text: widget.animal?.descripcion ?? '');
    _imagenUrlController = TextEditingController(text: widget.animal?.imagenUrl ?? '');
  }

  @override
  void dispose() {
    // Liberamos los controladores cuando ya no se necesiten
    _nombreController.dispose();
    _tipoController.dispose();
    _categoriaController.dispose();
    _edadController.dispose();
    _descripcionController.dispose();
    _imagenUrlController.dispose();
    super.dispose();
  }

  // Método para guardar o actualizar el animal
  void _guardarAnimal() {
    if (_formKey.currentState!.validate()) {
      final animal = Animal(
        id: widget.animal?.id ?? '', // Si es nuevo, no tendrá id aún
        nombre: _nombreController.text,
        tipo: _tipoController.text,
        categoria: _categoriaController.text,
        edad: int.parse(_edadController.text),
        descripcion: _descripcionController.text,
        imagenUrl: _imagenUrlController.text,
      );

      if (widget.animal == null) {
        // Si el animal es null, estamos agregando uno nuevo
        _firestoreService.agregarAnimal(animal);
      } else {
        // Si no es null, estamos editando el existente
        _firestoreService.actualizarAnimal(animal);
      }

      Navigator.pop(context); // Regresar a la pantalla anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.animal == null ? 'Agregar Animal' : 'Editar Animal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre del Animal'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tipoController,
                decoration: InputDecoration(labelText: 'Tipo (Perro, Gato, etc.)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el tipo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoriaController,
                decoration: InputDecoration(labelText: 'Categoría'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la categoría';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _edadController,
                decoration: InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la edad';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imagenUrlController,
                decoration: InputDecoration(labelText: 'URL de la Imagen'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la URL de la imagen';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardarAnimal,
                child: Text(widget.animal == null ? 'Agregar' : 'Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
