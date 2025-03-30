import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data_objects/cocktail.dart';
import '../data_objects/meta.dart';



class CocktailApiClient {
  final String baseUrl;
  final http.Client _client = http.Client();

  CocktailApiClient({this.baseUrl = 'https://cocktails.solvro.pl'});

  // Fetch all cocktails from the database
  Future<List<Cocktail>> getAllCocktails() async {
    final List<Cocktail> allCocktails = [];
    int currentPage = 1;
    int lastPage = 1;

    try {
      do {
        final response = await getPage(currentPage);
        allCocktails.addAll(response.data);

        // Update pagination information
        lastPage = response.meta.lastPage;
        currentPage++;

        print('Loaded page ${currentPage - 1}/$lastPage. Total cocktails: ${allCocktails.length}');
      } while (currentPage <= lastPage);

      return allCocktails;
    } catch (e) {
      print('Error fetching cocktails: $e');
      throw Exception('Failed to load cocktails');
    }
  }

  // Get a single page of cocktails
  Future<ApiResponse> getPage(int page) async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/?page=$page'));

      if (response.statusCode != 200) {
        throw Exception('API returned error code: ${response.statusCode}');
      }

      return ApiResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print('Error fetching page $page: $e');
      throw Exception('Failed to fetch page $page');
    }
  }

  void dispose() {
    _client.close();
  }
}
