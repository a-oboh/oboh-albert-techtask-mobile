import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_task/core/core.dart';

import '../model/model.dart';

final recipeRemoteDataSourceProvider = Provider<RecipeDataSource>((ref) {
  return RecipeRemoteDataSource(dio: ref.read(dioProvider));
});

abstract class RecipeDataSource {
  Future<List<Recipe>?> getRecipes(List<Ingredient> ingredients);
}

class RecipeRemoteDataSource implements RecipeDataSource {
  RecipeRemoteDataSource({required this.dio});

  final Dio dio;

  @override
  Future<List<Recipe>?> getRecipes(List<Ingredient> ingredients) async {
    try {
      String query = '';

      if (ingredients.length > 1) {
        ingredients.forEach((e) {
          query = query + ',' + e.title;
        });
        query = query.substring(1);
      }

      query = ingredients[0].title;

      final res = await dio.get('/recipe?ingredients=$query');
      if (res.statusCode == 200) {
        final List<Recipe> recipes = [];
        for (var data in res.data) {
          recipes.add(Recipe.fromJson(data));
        }

        return recipes;
      }
    } catch (e) {
      rethrow;
    }
  }
}
