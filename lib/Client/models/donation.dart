class Donation {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  Donation({required this.id, required this.title, required this.description, required this.imageUrl});

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}
