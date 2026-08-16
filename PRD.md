# PRD — Wirid Al-Busyro

**Status:** Final v1.0 — ready for development
**Last updated:** 2026-08-15
**App name:** Wirid Al-Busyro
**Platform:** Android & iOS
**Content source:** Wirid Subuhan Majlis Al-Busyro — Prof. Dr. Habib Segaf Baharun
**Distribution permission:** Obtained

---

## 1. Summary

A simple mobile app presenting 21 wirid and prayer items recited after the Fajr (Subuh) prayer,
compiled by Habib Segaf Baharun of Majlis Al-Busyro. Users open a list, select an item, and
read the full Arabic text with translation and notes. All content is stored locally (JSON in
assets) — **100% offline, no images, no ads.**

---

## 2. Target Users

Members and supporters of Majlis Al-Busyro who want to practice this wirid consistently after
Fajr, especially when traveling or in places without internet access.

---

## 3. Goals & Non-Goals

### Goals
- Quick access to all 21 post-Fajr wirid items, offline
- Arabic text rendered clearly with correct harakat (diacritics)
- Repetition counter operable with one hand
- Faidah (benefits) and source information available without interrupting the main reading
- Lightweight APK (target < 20 MB)

### Non-Goals (explicitly out of scope, binding)
- Audio / murottal recitation
- User accounts / cloud sync
- Prayer times, qibla direction, Hijri calendar
- Server-side content / automatic updates
- Ads

---

## 4. Content Structure

One category, 21 items in fixed order. Data file: `assets/data/wirid_items.json` — **already
available and ready to use**, extracted from the original `.docx` source with clean Arabic text.

| No | ID | Latin Title | Repetition | Has Translation |
|----|----|-------------|------------|-----------------|
| 1 | wirdul_lathif | Wirdul Lathif | — (read once) | No |
| 2 | wirdus_sakran | Wirdus Sakran | — | No |
| 3 | tawassul_fatihah | Tawassul Fatihah before Yasin | 1x | Partial |
| 4 | surah_yasin | Surah Yasin (83 verses) | 1x | No |
| 5 | doa_setelah_yasin | Doa after Surah Yasin | 1x | Yes |
| 6 | sholawat_dafful_bala | Sholawat Daf'ul Bala' | — | Yes |
| 7 | sholawat_busyra | Sholawat Busyra | 41x | Yes |
| 8 | tawassul_thaha | Tawassul Thaha | 110x | Yes |
| 9 | ya_allah_ya_mubdi | Ya Allah Ya Mubdi | 111x | Yes |
| 10 | lailaha_illallah_malik | Laa Ilaaha Illallah Al-Malik | 100x | Yes |
| 11 | ya_kafi_ya_mughni | Ya Kafi Ya Mughni | 100x | Yes |
| 12 | masya_allah_la_quwwata | Maa Syaa Allah Laa Quwwata | 100x | Yes |
| 13 | ya_fattahu_ya_aliim | Ya Fattahu Ya Aliim | 100x | Yes |
| 14 | ya_lathiif | Ya Lathiif | 129x | Yes |
| 15 | istighfar | Istighfar | 100x | Yes |
| 16 | qs_at_taubah_128_129 | QS. At-Taubah 128-129 | 7x | Yes |
| 17 | doa_nafs_muthmainnah | Doa Nafs Muthmainnah | 3x | Yes |
| 18 | ya_ghani_ya_mughni | Ya Ghani Ya Mughni | 10x (×4 = 40x total) | Yes |
| 19 | doa_tahshin | Doa Tahshin | 3x | Yes |
| 20 | sholawat_manshub | Sholawat Manshub | 11x (or 41x) | Yes |
| 21 | sholawat_ridho | Sholawat Ridho | 33x | Yes |

**Special item notes:**
- Item 1 (Wirdul Lathif): long text (~8,100 Arabic characters), composed of many sequential
  prayers each with their own internal repetition (×3, ×4, ×7, ×10)
- Item 4 (Surah Yasin): 83 verses, long single-page scroll
- Item 18 (Ya Ghani): read 10x per round, 4 rounds total = 40x; counter tracks per-round progress

---

## 5. Features

### P0 — MVP (required for first release)

| # | Feature | Done When |
|---|---|---|
| F-01 | List of 21 items | Arabic title + Latin title (no faidah preview — keeps the list scannable, faidah is detail-screen only) |
| F-02 | Detail page per item | Arabic text (RTL), translation if available, faidah, source |
| F-03 | Next/prev navigation in detail | Bottom buttons, no return to list required |
| F-04 | Repetition counter | Shows count (e.g. 100 → 99 → … → 0), tap to decrement, reset button; items with null repeatCount show no counter |
| F-05 | Faidah & source accordion | Collapsed by default, expandable; does not interrupt main reading |
| F-06 | Arabic font size control | 4 presets (S/M/L/XL), persisted across sessions |
| F-07 | Dark mode | Follow system + manual override |
| F-08 | Full offline | Airplane mode: all features work without errors |

### P1 — Post-MVP

| # | Feature | Notes |
|---|---|---|
| F-09 | Bookmark / favorites | Save items locally, no account needed |
| F-10 | Resume last position | Remember the last item opened |
| F-11 | Share text | Native share sheet — Arabic + translation |
| F-12 | Content correction channel | Link to WhatsApp/email for reporting errors |

### P2 — Under consideration
- Arabic font choice (Naskh / Uthmani)
- Home screen widget

---

## 6. Core User Flows

**Flow A — Reading wirid in sequence after Fajr**
```
Open app → list of 21 items
→ tap item 1 (Wirdul Lathif) → read, scroll
→ tap next → item 2 (Wirdus Sakran) → read
→ ... → item 7 (Sholawat Busyra) → tap counter 41x
→ tap next → item 8 (Tawassul Thaha) → tap counter 110x
→ ... → finish item 21
```

**Flow B — Jump directly to a specific item**
```
Open app → scroll list → tap target item → read
```

---

## 7. Technical Specification

### 7.1 Data

`assets/data/wirid_items.json` is already available. No complex queries or server calls needed
— load once on startup, parse in an isolate, hold in memory.

If total parse time < 50ms, no loading screen is needed. JSON size is approximately ~50 KB.

### 7.2 Arabic Font

Font **must be bundled** — never rely on system fonts.
- **Primary recommendation:** Amiri (OFL license, excellent harakat rendering for long texts)
- **Fallback:** Scheherazade New (SIL, OFL)
- Subset the font to Arabic Unicode range only to reduce file size

**Mandatory spike before writing any feature code:** render 5 lines from Wirdul Lathif (the
densest harakat text) on 3 different physical devices. Verify syaddah, sukun, tanwin positioning,
and the `اللَّهِ` (lafaz jalalah) ligature. Only proceed with feature development if rendering is correct.

### 7.3 Counter Logic

```dart
// Pseudocode counter state
int target;   // from JSON repeat_count (null = no counter)
int current;  // starts at target, decrements to 0

onTap() {
  if (current > 0) current--;
  if (current == 0) showCompletionFeedback(); // haptic + subtle visual
}

onReset() => current = target;
```

Item 18 (Ya Ghani) special case: 1 round = 10x, 4 rounds total. Counter displays
`Round X/4 — Y/10`. After 10 taps, auto-advance to next round. After round 4 completes,
show done state.

### 7.4 Arabic Rendering

```dart
Text(
  item.arabic,
  textDirection: TextDirection.rtl,
  style: TextStyle(
    fontFamily: 'Amiri',
    fontSize: arabicFontSize,  // user preference: 22, 26, 30, or 36
    height: 2.0,               // line-height — harakat require vertical space
    color: theme.arabicTextColor,
  ),
)
```

### 7.5 Platform

- Android minSdk: **24 in practice**, not 23 as originally specified —
  `shared_preferences_android` (used for font-size/theme persistence,
  F-06/F-07) hard-requires 24; the manifest merger fails the build at 23.
  Forcing 23 would mean dropping that plugin/feature or pinning to a much
  older, unmaintained version. Confirmed via a real `flutter build apk`
  failure, not a guess.
- iOS minimum: **15.0 in practice**, not 13 as originally specified —
  Flutter 3.47's own project template defaults new projects to 15.0,
  meaning current tooling doesn't support building for iOS 13 at all.
- Target: phone only (tablet scaling acceptable but not a priority)

---

## 8. UI Direction

**Explicitly avoided:** the reference app provided (saturated green filling the entire screen,
thick gold ornaments, ads placed directly below prayer text).

**Direction:**
- Background: warm white (`#FAFAF7`) in light mode; very dark grey (`#1A1A1A`) in dark mode —
  not pure black, to prevent thin Arabic strokes from appearing to vibrate on OLED screens
- Green: single accent color for active elements (counter, selected item, CTA)
- Arabic text: large font (min 22sp), high contrast, line-height 2.0
- Translation: 80% of Arabic font size, 60% opacity — subordinate but readable
- Counter: large, thumb-friendly tap target, minimum 48×48dp
- Faidah & source: inside accordion, not visible by default

Target mood: calm reader app (not a dashboard, not a landing page).

---

## 9. Success Metrics

| Metric | Target |
|---|---|
| Cold start | < 1.5s on low-end device |
| APK size | < 20 MB (Arabic font is the largest contributor) |
| Harakat errors reported | 0 in first 30 days |
| Crash-free sessions | > 99.5% |

---

## 10. Risks

| Risk | Impact | Mitigation |
|---|---|---|
| Poor harakat rendering in Flutter | High — core product | Mandatory spike before any feature work (§7.2) |
| Item 18 counter logic (4 rounds) | Low | Isolated logic, unit-tested |
| Surah Yasin (83 verses) scroll performance | Low | `SingleChildScrollView` + lazy text rendering is sufficient |
| Latin transliteration missing for most items | Low for MVP | `latin` field exists in JSON, fill manually over time |

---

## 11. Open Questions

1. **[TBD]** Latin transliteration: fill in gradually after MVP launch, or required before first release?
2. **[TBD]** Sholawat Manshub (item 20): default counter 11x or 41x? (source document states both are valid)
3. **[TBD]** Haptic feedback on counter completion: yes or no?
4. **[TBD]** Tawassul Fatihah (item 3) and Surah Yasin (item 4): keep as separate items, or merge into one combined page?