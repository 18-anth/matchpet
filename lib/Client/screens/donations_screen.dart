import 'package:flutter/material.dart';
import '../widgets/donation_card.dart';
import '../services/donations_service.dart';

class DonationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donaciones')),
      body: FutureBuilder(
        future: DonationsService().fetchDonations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay donaciones disponibles.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return DonationCard(donation: snapshot.data![index]);
            },
          );
        },
      ),
    );
  }
}
