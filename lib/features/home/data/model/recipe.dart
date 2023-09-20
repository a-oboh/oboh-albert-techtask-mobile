import 'dart:convert';

class Recipe {
    String title;
    List<String> ingredients;

    Recipe({
        required this.title,
        required this.ingredients,
    });

    factory Recipe.fromRawJson(String str) => Recipe.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        title: json["title"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
    };
}
