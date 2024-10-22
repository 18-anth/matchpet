import 'package:flutter/material.dart';
import '../models/donation.dart';
import '../screens/donation_detail_screen.dart';

class DonationCard extends StatelessWidget {
  final Donation donation;

  DonationCard({required this.donation});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(donation.title),
        subtitle: Text(donation.description),
        leading: Image.network(donation.imageUrl),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DonationDetailScreen(donation: donation)),
          );
        },
      ),
    );
  }
}
