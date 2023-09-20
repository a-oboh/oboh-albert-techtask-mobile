import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/features/features.dart';

import '../../../mocks.dart';

void main() {
  late final IngredientStateNotifier notifier;
  final ingredientRepo = MockIngredientRepository();
  final recipeRepo = MockRecipeRepository();

  setUp(() {
    notifier = IngredientStateNotifier(
      ingredientRepository: ingredientRepo,
      recipeRepository: recipeRepo,
    );
  });

  testWidgets('home screen', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [ingredientStateProvider.overrideWith((ref) => notifier)],
        child: MaterialApp(home: HomePage()),
      ),
    );

    expect(find.byType(TextButton), findsOneWidget);
    final button = find.byType(TextButton);
    await tester.tap(button);

    await tester.pumpAndSettle();

    expect(find.byType(DatePickerDialog), findsOneWidget);
    expect(find.byKey(Key('date-button')), findsOneWidget);
  });

  
}
