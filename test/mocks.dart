import 'package:mockito/mockito.dart';
import 'package:tech_task/features/features.dart';

class MockIngredientRepository extends Mock
    implements IngredientRepositoryImpl {}

class MockRecipeRepository extends Mock implements RecipeRepositoryImpl {}

class Listener extends Mock {
  void call(int? previous, int value);
}