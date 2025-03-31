
import 'package:http/http.dart' as http;

import '../data_objects/Cocktail.dart';
import '../data_objects/CocktailResponse.dart';

class RemoteService {
  Future<List<Cocktail>?> getCocktails() async {
    var client = http.Client();

    var url = Uri.parse('https://cocktails.solvro.pl/api/v1/'
        'cocktails?page=1&perPage=1');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      return cocktailResponseFromJson(json).data;
    }
    return null;
  }
}
