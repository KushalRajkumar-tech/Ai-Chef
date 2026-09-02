---
page: saved
---
Build the Saved Recipes Grid Screen for the AI Chef mobile web app (390px width).

**Page Structure:**
1. **Top Bar:**
   - Title text "Saved Recipes" in Outfit bold font (white text) centered.
2. **Saved Grid Area:**
   - A 2-column grid of saved recipe cards. Each card represents a saved culinary dish.
   - Card 1: 
     - Culinary photo placeholder (Pan-Seared Garlic Salmon).
     - Active "filled heart" icon (Sunset Orange #FF5C00) in the top-right corner of the image.
     - Recipe Title: "Garlic Salmon" in Outfit bold font (white text).
     - Cooking details: "25 MINS • EASY" in monospace (Warm Silver).
     - Link: Card links to `recipe.html`.
   - Card 2:
     - Culinary photo placeholder (Truffle Mushroom Pasta).
     - Active "filled heart" icon (Sunset Orange #FF5C00) in the top-right corner.
     - Recipe Title: "Truffle Pasta" in Outfit bold font (white text).
     - Cooking details: "20 MINS • MEDIUM" in monospace (Warm Silver).
     - Link: Card links to `recipe.html`.
   - Card 3:
     - Culinary photo placeholder (Honey Glazed Brussels Sprouts).
     - Active "filled heart" icon (Sunset Orange #FF5C00) in the top-right corner.
     - Recipe Title: "Glazed Sprouts" in Outfit bold font (white text).
     - Cooking details: "15 MINS • EASY" in monospace (Warm Silver).
     - Link: Card links to `recipe.html`.
   - Card 4:
     - Culinary photo placeholder (Avocado Toast with Egg).
     - Active "filled heart" icon (Sunset Orange #FF5C00) in the top-right corner.
     - Recipe Title: "Avocado Toast" in Outfit bold font (white text).
     - Cooking details: "10 MINS • EASY" in monospace (Warm Silver).
     - Link: Card links to `recipe.html`.
3. **Empty State Message (Hidden/Optional UI indicator):**
   - No extra text, just keep it clean and filled with these 4 saved cards.
4. **Bottom navigation tab bar:**
   - Navigation bar sticky to the bottom.
   - Pinned tabs: Home (Inactive - Warm Silver), Cook (Inactive - Warm Silver), Saved (Active - Sunset Orange colored).
   - Linking: Home tab links to `index.html`, Cook tab links to `ingredients.html`, Saved tab links to `saved.html`.

**DESIGN SYSTEM (REQUIRED):**
*   **Visual Style:** Mobile screen with dark mode UI. Canvas background is `#090909`. Cards/inputs are `#161616`.
*   **Colors:** Accent primary is warm orange `#FF5C00`. High contrast text is `#FFFFFF`. Muted text is `#A3A3A3`. Borders are `rgba(255, 255, 255, 0.08)`.
*   **Typography:** Headings use `Outfit` font, body uses `Satoshi` or clean sans-serif.
*   **Components:** Rounded corners are 12px for inputs/buttons and 16px for cards. Navigation is a sticky bottom tab bar with tabs: Home (active/inactive), Cook (active/inactive), Saved (active/inactive) matching the respective page.
*   **No AI tells:** No emojis, no gradients on text, no generic placeholder text. Use realistic recipe names and ingredients.
