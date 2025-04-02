import 'package:flutter/material.dart';
import '../../data_objects/cocktails/Cocktail.dart';

class CocktailCard extends StatelessWidget {
  final Cocktail cocktail;
  final VoidCallback onFavoriteToggle;

  const CocktailCard({
    super.key,
    required this.cocktail,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          // Navigate to DetailPage (not implemented here)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tapped ${cocktail.name}')),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(
                cocktail.imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      cocktail.name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      cocktail.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: cocktail.isFavorite ? Colors.red : null,
                    ),
                    onPressed: onFavoriteToggle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}