// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../data_objects/api_response.dart' show CocktailResponse;
//
// class CocktailApiClient {
//   final String baseUrl = 'https://cocktails.solvro.pl/api/v1';
//
//   Future<CocktailResponse> fetchCocktails() async {
//     final client = http.Client();
//     final response = await client.get(
//       Uri.parse('$baseUrl/cocktails?page=1&perPage=2'),
//     );
//
//     if (response.statusCode == 200) {
//       return CocktailResponse.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load cocktails');
//     }
//   }
// }
