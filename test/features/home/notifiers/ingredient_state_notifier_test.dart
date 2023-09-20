import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tech_task/features/home/home.dart';

import '../../../mocks.dart';

void main() {
  late final IngredientStateNotifier notifier;
  final ingredientRepo = MockIngredientRepository();
  final recipeRepo = MockRecipeRepository();
  final fakeIngredient = Ingredient(title: 'ham', useBy: DateTime(2020, 6, 10));
  final fakeRecipe = Recipe(title: 'Burger', ingredients: [
    fakeIngredient.title,
    fakeIngredient.title,
  ]);

  setUp(() {
    notifier = IngredientStateNotifier(
        ingredientRepository: ingredientRepo, recipeRepository: recipeRepo);
  });

  test('get ingredients test', () async {
    when(ingredientRepo.getIngredients())
        .thenAnswer((_) async => [fakeIngredient]);

    await notifier.getIngredients();

    verify(() => ingredientRepo.getIngredients()).called(1);
    verifyNoMoreInteractions(ingredientRepo);
  });
}
