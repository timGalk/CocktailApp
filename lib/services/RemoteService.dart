
import 'package:http/http.dart' as http;

import '../data_objects/cocktails/Cocktail.dart';
import '../data_objects/cocktails/CocktailResponse.dart';

class RemoteService {
  var client = http.Client();

  Future<List<Cocktail>?> getCocktails() async {


    var url = Uri.parse('https://cocktails.solvro.pl'
        '/api/v1/cocktails?ingredients=true&page=1&perPage=220');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      return cocktailResponseFromJson(json).data;
    }
    return null;
  }
}
