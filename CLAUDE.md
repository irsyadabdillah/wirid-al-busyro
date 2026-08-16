# Wirid Al-Busyro

A mobile app (iOS + Android) for reading the Wirid Al-Busyro — an Islamic daily
dhikr/litany compiled by Habib Segaf Baharun. Arabic text with translation and
faidah (benefits). Solo project, no backend, fully offline.

For product context see [PRD.md](PRD.md).

---

## Tech stack

- Flutter 3.47.0 (stable) / Dart ^3.13.0
- State management: `flutter_riverpod` + `riverpod_annotation` (code generation)
- Navigation: `go_router`
- Local storage for preferences: `shared_preferences`
- Codegen: `riverpod_generator` + `json_serializable` + `build_runner`
- Lints: `flutter_lints` only — `custom_lint`/`riverpod_lint` are NOT installed:
  every `custom_lint` version caps `analyzer` below what `json_serializable`
  ^6.14.1 requires, a real unresolvable conflict at the current package
  versions. Re-check `flutter pub add --dev custom_lint riverpod_lint` next
  time `json_serializable` is upgraded — it may resolve on its own.
- Testing: `flutter_test` (add `mocktail` back if a test needs mocking —
  it's not currently a dependency since nothing uses it yet)
- Single environment — no dev/staging/prod flavors
- Fonts: bundled Amiri (general text) + AmiriQuran (Surah Yasin only) TTFs
  in `assets/fonts/`, declared in `pubspec.yaml` — never rely on system
  fonts for Arabic (PRD §7.2)

---

## Architecture

Feature-first Clean Architecture. No explicit domain layer for this project —
app is offline-only with no business logic beyond counter state. Dependency flow:

```
presentation (providers + views) → data (repository + models)
```

Providers call repositories directly. No use case classes — the app has no
logic complex enough to justify them.

---

## Folder convention

```
lib/
  core/
    constants/       # app_colors.dart, app_text_styles.dart — no hardcoded hex outside here
    router/          # app_router.dart (go_router)
    theme/           # app_theme.dart (ThemeData light + dark)
    providers/       # shared_preferences_provider.dart
  features/
    wirid/
      data/
        models/      # WiridItem, WiridCategory — immutable data classes
        wirid_repository.dart   # loads JSON from assets, parses in compute()
      presentation/
        providers/   # wirid_provider.dart, counter_provider.dart, preferences_provider.dart
        views/       # wirid_list_screen.dart, wirid_detail_screen.dart
        widgets/     # arabic_text.dart, counter_widget.dart, faidah_accordion.dart
  shared/            # shared widgets, extensions, utils
  main.dart
test/                # mirrors lib/ structure 1:1
```

---

## Commands

```bash
flutter pub get
flutter analyze
flutter test --coverage
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

## Naming conventions

- Files: `snake_case.dart`
- Classes: `UpperCamelCase`
- Providers: `<feature>Provider` for `Provider`/`FutureProvider`;
  `<Feature>Notifier` for `AsyncNotifier`/`Notifier` classes
- Provider files suffix: `_provider.dart`
- Repository interfaces: not used (no domain layer) — concrete class is
  `WiridRepository` directly
- Models (data layer): plain Dart immutable classes with `const` constructor,
  `fromJson` factory; no `Dto` suffix needed (no server DTOs in this project)

---

## Key data facts

- Content source: `assets/data/wirid_items.json` — **do not modify this file**
- 21 items, one category, fixed order
- JSON schema: `id`, `order`, `title`, `title_latin`, `arabic`, `latin?`,
  `translation?`, `repeat_count?` (nullable int), `source?`, `faidah?`, `note?`
- Items where `repeat_count` is null have **no counter** — never create counter
  state for them
- Item `ya_ghani_ya_mughni` (order 18): 4 rounds of 10 = 40 total, counter
  tracks round progress separately

---

## Testing rule

Every provider with non-trivial logic and every repository must have a test
covering the success path and at least one error/edge-case path. Pure data
classes don't need dedicated tests unless they contain logic.

---

## Git convention

- Branches: `feature/<short-description>`, `fix/<short-description>`,
  `chore/<short-description>`
- Commits: Conventional Commits — `feat:`, `fix:`, `chore:`, `refactor:`,
  `test:`, `docs:` prefix + short imperative summary

---

## Do NOT

- No repository calls from widgets — always go through a provider
- No business logic in views — views read provider state and call provider
  methods, nothing more
- No use case classes — this project has no logic that justifies the overhead
- No Bloc, Cubit, or get_it — Riverpod is the only DI and state solution
- No hardcoded hex colors outside `app_colors.dart`
- No hardcoded font sizes for Arabic outside the 4 preset values (22, 26, 30, 36)
- Never commit `.env` — only `.env.example` is tracked (not currently used)
- Do not modify `assets/data/wirid_items.json`