

import 'dart:convert';

import 'package:cocktail_app/data_objects/ingredients/Ingredient.dart';

IngredientResponse ingredientResponseFromJson(String str) => IngredientResponse.fromJson(json.decode(str));
String ingredientResponseToJson(IngredientResponse data) => json.encode(data.toJson());
class IngredientResponse {
  final List<Ingredient> data;

  IngredientResponse({required this.data});
  factory IngredientResponse.fromJson(Map<String, dynamic> json) =>IngredientResponse(
    data: List<Ingredient>.from(json['data'].map((x) => Ingredient.fromJson(x))),
  );
  Map<String, dynamic> toJson() => {
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };

}