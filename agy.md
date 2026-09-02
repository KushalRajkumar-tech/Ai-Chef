# AI Chef — Master Specification & Replication Blueprint (`agy.md`)

> **Project Name:** AI Chef (Obsidian Gourmet Mobile Web App)  
> **Version:** 2.0.0  
> **Target Form Factor:** Mobile First (Optimized for 390px width baseline, responsive across all mobile screens)  
> **Aesthetic Theme:** "Obsidian Gourmet" — Deep obsidian dark mode, glassmorphism, warm glowing amber accents, architectural Montserrat headings, and Hanken Grotesk body typography.

---

## 1. Project Purpose & Overview

**AI Chef** is a state-of-the-art mobile culinary application designed to deliver a luxury private-chef experience. It enables users to:
1. Browse curated gourmet categories (**Indian Food**, **Chef's Favorites**, **Artisan Desserts**) in horizontal sliding carousels.
2. Use an interactive **Smart Ingredient Engine** to formulate custom recipes from their kitchen inventory with live tag adding/removal and quick pantry additions.
3. Access detailed, chef-verified recipe guides with key culinary statistics, an interactive checklist with strike-through animations, and step-by-step numbered preparation instructions.
4. Save and organize recipes into a personalized **Cookbook Library** with active favorites toggles and collection filtering.

---

## 2. Design System & Style Guide ("Obsidian Gourmet")

### 2.1 Color Palette
| Color Role | HEX / RGBA Value | Usage & Application |
| :--- | :--- | :--- |
| **Canvas Background** | `#0D0D11` | Core deep obsidian background for the app canvas |
| **Glass Surface** | `rgba(28, 28, 42, 0.75)` | Translucent card panels, inputs, bottom bar (`backdrop-filter: blur(14px)`) |
| **Solid Surfaces** | `#131317`, `#1F1F23`, `#2A292E` | Container backings and elevated components |
| **Primary Accent** | `#FF6B00` (Ember Orange) | Action buttons, active navigation, glowing icons, ratings |
| **Primary Light** | `#FFB693` | Secondary text highlights and gradient accents |
| **Glass Border** | `rgba(255, 255, 255, 0.08)` to `0.15` | 1px border on all glassmorphic cards and containers |
| **Primary Text** | `#FFFFFF` / `#E4E1E7` | Crisp white headings and high-contrast input text |
| **Secondary Text** | `#B5B3C6` / `#E2BFB0` | Metadata, cook times, difficulty levels, placeholders |

### 2.2 Typography
*   **Display & Headings:** `Montserrat` (Google Fonts: 600, 700, 800) — Bold, architectural geometric styling.
*   **Body & Labels:** `Hanken Grotesk` (Google Fonts: 400, 500, 600) — High legibility with generous line heights (`1.6`).
*   **Icons:** `Material Symbols Outlined` (Google Material Icons) with dynamic fill support (`font-variation-settings: 'FILL' 1`).

### 2.3 Visual Effects & Atmosphere
```css
/* Ambient Lighting */
body {
    background-color: #0D0D11;
    background-image: 
        radial-gradient(circle at 15% 10%, rgba(255, 107, 0, 0.08) 0%, transparent 40%),
        radial-gradient(circle at 85% 90%, rgba(255, 107, 0, 0.05) 0%, transparent 40%);
    background-attachment: fixed;
}

/* Text Gradient */
.text-gradient {
    background: linear-gradient(135deg, #ffffff 0%, #ffdbcc 100%);
    -webkit-background-clip: text;
    background-clip: text;
    -webkit-text-fill-color: transparent;
}

/* Glassmorphism Panel */
.glass-panel {
    background: rgba(28, 28, 42, 0.75);
    backdrop-filter: blur(14px);
    -webkit-backdrop-filter: blur(14px);
    border: 1px solid rgba(255, 255, 255, 0.08);
}

/* Active Highlight Glass */
.glass-panel-active {
    background: rgba(255, 107, 0, 0.18);
    backdrop-filter: blur(14px);
    border: 1px solid rgba(255, 107, 0, 0.45);
}

/* Glowing Ember CTA */
.glow-button {
    box-shadow: 0 0 22px rgba(255, 107, 0, 0.4);
    transition: all 0.3s ease;
}
.glow-button:hover, .glow-button:active {
    box-shadow: 0 0 32px rgba(255, 107, 0, 0.65);
    transform: translateY(-1px);
}

/* High-Contrast Inputs */
input, textarea {
    color: #FFFFFF !important;
    background-color: rgba(28, 28, 42, 0.95) !important;
    caret-color: #FF6B00 !important;
    border: 1px solid rgba(255, 255, 255, 0.2) !important;
}
```

---

## 3. Project Architecture & File Structure

```
chef/
├── site/
│   └── public/
│       ├── index.html        # Screen 1: Gourmet Home (Search & Horizontal Category Rails)
│       ├── ingredients.html  # Screen 2: Smart Ingredient Engine & Category Showcase
│       ├── recipe.html       # Screen 3: Recipe Details & Step-by-Step Cooking Guide
│       └── saved.html        # Screen 4: My Saved Cookbook (2-Column Grid & Tabs)
├── .stitch/
│   ├── DESIGN.md             # Design tokens & constitution
│   ├── SITE.md               # Sitemap & development progress tracker
│   └── designs/              # Mirrored source HTML & assets
└── agy.md                    # Master specification & AI replication prompt
```

---

## 4. Screen Specifications & Micro-Interactions

### Screen 1: Gourmet Home (`index.html`)
*   **Header Bar:** Sticky glass panel with AiChef gradient logo, active notification bell with glowing indicator, and chef avatar.
*   **Hero Search:** High-visibility text input (`#FFFFFF`) with real-time filtering that searches titles and categories across all recipe cards.
*   **Section 1 — Indian Food:** Horizontal sliding carousel with:
    *   *Royal Butter Chicken* (`recipe.html?id=butter-chicken`) — 35m, Medium, 4.9 ★
    *   *Smoky Paneer Tikka Masala* (`recipe.html?id=paneer-tikka`) — 30m, Easy, 4.8 ★
    *   *Hyderabadi Dum Biryani* (`recipe.html?id=dum-biryani`) — 50m, Hard, 5.0 ★
*   **Section 2 — Chef's Favorites:** Horizontal sliding carousel with:
    *   *Pan-Seared Garlic Salmon* (`recipe.html?id=salmon`) — 25m, Easy, 4.9 ★
    *   *Truffle Tagliatelle Pasta* (`recipe.html?id=truffle-pasta`) — 20m, Medium, 4.8 ★
    *   *Wagyu Ribeye & Roast Herbs* (`recipe.html?id=wagyu`) — 45m, Hard, 5.0 ★
*   **Section 3 — Artisan Desserts:** Horizontal sliding carousel with:
    *   *Molten Chocolate Lava Cake* (`recipe.html?id=lava-cake`) — 25m, Medium, 4.9 ★
    *   *Saffron Gulab Jamun Cheesecake* (`recipe.html?id=gulab-jamun-cheesecake`) — 30m, Easy, 4.9 ★
*   **Card Interaction:** Entire card is tappable with hover lift effect; contains an instant heart save toggle with `event.stopPropagation()`.

### Screen 2: Smart Ingredient Engine (`ingredients.html`)
*   **Top Bar:** Smart back button (`history.back()`) with title "Smart Ingredient Engine".
*   **Selected Ingredients Pool:** Dynamic tag pills with smooth deletion (`×` button) and real-time counter (`"X items ready"`).
*   **Input Bar:** Bright white text input (`#FFFFFF`), amber caret, supporting both `Enter` keypress and `Add` button click.
*   **Quick-Add Pantry Chips:** One-tap pills (*+ Paneer, + Salmon, + Mushrooms, + Wagyu, + Basmati Rice, + Dark Chocolate*).
*   **AI Formulator Button:** Large glowing amber button with algorithm matching:
    *   Contains *chicken, butter, tomato* $\rightarrow$ `butter-chicken`
    *   Contains *paneer, cheese, pepper* $\rightarrow$ `paneer-tikka`
    *   Contains *rice, biryani, saffron* $\rightarrow$ `dum-biryani`
    *   Contains *salmon, fish, lemon* $\rightarrow$ `salmon`
    *   Contains *pasta, mushroom, truffle* $\rightarrow$ `truffle-pasta`
    *   Contains *steak, wagyu, beef* $\rightarrow$ `wagyu`
    *   Contains *chocolate, lava, cake* $\rightarrow$ `lava-cake`
    *   Contains *gulab, dessert, sweet* $\rightarrow$ `gulab-jamun-cheesecake`
*   **Category Rails Below:** Full horizontal sliding rails for browsing all categories.

### Screen 3: Recipe Details & Step Guide (`recipe.html`)
*   **Top Navigation:** Smart `goBack()` button returning to the referring page (Home, Saved, or Cook).
*   **Dynamic Data Loader:** Reads `?id=...` from URL and renders matching recipe name, photo, description, key stats, ingredients, and steps.
*   **Key Stats Bar:** 4 glass pills showing *Cook Time*, *Difficulty Level*, *Servings*, and *Calories*.
*   **Interactive Ingredients Checklist:** Circular custom checkmarks; tapping an ingredient strikes through text (`line-through opacity-45`) and fills checkmark with amber.
*   **Step-by-Step Cooking Guide:** Numbered circular step markers with highlighted first step and detailed instructions.
*   **Floating Action CTA:** Glowing "Save to My Cookbook" button with instant toggle feedback ("Saved to Cookbook!").

### Screen 4: My Saved Cookbook (`saved.html`)
*   **Top Navigation:** Smart back button returning to the previous screen.
*   **Collection Filter Tabs:** *All Saved (6)*, *Indian Food*, *Chef's Favorites*, *Desserts* that dynamically filter the cards and update the count label.
*   **2-Column Recipe Grid:** Masonry glass cards displaying ratings, cook times, and active heart favorites linking directly to full recipe guides.

### Bottom Navigation Bar (Across All Screens)
*   Frosted glass bar (`bg-[#0D0D11]/90 backdrop-blur-xl border-t border-white/10`).
*   **Tabs:**
    1. 🏠 **Home:** `index.html`
    2. 🍳 **Cook / Explore:** `ingredients.html`
    3. 📖 **Saved:** `saved.html`
*   Active tab highlighted with `#FF6B00`, bold typography, and a top indicator glow bar.

---

## 5. Recipe Database Schema (JavaScript Dataset)

```javascript
const RECIPES = {
  'butter-chicken': {
    name: 'Royal Butter Chicken (Murgh Makhani)',
    category: 'Indian Food • North Indian',
    desc: 'Tender tandoori chicken simmered in a velvety aromatic tomato, cashew, and fenugreek butter gravy.',
    image: 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=800&auto=format&fit=crop&q=80',
    match: 'Popular Indian Masterpiece',
    time: '35 min',
    level: 'Medium',
    servings: '4 Servings',
    calories: '560 kcal',
    ingredients: [
      '600g boneless chicken thighs (cubed)',
      '1/2 cup Greek yogurt + 1 tbsp ginger-garlic paste',
      '4 tbsp grass-fed butter + 1 tbsp oil',
      '1.5 cups smooth San Marzano tomato puree',
      '1/2 cup heavy whipping cream',
      '2 tbsp soaked cashew paste',
      '1 tbsp dried Kasuri Methi (crushed fenugreek leaves)',
      '1 tsp Kashmiri red chili powder & 1 tsp Garam Masala'
    ],
    steps: [
      { title: 'Marinate & Pan-Sear', desc: 'Marinate chicken in yogurt, ginger-garlic, and spices for 20 mins. Sear in a hot skillet until lightly charred.' },
      { title: 'Simmer Silky Tomato Base', desc: 'Melt 2 tbsp butter. Cook tomato puree, Kashmiri chili, and cashew paste on medium-low until oil separates.' },
      { title: 'Enrich with Cream & Fenugreek', desc: 'Stir in heavy cream, remaining butter, garam masala, and roasted kasuri methi until velvety smooth.' },
      { title: 'Simmer Chicken & Garnish', desc: 'Add seared chicken pieces into the gravy and simmer for 6 minutes. Garnish with a swirl of cream and fresh cilantro.' }
    ]
  },
  'paneer-tikka': {
    name: 'Smoky Paneer Tikka Masala',
    category: 'Indian Food • Vegetarian',
    desc: 'Char-grilled cottage cheese cubes and crisp peppers tossed in a robust spiced onion-tomato masala.',
    image: 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=800&auto=format&fit=crop&q=80',
    match: 'Vegetarian Classic',
    time: '30 min',
    level: 'Easy',
    servings: '3 Servings',
    calories: '480 kcal',
    ingredients: [
      '400g fresh Malai Paneer (cubed)',
      '1 large diced red onion & green bell pepper',
      '1/2 cup hung curd with mustard oil & chaat masala',
      '2 finely chopped onions & 3 pureed tomatoes',
      '1 tbsp ginger-garlic paste',
      '1 tsp cumin seeds, turmeric, and coriander powder',
      'Fresh lemon juice & coriander leaves'
    ],
    steps: [
      { title: 'Coat in Tandoori Marinade', desc: 'Toss paneer cubes and peppers in spiced hung curd with mustard oil. Let rest for 15 minutes.' },
      { title: 'Char-Grill Paneer', desc: 'Grill skewers or pan-roast in a smoking cast-iron pan until paneer edges develop golden brown char.' },
      { title: 'Build Onion-Tomato Masala', desc: 'Sauté cumin, chopped onions, and ginger-garlic until deeply caramelized. Add tomato puree and ground spices.' },
      { title: 'Combine & Finish', desc: 'Gently fold grilled paneer and peppers into the rich masala gravy. Simmer for 3 minutes and finish with lemon juice.' }
    ]
  },
  'dum-biryani': {
    name: 'Hyderabadi Dum Biryani',
    category: 'Indian Food • Royal Feast',
    desc: 'Fragrant long-grain basmati rice layered with spiced saffron marinade, clarified ghee, caramelized onions, and fresh mint.',
    image: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=800&auto=format&fit=crop&q=80',
    match: 'Royal Heritage Dish',
    time: '50 min',
    level: 'Hard',
    servings: '4 Servings',
    calories: '620 kcal',
    ingredients: [
      '2 cups aged Royal Basmati rice (soaked for 30m)',
      '500g bone-in chicken or spiced mixed vegetables',
      '1/2 cup crispy fried golden onions (Birista)',
      'Pinch of saffron threads steeped in 1/4 cup warm milk',
      '3 tbsp pure desi ghee + whole shahi jeera, cardamom & star anise',
      '1/2 cup chopped fresh mint & coriander leaves',
      '1 cup thick spiced yogurt marinade'
    ],
    steps: [
      { title: 'Marinate Core Proteins', desc: 'Marinate chicken/vegetables with yogurt, ginger-garlic, mint, fried onions, and whole spices for 1 hour.' },
      { title: 'Par-boil Basmati Rice', desc: 'Boil rice in whole-spiced rolling water until exactly 70% cooked (grain bends without snapping). Drain.' },
      { title: 'Royal Dum Layering', desc: 'In a heavy-bottomed handi, layer marinated base, topped with fragrant rice, saffron milk, fried onions, and mint.' },
      { title: 'Steam on Dum', desc: 'Seal the pot tightly with dough or foil. Cook on high for 5 mins, then slow steam over a tawa for 25 minutes.' }
    ]
  },
  'salmon': {
    name: 'Pan-Seared Garlic Salmon',
    category: "Chef's Favorite • Seafood",
    desc: 'Crispy skin Atlantic salmon basted with fragrant garlic, fresh lemon juice, and infused herb butter.',
    image: 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=800&auto=format&fit=crop&q=80',
    match: 'Chef Recommended',
    time: '25 min',
    level: 'Easy',
    servings: '2 Servings',
    calories: '420 kcal',
    ingredients: [
      '2 fresh Atlantic salmon fillets (6 oz each)',
      '4 cloves fresh garlic, minced',
      '2 tbsp unsalted organic butter',
      '1 tbsp extra virgin olive oil',
      '1 fresh lemon (sliced & juiced)',
      'Fresh chopped parsley & sea salt flakes'
    ],
    steps: [
      { title: 'Pat Dry & Season', desc: 'Thoroughly pat salmon fillets dry with paper towels to ensure a crisp sear. Season flesh side with sea salt and cracked black pepper.' },
      { title: 'Crisp the Skin', desc: 'Heat olive oil in a skillet over medium-high. Place salmon skin-side down and press gently for 5 minutes until crispy.' },
      { title: 'Baste with Garlic Butter', desc: 'Flip fillets. Drop butter, minced garlic, and lemon juice into pan. Continuously spoon foamy aromatic butter over the fillets for 3 minutes.' },
      { title: 'Rest & Garnish', desc: 'Transfer salmon to warm plates. Pour remaining garlic pan juices over top and garnish with chopped fresh parsley and lemon wedges.' }
    ]
  },
  'truffle-pasta': {
    name: 'Truffle Tagliatelle Pasta',
    category: "Chef's Favorite • Artisan Italian",
    desc: 'Al dente ribbons of tagliatelle tossed in a silky parmesan emulsion infused with black truffle oil and wild mushrooms.',
    image: 'truffle_pasta.jpg',
    match: 'Chef Recommended',
    time: '20 min',
    level: 'Medium',
    servings: '2 Servings',
    calories: '520 kcal',
    ingredients: [
      '250g fresh artisan tagliatelle pasta',
      '150g mixed wild mushrooms (cremini & chanterelle)',
      '2 tbsp premium black truffle oil',
      '60g freshly grated Parmigiano-Reggiano',
      '2 cloves garlic, finely sliced',
      '1/4 cup heavy cream or pasta water',
      'Fresh thyme sprigs & cracked black pepper'
    ],
    steps: [
      { title: 'Boil Pasta', desc: 'Bring a large pot of heavily salted water to a rolling boil. Cook tagliatelle until 1 minute shy of al dente.' },
      { title: 'Sauté Wild Mushrooms', desc: 'Heat butter and olive oil in a wide pan over medium-high. Sauté mushrooms until browned and caramelized.' },
      { title: 'Emulsify Sauce', desc: 'Add garlic, cream, and half a ladle of pasta water. Toss the pasta vigorously with parmesan until a glossy sauce forms.' },
      { title: 'Finish with Truffle', desc: 'Drizzle with black truffle oil off the heat, season with fresh thyme, and serve with shaved parmesan.' }
    ]
  },
  'wagyu': {
    name: 'Wagyu Ribeye & Roast Herbs',
    category: "Chef's Favorite • Prime Steak",
    desc: 'A5 Japanese Wagyu ribeye seared with a caramelized golden crust, basted in rosemary thyme butter with charred asparagus.',
    image: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&auto=format&fit=crop&q=80',
    match: 'Prime Culinary Cut',
    time: '45 min',
    level: 'Hard',
    servings: '2 Servings',
    calories: '680 kcal',
    ingredients: [
      '1 prime A5 Wagyu or dry-aged ribeye steak (14 oz)',
      '3 tbsp European grass-fed butter',
      '3 sprigs fresh rosemary & 4 sprigs thyme',
      '1 whole head of garlic, halved crosswise',
      '1 bunch tender baby asparagus',
      'Coarse Maldon sea salt & freshly cracked peppercorn'
    ],
    steps: [
      { title: 'Temper & Season', desc: 'Bring steak to room temperature for 30 minutes. Liberally season with coarse Maldon sea salt on all sides.' },
      { title: 'High-Heat Sear', desc: 'Preheat a heavy cast-iron skillet until smoking hot. Sear the ribeye undisturbed for 2-3 minutes to build a deep crust.' },
      { title: 'Aromatic Butter Basting', desc: 'Flip steak. Add butter, crushed garlic, rosemary, and thyme. Tilt the pan and spoon foaming butter continuously for 2 minutes.' },
      { title: 'Rest & Slice', desc: 'Rest on a warm carving board for 8 minutes before slicing against the grain into thick ribbons.' }
    ]
  },
  'lava-cake': {
    name: 'Molten Chocolate Lava Cake',
    category: 'Artisan Desserts • French Patisserie',
    desc: 'Decadent dark chocolate soufflé cake with a warm, flowing molten fudge center and Madagascar vanilla bean notes.',
    image: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800&auto=format&fit=crop&q=80',
    match: 'Sweet Signature',
    time: '25 min',
    level: 'Medium',
    servings: '4 Servings',
    calories: '380 kcal',
    ingredients: [
      '120g premium 70% Valrhona dark chocolate',
      '1/2 cup unsalted butter (melted)',
      '2 large eggs + 2 egg yolks',
      '1/4 cup granulated organic sugar',
      '2 tbsp all-purpose flour',
      '1 tsp Madagascar vanilla extract',
      'Powdered sugar & fresh raspberries for serving'
    ],
    steps: [
      { title: 'Melt Chocolate & Butter', desc: 'Gently melt chopped dark chocolate and butter in a heatproof bowl set over simmering water until smooth.' },
      { title: 'Whisk Eggs & Sugar', desc: 'In a separate bowl, vigorously whisk eggs, yolks, sugar, and vanilla until pale and frothy.' },
      { title: 'Fold & Fill Ramekins', desc: 'Fold melted chocolate and flour into the eggs. Pour into buttered, cocoa-dusted ramekins.' },
      { title: 'Precision Bake', desc: 'Bake at 425°F (220°C) for exactly 12 minutes until edges are set and center is soft. Invert onto plates and dust with powdered sugar.' }
    ]
  },
  'carrot-halwa': {
    name: 'Royal Gajar Ka Halwa (Carrot Halwa)',
    category: 'Artisan Desserts • Royal Indian Halwa',
    desc: 'Slow-cooked tender grated Delhi carrots simmered in rich whole milk, infused with green cardamom, roasted cashews, and golden desi ghee.',
    image: 'gajar_ka_halwa.jpg',
    match: 'Royal Indian Dessert',
    time: '35 min',
    level: 'Easy',
    servings: '4 Servings',
    calories: '390 kcal',
    ingredients: [
      '500g fresh tender red carrots (peeled & finely grated)',
      '3 cups full-cream whole milk',
      '4 tbsp pure desi ghee',
      '1/2 cup organic sugar (or condensed milk)',
      '1/2 cup crumbled fresh Khoya / Mawa (or milk powder)',
      '1 tsp freshly ground green cardamom powder',
      '2 tbsp golden roasted cashews, raisins & slivered almonds',
      'Pinch of saffron strands soaked in warm milk'
    ],
    steps: [
      { title: 'Sauté Grated Carrots in Ghee', desc: 'Heat 2 tbsp desi ghee in a heavy-bottomed kadai. Sauté finely grated carrots for 5 minutes on medium heat until fragrant and slightly tender.' },
      { title: 'Slow Simmer in Whole Milk', desc: 'Pour in 3 cups of full-cream milk and saffron. Cook on medium-low, stirring occasionally, until the milk is completely absorbed by the carrots.' },
      { title: 'Sweeten & Caramelize', desc: 'Add sugar and remaining 2 tbsp ghee. Cook for 8 minutes until the halwa deepens to a lustrous rich ruby-amber color.' },
      { title: 'Fold Khoya & Roasted Nuts', desc: 'Stir in crumbled khoya (mawa) and cardamom powder. Garnish with golden-fried cashews, pistachios, and slivered almonds. Serve warm.' }
    ]
  }
};
```

---

## 6. How to Run & Preview

To serve and test the application locally on port `3000`:
```powershell
python -m http.server 3000 --directory site/public
```

Access URLs:
*   **Home:** [http://localhost:3000/index.html](http://localhost:3000/index.html)
*   **Cook / Ingredient Engine:** [http://localhost:3000/ingredients.html](http://localhost:3000/ingredients.html)
*   **Recipe Details:** [http://localhost:3000/recipe.html](http://localhost:3000/recipe.html)
*   **Saved Cookbook:** [http://localhost:3000/saved.html](http://localhost:3000/saved.html)

---

## 7. Gemini AI Recipe Generation Engine

The application integrates with the **Gemini API** to formulate unique, Michelin-grade recipes dynamically from user-provided pantry ingredients.

### 7.1 API Configuration
* **Endpoint:** `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key={API_KEY}` (with fallback to `gemini-3.6-flash` / `gemini-3.5-flash`)
* **API Key:** Configured via `config.js` / `GEMINI_API_KEY` environment variable
* **Response Format:** `application/json`

### 7.2 Structured Chef Prompting
```text
You are a talented, practical chef who creates delicious, authentic, and easy-to-follow recipes.
Create a mouth-watering, realistic recipe based on the user's input ingredients/dish request: {INGREDIENTS_OR_DISH}.

Rules:
1. Dish Name: Keep the name simple, authentic, and natural (e.g. "Classic Restaurant-Style Paneer Tikka", "Creamy Garlic Butter Salmon", "Homestyle Butter Chicken", "Easy Truffle Mushroom Pasta"). DO NOT make it overly fancy, pretentious, or use obscure French/Michelin culinary jargon.
2. Description: A short, appetizing 2-sentence summary explaining why it tastes great and what to expect.
3. Ingredients: Everyday practical ingredients with clear standard measurements (e.g. "250g Paneer, cubed", "2 tbsp Olive oil", "1 tsp Cumin powder").
4. Steps: Simple, clear, numbered step-by-step instructions that anyone can easily cook at home.
5. Stats: Realistic cook time (e.g. "25 min"), level ("Easy" or "Medium"), servings ("2-3 Servings"), and calories (e.g. "380 kcal").

Return ONLY a single valid JSON object strictly matching this schema:
{
  "name": "Natural Delicious Dish Name",
  "category": "Cuisine / Style Category",
  "desc": "Short appetizing description.",
  "match": "Custom Recipe",
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
```

### 7.3 Dual AI Recipe Generation Flows

1. **Home Screen Dish Search:**
   * **Single Integrated Search Bar:** Clean pill search bar with an integrated search button and dynamic **Clear (`✕`) Button** that appears whenever the user types text.
   * **Behavior:** When the user types a dish name (e.g. *"Paneer Tikka"*, *"Butter Chicken"*, *"Pasta Primavera"*) and presses **Enter** or taps the **Search Button**:
     * Immediately triggers Gemini AI with the dish name prompt.
     * Displays the glowing obsidian loading overlay (*"Crafting authentic [Dish Name] recipe..."*).
     * Automatically resolves matching authentic high-resolution gourmet food photography.
     * Navigates directly to `recipe.html?id=ai-custom` (or `RecipeDetailScreen` in Flutter) displaying the generated recipe with full ingredients, quantities, stats, and numbered instructions.

2. **Multi-Dish Ingredient Engine (Cook Screen / `ingredients.html`):**
   * **Ingredient Tag Pool:** User adds ingredients from their kitchen pantry.
   * **Multi-Dish AI Suggestion:** Tapping **"Find Matching Dishes"** queries Gemini AI with the pantry list, returning 3 to 4 distinct recipe options with match percentages (e.g. Kadai Paneer 95%, Paneer Bhurji 92%, Paneer Capsicum Stir Fry 88%).
   * **Interactive Dish Cards:** Users browse the suggested dishes directly with authentic photos, cook times, and pantry match indicators, then select the dish they wish to prepare to view full cooking instructions.
   * **High-Precision Image Engine:** 100% free, authentic culinary image database mapped across all popular Indian, Continental, Asian, Seafood, and Dessert dishes.

3. **Cookbook (Saved Recipes Screen / `saved.html`):**
   * **Robust Index-Based Card Rendering:** Eliminated inline HTML attribute escaping issues by referencing cookbook items via indexed memory store (`openCardRecipeByIndex`), guaranteeing that all recipe titles, cooking times, difficulty levels, star ratings, and AI badges render with 100% fidelity without blank cards.
   * **Persistence:** Users can save any recipe (both default curated dishes and custom Gemini AI creations) by tapping the top heart icon or the bottom **"Save to My Cookbook"** button on the Recipe Details screen.
   * **Real-time Synchronization:**
     * Saved recipes are persisted in `localStorage` (`ai_user_saved_recipes`) in the web app and `RecipeRepository` in Flutter.
     * Saved AI recipes appear at the top of the Cookbook grid with a glowing **"✦ AI Recipe"** badge, generated dish photo, cook time, and difficulty rating.
     * 1-Tap Unsave: Tapping the heart on any cookbook card dynamically updates the saved collection and counter.
     * Filter Tabs: Categorize by "All Saved", "✦ AI Generated", "Indian Food", "Chef's Favorites", and "Desserts".
   * **Authentic Culinary Image Integration:** Every dish accurately reflects its real-world appearance using the high-precision culinary mapper.

---

## 8. Flutter Mobile Application Architecture

The project is also fully implemented as a native Flutter application located in `c:\Kushal\AI projects\chef\flutter_app\`:

### 8.1 Flutter File Structure
```
flutter_app/
├── lib/
│   ├── data/
│   │   ├── models/recipe_model.dart          # Data structures
│   │   └── repositories/recipe_repository.dart# 8 Gourmet recipes dataset
│   ├── theme/
│   │   └── app_theme.dart                    # Colors, Google Fonts, and ambient decorations
│   ├── ui/
│   │   ├── widgets/
│   │   │   ├── glass_container.dart          # BackdropFilter glassmorphic container
│   │   │   ├── glow_button.dart              # Glowing ember orange action button
│   │   │   └── recipe_card.dart              # Horizontal carousel and grid recipe cards
│   │   └── screens/
│   │       ├── main_shell.dart               # Bottom navigation with frosted glass bar
│   │       ├── home_screen.dart              # Search and horizontal category carousels
│   │       ├── cook_screen.dart              # Ingredient engine with tags & Gemini AI formulator
│   │       ├── recipe_detail_screen.dart     # Checklist with strike-through & cooking timeline
│   │       └── saved_screen.dart             # 2-column saved grid & collection tabs
│   └── main.dart                             # Application entrypoint
├── assets/images/                            # Image assets
└── pubspec.yaml                              # Flutter dependencies (http, google_fonts, provider)
```

### 8.2 Running the Flutter App Locally
```powershell
cd flutter_app
flutter run -d chrome
```


