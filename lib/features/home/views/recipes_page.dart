import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/data.dart';

class RecipesPage extends ConsumerWidget {
  const RecipesPage({
    super.key,
    required this.recipes,
  });

  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: ListView.builder(
        itemBuilder: (_, i) {
          final item = recipes[i];

          ExpansionTile(
            title: Text(item.title),
            children: item.ingredients.map((e) => Text(e)).toList(),
          );
        },
        itemCount: recipes.length,
      ),
    );
  }
}
