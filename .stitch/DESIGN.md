# Design System: Obsidian Gourmet (AI Chef)

## 1. Visual Theme & Atmosphere
A luxurious, dark culinary experience that feels like a private master chef's kitchen at midnight. It features modern minimalism infused with glassmorphism, glowing amber accents, and crisp architectural typography.

- **Density:** Daily App Balanced (5/10)
- **Variance:** Offset Asymmetric (6/10)
- **Device Type:** Mobile (Portrait, 390px width baseline)

## 2. Color Palette & Roles
- **Canvas Obsidian** (`#0D0D11`) — Deep canvas background with ambient warm radial gradients
- **Glass Surface** (`rgba(28, 28, 42, 0.75)`) — Card panels, dialogs, inputs with `backdrop-filter: blur(12px)`
- **Surface Dark** (`#131317`, `#1F1F23`) — Solid container backing layers
- **Glowing Ember Orange** (`#FF6B00`) — Primary accent, active navigation, glowing CTAs (`box-shadow: 0 0 20px rgba(255, 107, 0, 0.3)`)
- **Pure White** (`#FFFFFF`) — High-contrast headlines and active icons
- **Cream / Warm Grey** (`#E4E1E7`, `#E2BFB0`) — Smooth gradient headline accents and primary text
- **Muted Lavender / Steel** (`#B5B3C6`, `#A98A7D`) — Secondary metadata, cook times, inactive tabs
- **Glass Border** (`rgba(255, 255, 255, 0.08)`) — 1px structural glass borders

## 3. Typography Rules
- **Headings & Display:** `Montserrat` (Google Font) — Bold (700) / Semi-bold (600), geometric precision.
- **Body & Labels:** `Hanken Grotesk` (Google Font) — Regular (400) / Medium (500) / Semi-bold (600), generous line height (1.6).
- **Metadata & Badges:** Monospace or `Hanken Grotesk` with uppercase tracking (`letter-spacing: 0.05em`).

## 4. Component Stylings
- **Buttons:**
  - **Primary CTA:** Pill-shaped (`rounded-full`) or `rounded-xl`, filled with `#FF6B00`, glowing drop shadow (`box-shadow: 0 0 20px rgba(255, 107, 0, 0.3)`), white bold Montserrat text.
  - **Secondary / Glass Button:** `background: rgba(28, 28, 42, 0.75)` with `1px solid rgba(255,255,255,0.08)`.
- **Cards:**
  - Glass panels with `backdrop-filter: blur(12px)` and `1px solid rgba(255, 255, 255, 0.08)`.
  - Rounded corners (`16px` to `20px`).
  - Subtle hover/active transform (`scale(1.02)` and soft shadow).
- **Inputs & Search:**
  - Glass pill input with magnifying glass and glowing submit arrow.
- **Chips & Badges:**
  - Pill-shaped (`rounded-full`), glass background, rating stars (`#FF6B00`), cooking time badges.
- **Checklists:**
  - Circular check indicator with animated strike-through on ingredients.
- **Navigation (Bottom Tab Bar):**
  - Ultra-frosted glass bar (`backdrop-filter: blur(16px)` over `#0D0D11/80`).
  - Active tab highlighted in glowing `#FF6B00` with subtle top indicator bar.

## 5. Ambient Lighting & Effects
```css
body {
    background-color: #0D0D11;
    background-image: 
        radial-gradient(circle at 15% 10%, rgba(255, 107, 0, 0.08) 0%, transparent 40%),
        radial-gradient(circle at 85% 90%, rgba(255, 107, 0, 0.05) 0%, transparent 40%);
    background-attachment: fixed;
}
.glass-panel {
    background: rgba(28, 28, 42, 0.75);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border: 1px solid rgba(255, 255, 255, 0.08);
}
.glow-button {
    box-shadow: 0 0 20px rgba(255, 107, 0, 0.35);
    transition: all 0.3s ease;
}
.glow-button:hover, .glow-button:active {
    box-shadow: 0 0 30px rgba(255, 107, 0, 0.55);
    transform: translateY(-1px);
}
.text-gradient {
    background: linear-gradient(135deg, #ffffff 0%, #ffdbcc 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}
```
