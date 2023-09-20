import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_task/features/home/home.dart';

class IngredientsPage extends ConsumerWidget {
  const IngredientsPage({required this.ingredients, super.key});

  final List<Ingredient> ingredients;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Ingredients'),
      ),
      body: Column(
        children: [
          !ref.watch(ingredientStateProvider).loading
              ? Expanded(
                  child: ListView.builder(
                    itemCount: ingredients.length,
                    itemBuilder: (context, i) {
                      final item = ingredients[i];
                      final isSelected = ref
                              .watch(ingredientStateProvider)
                              .selectedIngredients
                              ?.contains(item) ??
                          false;

                      return CheckboxListTile(
                          title: Text(item.title),
                          value: isSelected,
                          onChanged: (value) {
                            ref
                                .read(ingredientStateProvider.notifier)
                                .onIngredientChanged(item, value ?? false);
                          });
                    },
                  ),
                )
              : CircularProgressIndicator(),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black)),
            onPressed: !ref.watch(ingredientStateProvider).loading
                ? ref.read(ingredientStateProvider.notifier).getRecipes
                : () {},
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}
