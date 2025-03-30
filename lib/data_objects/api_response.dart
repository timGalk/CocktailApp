import 'cocktail.dart';
import 'meta.dart';

class ApiResponse {
  final Meta meta;
  final List<Cocktail> data;

  ApiResponse({required this.meta, required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      meta: Meta.fromJson(json['meta']),
      data: (json['data'] as List).map((item) => Cocktail.fromJson(item)).toList(),
    );
  }
}