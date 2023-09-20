import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_task/features/home/notifiers/ingredient_state.dart';
import 'package:tech_task/features/home/repositories/ingredient_repository.dart';
import 'package:tech_task/features/home/repositories/recipe_repository.dart';

import '../data/data.dart';

final ingredientStateProvider =
    StateNotifierProvider.autoDispose<IngredientStateNotifier, IngredientState>(
        (ref) {
  return IngredientStateNotifier(
    ingredientRepository: ref.read(ingredientRepoProvider),
    recipeRepository: ref.read(recipeRepoProvider),
  );
});

class IngredientStateNotifier extends StateNotifier<IngredientState> {
  IngredientStateNotifier(
      {required IngredientRepository ingredientRepository,
      required RecipeRepository recipeRepository})
      : _ingredientRepository = ingredientRepository,
        _recipeRepository = recipeRepository,
        super(IngredientState());

  final IngredientRepository _ingredientRepository;
  final RecipeRepository _recipeRepository;

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  onIngredientChanged(Ingredient ingredient, bool value) {
    if (ingredient.useBy.isBefore(state.selectedDate ?? DateTime.now())) {
      return;
    }
    if (value == false) {
      state.selectedIngredients?.remove(ingredient);
      var newList = state.selectedIngredients;

      state = state.copyWith(selectedIngredients: newList);
    } else {
      state = state.copyWith(selectedIngredients: [
        ...state.selectedIngredients ?? [],
        ingredient
      ]);
    }
  }

  resetIngredients() {
    try {
      state = state.copyWith(ingredients: null);
    } catch (e) {}
  }

  Future<void> getIngredients() async {
    try {
      state = state.copyWith(loading: true);
      final ingredients = await _ingredientRepository.getIngredients();
      state = state.copyWith(
        loading: false,
        ingredients: ingredients,
      );
    } on SocketException catch (e) {
      state = state.copyWith(
        loading: false,
        error: true,
        errorText: 'Please check your internet connection and try again',
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: true,
        errorText: 'An error occured while fetching ingredients',
      );
    }
  }

  Future<void> getRecipes() async {
    try {
      state = state.copyWith(loading: true);
      final recipes =
          await _recipeRepository.getRecipies(state.selectedIngredients ?? []);
      state = state.copyWith(
        loading: false,
        recipes: recipes,
      );
    } on SocketException catch (e) {
      state = state.copyWith(
        loading: false,
        error: true,
        errorText: 'Please check your internet connection and try again',
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: true,
        errorText: 'An error occured while fetching recipes',
      );
    }
  }
}
