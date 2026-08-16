import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wirid_al_busyro/core/constants/app_colors.dart';
import 'package:wirid_al_busyro/features/wirid/data/models/wirid_item.dart';
import 'package:wirid_al_busyro/features/wirid/presentation/providers/preferences_provider.dart';
import 'package:wirid_al_busyro/features/wirid/presentation/providers/wirid_provider.dart';

/// F-01: list of all wirid items — Arabic title and Latin title only
/// (faidah is detail-screen-only, kept out of the list to stay scannable).
/// Also hosts the font-size (F-06) and dark mode (F-07) controls.
class WiridListScreen extends ConsumerWidget {
  const WiridListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(wiridItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wirid Al Busyro'),
        actions: const [_FontSizeMenuButton(), _ThemeModeMenuButton()],
      ),
      body: items.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
        data: (items) => ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: items.length,
          itemBuilder: (context, index) => _WiridListTile(item: items[index]),
        ),
      ),
    );
  }
}

class _WiridListTile extends StatelessWidget {
  const _WiridListTile({required this.item});

  final WiridItem item;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Material(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.push('/wirid/${item.id}'),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: isDark
                  ? null
                  : Border.all(color: Colors.black.withValues(alpha: 0.04)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${item.order}',
                    style: TextStyle(fontWeight: FontWeight.bold, color: accent),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.titleLatin,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: accent, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A single row in the font-size / theme-mode menus: leading icon, label,
/// and a trailing checkmark on whichever option is currently selected.
class _ModernMenuRow extends StatelessWidget {
  const _ModernMenuRow({
    required this.icon,
    required this.label,
    required this.selected,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;
    return Row(
      children: [
        Icon(icon, size: 20, color: selected ? accent : null),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            color: selected ? accent : null,
            fontWeight: selected ? FontWeight.w600 : null,
          ),
        ),
        const Spacer(),
        if (selected) Icon(Icons.check, size: 18, color: accent),
      ],
    );
  }
}

class _FontSizeMenuButton extends ConsumerWidget {
  const _FontSizeMenuButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(arabicFontSizeProvider);
    return PopupMenuButton<ArabicFontSize>(
      icon: const Icon(Icons.text_fields),
      tooltip: 'Ukuran teks Arab',
      initialValue: current,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      onSelected: (size) =>
          ref.read(arabicFontSizeProvider.notifier).setFontSize(size),
      itemBuilder: (context) => ArabicFontSize.values
          .map(
            (size) => PopupMenuItem(
              value: size,
              child: _ModernMenuRow(
                icon: Icons.text_fields,
                label: size.label,
                selected: size == current,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ThemeModeMenuButton extends ConsumerWidget {
  const _ThemeModeMenuButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(appThemeModeProvider);
    return PopupMenuButton<ThemeMode>(
      icon: Icon(
        switch (current) {
          ThemeMode.light => Icons.light_mode,
          ThemeMode.dark => Icons.dark_mode,
          ThemeMode.system => Icons.brightness_auto,
        },
      ),
      tooltip: 'Mode tampilan',
      initialValue: current,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      onSelected: (mode) =>
          ref.read(appThemeModeProvider.notifier).setThemeMode(mode),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: ThemeMode.system,
          child: _ModernMenuRow(
            icon: Icons.brightness_auto,
            label: 'Ikuti Sistem',
            selected: current == ThemeMode.system,
          ),
        ),
        PopupMenuItem(
          value: ThemeMode.light,
          child: _ModernMenuRow(
            icon: Icons.light_mode,
            label: 'Terang',
            selected: current == ThemeMode.light,
          ),
        ),
        PopupMenuItem(
          value: ThemeMode.dark,
          child: _ModernMenuRow(
            icon: Icons.dark_mode,
            label: 'Gelap',
            selected: current == ThemeMode.dark,
          ),
        ),
      ],
    );
  }
}
