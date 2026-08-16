# Wirid Al-Busyro

A mobile app for reading the 21 wirid and prayer items recited after
Fajr, compiled by Prof. Dr. Habib Segaf Baharun of Majlis Al-Busyro —
Arabic text with translation, faidah, and a repetition counter, on iOS
and Android. Fully offline, no backend.

## Prerequisites

- Flutter 3.47.0 (stable channel)
- Dart ^3.13.0 (bundled with the above Flutter SDK)
- Xcode (latest stable) + CocoaPods, for iOS
- Android SDK (cmdline-tools + platform 36), for Android

## Setup

```bash
git clone <repo-url>
cd wirid-al-busyro
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

There's a single build environment — no dev/staging/prod flavors, so
`flutter run` targets whatever device/simulator is connected.

## Project structure

Feature-first, no domain layer (`presentation → data`) — Riverpod
providers double as the DI mechanism. See [ARCHITECTURE.md](ARCHITECTURE.md)
for the full layer diagram, DI approach, and the reasoning behind the
state-management/navigation choices.

## Running tests

```bash
flutter test --coverage
```

Coverage output is written to `coverage/lcov.info`.

## Contributing

Solo project right now — no CONTRIBUTING.md yet. See
[CLAUDE.md](CLAUDE.md) for naming conventions, git branch/commit format,
and the testing rule enforced before merge.

## License

[TBD — needs my input]
