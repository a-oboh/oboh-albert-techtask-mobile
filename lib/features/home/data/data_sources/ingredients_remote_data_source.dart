import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_task/core/core.dart';
import 'package:tech_task/features/home/data/model/ingredients.dart';

final ingredientRemoteDataSourceProvider =
    Provider<IngredientDataSource>((ref) {
  return IngredientRemoteDataSource(dio: ref.read(dioProvider));
});

abstract class IngredientDataSource {
  Future<List<Ingredient>?> getIngredients();
}

class IngredientRemoteDataSource implements IngredientDataSource {
  IngredientRemoteDataSource({required this.dio});

  final Dio dio;

  @override
  Future<List<Ingredient>?> getIngredients() async {
    try {
      final res = await dio.get('/ingredients');

      if (res.statusCode == 200) {
        final ingredients = <Ingredient>[];

        for (var data in res.data) {
          ingredients.add(Ingredient.fromJson(data));
        }
        return ingredients;
      }
    } catch (e) {
      rethrow;
    }
  }
}
