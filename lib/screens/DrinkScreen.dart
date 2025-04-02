import 'package:cocktail_app/screens/widgets/DrinkCard.dart';
import 'package:flutter/material.dart';
import '../data_objects/cocktails/Cocktail.dart';
import '../services/RemoteService.dart';

class DrinkListScreen extends StatefulWidget {
  const DrinkListScreen({super.key});

  @override
  _DrinkListScreenState createState() => _DrinkListScreenState();
}

class _DrinkListScreenState extends State<DrinkListScreen> {
  List<Cocktail>? cocktails;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() => isLoading = true); // Show loading initially
    cocktails = await RemoteService().getCocktails();
    setState(() {
      isLoading = false; // Hide loading once data is fetched
    });
  }

  String searchQuery = '';
  String filterQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drink List'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(112.0),
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
                    prefixIcon: const Icon(Icons.search),
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
                    prefixIcon: const Icon(Icons.filter_list),
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cocktails == null || cocktails!.isEmpty
          ? const Center(child: Text('No cocktails found'))
          : ListView(
        children: cocktails!
            .where((cocktail) {
          final matchesSearch =
          cocktail.name.toLowerCase().contains(searchQuery);
          final matchesFilter = filterQuery.isEmpty ||
              cocktail.ingredients
                  ?.map((i) => i.name.toLowerCase())
                  .join(', ')
                  .contains(filterQuery) ==
                  true;
          return matchesSearch && matchesFilter;
        })
            .map((cocktail) => CocktailCard(
          cocktail: cocktail,
          onFavoriteToggle: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DrinkDetailScreen(cocktail: cocktail),
              ),
            );
          },
        ))
            .toList(),
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
              child: Image.network(
                cocktail.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Ingredients: ${cocktail.ingredients?.map((x) => x.name).join(', ') ?? 'N/A'}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Instructions: ${cocktail.instructions ?? 'N/A'}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Glass: ${cocktail.glass ?? 'N/A'}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}