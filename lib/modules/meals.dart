enum Complexity{
  simple,
  challenging,
  hard,
}
enum Affordability{
  affordable,
  pricey,
  luxurious
}



class Meal {
  final String id;

  final String title;

  final String imageUrl;

  final bool isGlutenFree;

  final bool isLactoseFree;

  final bool isVegan;

  final bool isVegetarian;

  final List<String> ingredients;
  final List<String> categories;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  Meal(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.isGlutenFree,
      required this.isLactoseFree,
      required this.isVegan,
      required this.isVegetarian,
      required this.ingredients,
      required this.categories,
      required this.steps,
      required this.duration,
      required this.complexity,
      required this.affordability});
}
