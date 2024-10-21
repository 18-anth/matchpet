import 'package:flutter/material.dart';
import '../models/adoption.dart';
import '../screens/adoption_detail_screen.dart';

class AdoptionCard extends StatelessWidget {
  final Adoption adoption;

  AdoptionCard({required this.adoption});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(adoption.petName),
        subtitle: Text('Edad: ${adoption.age} años'),
        leading: Image.network(adoption.imageUrl),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdoptionDetailScreen(adoption: adoption)),
          );
        },
      ),
    );
  }
}
