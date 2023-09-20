import 'package:tech_task/features/home/home.dart';

class IngredientState {
  IngredientState({
    this.loading = false,
    this.error = false,
    this.ingredients,
    this.selectedIngredients,
    this.recipes,
    this.errorText,
    this.selectedDate,
  });

  final bool loading;
  final bool error;
  final List<Ingredient>? ingredients;
  final List<Ingredient>? selectedIngredients;
  final List<Recipe>? recipes;
  final String? errorText;
  final DateTime? selectedDate;

  IngredientState copyWith({
    bool? loading,
    bool? error,
    List<Ingredient>? ingredients,
    List<Ingredient>? selectedIngredients,
    List<Recipe>? recipes,
    String? errorText,
    DateTime? selectedDate,
  }) {
    return IngredientState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      ingredients: ingredients ?? this.ingredients,
      selectedIngredients: selectedIngredients ?? this.selectedIngredients,
      recipes: recipes ?? this.recipes,
      errorText: errorText ?? this.errorText,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
