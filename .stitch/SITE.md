# Site Constitution: AI Chef

## 1. Vision & Purpose
AI Chef is a premium, dark-themed mobile web application that allows users to discover recipes, input their available kitchen ingredients, generate custom step-by-step recipes, and save their favorite dishes into a beautiful grid display.

- **Name:** AI Chef
- **Device Type:** MOBILE
- **Stitch Project ID:** 17223481740130135379

---

## 2. Navigation Flow
The application has a persistent bottom navigation bar on all pages:
- **Home** (routes to `index.html`)
- **Cook** (routes to `ingredients.html`)
- **Saved** (routes to `saved.html`)

Additional page-specific transitions:
- On Home (`index.html`), clicking a featured recipe card navigates to the Recipe Result page (`recipe.html`) pre-loaded with details for that recipe.
- On Ingredient Input (`ingredients.html`), clicking "Generate Recipe" navigates to the Recipe Result page (`recipe.html`).
- On Recipe Result (`recipe.html`), clicking "Save Recipe" triggers a state update or visual indicator, and the recipe will appear in the Saved Recipes page (`saved.html`).

---

## 3. Sitemap
- [x] `index` (Home Screen) — Featured recipes, search, category chips.
- [x] `ingredients` (Ingredient Input) — Textarea, tags, and generate button.
- [x] `recipe` (Recipe Result) — Ingredients, details, steps, save button.
- [x] `saved` (Saved Recipes) — Grid of cards showing saved items.

---

## 4. Roadmap & Progress
- [x] **Step 1:** Initialize Stitch project and metadata.
- [x] **Step 2:** Generate and download `index` screen.
- [x] **Step 3:** Generate and download `ingredients` screen.
- [x] **Step 4:** Generate and download `recipe` screen.
- [x] **Step 5:** Generate and download `saved` screen.
- [x] **Step 6:** Cross-wire all navigation links and verify.
