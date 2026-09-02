import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../data/models/recipe_model.dart';
import '../../data/repositories/recipe_repository.dart';
import '../../theme/app_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(int)? onTabChange;

  const HomeScreen({super.key, this.onTabChange});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const String _geminiApiKey = String.fromEnvironment('GEMINI_API_KEY', defaultValue: 'AIzaSyDemoKeyFallback');

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToDetail(Recipe recipe) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RecipeDetailScreen(recipe: recipe),
      ),
    );
  }

  String _getImageForDish(String dishName, {String category = '', List<String> ingredients = const []}) {
    final text = ('$dishName $category ${ingredients.join(' ')}').toLowerCase();
    
    // Indian & Tandoori Specialties
    if (text.contains('paneer') || text.contains('tikka') || text.contains('cottage cheese')) {
      return 'https://images.unsplash.com/photo-1567184109191-37764e7fadd9?w=800&auto=format&fit=crop&q=80';
    }
    if (text.contains('butter chicken') || text.contains('makhani') || text.contains('tikka masala') || text.contains('chicken curry') || text.contains('korma')) {
      return 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=800&auto=format&fit=crop&q=80';
    }
    if (text.contains('biryani') || text.contains('pulao') || text.contains('fried rice') || text.contains('basmati')) {
      return 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=800&auto=format&fit=crop&q=80';
    }
    if (text.contains('tandoori') || text.contains('kebab') || text.contains('seekh') || text.contains('roast chicken') || text.contains('grilled chicken')) {
      return 'https://images.unsplash.com/photo-1599488615731-7e5c2823ff28?w=800&auto=format&fit=crop&q=80';
    }
    if (text.contains('dal') || text.contains('lentil') || text.contains('chana') || text.contains('curry') || text.contains('sambar')) {
      return 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800&auto=format&fit=crop&q=80';
    }
    if (text.contains('halwa') || text.contains('gajar') || text.contains('carrot halwa') || text.contains('gulab jamun') || text.contains('kheer')) {
      return 'https://images.unsplash.com/photo-1579372786545-d24232daf58c?w=800&auto=format&fit=crop&q=80';
    }

    // Pastas & Italian
    if (text.contains('pasta') || text.contains('tagliatelle') || text.contains('spaghetti') || text.contains('carbonara') || text.contains('fettuccine') || text.contains('penne') || text.contains('lasagna') || text.contains('alfredo') || text.contains('macaroni')) {
      return 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=800&auto=format&fit=crop&q=80';
    }
    if (text.contains('pizza') || text.contains('flatbread') || text.contains('focaccia') || text.contains('calzone')) {
      return 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800&auto=format&fit=crop&q=80';
    }
    if (text.contains('risotto') || text.contains('mushroom') || text.contains('truffle')) {
      return 'https://images.unsplash.com/photo-1633964913295-ceb43826e7c9?w=800&auto=format&fit=crop&q=80';
    }

    // Seafood & Meats
    if (text.contains('salmon') || text.contains('fish') || text.contains('trout') || text.contains('cod') || text.contains('tuna') || text.contains('halibut')) {
      return 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=800&auto=format&fit=crop&q=80';
    }
    if (text.contains('prawn') || text.contains('shrimp') || text.contains('lobster') || text.contains('crab') || text.contains('calamari')) {
      return 'https://images.unsplash.com/photo-1559742811-822873691df8?w=800&auto=format&fit=crop&q=80';
    }
    if (text.contains('steak') || text.contains('beef') || text.contains('ribeye') || text.contains('tenderloin') || text.contains('lamb') || text.contains('mutton')) {
      return 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&auto=format&fit=crop&q=80';
    }
    if (text.contains('burger') || text.contains('sandwich') || text.contains('wrap') || text.contains('sub')) {
      return 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800&auto=format&fit=crop&q=80';
    }
    if (text.contains('taco') || text.contains('burrito') || text.contains('fajita') || text.contains('quesadilla') || text.contains('mexican')) {
      return 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=800&auto=format&fit=crop&q=80';
    }

    // Asian Noodles & Stir Fries
    if (text.contains('noodle') || text.contains('ramen') || text.contains('pad thai') || text.contains('chow mein') || text.contains('udon') || text.contains('soba') || text.contains('stir fry')) {
      return 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800&auto=format&fit=crop&q=80';
    }
    if (text.contains('soup') || text.contains('broth') || text.contains('chowder') || text.contains('stew')) {
      return 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800&auto=format&fit=crop&q=80';
    }
    if (text.contains('salad') || text.contains('bowl') || text.contains('avocado') || text.contains('quinoa') || text.contains('caesar')) {
      return 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&auto=format&fit=crop&q=80';
    }
    if (text.contains('egg') || text.contains('omelet') || text.contains('shakshuka') || text.contains('scramble') || text.contains('breakfast')) {
      return 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800&auto=format&fit=crop&q=80';
    }

    // Desserts & Bakery
    if (text.contains('chocolate') || text.contains('brownie') || text.contains('fudge') || text.contains('lava cake')) {
      return 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800&auto=format&fit=crop&q=80';
    }
    if (text.contains('cheesecake') || text.contains('tiramisu') || text.contains('pudding') || text.contains('pancake') || text.contains('waffle') || text.contains('dessert') || text.contains('ice cream')) {
      return 'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=800&auto=format&fit=crop&q=80';
    }

    // High Quality Gourmet Food Fallback
    return 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&auto=format&fit=crop&q=80';
  }

  Future<void> _searchAndGenerateDish() async {
    final dishName = _searchController.text.trim();
    if (dishName.isEmpty) return;

    // Show Loading Modal
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: GlassContainer(
              padding: const EdgeInsets.all(24),
              borderRadius: 24,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [AppColors.primaryContainer, Color(0xFFFF9933)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryContainer.withOpacity(0.4),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'GEMINI AI CHEF',
                    style: GoogleFonts.montserrat(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                      color: AppColors.primaryLight,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Crafting "$dishName"...',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Formulating authentic ingredients and step-by-step cooking guide.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const LinearProgressIndicator(
                    backgroundColor: AppColors.surfaceContainer,
                    color: AppColors.primaryContainer,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    final prompt = '''
You are a talented, practical chef who creates delicious, authentic, and easy-to-follow recipes.
Create a mouth-watering, authentic, and realistic recipe for this dish: "$dishName".

Rules:
1. Dish Name: Keep the name simple, authentic, and natural (e.g. "Classic Restaurant-Style Paneer Tikka", "Creamy Butter Chicken", "Authentic Hyderabadi Chicken Biryani", "Classic Spaghetti Carbonara"). DO NOT make it overly fancy, pretentious, or use obscure French/Michelin culinary jargon.
2. Description: A short, appetizing 2-sentence summary explaining why this dish is loved and what makes it delicious.
3. Visual Prompt: A detailed 1-sentence description for generating a realistic, mouth-watering gourmet food photo of this exact finished dish.
4. Ingredients: Everyday practical ingredients with clear standard measurements (e.g. "250g Paneer, cut into cubes", "2 tbsp Ghee", "1 tsp Kashmiri red chili powder").
5. Steps: Simple, clear, numbered step-by-step cooking instructions that anyone can easily cook at home.
6. Stats: Realistic cook time (e.g. "30 min"), level ("Easy" or "Medium"), servings ("2-3 Servings"), and calories (e.g. "420 kcal").

Return ONLY a single valid JSON object without markdown formatting, code fences, or extra text:
{
  "name": "Natural Delicious Dish Name",
  "category": "Cuisine / Style Category",
  "desc": "Short appetizing description.",
  "visualPrompt": "Delicious appetizing restaurant food photo of [Dish Name] garnished with fresh herbs on a plate",
  "match": "✦ Gemini AI Recipe",
  "time": "25 min",
  "level": "Easy",
  "servings": "2 Servings",
  "calories": "420 kcal",
  "ingredients": [
    "Quantity + Ingredient name"
  ],
  "steps": [
    {
      "title": "Clear Actionable Step Title",
      "desc": "Simple, straightforward cooking step."
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
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash:generateContent?key=$_geminiApiKey',
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent?key=$_geminiApiKey',
    ];

    String? lastError;
    Recipe? generatedRecipe;

    for (final url in endpoints) {
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: requestBody,
        );

        if (response.statusCode != 200) {
          lastError = 'HTTP ${response.statusCode}';
          continue;
        }

        final data = jsonDecode(response.body);
        final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'] as String?;
        if (text == null || text.isEmpty) {
          throw Exception('Empty response from Gemini');
        }

        final cleanJson = text.replaceAll(RegExp(r'^```json\s*', caseSensitive: false), '').replaceAll(RegExp(r'\s*```$'), '').trim();
        final recipeMap = jsonDecode(cleanJson) as Map<String, dynamic>;

        final stepsRaw = recipeMap['steps'] as List<dynamic>? ?? [];
        final steps = stepsRaw.map((s) {
          if (s is String) {
            return RecipeStep(
              title: 'Instruction',
              desc: s,
            );
          }
          final sm = s as Map<String, dynamic>;
          return RecipeStep(
            title: sm['title'] ?? 'Instruction',
            desc: sm['desc'] ?? '',
          );
        }).toList();

        final ingRaw = recipeMap['ingredients'] as List<dynamic>? ?? [];
        final ingredients = ingRaw.map((i) => i.toString()).toList();

        final dishFinalName = recipeMap['name'] ?? dishName;
        final dishCategory = recipeMap['category'] ?? 'Gemini AI Recipe';

        final visualDesc = recipeMap['visualPrompt'] as String? ?? 'Delicious gourmet plate of $dishFinalName, appetizing restaurant plating, professional food photography';
        final seed = (DateTime.now().millisecondsSinceEpoch) % 900000;
        final aiImageUrl = 'https://image.pollinations.ai/prompt/${Uri.encodeComponent(visualDesc)}?width=800&height=600&nologo=true&seed=$seed';

        generatedRecipe = Recipe(
          id: 'ai-custom-${DateTime.now().millisecondsSinceEpoch}',
          name: dishFinalName,
          category: dishCategory,
          categoryGroup: 'favorites',
          desc: recipeMap['desc'] ?? 'A delicious recipe crafted by Gemini AI.',
          imageUrl: aiImageUrl,
          rating: 5.0,
          time: recipeMap['time'] ?? '25 min',
          level: recipeMap['level'] ?? 'Easy',
          servings: recipeMap['servings'] ?? '2 Servings',
          calories: recipeMap['calories'] ?? '420 kcal',
          match: '✦ Gemini AI Recipe',
          ingredients: ingredients,
          steps: steps,
        );

        break;
      } catch (e) {
        lastError = e.toString();
      }
    }

    if (mounted && Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    if (generatedRecipe != null && mounted) {
      _navigateToDetail(generatedRecipe);
    } else if (mounted) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppColors.surfaceContainer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              const Icon(Icons.error_outline_rounded, color: Colors.redAccent),
              const SizedBox(width: 8),
              Text(
                'Generation Notice',
                style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          content: Text(
            'Could not formulate recipe for "$dishName". Please check your connection and try again.\n\n$lastError',
            style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary, fontSize: 12),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK', style: TextStyle(color: AppColors.primaryContainer, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryContainer, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalCarousel(List<Recipe> recipes) {
    final filtered = recipes.where((r) {
      if (_searchQuery.isEmpty) return true;
      return r.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          r.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          r.desc.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    if (filtered.isEmpty) {
      return Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.center,
        child: Text(
          'Press Enter or Search button to generate "$_searchQuery" with Gemini AI!',
          style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.primaryLight),
          textAlign: TextAlign.center,
        ),
      );
    }

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final recipe = filtered[index];
          return RecipeCard(
            recipe: recipe,
            onTap: () => _navigateToDetail(recipe),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final indianRecipes = RecipeRepository.getRecipesByCategory('indian');
    final favoriteRecipes = RecipeRepository.getRecipesByCategory('favorites');
    final dessertRecipes = RecipeRepository.getRecipesByCategory('desserts');

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                            Icons.local_fire_department_rounded,
                            color: AppColors.primaryContainer,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AiChef Luxury',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'CULINARY STUDIO',
                              style: GoogleFonts.montserrat(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                                color: AppColors.primaryLight,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.glassBackground,
                            border: Border.all(color: AppColors.glassBorder),
                          ),
                          child: const Icon(
                            Icons.notifications_none_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primaryContainer, width: 1.5),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop&q=80',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Hero Greeting & Title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryContainer,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'AI CULINARY ENGINE',
                          style: GoogleFonts.montserrat(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            color: AppColors.primaryLight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'What will you cook today?',
                      style: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar with Integrated Clear (✕) and Search Buttons
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: GlassContainer(
                  padding: const EdgeInsets.fromLTRB(14, 2, 4, 2),
                  borderRadius: 24,
                  borderColor: AppColors.glassBorder,
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded, color: AppColors.primaryContainer, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          cursorColor: AppColors.primaryContainer,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          onChanged: (val) {
                            setState(() {
                              _searchQuery = val;
                            });
                          },
                          onSubmitted: (_) => _searchAndGenerateDish(),
                          decoration: InputDecoration(
                            hintText: 'Search dish (e.g. Paneer Tikka, Butter Chicken)...',
                            hintStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              color: AppColors.textSecondary.withOpacity(0.7),
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      
                      // Clear (✕) Button
                      if (_searchQuery.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            margin: const EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              color: AppColors.textSecondary,
                              size: 16,
                            ),
                          ),
                        ),

                      // Search Action Button
                      GestureDetector(
                        onTap: _searchAndGenerateDish,
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryContainer,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryContainer.withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.search_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Section 1: Indian Food
            SliverToBoxAdapter(
              child: _buildSectionHeader(
                icon: Icons.dinner_dining_rounded,
                title: 'Indian Food',
                subtitle: 'Aromatic & Rich',
              ),
            ),
            SliverToBoxAdapter(
              child: _buildHorizontalCarousel(indianRecipes),
            ),

            // Section 2: All-Time Favorites
            SliverToBoxAdapter(
              child: const SizedBox(height: 12),
            ),
            SliverToBoxAdapter(
              child: _buildSectionHeader(
                icon: Icons.star_rounded,
                title: 'All-Time Favorites',
                subtitle: 'Gourmet Classics',
              ),
            ),
            SliverToBoxAdapter(
              child: _buildHorizontalCarousel(favoriteRecipes),
            ),

            // Section 3: Artisan Desserts
            SliverToBoxAdapter(
              child: const SizedBox(height: 12),
            ),
            SliverToBoxAdapter(
              child: _buildSectionHeader(
                icon: Icons.cake_rounded,
                title: 'Artisan Desserts',
                subtitle: 'Sweet Creations',
              ),
            ),
            SliverToBoxAdapter(
              child: _buildHorizontalCarousel(dessertRecipes),
            ),

            // Bottom Spacing
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
    );
  }
}
