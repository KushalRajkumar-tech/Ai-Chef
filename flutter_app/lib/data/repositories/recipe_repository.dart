import '../models/recipe_model.dart';

class RecipeRepository {
  static final List<Recipe> _recipes = [
    Recipe(
      id: 'butter-chicken',
      name: 'Royal Butter Chicken (Murgh Makhani)',
      category: 'Indian Food • North Indian',
      categoryGroup: 'indian',
      desc: 'Tender tandoori chicken simmered in a velvety aromatic tomato, cashew, and fenugreek butter gravy.',
      imageUrl: 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=800&auto=format&fit=crop&q=80',
      match: 'Popular Indian Masterpiece',
      time: '35 min',
      level: 'Medium',
      servings: '4 Servings',
      calories: '560 kcal',
      rating: 4.9,
      isSaved: true,
      ingredients: [
        '600g boneless chicken thighs (cubed)',
        '1/2 cup Greek yogurt + 1 tbsp ginger-garlic paste',
        '4 tbsp grass-fed butter + 1 tbsp oil',
        '1.5 cups smooth San Marzano tomato puree',
        '1/2 cup heavy whipping cream',
        '2 tbsp soaked cashew paste',
        '1 tbsp dried Kasuri Methi (crushed fenugreek leaves)',
        '1 tsp Kashmiri red chili powder & 1 tsp Garam Masala',
      ],
      steps: [
        const RecipeStep(
          title: 'Marinate & Pan-Sear',
          desc: 'Marinate chicken in yogurt, ginger-garlic, and spices for 20 mins. Sear in a hot skillet until lightly charred.',
        ),
        const RecipeStep(
          title: 'Simmer Silky Tomato Base',
          desc: 'Melt 2 tbsp butter. Cook tomato puree, Kashmiri chili, and cashew paste on medium-low until oil separates.',
        ),
        const RecipeStep(
          title: 'Enrich with Cream & Fenugreek',
          desc: 'Stir in heavy cream, remaining butter, garam masala, and roasted kasuri methi until velvety smooth.',
        ),
        const RecipeStep(
          title: 'Simmer Chicken & Garnish',
          desc: 'Add seared chicken pieces into the gravy and simmer for 6 minutes. Garnish with a swirl of cream and fresh cilantro.',
        ),
      ],
    ),
    Recipe(
      id: 'paneer-tikka',
      name: 'Smoky Paneer Tikka Masala',
      category: 'Indian Food • Vegetarian',
      categoryGroup: 'indian',
      desc: 'Char-grilled cottage cheese cubes and crisp peppers tossed in a robust spiced onion-tomato masala.',
      imageUrl: 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=800&auto=format&fit=crop&q=80',
      match: 'Vegetarian Classic',
      time: '30 min',
      level: 'Easy',
      servings: '3 Servings',
      calories: '480 kcal',
      rating: 4.8,
      isSaved: true,
      ingredients: [
        '400g fresh Malai Paneer (cubed)',
        '1 large diced red onion & green bell pepper',
        '1/2 cup hung curd with mustard oil & chaat masala',
        '2 finely chopped onions & 3 pureed tomatoes',
        '1 tbsp ginger-garlic paste',
        '1 tsp cumin seeds, turmeric, and coriander powder',
        'Fresh lemon juice & coriander leaves',
      ],
      steps: [
        const RecipeStep(
          title: 'Coat in Tandoori Marinade',
          desc: 'Toss paneer cubes and peppers in spiced hung curd with mustard oil. Let rest for 15 minutes.',
        ),
        const RecipeStep(
          title: 'Char-Grill Paneer',
          desc: 'Grill skewers or pan-roast in a smoking cast-iron pan until paneer edges develop golden brown char.',
        ),
        const RecipeStep(
          title: 'Build Onion-Tomato Masala',
          desc: 'Sauté cumin, chopped onions, and ginger-garlic until deeply caramelized. Add tomato puree and ground spices.',
        ),
        const RecipeStep(
          title: 'Combine & Finish',
          desc: 'Gently fold grilled paneer and peppers into the rich masala gravy. Simmer for 3 minutes and finish with lemon juice.',
        ),
      ],
    ),
    Recipe(
      id: 'dum-biryani',
      name: 'Hyderabadi Dum Biryani',
      category: 'Indian Food • Royal Feast',
      categoryGroup: 'indian',
      desc: 'Fragrant long-grain basmati rice layered with spiced saffron marinade, clarified ghee, caramelized onions, and fresh mint.',
      imageUrl: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=800&auto=format&fit=crop&q=80',
      match: 'Royal Heritage Dish',
      time: '50 min',
      level: 'Hard',
      servings: '4 Servings',
      calories: '620 kcal',
      rating: 5.0,
      isSaved: false,
      ingredients: [
        '2 cups aged Royal Basmati rice (soaked for 30m)',
        '500g bone-in chicken or spiced mixed vegetables',
        '1/2 cup crispy fried golden onions (Birista)',
        'Pinch of saffron threads steeped in 1/4 cup warm milk',
        '3 tbsp pure desi ghee + whole shahi jeera, cardamom & star anise',
        '1/2 cup chopped fresh mint & coriander leaves',
        '1 cup thick spiced yogurt marinade',
      ],
      steps: [
        const RecipeStep(
          title: 'Marinate Core Proteins',
          desc: 'Marinate chicken/vegetables with yogurt, ginger-garlic, mint, fried onions, and whole spices for 1 hour.',
        ),
        const RecipeStep(
          title: 'Par-boil Basmati Rice',
          desc: 'Boil rice in whole-spiced rolling water until exactly 70% cooked (grain bends without snapping). Drain.',
        ),
        const RecipeStep(
          title: 'Royal Dum Layering',
          desc: 'In a heavy-bottomed handi, layer marinated base, topped with fragrant rice, saffron milk, fried onions, and mint.',
        ),
        const RecipeStep(
          title: 'Steam on Dum',
          desc: 'Seal the pot tightly with dough or foil. Cook on high for 5 mins, then slow steam over a tawa for 25 minutes.',
        ),
      ],
    ),
    Recipe(
      id: 'salmon',
      name: 'Pan-Seared Garlic Salmon',
      category: "Chef's Favorite • Seafood",
      categoryGroup: 'favorites',
      desc: 'Crispy skin Atlantic salmon basted with fragrant garlic, fresh lemon juice, and infused herb butter.',
      imageUrl: 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=800&auto=format&fit=crop&q=80',
      match: 'Chef Recommended',
      time: '25 min',
      level: 'Easy',
      servings: '2 Servings',
      calories: '420 kcal',
      rating: 4.9,
      isSaved: true,
      ingredients: [
        '2 fresh Atlantic salmon fillets (6 oz each)',
        '4 cloves fresh garlic, minced',
        '2 tbsp unsalted organic butter',
        '1 tbsp extra virgin olive oil',
        '1 fresh lemon (sliced & juiced)',
        'Fresh chopped parsley & sea salt flakes',
      ],
      steps: [
        const RecipeStep(
          title: 'Pat Dry & Season',
          desc: 'Thoroughly pat salmon fillets dry with paper towels to ensure a crisp sear. Season flesh side with sea salt and cracked black pepper.',
        ),
        const RecipeStep(
          title: 'Crisp the Skin',
          desc: 'Heat olive oil in a skillet over medium-high. Place salmon skin-side down and press gently for 5 minutes until crispy.',
        ),
        const RecipeStep(
          title: 'Baste with Garlic Butter',
          desc: 'Flip fillets. Drop butter, minced garlic, and lemon juice into pan. Continuously spoon foamy aromatic butter over the fillets for 3 minutes.',
        ),
        const RecipeStep(
          title: 'Rest & Garnish',
          desc: 'Transfer salmon to warm plates. Pour remaining garlic pan juices over top and garnish with chopped fresh parsley and lemon wedges.',
        ),
      ],
    ),
    Recipe(
      id: 'truffle-pasta',
      name: 'Truffle Tagliatelle Pasta',
      category: "Chef's Favorite • Artisan Italian",
      categoryGroup: 'favorites',
      desc: 'Al dente ribbons of tagliatelle tossed in a silky parmesan emulsion infused with black truffle oil and wild mushrooms.',
      imageUrl: 'assets/images/truffle_pasta.jpg',
      match: 'Chef Recommended',
      time: '20 min',
      level: 'Medium',
      servings: '2 Servings',
      calories: '520 kcal',
      rating: 4.8,
      isSaved: true,
      ingredients: [
        '250g fresh artisan tagliatelle pasta',
        '150g mixed wild mushrooms (cremini & chanterelle)',
        '2 tbsp premium black truffle oil',
        '60g freshly grated Parmigiano-Reggiano',
        '2 cloves garlic, finely sliced',
        '1/4 cup heavy cream or pasta water',
        'Fresh thyme sprigs & cracked black pepper',
      ],
      steps: [
        const RecipeStep(
          title: 'Boil Pasta',
          desc: 'Bring a large pot of heavily salted water to a rolling boil. Cook tagliatelle until 1 minute shy of al dente.',
        ),
        const RecipeStep(
          title: 'Sauté Wild Mushrooms',
          desc: 'Heat butter and olive oil in a wide pan over medium-high. Sauté mushrooms until browned and caramelized.',
        ),
        const RecipeStep(
          title: 'Emulsify Sauce',
          desc: 'Add garlic, cream, and half a ladle of pasta water. Toss the pasta vigorously with parmesan until a glossy sauce forms.',
        ),
        const RecipeStep(
          title: 'Finish with Truffle',
          desc: 'Drizzle with black truffle oil off the heat, season with fresh thyme, and serve with shaved parmesan.',
        ),
      ],
    ),
    Recipe(
      id: 'wagyu',
      name: 'Wagyu Ribeye & Roast Herbs',
      category: "Chef's Favorite • Prime Steak",
      categoryGroup: 'favorites',
      desc: 'A5 Japanese Wagyu ribeye seared with a caramelized golden crust, basted in rosemary thyme butter with charred asparagus.',
      imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&auto=format&fit=crop&q=80',
      match: 'Prime Culinary Cut',
      time: '45 min',
      level: 'Hard',
      servings: '2 Servings',
      calories: '680 kcal',
      rating: 5.0,
      isSaved: true,
      ingredients: [
        '1 prime A5 Wagyu or dry-aged ribeye steak (14 oz)',
        '3 tbsp European grass-fed butter',
        '3 sprigs fresh rosemary & 4 sprigs thyme',
        '1 whole head of garlic, halved crosswise',
        '1 bunch tender baby asparagus',
        'Coarse Maldon sea salt & freshly cracked peppercorn',
      ],
      steps: [
        const RecipeStep(
          title: 'Temper & Season',
          desc: 'Bring steak to room temperature for 30 minutes. Liberally season with coarse Maldon sea salt on all sides.',
        ),
        const RecipeStep(
          title: 'High-Heat Sear',
          desc: 'Preheat a heavy cast-iron skillet until smoking hot. Sear the ribeye undisturbed for 2-3 minutes to build a deep crust.',
        ),
        const RecipeStep(
          title: 'Aromatic Butter Basting',
          desc: 'Flip steak. Add butter, crushed garlic, rosemary, and thyme. Tilt the pan and spoon foaming butter continuously for 2 minutes.',
        ),
        const RecipeStep(
          title: 'Rest & Slice',
          desc: 'Rest on a warm carving board for 8 minutes before slicing against the grain into thick ribbons.',
        ),
      ],
    ),
    Recipe(
      id: 'lava-cake',
      name: 'Molten Chocolate Lava Cake',
      category: 'Artisan Desserts • French Patisserie',
      categoryGroup: 'desserts',
      desc: 'Decadent dark chocolate soufflé cake with a warm, flowing molten fudge center and Madagascar vanilla bean notes.',
      imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800&auto=format&fit=crop&q=80',
      match: 'Sweet Signature',
      time: '25 min',
      level: 'Medium',
      servings: '4 Servings',
      calories: '380 kcal',
      rating: 4.9,
      isSaved: true,
      ingredients: [
        '120g premium 70% Valrhona dark chocolate',
        '1/2 cup unsalted butter (melted)',
        '2 large eggs + 2 egg yolks',
        '1/4 cup granulated organic sugar',
        '2 tbsp all-purpose flour',
        '1 tsp Madagascar vanilla extract',
        'Powdered sugar & fresh raspberries for serving',
      ],
      steps: [
        const RecipeStep(
          title: 'Melt Chocolate & Butter',
          desc: 'Gently melt chopped dark chocolate and butter in a heatproof bowl set over simmering water until smooth.',
        ),
        const RecipeStep(
          title: 'Whisk Eggs & Sugar',
          desc: 'In a separate bowl, vigorously whisk eggs, yolks, sugar, and vanilla until pale and frothy.',
        ),
        const RecipeStep(
          title: 'Fold & Fill Ramekins',
          desc: 'Fold melted chocolate and flour into the eggs. Pour into buttered, cocoa-dusted ramekins.',
        ),
        const RecipeStep(
          title: 'Precision Bake',
          desc: 'Bake at 425°F (220°C) for exactly 12 minutes until edges are set and center is soft. Invert onto plates and dust with powdered sugar.',
        ),
      ],
    ),
    Recipe(
      id: 'carrot-halwa',
      name: 'Royal Gajar Ka Halwa (Carrot Halwa)',
      category: 'Artisan Desserts • Royal Indian Halwa',
      categoryGroup: 'desserts',
      desc: 'Slow-cooked tender grated Delhi carrots simmered in rich whole milk, infused with green cardamom, roasted cashews, and golden desi ghee.',
      imageUrl: 'assets/images/gajar_ka_halwa.jpg',
      match: 'Royal Indian Dessert',
      time: '35 min',
      level: 'Easy',
      servings: '4 Servings',
      calories: '390 kcal',
      rating: 4.9,
      isSaved: true,
      ingredients: [
        '500g fresh tender red carrots (peeled & finely grated)',
        '3 cups full-cream whole milk',
        '4 tbsp pure desi ghee',
        '1/2 cup organic sugar (or condensed milk)',
        '1/2 cup crumbled fresh Khoya / Mawa (or milk powder)',
        '1 tsp freshly ground green cardamom powder',
        '2 tbsp golden roasted cashews, raisins & slivered almonds',
        'Pinch of saffron strands soaked in warm milk',
      ],
      steps: [
        const RecipeStep(
          title: 'Sauté Grated Carrots in Ghee',
          desc: 'Heat 2 tbsp desi ghee in a heavy-bottomed kadai. Sauté finely grated carrots for 5 minutes on medium heat until fragrant and slightly tender.',
        ),
        const RecipeStep(
          title: 'Slow Simmer in Whole Milk',
          desc: 'Pour in 3 cups of full-cream milk and saffron. Cook on medium-low, stirring occasionally, until the milk is completely absorbed by the carrots.',
        ),
        const RecipeStep(
          title: 'Sweeten & Caramelize',
          desc: 'Add sugar and remaining 2 tbsp ghee. Cook for 8 minutes until the halwa deepens to a lustrous rich ruby-amber color.',
        ),
        const RecipeStep(
          title: 'Fold Khoya & Roasted Nuts',
          desc: 'Stir in crumbled khoya (mawa) and cardamom powder. Garnish with golden-fried cashews, pistachios, and slivered almonds. Serve warm.',
        ),
      ],
    ),
  ];

  static final List<Recipe> _customRecipes = [];

  static List<Recipe> getAllRecipes() => [..._customRecipes, ..._recipes];

  static List<Recipe> get allRecipes => [..._customRecipes, ..._recipes];

  static List<Recipe> getRecipesByCategory(String categoryGroup) {
    if (categoryGroup == 'ai') {
      return _customRecipes.where((r) => r.isSaved).toList();
    }
    return _recipes.where((r) => r.categoryGroup == categoryGroup).toList();
  }

  static Recipe? getRecipeById(String id) {
    try {
      final all = [..._customRecipes, ..._recipes];
      return all.firstWhere((r) => r.id == id);
    } catch (_) {
      return _recipes.first;
    }
  }

  static List<Recipe> getSavedRecipes() {
    final customSaved = _customRecipes.where((r) => r.isSaved).toList();
    final defaultSaved = _recipes.where((r) => r.isSaved).toList();
    return [...customSaved, ...defaultSaved];
  }

  static bool isRecipeSaved(Recipe recipe) {
    if (_recipes.any((r) => r.id == recipe.id)) {
      return _recipes.firstWhere((r) => r.id == recipe.id).isSaved;
    }
    final match = _customRecipes.where((r) => r.id == recipe.id || r.name.toLowerCase() == recipe.name.toLowerCase());
    if (match.isNotEmpty) {
      return match.first.isSaved;
    }
    return recipe.isSaved;
  }

  static void toggleSaveRecipe(Recipe recipe) {
    final defaultIndex = _recipes.indexWhere((r) => r.id == recipe.id);
    if (defaultIndex >= 0) {
      _recipes[defaultIndex].isSaved = !_recipes[defaultIndex].isSaved;
      recipe.isSaved = _recipes[defaultIndex].isSaved;
      return;
    }

    final customIndex = _customRecipes.indexWhere((r) => r.id == recipe.id || r.name.toLowerCase() == recipe.name.toLowerCase());
    if (customIndex >= 0) {
      _customRecipes[customIndex].isSaved = !_customRecipes[customIndex].isSaved;
      recipe.isSaved = _customRecipes[customIndex].isSaved;
    } else {
      recipe.isSaved = true;
      _customRecipes.insert(0, recipe);
    }
  }

  static void toggleSave(String id) {
    final recipe = getRecipeById(id);
    if (recipe != null) {
      toggleSaveRecipe(recipe);
    }
  }
}
