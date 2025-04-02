import 'package:cocktail_app/screens/widgets/CocktailDetailsScreen.dart';
import 'package:cocktail_app/screens/widgets/DrinkCard.dart';
import 'package:flutter/material.dart';
import '../data_objects/cocktails/Cocktail.dart';
import '../services/RemoteService.dart';

class CocktailListScreen extends StatefulWidget {
  const CocktailListScreen({super.key});

  @override
  _CocktailListScreenState createState() => _CocktailListScreenState();
}

class _CocktailListScreenState extends State<CocktailListScreen> {
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
        title: const Text('Cocktail List'),
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
           onTap: () {Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CocktailDetailsScreen(cocktail: cocktail),
          ),
        );  },
        ))
            .toList(),
      ),
    );
  }
}


