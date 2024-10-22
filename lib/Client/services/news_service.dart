import '../models/post.dart';

class NewsService {
  Future<List<Post>> fetchPosts() async {
    // Simulando datos de Firebase
    return [
      Post(id: '1', title: 'Brigada de Adopción', description: 'Evento de adopción este sábado.', imageUrl: 'https://fps.cdnpk.net/images/home/subhome-ai.webp?w=649&h=649'),
      Post(id: '2', title: 'Mascota Extraviada', description: 'Se busca perrito perdido en el centro.', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRk6PTgrG1FSAPViH9p7b4-0nbDVMu2xFutnw&s'),
    ];
  }
}
