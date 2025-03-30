import 'package:flutter/material.dart';

void main() {
  runApp(DrinkApp());
}

class DrinkApp extends StatelessWidget {
  const DrinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drink List',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.orange[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange,
          elevation: 2,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: DrinkListScreen(),
    );
  }
}

class Drink {
  final String name;
  final String imageUrl;
  final List<String> ingredients;

  Drink({required this.name, required this.imageUrl, required this.ingredients});
}

class DrinkListScreen extends StatefulWidget {
  const DrinkListScreen({super.key});

  @override
  _DrinkListScreenState createState() => _DrinkListScreenState();
}

class _DrinkListScreenState extends State<DrinkListScreen> {
  final List<Drink> drinks = [
    Drink(name: 'Mojito', imageUrl: 'https://media.istockphoto.com/id/1000079034/pl/zdj%C4%99cie/kieliszek-koktajlu-mojito.jpg?s=2048x2048&w=is&k=20&c=YZFSMGN_W2OAQamZ_CfJfFWC19qU18gtXxiAGaUCxo8=', ingredients: ['Rum', 'Mint', 'Sugar', 'Lime', 'Soda']),
    Drink(name: 'Margarita', imageUrl: 'https://mixthatdrink.com/wp-content/uploads/2023/03/classic-margarita-cocktail-750x1127.jpg', ingredients: ['Tequila', 'Lime Juice', 'Triple Sec']),
    Drink(name: 'Old Fashioned', imageUrl: 'https://assets.epicurious.com/photos/5e41a6d175661800087cc87c/1:1/w_1920,c_limit/OldFashioned_HERO_020520_619.jpg', ingredients: ['Whiskey', 'Sugar', 'Bitters', 'Water']),
  ];

  String searchQuery = '';
  String filterQuery = '';

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
      body: ListView(
        children: drinks.where((drink) =>
        drink.name.toLowerCase().contains(searchQuery) &&
            (filterQuery.isEmpty || drink.ingredients.any((ingredient) => ingredient.toLowerCase().contains(filterQuery)))
        ).map((drink) {
          return Card(
            margin: EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            elevation: 4,
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(drink.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
              ),
              title: Text(drink.name, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(drink.ingredients.join(', ')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DrinkDetailScreen(drink: drink)),
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
  final Drink drink;

  const DrinkDetailScreen({super.key, required this.drink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(drink.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(drink.imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            Text('Ingredients:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ...drink.ingredients.map((ingredient) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 8, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(ingredient, style: TextStyle(fontSize: 16)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
