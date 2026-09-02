import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../data/models/recipe_model.dart';
import '../../theme/app_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/glow_button.dart';
import 'recipe_detail_screen.dart';

class CookScreen extends StatefulWidget {
  const CookScreen({super.key});

  @override
  State<CookScreen> createState() => _CookScreenState();
}

class _CookScreenState extends State<CookScreen> {
  final TextEditingController _ingredientController = TextEditingController();
  final List<String> _selectedIngredients = [
    'Paneer',
    'Capsicum',
    'Onion',
  ];

  final List<String> _popularSuggestions = [
    'Butter',
    'Tomatoes',
    'Garlic',
    'Chicken Breast',
    'Mushrooms',
    'Basmati Rice',
    'Salmon',
    'Dark Chocolate',
  ];

  static const String _geminiApiKey = String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');

  List<Recipe> _generatedDishes = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }

  void _addIngredient() {
    final text = _ingredientController.text.trim();
    if (text.isNotEmpty && !_selectedIngredients.contains(text)) {
      setState(() {
        _selectedIngredients.add(text);
        _ingredientController.clear();
      });
    }
  }

  void _removeIngredient(String item) {
    setState(() {
      _selectedIngredients.remove(item);
    });
  }

  static const Map<String, String> _culinaryMap = {
    'paneer tikka': 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=800&auto=format&fit=crop&q=80',
    'kadai paneer': 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Paneer_tikka.jpg/640px-Paneer_tikka.jpg',
    'paneer bhurji': 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800&auto=format&fit=crop&q=80',
    'palak paneer': 'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=800&auto=format&fit=crop&q=80',
    'matar paneer': 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800&auto=format&fit=crop&q=80',
    'butter chicken': 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=800&auto=format&fit=crop&q=80',
    'chicken curry': 'https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?w=800&auto=format&fit=crop&q=80',
    'chicken biryani': 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=800&auto=format&fit=crop&q=80',
    'biryani': 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=800&auto=format&fit=crop&q=80',
    'dal makhani': 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800&auto=format&fit=crop&q=80',
    'dal tadka': 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800&auto=format&fit=crop&q=80',
    'chole': 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800&auto=format&fit=crop&q=80',
    'rajma': 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800&auto=format&fit=crop&q=80',
    'pav bhaji': 'https://images.unsplash.com/photo-1606491956689-2ea866880c84?w=800&auto=format&fit=crop&q=80',
    'dosa': 'https://images.unsplash.com/photo-1668236543090-82eba5ee5976?w=800&auto=format&fit=crop&q=80',
    'idli': 'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=800&auto=format&fit=crop&q=80',
    'fried rice': 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800&auto=format&fit=crop&q=80',
    'noodles': 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800&auto=format&fit=crop&q=80',
    'pasta': 'assets/images/truffle_pasta.jpg',
    'truffle pasta': 'assets/images/truffle_pasta.jpg',
    'carbonara': 'https://images.unsplash.com/photo-1612874742237-6526221588e3?w=800&auto=format&fit=crop&q=80',
    'salmon': 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=800&auto=format&fit=crop&q=80',
    'steak': 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&auto=format&fit=crop&q=80',
    'lava cake': 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800&auto=format&fit=crop&q=80',
    'halwa': 'assets/images/gajar_ka_halwa.jpg',
    'gajar ka halwa': 'assets/images/gajar_ka_halwa.jpg',
    'shakshuka': 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800&auto=format&fit=crop&q=80',
    'pizza': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800&auto=format&fit=crop&q=80',
  };

  String _getAccurateImageForDish(String dishName) {
    final clean = dishName.toLowerCase().trim();
    for (final entry in _culinaryMap.entries) {
      if (clean.contains(entry.key)) {
        return entry.value;
      }
    }
    if (clean.contains('paneer')) return _culinaryMap['paneer tikka']!;
    if (clean.contains('chicken')) return _culinaryMap['butter chicken']!;
    if (clean.contains('biryani') || clean.contains('rice')) return _culinaryMap['biryani']!;
    if (clean.contains('pasta') || clean.contains('noodle')) return _culinaryMap['pasta']!;
    if (clean.contains('salmon') || clean.contains('fish')) return _culinaryMap['salmon']!;
    if (clean.contains('cake') || clean.contains('dessert')) return _culinaryMap['lava cake']!;

    return 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&auto=format&fit=crop&q=80';
  }

  Future<void> _generateDishes() async {
    if (_selectedIngredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.surfaceContainer,
          content: Text('Please add at least 1 ingredient.', style: TextStyle(color: Colors.white)),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final ingredientsList = _selectedIngredients.join(', ');
    final prompt = '''
You are an expert chef who suggests practical and delicious recipes based on available pantry items.
Given the user's available ingredients: $ingredientsList.

Suggest 3 to 4 realistic, appetizing dishes that can be cooked using these ingredients.
Rules:
1. Dish Names: Natural, authentic, and delicious (e.g., "Kadai Paneer", "Paneer Bhurji", "Paneer Capsicum Stir Fry", "Tawa Paneer Tikka").
2. Match Percentage: Give a realistic pantry match percentage between 80% and 98%.
3. Instructions: Provide practical ingredients with standard quantities and numbered step-by-step instructions.

Return ONLY a single valid JSON object without markdown code blocks:
{
  "dishes": [
    {
      "name": "Authentic Dish Name",
      "category": "Cuisine Category",
      "desc": "Short 2-sentence appetizing description.",
      "match": "95% Pantry Match",
      "time": "25 min",
      "level": "Easy",
      "servings": "2-3 Servings",
      "calories": "380 kcal",
      "ingredients": ["Quantity + Ingredient name"],
      "steps": [{"title": "Step Title", "desc": "Step description"}]
    }
  ]
}
''';

    final requestBody = jsonEncode({
      'contents': [
        {
          'parts': [
            {'text': prompt}
          ]
        }
      ],
      'generationConfig': {
        'responseMimeType': 'application/json',
      }
    });

    final endpoints = [
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-3.6-flash:generateContent?key=$_geminiApiKey',
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-3.7-flash:generateContent?key=$_geminiApiKey',
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent?key=$_geminiApiKey',
    ];

    List<Recipe> dishes = [];

    for (final url in endpoints) {
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: requestBody,
        );

        if (response.statusCode != 200) {
          continue;
        }

        final data = jsonDecode(response.body);
        final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'] as String?;
        if (text == null || text.isEmpty) continue;

        final cleanJson = text.replaceAll(RegExp(r'^```json\s*', caseSensitive: false), '').replaceAll(RegExp(r'\s*```$'), '').trim();
        final parsed = jsonDecode(cleanJson);

        final dishesRaw = (parsed is Map && parsed['dishes'] is List) ? parsed['dishes'] as List : (parsed is List ? parsed : [parsed]);

        dishes = dishesRaw.map((d) {
          final dm = d as Map<String, dynamic>;
          final dishName = dm['name'] ?? 'Custom Creation';
          final stepsRaw = dm['steps'] as List<dynamic>? ?? [];
          final steps = stepsRaw.map((s) {
            if (s is String) return RecipeStep(title: 'Instruction', desc: s);
            final sm = s as Map<String, dynamic>;
            return RecipeStep(title: sm['title'] ?? 'Instruction', desc: sm['desc'] ?? '');
          }).toList();

          final ingRaw = dm['ingredients'] as List<dynamic>? ?? [];
          final ingredients = ingRaw.map((i) => i.toString()).toList();

          return Recipe(
            id: 'ai-custom-${DateTime.now().millisecondsSinceEpoch}-${dishes.length}',
            name: dishName,
            category: dm['category'] ?? 'Pantry Creation',
            categoryGroup: 'ai',
            desc: dm['desc'] ?? 'A delicious dish crafted from your pantry.',
            imageUrl: _getAccurateImageForDish(dishName),
            rating: 5.0,
            time: dm['time'] ?? '25 min',
            level: dm['level'] ?? 'Easy',
            servings: dm['servings'] ?? '2-3 Servings',
            calories: dm['calories'] ?? '380 kcal',
            match: dm['match'] ?? '90% Match',
            ingredients: ingredients,
            steps: steps,
          );
        }).toList();

        break;
      } catch (e) {
        // Try next endpoint
      }
    }

    if (dishes.isEmpty) {
      final primary = _selectedIngredients.isNotEmpty ? _selectedIngredients.first : 'Pantry Special';
      dishes = [
        Recipe(
          id: 'ai-custom-${DateTime.now().millisecondsSinceEpoch}-0',
          name: 'Classic Sautéed $primary Medley',
          category: 'Quick Pantry Stir-Fry',
          categoryGroup: 'ai',
          desc: 'A vibrant pan-seared dish highlighting ${_selectedIngredients.join(', ')}.',
          imageUrl: _getAccurateImageForDish(primary),
          rating: 4.9,
          time: '20 min',
          level: 'Easy',
          servings: '2 Servings',
          calories: '340 kcal',
          match: '95% Pantry Match',
          ingredients: _selectedIngredients.map((i) => 'Fresh $i (to taste)').toList()..addAll(['2 tbsp Butter/Oil', '1/2 tsp Salt & Pepper']),
          steps: [
            const RecipeStep(title: 'Prep Items', desc: 'Chop all selected pantry items evenly.'),
            const RecipeStep(title: 'Sauté in Pan', desc: 'Heat butter or oil over medium heat. Sauté until tender and golden.'),
            const RecipeStep(title: 'Season & Serve', desc: 'Season to taste and serve immediately while hot.')
          ],
        ),
        Recipe(
          id: 'ai-custom-${DateTime.now().millisecondsSinceEpoch}-1',
          name: 'Homestyle Spiced $primary Curry',
          category: 'Comfort Cuisine',
          categoryGroup: 'ai',
          desc: 'Rich, warming gravy simmered with ${_selectedIngredients.join(', ')} and spices.',
          imageUrl: _getAccurateImageForDish('$primary curry'),
          rating: 4.8,
          time: '25 min',
          level: 'Easy',
          servings: '2-3 Servings',
          calories: '390 kcal',
          match: '91% Pantry Match',
          ingredients: _selectedIngredients.map((i) => '200g $i').toList()..addAll(['1 tsp Cumin & Turmeric', '1/2 cup Cream or Water']),
          steps: [
            const RecipeStep(title: 'Temper Spices', desc: 'Heat ghee or oil and temper aromatics.'),
            const RecipeStep(title: 'Simmer', desc: 'Add ingredients, pour gravy base, and simmer for 10 minutes.')
          ],
        ),
      ];
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
        _generatedDishes = dishes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Top App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryContainer.withOpacity(0.2),
                        border: Border.all(color: AppColors.primaryContainer.withOpacity(0.5)),
                      ),
                      child: const Icon(
                        Icons.kitchen_rounded,
                        color: AppColors.primaryContainer,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Pantry Cook',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Header Hero
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.tune_rounded, size: 14, color: AppColors.primaryContainer),
                        const SizedBox(width: 4),
                        Text(
                          'AI PANTRY ENGINE',
                          style: GoogleFonts.montserrat(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                            color: AppColors.primaryLight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "What's in your kitchen?",
                      style: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Add ingredients. Gemini AI will suggest multiple delicious dishes you can make right now!',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Selected Ingredients Box
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GlassContainer(
                  borderRadius: 18,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.checklist_rounded, size: 16, color: AppColors.primaryContainer),
                              const SizedBox(width: 6),
                              Text(
                                'SELECTED INGREDIENTS',
                                style: GoogleFonts.montserrat(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.primaryContainer.withOpacity(0.3)),
                            ),
                            child: Text(
                              '${_selectedIngredients.length} items',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Tag Pills
                      Container(
                        constraints: const BoxConstraints(minHeight: 50),
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.canvasBackground.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.glassBorder),
                        ),
                        child: _selectedIngredients.isEmpty
                            ? Center(
                                child: Text(
                                  'Add ingredients from your kitchen below...',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    color: AppColors.textSecondary.withOpacity(0.6),
                                  ),
                                ),
                              )
                            : Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: _selectedIngredients.map((ing) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryContainer.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: AppColors.primaryContainer.withOpacity(0.5)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          ing,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        GestureDetector(
                                          onTap: () => _removeIngredient(ing),
                                          child: const Icon(
                                            Icons.close_rounded,
                                            size: 14,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                      ),
                      const SizedBox(height: 12),

                      // Input bar
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _ingredientController,
                              style: GoogleFonts.plusJakartaSans(fontSize: 13, color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Type ingredient...',
                                hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary, fontSize: 12),
                                isDense: true,
                                filled: true,
                                fillColor: AppColors.surfaceContainer,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: AppColors.glassBorder),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: AppColors.glassBorder),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: AppColors.primaryContainer),
                                ),
                              ),
                              onSubmitted: (_) => _addIngredient(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _addIngredient,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryContainer,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(
                              'Add',
                              style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Quick Add Chips
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'QUICK ADD PANTRY FAVORITES',
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                        color: AppColors.primaryLight,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: _popularSuggestions.map((item) {
                        return GestureDetector(
                          onTap: () {
                            if (!_selectedIngredients.contains(item)) {
                              setState(() {
                                _selectedIngredients.add(item);
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.glassBackground,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.glassBorder),
                            ),
                            child: Text(
                              '+ $item',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            // Find Matching Dishes Button
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 14),
                child: GlowButton(
                  text: _isLoading ? 'Analyzing Pantry...' : 'Find Matching Dishes',
                  icon: Icons.auto_awesome_rounded,
                  onPressed: _isLoading ? () {} : _generateDishes,
                ),
              ),
            ),

            // AI Dishes Suggestions List (Multi-Dish Results)
            if (_generatedDishes.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dishes You Can Make',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${_generatedDishes.length} Options',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: AppColors.primaryLight,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ..._generatedDishes.map((dish) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: GlassContainer(
                            borderRadius: 16,
                            padding: const EdgeInsets.all(10),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetailScreen(recipe: dish),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    dish.imageUrl,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 80,
                                      height: 80,
                                      color: AppColors.surfaceContainer,
                                      child: const Icon(Icons.restaurant, color: AppColors.textSecondary),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryContainer.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          dish.match,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.primaryContainer,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        dish.name,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        dish.desc,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 10,
                                          color: AppColors.textSecondary,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.schedule_rounded, size: 11, color: AppColors.primaryContainer),
                                              const SizedBox(width: 3),
                                              Text(
                                                dish.time,
                                                style: GoogleFonts.plusJakartaSans(fontSize: 10, color: AppColors.textSecondary),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Cook This',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.primaryContainer,
                                                ),
                                              ),
                                              const Icon(Icons.arrow_forward_ios_rounded, size: 9, color: AppColors.primaryContainer),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
    );
  }
}
