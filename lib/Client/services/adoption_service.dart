import '../models/adoption.dart';

class AdoptionService {
  Future<List<Adoption>> fetchAdoptions() async {
    // Simulando datos de Firebase
    return [
      Adoption(id: '1', petName: 'Rex', age: 3, imageUrl: 'https://fps.cdnpk.net/images/home/subhome-ai.webp?w=649&h=649'),
      Adoption(id: '2', petName: 'Max', age: 2, imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRk6PTgrG1FSAPViH9p7b4-0nbDVMu2xFutnw&s'),
    ];
  }
}
