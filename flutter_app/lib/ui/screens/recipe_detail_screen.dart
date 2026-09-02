import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/recipe_model.dart';
import '../../data/repositories/recipe_repository.dart';
import '../../theme/app_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/glow_button.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late Set<int> _checkedIngredients;
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _checkedIngredients = {};
    _isSaved = RecipeRepository.isRecipeSaved(widget.recipe);
  }

  void _toggleSave() {
    setState(() {
      RecipeRepository.toggleSaveRecipe(widget.recipe);
      _isSaved = RecipeRepository.isRecipeSaved(widget.recipe);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.surfaceContainer,
        content: Text(
          _isSaved ? 'Saved to your Cookbook!' : 'Removed from Cookbook',
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildHeroImage(String path) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        width: double.infinity,
        height: 280,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: AppColors.surfaceContainer,
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.primaryContainer),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => Container(
          color: AppColors.surfaceContainer,
          child: const Icon(Icons.restaurant, color: AppColors.textSecondary, size: 40),
        ),
      );
    } else {
      return Image.asset(
        path,
        width: double.infinity,
        height: 280,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: AppColors.surfaceContainer,
          child: const Icon(Icons.restaurant, color: AppColors.textSecondary, size: 40),
        ),
      );
    }
  }

  Widget _buildStatBadge(String label, String value, IconData icon) {
    return Expanded(
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        borderRadius: 14,
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryContainer, size: 16),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBackground,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Hero Image & App Bar
              SliverAppBar(
                expandedHeight: 260,
                pinned: true,
                backgroundColor: AppColors.canvasBackground,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GlassContainer(
                    padding: EdgeInsets.zero,
                    borderRadius: 20,
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GlassContainer(
                      padding: EdgeInsets.zero,
                      borderRadius: 20,
                      onTap: _toggleSave,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          _isSaved ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          color: _isSaved ? AppColors.primaryContainer : Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      _buildHeroImage(widget.recipe.imageUrl),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.transparent,
                              AppColors.canvasBackground,
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Recipe Title & Category
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Match Pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.primaryContainer.withOpacity(0.4)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.stars_rounded, size: 14, color: AppColors.primaryContainer),
                            const SizedBox(width: 4),
                            Text(
                              widget.recipe.match,
                              style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        widget.recipe.name,
                        style: GoogleFonts.montserrat(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.recipe.category,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryLight,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.recipe.desc,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 4 Stat Badges
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      _buildStatBadge('Time', widget.recipe.time, Icons.schedule_rounded),
                      const SizedBox(width: 8),
                      _buildStatBadge('Level', widget.recipe.level, Icons.speed_rounded),
                      const SizedBox(width: 8),
                      _buildStatBadge('Servings', widget.recipe.servings, Icons.restaurant_rounded),
                      const SizedBox(width: 8),
                      _buildStatBadge('Calories', widget.recipe.calories, Icons.local_fire_department_rounded),
                    ],
                  ),
                ),
              ),

              // Interactive Ingredients Checklist
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.format_list_bulleted_rounded, color: AppColors.primaryContainer, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Ingredients',
                            style: GoogleFonts.montserrat(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Tap to check off',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = widget.recipe.ingredients[index];
                    final isChecked = _checkedIngredients.contains(index);

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                      child: GlassContainer(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        borderRadius: 12,
                        onTap: () {
                          setState(() {
                            if (isChecked) {
                              _checkedIngredients.remove(index);
                            } else {
                              _checkedIngredients.add(index);
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isChecked ? AppColors.primaryContainer : Colors.transparent,
                                border: Border.all(
                                  color: isChecked ? AppColors.primaryContainer : AppColors.textSecondary.withOpacity(0.5),
                                  width: 1.5,
                                ),
                              ),
                              child: isChecked
                                  ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: isChecked ? AppColors.textSecondary.withOpacity(0.5) : Colors.white,
                                  decoration: isChecked ? TextDecoration.lineThrough : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: widget.recipe.ingredients.length,
                ),
              ),

              // Step-by-Step Cooking Guide
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                  child: Row(
                    children: [
                      const Icon(Icons.menu_book_rounded, color: AppColors.primaryContainer, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Preparation Steps',
                        style: GoogleFonts.montserrat(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final step = widget.recipe.steps[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                      child: GlassContainer(
                        padding: const EdgeInsets.all(14),
                        borderRadius: 14,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryContainer.withOpacity(0.2),
                                border: Border.all(color: AppColors.primaryContainer.withOpacity(0.5)),
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryContainer,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step.title,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    step.desc,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: widget.recipe.steps.length,
                ),
              ),

              // Bottom Spacing for Floating Button
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),

          // Floating Save Action CTA
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: GlowButton(
              text: _isSaved ? 'Saved in Cookbook' : 'Save to My Cookbook',
              icon: _isSaved ? Icons.bookmark_added_rounded : Icons.bookmark_add_rounded,
              onPressed: _toggleSave,
            ),
          ),
        ],
      ),
    );
  }
}
