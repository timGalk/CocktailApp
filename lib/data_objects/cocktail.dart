import 'dart:convert';

class Cocktail {
  final int id;
  final String name;
  final String category;
  final String glass;
  final String instructions;
  final String imageUrl;
  final bool alcoholic;

  Cocktail({
    required this.id,
    required this.name,
    required this.category,
    required this.glass,
    required this.instructions,
    required this.imageUrl,
    required this.alcoholic,
  });

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return Cocktail(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      glass: json['glass'],
      instructions: json['instructions'],
      imageUrl: json['image_url'],
      alcoholic: json['alcoholic'],
    );
  }

  static List<Cocktail> fromJsonList(Map<String, dynamic> json) {
    final List<dynamic> jsonData = json['data'];
    return jsonData.map((e) => Cocktail.fromJson(e)).toList();
  }
}
