class RecipeStep {
  final String title;
  final String desc;

  const RecipeStep({
    required this.title,
    required this.desc,
  });
}

class Recipe {
  final String id;
  final String name;
  final String category;
  final String categoryGroup; // 'indian', 'favorites', 'desserts'
  final String desc;
  final String imageUrl;
  final String match;
  final String time;
  final String level;
  final String servings;
  final String calories;
  final double rating;
  final List<String> ingredients;
  final List<RecipeStep> steps;
  bool isSaved;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.categoryGroup,
    required this.desc,
    required this.imageUrl,
    required this.match,
    required this.time,
    required this.level,
    required this.servings,
    required this.calories,
    required this.rating,
    required this.ingredients,
    required this.steps,
    this.isSaved = false,
  });
}
