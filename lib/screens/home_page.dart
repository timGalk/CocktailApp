// import 'dart:async';
// import 'package:cocktail_app/screens/widgets/DrinkCard.dart';
// import 'package:flutter/material.dart';
//
// import '../data_objects/cocktails/Cocktail.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   List<Cocktail> cocktails = [];
//   int page = 0;
//   bool isLoading = false;
//   String searchQuery = '';
//   Timer? _debounce;
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCocktails();
//     _scrollController.addListener(_onScroll);
//   }
//
//   Future<void> _loadCocktails({bool reset = false}) async {
//     if (isLoading) return;
//     setState(() => isLoading = true);
//     final newCocktails = await ApiService.fetchCocktails(
//       reset ? 0 : page,
//       query: searchQuery.isEmpty ? null : searchQuery,
//     );
//     setState(() {
//       if (reset) {
//         cocktails = newCocktails;
//         page = 0;
//       } else {
//         cocktails.addAll(newCocktails);
//       }
//       page++;
//       isLoading = false;
//     });
//   }
//
//   void _onScroll() {
//     if (_scrollController.position.pixels >=
//         _scrollController.position.maxScrollExtent - 200) {
//       _loadCocktails();
//     }
//   }
//
//   void _onSearchChanged(String value) {
//     if (_debounce?.isActive ?? false) _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 300), () {
//       setState(() {
//         searchQuery = value;
//         _loadCocktails(reset: true);
//       });
//     });
//   }
//
//   void _toggleFavorite(Cocktail cocktail) {
//     setState(() {
//       cocktail.isFavorite = !cocktail.isFavorite;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cocktail Explorer'),
//         actions: [
//           IconButton(
//             icon: Icon(
//               Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
//                   ? Icons.dark_mode
//                   : Icons.light_mode,
//             ),
//             onPressed:
//                 () =>
//                     Provider.of<ThemeProvider>(
//                       context,
//                       listen: false,
//                     ).toggleTheme(),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search by name...',
//                 prefixIcon: const Icon(Icons.search),
//                 suffixIcon:
//                     searchQuery.isNotEmpty
//                         ? IconButton(
//                           icon: const Icon(Icons.clear),
//                           onPressed: () {
//                             setState(() {
//                               searchQuery = '';
//                               _loadCocktails(reset: true);
//                             });
//                           },
//                         )
//                         : null,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onChanged: _onSearchChanged,
//             ),
//           ),
//           Expanded(
//             child:
//                 cocktails.isEmpty && !isLoading
//                     ? const Center(child: Text('No cocktails found'))
//                     : ListView.builder(
//                       controller: _scrollController,
//                       itemCount: cocktails.length + (isLoading ? 1 : 0),
//                       itemBuilder: (context, index) {
//                         if (index == cocktails.length) {
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         }
//                         final cocktail = cocktails[index];
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 8.0,
//                             vertical: 4.0,
//                           ),
//                           child: CocktailCard(
//                             cocktail: cocktail,
//                             onFavoriteToggle: () => _toggleFavorite(cocktail),
//                           ),
//                         );
//                       },
//                     ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _debounce?.cancel();
//     super.dispose();
//   }
// }
