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
    'Chicken Breast',
    'Heavy Cream',
    'Butter',
    'Garam Masala',
  ];

  final List<String> _popularSuggestions = [
    'Paneer',
    'Salmon',
    'Mushrooms',
    'Wagyu',
    'Basmati Rice',
    'Carrots',
    'Dark Chocolate',
  ];

  static const String _geminiApiKey = String.fromEnvironment('GEMINI_API_KEY', defaultValue: 'AIzaSyDemoKeyFallback');

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

  Future<void> _generateRecipe() async {
    if (_selectedIngredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.surfaceContainer,
          content: Text('Please add at least 1 ingredient.', style: TextStyle(color: Colors.white)),
        ),
      );
      return;
    }

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
                  // Animated Pulsing Icon
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
                    'Formulating Bespoke Recipe...',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Analyzing ingredients, flavor profiles, and generating Michelin-level culinary steps.',
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

    final ingredientsList = _selectedIngredients.join(', ');
    final prompt = '''
You are a talented, practical chef who creates delicious, authentic, and easy-to-follow recipes.
Create a mouth-watering, realistic recipe based on the user's input ingredients/dish request: $ingredientsList.

Rules:
1. Dish Name: Keep the name simple, authentic, and natural (e.g. "Classic Restaurant-Style Paneer Tikka", "Creamy Garlic Butter Salmon", "Homestyle Butter Chicken", "Easy Truffle Mushroom Pasta"). DO NOT make it overly fancy, pretentious, or use obscure French/Michelin culinary jargon.
2. Description: A short, appetizing 2-sentence summary explaining why it tastes great and what to expect.
3. Visual Prompt: A detailed 1-sentence description for generating a realistic, mouth-watering gourmet food photo of this exact finished dish.
4. Ingredients: Everyday practical ingredients with clear standard measurements (e.g. "250g Paneer, cubed", "2 tbsp Olive oil", "1 tsp Cumin powder").
5. Steps: Simple, clear, numbered step-by-step instructions that anyone can easily cook at home.
6. Stats: Realistic cook time (e.g. "25 min"), level ("Easy" or "Medium"), servings ("2-3 Servings"), and calories (e.g. "380 kcal").

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
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$_geminiApiKey',
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
          lastError = 'HTTP ${response.statusCode}: ${response.body}';
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
          final sm = s as Map<String, dynamic>;
          return RecipeStep(
            title: sm['title'] ?? 'Instruction',
            desc: sm['desc'] ?? '',
          );
        }).toList();

        final ingRaw = recipeMap['ingredients'] as List<dynamic>? ?? [];
        final ingredients = ingRaw.map((i) => i.toString()).toList();

        final dishFinalName = recipeMap['name'] ?? 'Gemini Custom Creation';
        final dishCategory = recipeMap['category'] ?? 'Gemini AI Recipe';

        final visualDesc = recipeMap['visualPrompt'] as String? ?? 'Delicious gourmet plate of $dishFinalName with ${ingredients.take(3).join(', ')}, appetizing restaurant plating, professional food photography';
        final seed = (DateTime.now().millisecondsSinceEpoch) % 900000;
        final aiImageUrl = 'https://image.pollinations.ai/prompt/${Uri.encodeComponent(visualDesc)}?width=800&height=600&nologo=true&seed=$seed';

        generatedRecipe = Recipe(
          id: 'ai-custom-${DateTime.now().millisecondsSinceEpoch}',
          name: dishFinalName,
          category: dishCategory,
          categoryGroup: 'favorites',
          desc: recipeMap['desc'] ?? 'A bespoke recipe crafted by Gemini AI.',
          imageUrl: aiImageUrl,
          rating: 5.0,
          time: recipeMap['time'] ?? '25 min',
          level: recipeMap['level'] ?? 'Easy',
          servings: recipeMap['servings'] ?? '2 Servings',
          calories: recipeMap['calories'] ?? '420 kcal',
          match: '✦ 100% Gemini AI Formulated',
          ingredients: ingredients,
          steps: steps,
        );

        break; // Success!
      } catch (e) {
        lastError = e.toString();
      }
    }

    // Dismiss loading dialog
    if (mounted && Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    if (generatedRecipe != null && mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RecipeDetailScreen(recipe: generatedRecipe!),
        ),
      );
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
                'Generation Failed',
                style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          content: Text(
            'Failed to connect to Gemini API. Please check your internet connection and try again.\n\nDetails: $lastError',
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
                    const SizedBox(width: 10),
                    Text(
                      'AI Recipe Engine',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Header Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                          'SMART PANTRY MATCH',
                          style: GoogleFonts.montserrat(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                            color: AppColors.primaryLight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Ingredient Engine',
                      style: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Select or type ingredients you have, and let Gemini AI formulate your bespoke recipe.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Ingredient Engine Box
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: GlassContainer(
                  padding: const EdgeInsets.all(16.0),
                  borderRadius: 18,
                  borderColor: AppColors.primaryContainer.withOpacity(0.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Active Tag List
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'CURRENT INGREDIENTS',
                            style: GoogleFonts.montserrat(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                              color: AppColors.primaryLight,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${_selectedIngredients.length} Added',
                              style: GoogleFonts.montserrat(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Selected Chips Wrap
                      _selectedIngredients.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'No ingredients added yet. Add some below!',
                                style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary),
                              ),
                            )
                          : Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _selectedIngredients.map((item) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryContainer.withOpacity(0.18),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppColors.primaryContainer.withOpacity(0.4),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        item,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      GestureDetector(
                                        onTap: () => _removeIngredient(item),
                                        child: const Icon(
                                          Icons.close_rounded,
                                          size: 14,
                                          color: AppColors.primaryLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),

                      const SizedBox(height: 16),
                      const Divider(color: AppColors.glassBorder, height: 1),
                      const SizedBox(height: 12),

                      // High Contrast Input Bar
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: AppColors.canvasBackground,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.primaryContainer.withOpacity(0.5),
                                  width: 1.2,
                                ),
                              ),
                              child: TextField(
                                controller: _ingredientController,
                                cursorColor: AppColors.primaryContainer,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                onSubmitted: (_) => _addIngredient(),
                                decoration: InputDecoration(
                                  hintText: 'Type ingredient (e.g. Saffron, Paneer)...',
                                  hintStyle: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    color: AppColors.textSecondary.withOpacity(0.6),
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: _addIngredient,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.primaryContainer,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryContainer.withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.add_rounded, size: 16, color: Colors.white),
                                  const SizedBox(width: 2),
                                  Text(
                                    'Add',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
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

            // Generate Button
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                child: GlowButton(
                  text: 'Generate AI Recipe',
                  icon: Icons.auto_awesome_rounded,
                  onPressed: _generateRecipe,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
