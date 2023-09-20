import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/data.dart';
final recipeRepoProvider = Provider<RecipeRepository>((ref) {
  return RecipeRepositoryImpl(ref.read(recipeRemoteDataSourceProvider));
});

abstract class RecipeRepository {
  Future<List<Recipe>?> getRecipies(List<Ingredient> ingredients);
}

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeDataSource _dataSource;

  RecipeRepositoryImpl(this._dataSource);

  @override
  Future<List<Recipe>?> getRecipies(List<Ingredient> ingredients) async {
    try {
      return await _dataSource.getRecipes(ingredients);
    } catch (e) {
      rethrow;
    }
  }
}
