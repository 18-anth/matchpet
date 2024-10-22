class Post {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  Post({required this.id, required this.title, required this.description, required this.imageUrl});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}
