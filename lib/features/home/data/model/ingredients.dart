import 'dart:convert';

class Ingredient {
  String title;
  DateTime useBy;

  Ingredient({
    required this.title,
    required this.useBy,
  });

  factory Ingredient.fromRawJson(String str) =>
      Ingredient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        title: json["title"],
        useBy: DateTime.parse(json["use-by"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "use-by":
            "${useBy.year.toString().padLeft(4, '0')}-${useBy.month.toString().padLeft(2, '0')}-${useBy.day.toString().padLeft(2, '0')}",
      };
}
