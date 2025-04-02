import 'package:cocktail_app/data_objects/cocktails/categories/Category.dart';
import 'package:cocktail_app/data_objects/ingredients/Ingredient.dart';

class Cocktail {
  int id;
  String name;
  Category category;
  String glass;
  String instructions;
  String imageUrl;
  bool alcoholic;
  DateTime createdAt;
  DateTime updatedAt;
  List<Ingredient>? ingredients;
  bool isFavorite;

  Cocktail({
    required this.id,
    required this.name,
    required this.category,
    required this.glass,
    required this.instructions,
    required this.imageUrl,
    required this.alcoholic,
    required this.createdAt,
    required this.updatedAt,
    required this.ingredients,
    this.isFavorite = false,
  });

  factory Cocktail.fromJson(Map<String, dynamic> json) => Cocktail(
    id: json["id"],
    name: json["name"],
    category: categoryValues.map[json["category"]]!,
    glass: json["glass"],
    instructions: json["instructions"],
    imageUrl: json["imageUrl"],
    alcoholic: json["alcoholic"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    ingredients:(json['ingredients'] as List<dynamic>)
        .map((item) => Ingredient.fromJson(item))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category": categoryValues.reverse[category],
    "glass": glass,
    "instructions": instructions,
    "imageUrl": imageUrl,
    "alcoholic": alcoholic,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "ingredients": ingredients

  };
}
