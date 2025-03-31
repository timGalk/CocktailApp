
class Ingredient {
  int id;
  String name;
  String? description;
  bool alcohol;
  String? type;
  dynamic percentage;
  String? imageUrl;
  DateTime createdAt;
  DateTime updatedAt;

  Ingredient({
    required this.id,
    required this.name,
    required this.description,
    required this.alcohol,
    required this.type,
    required this.percentage,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    alcohol: json["alcohol"],
    type: json["type"],
    percentage: json["percentage"],
    imageUrl: json["imageUrl"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "alcohol": alcohol,
    "type": type,
    "percentage": percentage,
    "imageUrl": imageUrl,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };

}
