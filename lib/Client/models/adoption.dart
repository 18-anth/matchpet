class Adoption {
  final String id;
  final String petName;
  final int age;
  final String imageUrl;

  Adoption({required this.id, required this.petName, required this.age, required this.imageUrl});

  factory Adoption.fromJson(Map<String, dynamic> json) {
    return Adoption(
      id: json['id'],
      petName: json['petName'],
      age: json['age'],
      imageUrl: json['imageUrl'],
    );
  }
}
