import '../models/adoption.dart';

class AdoptionService {
  Future<List<Adoption>> fetchAdoptions() async {
    // Simulando datos de Firebase
    return [
      Adoption(id: '1', petName: 'Rex', age: 3, imageUrl: 'https://example.com/image1.jpg'),
      Adoption(id: '2', petName: 'Max', age: 2, imageUrl: 'https://example.com/image2.jpg'),
    ];
  }
}
