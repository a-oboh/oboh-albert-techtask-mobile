import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/data.dart';

final ingredientRepoProvider = Provider<IngredientRepository>((ref) {
  return IngredientRepositoryImpl(ref.read(ingredientRemoteDataSourceProvider));
});

abstract class IngredientRepository {
  Future<List<Ingredient>> getIngredients();
}

class IngredientRepositoryImpl implements IngredientRepository {
  IngredientRepositoryImpl(this._dataSource);
  final IngredientDataSource _dataSource;

  @override
  Future<List<Ingredient>> getIngredients() async {
    try {
      final ingredients = await _dataSource.getIngredients();
      return ingredients ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
