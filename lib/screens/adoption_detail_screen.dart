import 'package:flutter/material.dart';
import '../models/adoption.dart';

class AdoptionDetailScreen extends StatelessWidget {
  final Adoption adoption;

  AdoptionDetailScreen({required this.adoption});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(adoption.petName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(adoption.imageUrl),
            SizedBox(height: 16),
            Text('Nombre: ${adoption.petName}', style: TextStyle(fontSize: 18)),
            Text('Edad: ${adoption.age}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Iniciar proceso de adopción
              },
              child: Text('Adoptar'),
            ),
          ],
        ),
      ),
    );
  }
}
