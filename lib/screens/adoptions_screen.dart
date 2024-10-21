import 'package:flutter/material.dart';
import '../widgets/adoption_card.dart';
import '../services/adoption_service.dart';

class AdoptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adopciones')),
      body: FutureBuilder(
        future: AdoptionService().fetchAdoptions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No hay mascotas disponibles para adopción.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return AdoptionCard(adoption: snapshot.data![index]);
            },
          );
        },
      ),
    );
  }
}
