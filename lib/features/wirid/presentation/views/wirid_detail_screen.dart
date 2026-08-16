import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wirid_al_busyro/core/constants/app_text_styles.dart';
import 'package:wirid_al_busyro/features/wirid/data/models/wirid_item.dart';
import 'package:wirid_al_busyro/features/wirid/presentation/providers/preferences_provider.dart';
import 'package:wirid_al_busyro/features/wirid/presentation/providers/wirid_provider.dart';
import 'package:wirid_al_busyro/features/wirid/presentation/widgets/arabic_text.dart';
import 'package:wirid_al_busyro/features/wirid/presentation/widgets/counter_widget.dart';
import 'package:wirid_al_busyro/features/wirid/presentation/widgets/faidah_accordion.dart';

/// F-02 (detail) + F-03 (next/prev navigation without returning to the
/// list). Surah Yasin renders with AmiriQuran for mushaf-accurate
/// harakat placement; every other item uses Amiri.
class WiridDetailScreen extends ConsumerWidget {
  const WiridDetailScreen({super.key, required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(wiridItemsProvider);

    return items.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(body: Center(child: Text('$error'))),
      data: (items) {
        final index = items.indexWhere((item) => item.id == itemId);
        if (index == -1) {
          return const Scaffold(body: Center(child: Text('Item not found')));
        }
        return _WiridDetailBody(
          items: items,
          index: index,
          key: ValueKey(itemId),
        );
      },
    );
  }
}

class _WiridDetailBody extends ConsumerWidget {
  const _WiridDetailBody({super.key, required this.items, required this.index});

  final List<WiridItem> items;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = items[index];
    final hasPrev = index > 0;
    final hasNext = index < items.length - 1;
    final fontSize = ref.watch(arabicFontSizeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(item.titleLatin)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ArabicBody(item: item),
            if (item.translation case final translation?) ...[
              const SizedBox(height: 16),
              Text(
                translation,
                style: AppTextStyles.translation(context, fontSize),
              ),
            ],
            const SizedBox(height: 24),
            Center(child: CounterWidget(item: item)),
            const SizedBox(height: 16),
            FaidahAccordion(item: item),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: hasPrev
                      ? () => context.pushReplacement(
                          '/wirid/${items[index - 1].id}',
                        )
                      : null,
                  icon: const Icon(Icons.chevron_left),
                  label: const Text('Sebelumnya'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: hasNext
                      ? () => context.pushReplacement(
                          '/wirid/${items[index + 1].id}',
                        )
                      : null,
                  label: const Text('Berikutnya'),
                  icon: const Icon(Icons.chevron_right),
                  iconAlignment: IconAlignment.end,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Surah Yasin's opening Bismillah is its own centered line; the rest of
/// the surah is justified rather than right-aligned. Every other item
/// keeps the default single right-aligned block.
class _ArabicBody extends StatelessWidget {
  const _ArabicBody({required this.item});

  final WiridItem item;

  @override
  Widget build(BuildContext context) {
    if (item.id != 'surah_yasin') {
      return ArabicText(item.arabic);
    }

    final newlineIndex = item.arabic.indexOf('\n');
    if (newlineIndex == -1) {
      return ArabicText(
        item.arabic,
        isQuran: true,
        textAlign: TextAlign.justify,
      );
    }

    final bismillah = item.arabic.substring(0, newlineIndex);
    final body = item.arabic.substring(newlineIndex + 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ArabicText(bismillah, isQuran: true, textAlign: TextAlign.center),
        const SizedBox(height: 12),
        ArabicText(body, isQuran: true, textAlign: TextAlign.justify),
      ],
    );
  }
}
