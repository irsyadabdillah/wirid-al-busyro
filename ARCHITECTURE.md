# Architecture

Feature-first, no explicit domain layer — the app is offline-only with no
business logic beyond counter state, so a domain layer of entities and
repository interfaces would just be ceremony around a single JSON asset.

## Layers

```
┌─────────────────────────────────────────────┐
│                presentation                   │
│   views (widgets)  →  providers (Riverpod)    │
└───────────────────────┬───────────────────────┘
                         │ ref.watch / ref.read
                         ▼
┌─────────────────────────────────────────────┐
│                    data                       │
│   models (WiridItem, WiridCategory, WiridData)│
│   WiridRepository — loads + parses the asset  │
└─────────────────────────────────────────────┘
```

## Dependency rule

`presentation → data`. There's no interface to implement — `WiridRepository`
is a concrete class injected via a Riverpod `Provider`, and the presentation
layer (views + other providers) reads it through `ref.watch`/`ref.read`.
Providers call the repository directly; no use-case classes wrap it, since
`getWiridItems()` is a pure passthrough with no branching logic to justify
one.

Example (`wirid` feature):
`WiridListScreen`/`WiridDetailScreen` → `wiridItemsProvider` (`@riverpod`
function) → `wiridRepositoryProvider` → `WiridRepository` → bundled
`assets/data/wirid_items.json`.

## DI approach

Riverpod providers ARE the DI mechanism — there's no separate service
locator (no `get_it`). Each provider is declared next to the class it
provides rather than centralized in one file:

- `lib/core/providers/shared_preferences_provider.dart` — a `Provider<SharedPreferences>`
  that throws if read before `main()` overrides it with the real instance
  obtained via `SharedPreferences.getInstance()`.
- `lib/features/wirid/presentation/providers/wirid_provider.dart` — `wiridRepositoryProvider`
  and `wiridItemsProvider`, both generated via `riverpod_generator`'s
  `@riverpod` annotation.
- `lib/features/wirid/presentation/providers/preferences_provider.dart` —
  `ArabicFontSizeNotifier`/`AppThemeModeNotifier`, persisted to
  `SharedPreferences` on every change.
- `lib/features/wirid/presentation/providers/counter_provider.dart` —
  `CounterNotifier`, a *family* provider keyed by `WiridItem` (one counter
  state per item, keyed by object identity since the items list is stable
  for the app's lifetime).

**Generated provider names drop the `Notifier` suffix** — riverpod_generator
turns a class `FooNotifier` into a provider named `fooProvider`, not
`fooNotifierProvider`. Check the `.g.dart` file's `@ProviderFor(...)` /
`final ... = ...` line if unsure, rather than guessing from the class name.

**Riverpod 3 auto-disposes every provider by default** when nothing is
listening — this matters for tests specifically: `container.read(x.future)`
alone doesn't keep `x` alive long enough to resolve, so tests need
`container.listen(x, (_, __) {})` held open (see
`test/features/wirid/presentation/providers/counter_provider_test.dart`
and the notifier pattern used in earlier iterations of this app for the
full explanation).

**Riverpod 3 also retries any thrown `Exception` (not `Error`) up to 10x
with exponential backoff by default** — a provider whose `build()` throws
won't settle into a terminal `AsyncError` until those retries exhaust. If a
provider ever needs to surface a domain-expected failure immediately
(rather than treating it as transient), pass `retry: (retryCount, error) =>
null` on that provider.

## Navigation

`go_router`, declared in `lib/core/router/app_router.dart`. Two routes:
`/` → `WiridListScreen`, `/wirid/:id` → `WiridDetailScreen`. Next/prev
(F-03) navigates by finding the current item's index in the already-loaded
list and pushing a replacement route for the neighboring item's id — it
does not return to the list screen in between.

## Error handling

No `Result`/`Failure` wrapper type — a single JSON asset load either
succeeds or the `FutureProvider` surfaces the exception as an `AsyncError`,
which `.when(error: ...)` renders directly. That's proportionate for one
bundled, version-controlled asset with no network/user-input failure modes
to model explicitly; revisit if a second, less-trusted data source is ever
added.

## Fonts

Two bundled families in `assets/fonts/` (PRD §7.2 — never system fonts,
harakat rendering must be verified, not assumed):
- **Amiri** (Regular/Bold/Italic/BoldItalic) — general wirid text via
  `ArabicText(isQuran: false)` (the default).
- **AmiriQuran** — Surah Yasin only (`ArabicText(isQuran: true)`), chosen
  for its mushaf-accurate harakat placement over plain Amiri.

Neither font is subset to the Arabic Unicode range yet (PRD §7.2's
"should", not "must") — worth doing before the `< 20MB` APK target (§9) is
actually measured.

## ADRs

### State management + DI: Riverpod (`riverpod_generator`)

Chosen to unify state management and dependency injection in one system —
no separate `get_it` service locator, no BLoC/Cubit. `@riverpod`-annotated
functions/classes generate typed providers; `AsyncNotifier`'s `AsyncValue`
gives loading/data/error states for free instead of a hand-rolled sealed
state class per feature.

### Navigation: go_router

Declarative, URL-based routing — `context.push('/wirid/$id')` reads
directly as "go to this screen" without imperative `Navigator` route
management, and scales cleanly if deep linking is ever added.

### No domain layer

A domain layer (entities distinct from data models, repository interfaces,
use cases) earns its cost when there's a reason to swap implementations
(e.g., a second data source) or when business logic needs isolating from
I/O concerns. Neither is true here yet — one bundled JSON asset, one
consumer. Revisit if a backend, second content source, or real business
logic (beyond counter arithmetic) shows up.
