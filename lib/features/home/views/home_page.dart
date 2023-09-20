import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_task/features/home/home.dart';
import 'package:tech_task/features/home/views/ingredients_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ingredientStateProvider.notifier).resetIngredients();
    });
    super.initState();
  }

  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // ref.listen<IngredientState>(ingredientStateProvider, (prev, state) {
    //   if (!state.loading &&
    //       prev?.ingredients == null &&
    //       state.ingredients != null) {

    //       }
    // });

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: Container(
        child: Center(
          child: !ref.watch(ingredientStateProvider).loading
              ? TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: now,
                      firstDate: DateTime(2018, now.month, now.day),
                      lastDate: DateTime(now.year + 1, now.month, now.day),
                    );

                    ref
                        .read(ingredientStateProvider.notifier)
                        .selectDate(date ?? now);
                    await ref
                        .read(ingredientStateProvider.notifier)
                        .getIngredients()
                        .then(
                      (value) {
                        print(ref.read(ingredientStateProvider).ingredients);

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => IngredientsPage(
                              ingredients: ref
                                      .read(ingredientStateProvider)
                                      .ingredients ??
                                  [],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'Select Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
