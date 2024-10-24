import '../models/donation.dart';

class DonationsService {
  Future<List<Donation>> fetchDonations() async {
    // Simulando datos de Firebase
    return [
      Donation(id: '1', title: 'Donación de alimentos', description: 'Necesitamos alimentos para gatos.', imageUrl: 'https://fps.cdnpk.net/images/home/subhome-ai.webp?w=649&h=649'),
      Donation(id: '2', title: 'Donación de medicinas', description: 'Medicinas para tratamientos urgentes.', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRk6PTgrG1FSAPViH9p7b4-0nbDVMu2xFutnw&s'),
    ];
  }
}
