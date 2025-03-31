import 'dart:convert';

import 'Cocktail.dart';
import 'Meta.dart';

CocktailResponse cocktailResponseFromJson(String str) => CocktailResponse.fromJson(json.decode(str));
String cocktailResponseToJson(CocktailResponse data) => json.encode(data.toJson());
class CocktailResponse {
  final Meta meta;
  final List<Cocktail> data;

  CocktailResponse({required this.meta, required this.data});

  factory CocktailResponse.fromJson(Map<String, dynamic> json) => CocktailResponse(
    meta: Meta.fromJson(json['meta']),
    data: List<Cocktail>.from(json['data'].map((x) => Cocktail.fromJson(x))),
  );

  Map<String, dynamic> toJson() =>{
    'meta': meta.toJson(),
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}