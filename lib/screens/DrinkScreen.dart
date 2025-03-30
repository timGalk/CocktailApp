import 'package:flutter/material.dart';

import '../client/cocktail_client.dart';
import '../data_objects/cocktail.dart';

class DrinkListScreen extends StatefulWidget {
  const DrinkListScreen({super.key});

  @override
  _DrinkListScreenState createState() => _DrinkListScreenState();
}

class _DrinkListScreenState extends State<DrinkListScreen> {

  final cocktailClient = CocktailApiClient();
  List<Cocktail> cocktails = [];
  String searchQuery = '';
  String filterQuery = '';

  @override
  Future<void> tryGetAllCocktails() async {
    try {
      final fetchedCocktails = await cocktailClient.getAllCocktails();
      setState(() {
        cocktails = fetchedCocktails;
      });
    } catch (e) {
      // Handle error (e.g., show a toast or error message)
      print('Error fetching cocktails: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drink List'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(112.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search drinks...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Filter by ingredient...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.filter_list),
                  ),
                  onChanged: (value) {
                    setState(() {
                      filterQuery = value.toLowerCase();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: cocktails.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loading spinner when no data
          : ListView(
        children: cocktails.where((cocktail) {
          return cocktail.name.toLowerCase().contains(searchQuery);
        }).map((cocktail) {
          return Card(
            margin: EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            elevation: 4,
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(cocktail.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
              ),
              title: Text(cocktail.name, style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DrinkDetailScreen(cocktail: cocktail)),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DrinkDetailScreen extends StatelessWidget {
  final Cocktail cocktail;

  const DrinkDetailScreen({super.key, required this.cocktail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cocktail.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(cocktail.imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            Text('Ingredients:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            // You can uncomment this part if your Cocktail class has an ingredients property
            // ...cocktail.ingredients.map((ingredient) => Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 4.0),
            //   child: Row(
            //     children: [
            //       Icon(Icons.circle, size: 8, color: Colors.orange),
            //       SizedBox(width: 8),
            //       Text(ingredient, style: TextStyle(fontSize: 16)),
            //     ],
            //   ),
            // )),
          ],
        ),
      ),
    );
  }
}