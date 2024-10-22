import 'package:flutter/material.dart';
import '../models/donation.dart';

class DonationDetailScreen extends StatelessWidget {
  final Donation donation;

  DonationDetailScreen({required this.donation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(donation.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(donation.imageUrl),
            SizedBox(height: 16),
            Text(donation.description, style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Lógica de donación
              },
              child: Text('Donar'),
            ),
          ],
        ),
      ),
    );
  }
}
