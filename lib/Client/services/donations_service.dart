import '../models/donation.dart';

class DonationsService {
  Future<List<Donation>> fetchDonations() async {
    // Simulando datos de Firebase
    return [
      Donation(id: '1', title: 'Donación de alimentos', description: 'Necesitamos alimentos para gatos.', imageUrl: 'https://example.com/image1.jpg'),
      Donation(id: '2', title: 'Donación de medicinas', description: 'Medicinas para tratamientos urgentes.', imageUrl: 'https://example.com/image2.jpg'),
    ];
  }
}
